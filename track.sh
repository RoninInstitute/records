#!/bin/bash
#
# tracks RIIS 2.0 documents versions using Preston [1,2]
#
#
# [1] Elliott M.J., Poelen J.H., Fortes J.A.B. (2020). Toward Reliable Biodiversity Dataset References. Ecological Informatics. https://doi.org/10.1016/j.ecoinf.2020.101132 hash://sha256/136c3c1808bcf463bb04b11622bb2e7b5fba28f5be1fc258c5ea55b3b84f482c
#
# [2] Elliott M.J., Poelen, J.H. & Fortes, J.A.B. (2023) Signing data citations enables data verification and citation persistence. Sci Data. https://doi.org/10.1038/s41597-023-02230-y hash://sha256/f849c870565f608899f183ca261365dce9c9f1c5441b1c779e0db49df9c2a19d
#

set -x

# create the document aliases
create_alias() {
    local alias_name="$1"

     if [ "$type" = "gdoc" ]; then
	 preston head | preston cat | grep hasVersion | grep docx | head -n1 | preston cat > "${alias_name}.docx"
	 preston head | preston cat | grep hasVersion | grep pdf | head -n1 | preston cat > "${alias_name}.pdf"
	 return
     fi
     if [ "$type" = "pdf" ]; then
	 # file export doesn't contain file type like 'pdf', so skip grep
	 preston head | preston cat | grep hasVersion | head -n1 | preston cat > "${alias_name}.pdf"
	 return
     fi
}

build_url() {
  local id="$1"
  local type="$2"

  case "$type" in
    gdoc)
      echo "https://docs.google.com/document/d/${id}"
      ;;
    pdf)
      echo "https://drive.google.com/uc?export=download&id=${id}"
      ;;
    *)
      echo "UNKNOWN_TYPE:$type" >&2
      return 1
      ;;
  esac
}

# retrieves documents and associated alias
track_doc() {
  local id="$1"
  local name="$2"
  local type="$3"

  echo "tracking: $id $name $type"
  url=$(build_url "$id" "$type") || return 1
  echo "url: $url"

  preston track "$url"
  create_alias "$name"    
}

# generate links to official docs: by-laws, policies
# pull mapping from a CSV file with "Google ID,alias,type"
tail -n +2 _data/docs.csv \
| while IFS=, read -r id name type; do
    track_doc "$id" "$name" "$type"
  done
# cat _data/docs.csv \
#  | tail -n+2 \
#  | tr ',' ' '\
#  | { while read -r doc; do track_doc $doc; done }

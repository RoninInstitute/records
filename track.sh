#!/bin/bash
#
# tracks Reframe Ronin documents versions using Preston [1,2]
#
#
# [1] Elliott M.J., Poelen J.H., Fortes J.A.B. (2020). Toward Reliable Biodiversity Dataset References. Ecological Informatics. https://doi.org/10.1016/j.ecoinf.2020.101132 hash://sha256/136c3c1808bcf463bb04b11622bb2e7b5fba28f5be1fc258c5ea55b3b84f482c
#
# [2] Elliott M.J., Poelen, J.H. & Fortes, J.A.B. (2023) Signing data citations enables data verification and citation persistence. Sci Data. https://doi.org/10.1038/s41597-023-02230-y hash://sha256/f849c870565f608899f183ca261365dce9c9f1c5441b1c779e0db49df9c2a19d
#

create_alias() {
  local alias_name="$1"
  preston head | preston cat | grep hasVersion | grep docx | head -n1 | preston cat > "${alias_name}.docx"
  preston head | preston cat | grep hasVersion | grep pdf | head -n1 | preston cat > "${alias_name}.pdf"
}

# official docs

# by-laws, policies

preston track https://docs.google.com/document/d/1KY8E_xia5vTVfBBLVGmcUW2ncPZi0btc8YHty0Pm8E4/edit

create_alias "bylaws"

preston track https://docs.google.com/document/d/14sqIUuw2i7QDQMOGqDM98JRRL_SMYP2S-ePgOYxlwfw/edit?tab=t.0

create_alias "belonging-policy"

preston track https://docs.google.com/document/d/1m9NEDv6L_z1GDQAKjrXdoQNh30goIeBqdVJNZ3yFLww/edit?tab=t.0

create_alias "code-of-conduct"

preston track https://docs.google.com/document/d/1HovWX8xA7-lXDK4CmQgMyuefmFzc6QiuoRrjGiWynNI/edit?tab=t.0

create_alias "privacy-policy"



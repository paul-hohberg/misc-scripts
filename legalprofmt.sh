#!/bin/bash
cat irm_legalpro.txt | sed "s/^/\"/; s/$/\",\"$(date '+%Y-%m-%d')\"/" | tr -d '\r' > ucla_lglpro.csv
sed -i '1s/^/UID,First Name,Last Name,Email Address,Title,Department,Update Date\n/' ucla_lglpro.csv

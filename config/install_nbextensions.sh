while read line; do
    jupyter nbextension enable "$line"
done < nbextension.config
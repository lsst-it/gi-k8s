#!/usr/bin/env bash
servicesID=$(cat ../../ID/servicesID)
for filename in *.json; do
    sed "s/\"folderId\": null/\"folderId\": $servicesID/g" $filename > ../list/$filename
done


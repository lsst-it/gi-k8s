#!/usr/bin/env bash
clustersID=$(cat ../../ID/clustersID)
for filename in *.json; do
    sed "s/\"folderId\": null/\"folderId\": $clustersID/g" $filename > ../list/$filename
done


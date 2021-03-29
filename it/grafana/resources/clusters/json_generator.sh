#!/usr/bin/env bash
clustersID=$(cat ../ID/clustersID)
for filename in scheme/*.json; do
    sed "s/\"folderId\": null/\"folderId\": $clustersID/g" scheme/$filename.json > list/$filename.json
done


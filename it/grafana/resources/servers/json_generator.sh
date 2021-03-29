#!/usr/bin/env bash
serversID=$(cat ../ID/serversID)
while read server;
do 
    sed "s/SERVER_NAME/$server/g" server_template.json > list/$server.json
done < server_list.txt
for filename in list/*.json; do
    sed -i "s/\"folderId\": null/\"folderId\": $serversID/g" $filename
done
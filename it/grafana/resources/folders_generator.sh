#!/usr/bin/env bash
set -xuo pipefail

NAMESPACE='it-grafana'
URL="$(kubectl -n it-grafana get ingress grafana -ojson | jq -r '.spec.tls[0].hosts[0]')"
USER="$(kubectl -n ${NAMESPACE} get secret grafana-credentials -ojson | jq -r '.data["admin-user"]' | base64 --decode)"
PASSWORD="$(kubectl -n ${NAMESPACE} get secret grafana-credentials -ojson | jq -r '.data["admin-password"]' | base64 --decode)"
POD="$(kubectl get -n ${NAMESPACE} pods -o json | jq -r '.items[].metadata.name')"

/usr/bin/kubectl wait --for=condition=ready pod -n ${NAMESPACE} ${POD} > /dev/null 2>&1
/usr/bin/curl -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/folders -d "{\"id\":null,\"uid\":\"fr5kaxQGz\",\"title\":\"clusters\"}" > /dev/null 2>&1
/usr/bin/curl -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/folders -d "{\"id\":null,\"uid\":\"xZtkaxwMk\",\"title\":\"services\"}" > /dev/null 2>&1
/usr/bin/curl -k -u ${USER}:${PASSWORD} -H "Content-Type: application/json" -X POST https://${URL}/api/folders -d "{\"id\":null,\"uid\":\"NbYQ1AwMz\",\"title\":\"servers\"}" > /dev/null 2>&1
clustersID="$(/usr/bin/curl -k -u ${USER}:${PASSWORD} -H 'Content-Type: application/json' -X GET https://it-grafana.ls.lsst.org/api/folders/fr5kaxQGz 2>/dev/null | jq -r '.id')"
servicesID="$(/usr/bin/curl -k -u ${USER}:${PASSWORD} -H 'Content-Type: application/json' -X GET https://it-grafana.ls.lsst.org/api/folders/xZtkaxwMk 2>/dev/null | jq -r '.id')"
serversID="$(/usr/bin/curl -k -u ${USER}:${PASSWORD} -H 'Content-Type: application/json' -X GET https://it-grafana.ls.lsst.org/api/folders/NbYQ1AwMz 2>/dev/null | jq -r '.id')"
rm -rf ID
mkdir ID
touch ID/$clustersID
touch ID/$servicesID
touch ID/$serversID
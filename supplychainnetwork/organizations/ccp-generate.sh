#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s/\${ORGMSP}/$6/" \
        -e "s/\${P1PORT}/$7/" \
        organizations/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s/\${ORGMSP}/$6/" \
        -e "s/\${P1PORT}/$7/" \
        organizations/ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

ORG=producer
P0PORT=7051
P1PORT=7056
CAPORT=7054
PEERPEM=organizations/peerOrganizations/producer.example.com/tlsca/tlsca.producer.example.com-cert.pem
CAPEM=organizations/peerOrganizations/producer.example.com/ca/ca.producer.example.com-cert.pem
ORGMSP=ProducerMSP

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGMSP $P1PORT)" > organizations/peerOrganizations/producer.example.com/connection-producer.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGMSP $P1PORT)" > organizations/peerOrganizations/producer.example.com/connection-producer.yaml


ORG=supplier
P0PORT=9051
P1PORT=9056
CAPORT=9054
PEERPEM=organizations/peerOrganizations/supplier.example.com/tlsca/tlsca.supplier.example.com-cert.pem
CAPEM=organizations/peerOrganizations/supplier.example.com/ca/ca.supplier.example.com-cert.pem
ORGMSP=SupplierMSP

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGMSP $P1PORT)" > organizations/peerOrganizations/supplier.example.com/connection-supplier.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGMSP $P1PORT)" > organizations/peerOrganizations/supplier.example.com/connection-supplier.yaml

ORG=wholeseller
P0PORT=6051
P1PORT=6056
CAPORT=6054
PEERPEM=organizations/peerOrganizations/wholeseller.example.com/tlsca/tlsca.wholeseller.example.com-cert.pem
CAPEM=organizations/peerOrganizations/wholeseller.example.com/ca/ca.wholeseller.example.com-cert.pem
ORGMSP=WholesellerMSP

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGMSP $P1PORT)" > organizations/peerOrganizations/wholeseller.example.com/connection-wholeseller.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGMSP $P1PORT)" > organizations/peerOrganizations/wholeseller.example.com/connection-wholeseller.yaml

*** Settings ***
Library             RequestsLibrary
Library             String
Library             Collections
Library             JSONLibrary
Library             FakerLibrary    locale=pt_BR

Resource        credentials.resource
Resource        auth.resource
Resource        user.resource
# Resource        company.resource
# Resource        board.resource
# Resource        costCenter.resource
# Resource        department.resource
# Resource        client.resource

*** Variables ***
${baseUrl}    https://quality-eagles.qacoders-academy.com.br/
${UrlConv}    https://convergentes.qacoders-academy.com.br/
*** Settings ***
Library         RequestsLibrary
Library         String
Library         Collections
Library         JSONLibrary
Library         FakerLibrary    locale=pt_BR

Resource        credentials.resource
Resource        auth.resource
Resource        user.resource
# Resource        company.resource
# Resource        board.resource
# Resource        costCenter.resource
# Resource        department.resource
# Resource        client.resource

*** Variables ***

# URL's
${UrlEagles}    https://quality-eagles.qacoders-academy.com.br/
${UrlConv}      https://convergentes.qacoders-academy.com.br/

# Admin
${admin_endpoint}       api/login/
${admin_validToken}     api/validateToken
${admin_alias}          auth_session

# Users
${user_endpoint}        api/user/
${user_alias}           user_session
${pass_user}            2634@Test
${accessProfile}        ADMIN
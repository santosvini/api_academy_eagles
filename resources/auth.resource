*** Settings ***
Documentation    Resources needed to access the systems during the tests

Resource        main.resource
Resource        ../utils/headers.resource
Resource        ../utils/body.resource
Resource        ../utils/messages.resource

*** Keywords ***
Login Admin
    Headers
    Body
    Create session    ${admin_alias}     ${UrlEagles}    disable_warnings=1

    ${response}=      Post on session    ${admin_alias}    ${admin_endpoint}    json=Body   headers=Headers
    
    #${response_body}=    Evaluate    json.loads('''${response.content}''')

    Should Be Equal As Integers    ${response.status_code}    200
    Should Not Be Empty            ${response}[token]
    Set Test Variable              ${ADMIN_TOKEN}    ${response}[token]
    Log    ${response}[token]
    
    ${response_email}=       Set variable    ${response}[user][mail]
    Should Be Equal As Strings     ${response_email}    ${mail.admin}

    ${response_password}=    Set variable    ${response}[user][password]   
    Should Be Equal As Strings     ${response_password}    ${response}[user][password]

Login Admin - Email Inválido
    Headers
    ${body}=          Create Dictionary    mail=${mail.error}         password=${password.admin}

    ${response}=      POST    ${UrlEagles}api/login/    json=${body}    headers=Headers    expected_status=400
    ${response_body}=    Evaluate    json.loads('''${response.content}''')
    
    Should Be Equal As Strings     ${response.json()}[alert]    ${alert}

Login Admin - Senha Inválida
    Headers
    ${body}=          Create Dictionary    mail=${mail.admin}         password=${password.error}

    ${response}=      POST    ${UrlEagles}${admin_endpoint}    json=${body}    headers=Headers    expected_status=400
    ${response_body}=    Evaluate    json.loads('''${response.content}''')
    
    Should Be Equal As Strings     ${response.json()}[alert]    ${alert}

Login Admin - Campos Obrigatórios
    Headers
    ${body}=          Create Dictionary    mail=         password=

    ${response}=      POST    ${UrlEagles}api/login/    json=${body}    headers=Headers    expected_status=400
    ${response_body}=    Evaluate    json.loads('''${response.content}''')

    Should Be Equal As Strings     ${response.json()}[mail]        ${needEmail}
    Should Be Equal As Strings     ${response.json()}[password]    ${needPass}

Validate Token - Admin
    ${headers}=       Create Dictionary    Authorization=Bearer ${ADMIN_TOKEN}
    ${resposta}=      Get on session    ${admin_alias}    ${UrlEagles}${admin_validToken} headers=${headers}

    Log  Resposta da Solicitação: ${resposta.content}
    Log  ${ADMIN_TOKEN}
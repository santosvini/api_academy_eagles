*** Settings ***
Documentation    Resources needed to access the systems during the tests

Resource        main.resource

*** Variables ***
${url}      ${baseUrl}
${alias}    auth_session

*** Keywords ***
Login Admin
    ${headers}=       Create Dictionary    accept=application/json    Content-Type=application/json
    ${body}=          Create Dictionary    mail=${mail.admin}         password=${password.admin}

    Create session    ${alias}     ${url}    disable_warnings=1

    ${response}=      Post on session    ${alias}    /api/login/    json=${body}    headers=${headers}
    Log    ${response}
    ${response_body}=    Evaluate    json.loads('''${response.content}''')
    Log    ${response_body}

    Should Be Equal As Integers    ${response.status_code}    200
    Should Not Be Empty            ${response_body}[token]
    Set Test Variable              ${ADMIN_TOKEN}    ${response_body}[token]
    Log    ${response_body}[token]
    
    ${response_email}=       Set variable    ${response_body}[user][mail]
    Should Be Equal As Strings     ${response_email}    ${mail.admin}

    ${response_password}=    Set variable    ${response_body}[user][password]   
    Should Be Equal As Strings     ${response_password}    ${response_body}[user][password]

Login Admin - Email Inválido
    ${headers}=       Create Dictionary    accept=application/json    Content-Type=application/json
    ${body}=          Create Dictionary    mail=${mail.error}         password=${password.admin}

    ${response}=      POST    ${baseUrl}api/login/    json=${body}    headers=${headers}    expected_status=400
    Log    ${response}
    ${response_body}=    Evaluate    json.loads('''${response.content}''')
    Log    ${response_body}
    
    Should Be Equal As Strings     ${response.json()}[alert]    E-mail ou senha informados são inválidos.

Login Admin - Senha Inválida
    ${headers}=       Create Dictionary    accept=application/json    Content-Type=application/json
    ${body}=          Create Dictionary    mail=${mail.admin}         password=${password.error}

    ${response}=      POST    ${baseUrl}api/login/    json=${body}    headers=${headers}    expected_status=400
    Log    ${response}
    ${response_body}=    Evaluate    json.loads('''${response.content}''')
    Log    ${response_body}
    
    Should Be Equal As Strings     ${response.json()}[alert]    E-mail ou senha informados são inválidos.

Login Admin - Campos Obrigatórios
    ${headers}=       Create Dictionary    accept=application/json    Content-Type=application/json
    ${body}=          Create Dictionary    mail=         password=

    ${response}=      POST    ${baseUrl}api/login/    json=${body}    headers=${headers}    expected_status=400
    Log    ${response}
    ${response_body}=    Evaluate    json.loads('''${response.content}''')
    Log    ${response_body}

    Should Be Equal As Strings     ${response.json()}[mail]        O campo e-mail é obrigatório.
    Should Be Equal As Strings     ${response.json()}[password]    O campo senha é obrigatório.

Validate Token - Admin
    ${headers}=       Create Dictionary    Authorization=Bearer ${ADMIN_TOKEN}
    ${resposta}=      Get on session    auth_session    ${url}api/validateToken    headers=${headers}

    Log  Resposta da Solicitação: ${resposta.content}
    Log  ${ADMIN_TOKEN}
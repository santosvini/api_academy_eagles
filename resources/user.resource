*** Settings ***
Documentation    Resources needed to access the systems during the tests

Resource    ${CURDIR}/main.resource
Resource    ../utils/headers.resource
Resource    ../utils/body.resource
Resource    ../utils/status.resource

*** Keywords ***
Create email random
  ${random_word}        Generate Random String     length=6    chars=[LETTERS]
  Set Test Variable     ${mail_user}               ${random_word}
Create cpf random
  ${random_number}      Generate Random String    length=11    chars=[NUMBERS]
  Set Test Variable     ${cpf}                    ${random_number}
 
Register - New User
  HeadersToken ${ADMIN_TOKEN}

  ${firstname}=     FakerLibrary.FirstName
  ${lastname}=      FakerLibrary.LastName
  ${fullName}=      Catenate    ${firstname} ${lastname}

  ${mail_user}=        Remove String            ${fullName}   .  -  ´  `  ^  ~  Ç  Sra  Srta  Sr  ${SPACE}
  ${mail_user}=        Convert to Lower Case    ${mail_user}

  Set Test Variable    ${fullName}    ${fullName}

  #Create email random
  Create cpf random

  ${body}=           Create Dictionary     fullName=${fullName}       mail=${mail_user}@qacoders.com.br     password=${pass_user}     accessProfile=${accessProfile}    cpf=${cpf}    confirmPassword=${pass_user}

  Create Session    ${user_alias}   ${user_endpoint}  disable_warnings=1

  ${response}=  POST On Session  ${user_alias}    ${user_endpoint}     json=${body}    headers=HeadersToken
  Log    ${response}

  ${response_body}=    Evaluate    json.loads('''${response.content}''')
  Log    ${response_body}

  Should Be Equal As Strings    ${response.status_code}    ${Created}
  Should Not Be Empty    ${response_body}[msg]

  Set Test Variable      ${ID_USER}         ${response_body}[user][_id]
  Set Test Variable      ${NAME_USER}       ${response_body}[user][fullName]
  Set Test Variable      ${MAIL_USER}       ${response_body}[user][mail]
  Set Test Variable      ${PROFILE_USER}    ${response_body}[user][accessProfile]
  Set Test Variable      ${CPF_USER}        ${response_body}[user][cpf]
  Set Test Variable      ${STATUS_USER}     ${response_body}[user][status]

Login User
  Headers
  ${body}=       Create Dictionary    mail=${MAIL_USER}    password=${pass_user}

  Create Session    ${user_alias}     ${user_endpoint}     disable_warnings=1

  ${response}=      Post on session    ${user_alias}    ${user_endpoint}    json=${body}    headers=Headers    Authorization=${ADMIN_TOKEN}
  #Log    ${response}
  ${response_body}=    Evaluate    json.loads('''${response.content}''')
  #Log    ${response_body}

  Should Be Equal As Integers    ${response.status_code}    ${Created}
  Should Not Be Empty            ${response_body}[token]
  
  ${response_email}=       Set variable    ${response_body}[user][mail]
  Should Be Equal As Strings     ${response_email}    ${mail.admin}

  ${response_password}=    Set variable    ${response_body}[user][password]  
  Should Be Equal As Strings     ${response_password}    ${response_body}[user][password]
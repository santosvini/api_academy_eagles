*** Settings ***

Resource    ../resources/main.resource

*** Keywords ***
Body
   ${body}=          Create Dictionary    mail=${mail.admin}         password=${password.admin}

BodyUser
   ${body}=           Create Dictionary     fullName=${fullName}       mail=${mail_user}@qacoders.com.br     password=${pass_user}     accessProfile=${accessProfile}    cpf=${cpf}  confirmPassword=${pass_user}
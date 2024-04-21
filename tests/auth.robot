*** Settings ***
Documentation    Suite de testes da API de authentication da API Academy da QaCoders

Resource         ../resources/main.resource
Resource         ../resources/auth.resource

*** Test Cases ***
TC00 - Login Admin
  [Tags]    login    success
  Login Admin
  Validate Token - Admin

TC01 - Login Admin - Email Inválido
  [Tags]    login    email_inv
  Login Admin - Email Inválido

TC02 - Login Admin - Senha Inválida
  [Tags]    login    senha_inv
  Login Admin - Senha Inválida

TC03 - Login Admin - Campos Obrigatórios
  [Tags]    login    campos_obrig
  Login Admin - Campos Obrigatórios
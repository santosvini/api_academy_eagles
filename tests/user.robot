*** Settings ***
Documentation    Suite de testes da API de usuários da API Academy da QaCoders

Resource         ../resources/main.resource
Resource         ../resources/user.resource

*** Test Cases ***
TC00 - Register New User
  [Tags]    register    newuser
  Login Admin
  Register - New User

TC01 - Login New User
  [Tags]    login    newuser
  Login Admin
  Register - New User
  Login User
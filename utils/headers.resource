*** Settings ***
Documentation    Resources needed to access the systems during the tests
Library    FakerLibrary

*** Keywords ***
Headers
   ${headers}=       Create Dictionary    accept=application/json    Content-Type=application/json

HeadersToken
   ${headers}=       Create Dictionary    Authorization=Bearer
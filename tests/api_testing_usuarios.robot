*** Settings ***
Resource  ../resources/api_testing_usuarios.resource


*** Test Cases ***

Cenário 01: Autenticar 
    Dado que seja realizado a devida autenticação no servidor

#HYDRA
Cenário 02: Consultar Jogos instalados no terminal
    Dado que seja iniciado uma sessao no servidor
    Quando o status code retornado for 200
    Então o jogo Break the Bank deve ocupar a posição 1
    E o jogo Let's Go Wild deve ocupar a posição 15
 


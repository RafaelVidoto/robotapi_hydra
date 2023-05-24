*** Settings ***
Library     RequestsLibrary
Library     String
Library     Collections
Library     OperatingSystem


*** Variables ***
${activate_endpoint}             /pt/activate
${ndsite3}   https://ndsite3.hydrasystems.com.br:2780
#${Token}    cd194475-d098-43ba-aeaa-b86cc8bc8b2d 
${security_key}    90a2c434-b1aa-423a-9565-419046c59ce8
${activate_body}    {"serial_number": POSTMAN,"security_key": ${security_key},"app_name": "cabinet","version": "3.22.9.39","status": {"printer_status": "","bv_status": "","main_door_status": 0,"belly_door_status": 0,"drop_door_status": 0,"cashbox_door_status": 0,"logic_door_status": 0,"battery_1_low": 0,"battery_2_low": 1,"create_timestamp": 1663871424235},"notification_requests": ["com.pilotgames.common.messages.nd.TerminalDisable", "com.pilotgames.common.messages.nd.RequestSoftwareCommand", "com.pilotgames.common.messages.nd.SoftwareCommand", "com.pilotgames.common.messages.nd.GenericNotification"], "checksum": null}   

#${security_key}

*** Keywords ***
### HYDRA
Dado que seja iniciado uma sessao no servidor
    Dado que seja realizado a devida autenticação no servidor
    Create Session    hydra    https://ndsite3.hydrasystems.com.br:2780/pt/lobby_information/${token}

Quando o status code retornado for 200
    ${resp_hydra}    GET On Session    hydra    /    expected_status=200
    Set Test Variable    ${resp_hydra}
    Log To Console    ${resp_hydra.json()}

Então o jogo Break the Bank deve ocupar a posição 1
    Log    ${resp_hydra.status_code}
    Log    ${resp_hydra.text}
    Log    ${resp_hydra.elapsed}
    Dictionary Should Contain Key    ${resp_hydra.json()}    answer
    Log    ${resp_hydra.json()["answer"][0]["lobby_ordering"][0]}
    Dictionary Should Contain Item    ${resp_hydra.json()["answer"][0]["lobby_ordering"][0]}    title    Break the Bank

E o jogo Let's Go Wild deve ocupar a posição 15    
    Dictionary Should Contain Item    ${resp_hydra.json()["answer"][0]["lobby_ordering"][14]}    title    Let's Go Wild


#TOKEN

Dado que seja realizado a devida autenticação no servidor
 
    create session  postRequest        ${ndsite3}  verify=true
    ${response}=    POST On Session  postRequest  ${activate_endpoint}    ${activate_body} 
    Log    ${response.json()}
    #${token}   Get From Dictionary      ${response.json()["answer"][0]}    session_token
    #Set Suite Variable     ${token} 
    #Log To Console    ${token}

  








---------------------------------------------------------------------------------------------------------------------


 #Set Test Variable    ${VARIAVEL}    ${resp_json("order")}

    #Should Be Equal As Strings    15    ${resp_json.json()}[order]

    #${resp_json}=    GET On Session    jsonplaceholder    /posts/1

    #Should Be Equal As Strings    ${resp_google.status_code}    200

#Então deve retornar 15 jogos instalados
#${resposta_consulta}    GET On Session    hydra    /    expected_status=200

    # Obtendo as propriedades do objeto response
    #Log    ${resposta_consulta.status_code}
    #Log    ${resposta_consulta.reason}
    #Log    ${resposta_consulta.headers}
    #Log    ${resposta_consulta.elapsed}
    #Log    ${resposta_consulta.text}
    #Log    ${resposta_consulta.json()}

    #Set Test Variable    ${RESP_CONSULTA}    ${resposta_consulta.json()}

#Conferir os dados retornados
    #Log    ${RESP_CONSULTA}
    #Dictionary Should Contain Item    ${RESP_CONSULTA}    nome    Fulano da Silva
    #Dictionary Should Contain Item    ${RESP_CONSULTA}    email    ${EMAIL_TESTE}
    #Dictionary Should Contain Item    ${RESP_CONSULTA}    password    1234
    #Dictionary Should Contain Item    ${RESP_CONSULTA}    administrador    true
    #Dictionary Should Contain Item    ${RESP_CONSULTA}    _id    ${ID_USUARIO}

 #Consultar Jogos
    ${resposta_consulta}    GET On Session
    ...    alias=ServeRestHydra
    ...    url=/pt/lobby_information/67fc3410-5b63-41db-905a-4e27555da238
    ...    expected_status=200

    # Obtendo as propriedades do objeto response
    #Log    ${resposta_consulta.status_code}
    #Log    ${resposta_consulta.reason}
    #Log    ${resposta_consulta.headers}
    #Log    ${resposta_consulta.elapsed}
    #Log    ${resposta_consulta.text}
    #Log    ${resposta_consulta.json()}

    #Set Test Variable    ${RESP_CONSULTA}    ${resposta_consulta.json()}

#Hydra
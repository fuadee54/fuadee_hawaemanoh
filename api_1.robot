*** Settings ***
Library     RequestsLibrary

*** Test Cases ***
TC-001 Verify when Input wrong username or password api Should return error 
    Create Session          LoginSession1               http://localhost:8082
    ${request_body1}=       Create Dictionary           username=doppio1            password=12345   
    ${resp1}=               pOST On Session             loginSession1               /login                      json=${request_body1}       expected_status=401
    Should Be Equal         ${resp1.json()['status']}                               error           
    Should Be Equal         ${resp1.json()['message']}                              invalid username or password
    Log To Console          ${resp1.text}

TC-002 verify when login with valid username and password api Should be return success
    Create Session          LoginSession2               http://localhost:8082
    ${request_body2}=       Create Dictionary           username=doppio             password=weBuildBestQa
    ${resp2}=               POST On Session             LoginSession2               /login                      json=${request_body2}       expected_status=200
    ${token2}=              Set Variable                ${resp2.json()['message']}
    ${header2}=             Create Dictionary           token=${token2}
    ${get_resp2}=           Get On Session              LoginSession2               /assets                     headers=${header2}
    ${count2}=              get length                  ${get_resp2.json()}
    ${morethanone}=         evaluate                    ${count2} > 0
    Should be true          ${morethanone}
    status Should be        200

TC-003 verify that create new asset can passed
    Create Session      AssetSession3       http://localhost:8082
    ${userpass3}        CreateDictionary    username=doppio         password=weBuildBestQa
    ${login3}           POST On Session     AssetSession3           /login                  json=${userpass3}
    ${token3}           Set Variable        ${login3.json()['message']}
    ${token3.1}         CreateDictionary    token=${token3}
    ${newasset3}        CreateDictionary    assetId=a006             assetName=iphone19      assetType=2             inUse=True
    ${createnewasset3}  Post On Session     AssetSession3           /assets                  headers=${token3.1}     json=${newasset3} 
    status Should be        200

TC-004 Verify that can not create asset with duplicated assetId
    Create Session      Assetsession4       http://localhost:8082
    ${userpass4}        CreateDictionary    username=doppio         password=weBuildBestQa
    ${login4}           POST On Session     AssetSession4           /login                  json=${userpass4}
    ${token4}           Set Variable        ${login4.json()['message']}
    ${token4.1}         CreateDictionary    token=${token4}   
    ${newasset4}        CreateDictionary    assetId=a006             assetName=iphone19      assetType=2         inUse=True 
    ${createnewasset4}  Post On Session     AssetSession4           /assets                 json=${newasset4}   headers=${token4.1} 
    Should Be Equal     ${createnewasset4.json()['status']}         failed
    Should Be Equal     ${createnewasset4.json()['message']}        id : a006 is already exists , please try with another id

TC-005 verify that modify asset API can work Correctly
    Create Session      AssetSession5       http://localhost:8082
    ${userpass5}        CreateDictionary    username=doppio     password=weBuildBestQa
    ${login5}           POST On Session     AssetSession5       /login                  json=${userpass5}
    ${token5}           Set Variable        ${login5.json()['message']}
    ${token5.1}         CreateDictionary    token=${token5}
    ${createasset5}     CreateDictionary    assetId=a001        assetName=iphone25      assetType=2         
    ${modify5}          PUT On Session      AssetSession5       /assets                 json=${createasset5}   headers=${token5.1}
    Should be Equal     ${modify5.json()['status']}             success
    ${getasset5}        get on Session      AssetSession5       /assets                          headers=${token5.1}
    Should be Equal     ${getasset5.json()[0]['assetName']}     iphone25
    
TC6 verify that delete asset API can work Correctly
    Create Session      AssetSession6       http://localhost:8082

    ${userpass6}        CreateDictionary    username=doppio         password=weBuildBestQa
    ${login6}           POST On Session     AssetSession6           /login                  json=${userpass6}

    ${token6}           Set Variable        ${login6.json()['message']}
    ${token6.1}         CreateDictionary    token=${token6}

    ${delete6}          DELETE On Session   AssetSession6           /assets/a006         headers=${token6.1}    expected_status=200

    Should Be Equal     ${delete6.json()['status']}                 success
    log to Console      ${delete6.text}

    ${asset6}           get on Session      AssetSession6           /assets              headers=${token6.1}
    ${count6}           get length          ${asset6.json()}
    
    #Log To Console      Total IDs = ${count6}
    Log To Console      Remaining ID = ${count6}
    
    #แสดงเฉพาะ ID
    ${asset_json}=      Evaluate    json.loads($asset6.text)    json
    
    FOR    ${item}    IN    @{asset_json}
    Log To Console    ${item['assetId']}
    END

    
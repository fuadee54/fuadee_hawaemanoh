*** Settings ***
Library     RequestsLibrary

*** Variables ***

*** Keywords ***
 
*** Test Cases ***
#install JAVA --> 'java'                                = in cmd
#start API    --> 'java -jar doppio_api.jar'            = in cmd

TC1 verify that username and password invalid
    Create Session      Login Session       http://localhost:8082
    ${requestbody}      CreateDictionary    username=doppio1        password=weBuildBestQa
    ${resp}             POST On Session     Login Session           /login          
    ...                 json=${requestbody}                         expected_status=401  
    Should Be Equal     ${resp.json()['status']}                    error
    Should Be Equal     ${resp.json()['message']}                   invalid username or password
    Status Should Be    401

# TC2 Verify That username and password Correctly
#     Create Session      AssetSession        http://localhost:8082
#     ${userpass}         CreateDictionary    username=doppio         password=weBuildBestQa
#     ${login1}           POST On Session     AssetSession            /login                         json=${userpass}
#     ...                 expected_status=200
#     ${token1}           Set Variable        ${login1.json()['message']}
#     ${token1.1}         CreateDictionary    token=${token1}
#     ### call get api to get asset (with token) and verify that status code is 200
#     ${getasset1}        Get On Session      AssetSession            /assets                         headers=${token1.1}     expected_status=200
#     ### check response contains at least 1 asset
#     ${count1}           Get Length          ${getasset1.json()}
#     ${morethan1}        Evaluate            ${count1} > 0
#     Should Be True      ${morethan1}
    

# TC3 verify that get asset API always require valid token
#     Create Session      AssetSession3       http://localhost:8082
#     ${userpass3}        CreateDictionary    username=doppio         password=weBuildBestQa
#     ${login3}           POST On Session     AssetSession3           /login                          json=${userpass3}
#     ${intoken3}         Set Variable        1234567890
#     ${intoken3.1}       CreateDictionary    token=${intoken3}
#     ${getasset3}        Get On Session      AssetSession3           /assets                         headers=${intoken3.1}
#     ...                 expected_status=401 
#     Should Be Equal     ${Getasset3.json()['status']}               error

# TC4 verify that create asset API can work Correctly
#     Create Session      AssetSession4       http://localhost:8082
#     ${userpass4}        CreateDictionary    username=doppio         password=weBuildBestQa
#     ${login4}           POST On Session     AssetSession4           /login                  json=${userpass4}
#     ${token4}           Set Variable        ${login4.json()['message']}
#     ${token4.1}         CreateDictionary    token=${token4}
#     ${newasset4}        CreateDictionary    assetId=a004             assetName=iphone19      assetType=2         inUse=True
#     ${createnewasset4}  Post On Session     AssetSession4           /assets                 json=${newasset4}   headers=${token4.1}    expected_status=200

# TC5 verify that can not create asset with duplicated assetId
#     Create Session      AssetSession5       http://localhost:8082

#     ${userpass5}        CreateDictionary    username=doppio         password=weBuildBestQa
#     ${login5}           POST On Session     AssetSession5           /login                  json=${userpass5}

#     ${token5}           Set Variable        ${login5.json()['message']}
#     ${token5.1}         CreateDictionary    token=${token5}
    
#     ${newasset5}        CreateDictionary    assetId=007             assetName=iphone19      assetType=2         inUse=True
    
#     ${createnewasset5}  Post On Session     AssetSession5           /assets                 json=${newasset5}   headers=${token5.1}
    
#     Should Be Equal     ${createnewasset5.json()['status']}         failed
#     Should Be Equal     ${createnewasset5.json()['message']}        id : 007 is already exists , please try with another id

# TC6 verify that modify asset API can work Correctly
    # Create Session      AssetSession6       http://localhost:8082
    
    # ${userpass6}        CreateDictionary    username=doppio     password=weBuildBestQa
    # ${login6}           POST On Session     AssetSession6       /login                  json=${userpass6}

    # ${token6}           Set Variable        ${login6.json()['message']}
    # ${token6.1}         CreateDictionary    token=${token6}

    # ${createasset6}     CreateDictionary    assetId=a004             assetName=iphone20      assetType=2         

    # ${modify6}          PUT On Session      AssetSession6           /assets                 json=${createasset6}   headers=${token6.1}

# TC7 verify that delete asset API can work Correctly
#     Create Session      AssetSession7       http://localhost:8082

#     ${userpass7}        CreateDictionary    username=doppio     password=weBuildBestQa
#     ${login7}           POST On Session     AssetSession7       /login                  json=${userpass7}

#     ${token7}           Set Variable        ${login7.json()['message']}
#     ${token7.1}         CreateDictionary    token=${token7}

#     ${delete7}          DELETE On Session   AssetSession7           /assets/a003         headers=${token7.1}
#     ...                 expected_status=200

#     Should Be Equal     ${delete7.json()['status']}                 success
              

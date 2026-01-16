*** Settings ***
Library         SeleniumLibrary

*** Keywords ***
openbrowser1
    open browser                ${web1}                                                         edge

*** Variables ***
${web1}                         https://the-internet.herokuapp.com 
    

*** Test Cases ***
Test 1 
	open browser	            https://the-internet.herokuapp.com                              edge
	Page Should Contain         the-internet
    #sleep                       5

Test 2
    Go To                       https://the-internet.herokuapp.com/login
    Input text                  xpath=//input[@type='text']                                     tomsmith
    Input text                  xpath=//input[@type='password']                                 SuperSecretPassword!
    click element               xpath=//button/i[@class='fa fa-2x fa-sign-in']
    Page Should Contain         You logged into a secure area!
    click element               xpath=//div//i[@class='icon-2x icon-signout']
    #sleep                       5
    close browser

Test 3
    open browser                ${web1}/login                                                   edge
    Input text                  xpath=//input[@type='text']                                     wrong
    Input text                  xpath=//input[@type='password']                                 wrong
    click element               xpath=//button/i[@class='fa fa-2x fa-sign-in']
    Page Should Contain         Your username is invalid!
    sleep                       5
    close browser

Test 4
    open browser                ${web1}/checkboxes                                              edge
    Checkbox Should Not Be Selected     xpath=//*[@id="checkboxes"]/input[1]
    click element               xpath=//*[@id="checkboxes"]/input[1]
    Checkbox Should Be Selected         xpath=//*[@id="checkboxes"]/input[1]
    close browser

Test 5
    open browser                ${web1}/dropdown                                                edge
    Select From List By label   xpath=//Select                                                  Option 1
    List Selection Should Be    xpath=//Select                                                  Option 1

Test 6
    open browser                ${web1}//add_remove_elements/                                   edge
    sleep                       5
    click element               xpath=//*[@id="content"]/div/button
    Element Should Be Visible   id=elements
    click element               xpath=//*[@id="elements"]/button
    Wait Until Element Is Not Visible   xpath=//*[@id="elements"]/button
    Element Should Not Be Visible       xpath=//*[@id="elements"]/button
    sleep                       5

Test 7
    open browser                ${web1}/javascript_alerts                                       edge
    click element               xpath=//button[@onclick='jsAlert()']
    Handle Alert                ACCEPT
    Element text Should Be      id=result                                                       You successfully clicked an alert

Test 8
    open browser                ${web1}/upload                                                  edge
    Choose File                 id=file-upload                                                  D:/QA/QA_TEST1/T1.txt
    click element               id=file-submit
    Element Text Should Be      id=uploaded-files                                               T1.txt

*** Settings ***
Library		SeleniumLibrary


*** Variables ***
${message}		My Message



*** Keywords ***

Input01
	Input text			xpath=//textarea[@title='ค้นหา']	${message}


*** Test Cases ***

# TC-00 Verify that when ...
# 	#เปิดบราวเซอร์
# 	#Open Browser	http://www.google.com		Edge
# 	#กรอกข้อมูล
# 	##Click Element	xpath=/html/body/div[1]/div[3]/form/div[1]/div[1]/div[4]/center/input[1]

# 	#เปิดบราวเซอร์
# 	Open Browser	https://thaimooc.org/course?keys=	Edge
# 	#เลือก Drop Down List
# 	#Select From List By Label	xpath=//select[@name='cityid']	26- นราธิวาส
# 	#ติ๊ก CheckBox
# 	Click Element	xpath=//input[@id='course-category-taxonomy-634']
# 	Click Element	xpath=//input[@id='course-category-taxonomy-636']	
# 	#หยุดสลีปการทำงานชั่วขณะ
# 	sleep	10

# TC-01 Verify.
#     Open Browser                        https://www.nokair.com/                             Edge
#     Maximize Browser Window
#     Wait Until Page Contains Element    xpath=//li[a[text()='Log in']]                                     
#     Click Element                       xpath=//li[a[text()='Log in']]
#     Wait Until Page Contains Element    xpath=//div[h1[text()='Home']]
#     Click Element                       xpath=/html/body/div[1]/div[1]/main/div/div/div/div/form/div[4]/button[1]
#     Wait Until Page Contains Element    xpath=//label[span[text()='Thai resident']]
#     Select From List By Label           xpath=//select[@id='profile-register-title']        MR
#     Input text                          xpath=//input[@id='profile-register-first-name']    fuadee
#     Click Element                       xpath=//label[span[text()='Thai resident']]
#     Click Element                       xpath=//label[span[text()='Yes, I want to subscribe.']]
#     sleep   15                     

TC-02
    Open Browser    file:///D:/Learning/for_doppio_youtube/ep01_material%20(1)/ep01/ep01_small_excercise.html   Edge
    Maximize Browser Window
    input text                  id=username-box                                    fuadee
    input text                  xpath=//div[@v='password']/input[@type='text']     12345
    input text                  xpath=//input[@doppio='nickname']                  fu
    Select From List By Label   xpath=//select[@name='com']                        Doppio
    Click Element               id=op1
    Click Element               id=use-me
    sleep                       10
    Handle Alert                ACCEPT
    sleep                       10
   
    
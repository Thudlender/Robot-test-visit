*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Resource    ../resources/variables.robot

*** Keywords ***
Open Google To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5s
    Set Selenium Implicit Wait    10s

# Click Login With Google
#     Click Element    id:btn-login

Click Login With Google
    ${main_window}=    Get Window Handle
    ${existing_windows}=    Get Window Handles

 Wait Until Keyword Succeeds    10x    1s    Popup Window Should Open    ${existing_windows}
    ${popup_window}=    Get New Window Handle    ${existing_windows}
    Switch Window    handle=${popup_window}

Handle Google Login In Popup
    Wait Until Element Is Visible    xpath=//input[@type="email"]
    Input Text    xpath=//input[@type="email"]    ${GOOGLE_EMAIL}
    Click Button    xpath=//button/span[contains(text(), "Next")]

    Wait Until Element Is Visible    xpath=//input[@type="password"]
    Input Password    xpath=//input[@type="password"]    ${GOOGLE_PASSWORD}
    Click Button    xpath=//button/span[contains(text(), "Next")]

    Sleep    2s    # wait for Firebase to finish
    Switch Window    index=0    # return to main window

Popup Window Should Open
    [Arguments]    ${previous_windows}
    ${current_windows}=    Get Window Handles
    ${new_windows}=    Evaluate    [w for w in ${current_windows} if w not in ${previous_windows}]
    Should Not Be Empty    ${new_windows}

Get New Window Handle
    [Arguments]    ${previous_windows}
    ${current_windows}=    Get Window Handles
    ${new_windows}=    Evaluate    [w for w in ${current_windows} if w not in ${previous_windows}]
    [Return]    ${new_windows}[0]

    Wait Until Page Contains Element    id:add_personnel_btn  #เปลี่ยนเป็น id ปุ่มของหน้าเว็บรึอะไรก็ได้ ของเรา


Prefix Dropdown
    [Arguments]    ${PREFIX}
    Select From List By Label    xpath=//select[@id="prefix"]    ${PREFIX}
Input First Name
    [Arguments]    ${FIRST_NAME}    
    Input Text   ${FIRST_NAME_FIELD}    ${FIRST_NAME}

Input Last Name
    [Arguments]    ${LAST_NAME}
    Input Text   ${LAST_NAME_FIELD}    ${LAST_NAME}

Input User ID
    [Arguments]    ${USER_ID}
    Input Text   ${USER_ID_FIELD}    ${USER_ID}

Input Phone Number
    [Arguments]    ${PHONE_NUMBER}
    Input Text   ${PHONE_NUMBER_FIELD}    ${PHONE_NUMBER}

Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${filename}=     Set Variable    ${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}


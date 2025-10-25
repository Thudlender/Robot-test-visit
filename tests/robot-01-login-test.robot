*** Settings ***
Documentation   Test Case สำหรับทดสอบการล็อกอินด้วยบัญชี Google ผ่าน OAuth
Library     SeleniumLibrary
Library    OperatingSystem
Resource    ../resources/keywords.robot
Resource    ../resources/variables.robot


*** Test Cases ***
TC1001 - Login With Google Account
    [Documentation]    ทดสอบล็อกอินด้วยบัญชี Google
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Click Element    xpath=//*[@id="privacy_checkbox"]
    Click Element    xpath=//*[@id="privacy_modal"]/div/div[2]/form/button
    Click Element    id=btn-login
    Login With Google OAuth    ${USERNAME}    ${PASSWORD}
    Wait Until Page Contains    เข้าสู่ระบบสำเร็จ    timeout=20s
    

    Capture Page Screenshot with Name    TC1001_Success
    Close Browser
    [Teardown]    Close Browser

*** Keywords ***

Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${folder}=       Set Variable    ${EXECDIR}/results/Login_results
    Create Directory    ${folder}
    ${filename}=     Set Variable    ${folder}/${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}
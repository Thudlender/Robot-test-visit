*** Settings ***
Documentation    ฟังก์ชั่นการจัดการช่วงเวลานัดวันเยี่ยมบ้าน (Admin Schedule Management)
Library     SeleniumLibrary
Library    OperatingSystem
Resource     ../resources/keywords.robot
Resource     ../resources/variables.robot

*** Test Cases ***

TC1901 - เจ้าหน้าที่ฝ่ายทะเบียนกำหนดช่วงเวลานัดเยี่ยมบ้านสำเร็จ
    [Documentation]    ทดสอบการกำหนดช่วงเวลานัดเยี่ยมบ้านของเจ้าหน้าที่ฝ่ายทะเบียน
    # เปิดเบราว์เซอร์ที่ URL ที่กำหนด โดยใช้ browser ที่ระบุ
    Open Browser    ${URL}    ${BROWSER}
    # ขยายหน้าต่างเบราว์เซอร์ให้เต็มจอ เพื่อป้องกันปัญหา element ไม่แสดง
    Maximize Browser Window
    # คลิกที่ checkbox ยอมรับนโยบายความเป็นส่วนตัว
    Click Element    xpath=//*[@id="privacy_checkbox"]
    # คลิกปุ่ม เข้าใจและยอมรับ
    Click Element    xpath=//*[@id="privacy_modal"]/div/div[2]/form/button
    # คลิกปุ่ม login เพื่อเริ่มกระบวนการล็อกอิน
    Click Element    id=btn-login
    # เรียกใช้ keyword สำหรับล็อกอินผ่าน Google OAuth โดยส่ง username และ password
    Login With Google OAuth    ${USERNAME}    ${PASSWORD}
    # รอ 5 วินาที เพื่อให้กระบวนการล็อกอินเสร็จสมบูรณ์
    Sleep    5s

    # --- Verify Login Page ---
    Page Should Contain    รายชื่อบุคลากร
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s

    Capture Page Screenshot With Name    TC1901_Admin_Schedule_Success
    Close Browser

*** Keywords ***




Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${folder}=       Set Variable    ${EXECDIR}/results/Admin_Schedule_results
    Create Directory    ${folder}
    ${filename}=     Set Variable    ${folder}/${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}
*** Settings ***
Documentation    ฟังก์ชันการจัดการข้อมูลการเยี่ยมบ้านนักเรียน
Library     SeleniumLibrary
Library    OperatingSystem
Resource     ../resources/keywords.robot
Resource     ../resources/variables.robot


*** Variables ***
${HOUSE_PHOTO_INPUT}    //*[@id="root"]/div[2]/div/form/div[1]/div[1]/div[1]/input[@type="file"]
${FAMILY_PHOTO_INPUT}   //*[@id="root"]/div[2]/div/form/div[1]/div[2]/div[1]/div

# --- File Path ---
${HOUSE_1_IMAGE}    ${EXECDIR}/resources/Teacher_Visits_photo/House1.jpg
${FAMILY_1_IMAGE}   ${EXECDIR}/resources/Teacher_Visits_photo/Family1.jpg

*** Test Cases ***
TC1301 - คุณครูกรอกข้อมูลการเยี่ยมบ้านสำเร็จ
    [Documentation]    ทดสอบการกรอกข้อมูลการเยี่ยมบ้านสำเร็จ
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
    # --- สลับเป็นคุณครู ---
    Click Element  xpath=//*[@id="btn-switch-navbar"]
    Sleep    5s
    # --- เลือกปี ---
    ํYear Dropdown    2568
    Sleep    3s
    # --- เลือกนักเรียน ---
    Click Element  xpath=//*[@id="root"]/div[2]/div/div[4]/div/table/tbody/tr[5]/td[1]
    # --- กดปุ่มผลการเยี่ยมบ้าน ---
    Click Element  xpath=//*[@id="manage_student_68ca61cdbd8da69c0f327228"]/div/div/a[5]
    Sleep    5s
    # --- กรอกข้อมูลการเยี่ยมบ้าน ---
    # --- ทำให้ Path ของไฟล์ถูกต้อง 100% ---
    ${absolute_path} =    Normalize Path    ${HOUSE_1_IMAGE}
    Log    File path to upload is: ${absolute_path}

    Choose File    ${HOUSE_PHOTO_INPUT}    ${absolute_path}
    
    # --- Verify Submit Page ---
    Page Should Contain    สร้างข้อมูลสำเร็จ    timeout=10s

    Capture Page Screenshot With Name    TC1301_Teacher_Visits_Success
    Close Browser


*** Keywords ***

ํYear Dropdown
    [Arguments]    ${YEAR}
    Select From List By Label    xpath=//*[@id="year-selector"]    ${YEAR}

Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${folder}=       Set Variable    ${EXECDIR}/results/Teacher_Visit_results
    Create Directory    ${folder}
    ${filename}=     Set Variable    ${folder}/${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}







*** Settings ***
Documentation    ฟังก์ชั่นแบบฟอร์มประเมิน SDQ (คุณครู)
Library     SeleniumLibrary
Library    OperatingSystem
Resource     ../resources/keywords.robot
Resource     ../resources/variables.robot
Resource     ../resources/06-teacher-sdq-keywords.robot

*** Variables ***


*** Test Cases ***

TC9001 - คุณครูทำแบบประเมิน SDQ ประเมินนักเรียนสำเร็จ
    [Documentation]    ทดสอบการประเมิน SDQ ของคุณครู
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
    # Click Element  xpath=//*[@id="root"]/div[2]/div/div[4]/div/table/tbody/tr[5]/td[1]
    Click Element  xpath=//*[@id="student_4"]
    Sleep    5s
    # --- กดปุ่มประเมิน SDQ ---
    # Click Element  xpath=//*[@id="manage_student_68ca61cdbd8da69c0f327228"]/div/div/a[1]
    Click Element    xpath=//*[@id="sdq_teacher"]
    Sleep    5s
    # --- ทำแบบฟอร์มประเมิน SDQ ---
    # Answer SDQ Page 1
    Answer SDQ Page 2
    Answer SDQ Page 3
    Answer SDQ Page 4
    Answer SDQ Page 5
    Answer SDQ Page 6
    Sleep    3s
    # --- Verify Submit Page ---
    Page Should Contain    เพิ่มข้อมูล SDQ สำเร็จ    timeout=10s

    Capture Page Screenshot With Name    TC9001_SDQ Assessment_Success
    Close Browser

TC9002 - คุณครูทำแบบประเมิน SDQ ประเมินนักเรียนไม่สำเร็จ(กดข้ามหน้าโดยไม่เลือกตัวเลือกข้อใดเลย)
    [Documentation]    ทดสอบการประเมิน SDQ ของคุณครูโดยไม่เลือกตัวเลือกข้อใดเลย
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
    # --- เลือกปี ---
    ํYear Dropdown    2568
    # --- เลือกนักเรียน ---
    Click Element  xpath=//*[@id="root"]/div[2]/div/div[4]/div/table/tbody/tr[6]/td[1]
    # --- กดปุ่มประเมิน SDQ ---
    Click Element  xpath=//*[@id="manage_student_68e6bb2e7a3a9c428012c369"]/div/div/a[1]
    Sleep    5s
    # --- ถัดไปหน้า 2 ---
    Click Button    xpath=//*[@id="next-button-page1"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="root"]/div[2]/div/form/div/div/div[2]/div[1]/div[5]/div[2]    timeout=10s
    Element Text Should Be    xpath=//*[@id="root"]/div[2]/div/form/div/div/div[2]/div[1]/div[5]/div[2]    กรุณาเลือกคำตอบ

    Capture Page Screenshot With Name    TC9002_SDQ Assessment_Error
    Close Browser

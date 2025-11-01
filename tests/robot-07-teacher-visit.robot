*** Settings ***
Documentation    ฟังก์ชันการจัดการข้อมูลการเยี่ยมบ้านนักเรียน
Library     SeleniumLibrary
Library    OperatingSystem
Resource     ../resources/keywords.robot
Resource     ../resources/variables.robot
Resource     ../resources/07-teacher-visit-keywords.robot


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
    Choose Student
    Sleep    10s
    # --- กดปุ่มผลการเยี่ยมบ้าน ---
    Click Button  xpath=//*[@id="visit_add"]
    Sleep    5s
    # --- กรอกข้อมูลการเยี่ยมบ้าน ---
    # --- ทำให้ Path ของไฟล์ถูกต้อง 100% ---
    # ${absolute_path} =    Normalize Path    ${HOUSE_1_IMAGE}
    # Log    File path to upload is: ${absolute_path}
    # #--- อัพโหลดรูปภาพถ่ายที่อยู่อาศัย ---
    # Choose File    ${HOUSE_PHOTO_INPUT}    ${absolute_path}

    # ${absolute_path} =    Normalize Path    ${FAMILY_1_IMAGE}
    # Log    File path to upload is: ${absolute_path}
    # #--- อัพโหลดรูปภาพถ่ายครอบครัว ---    
    # Choose File    ${FAMILY_PHOTO_INPUT}    ${absolute_path}
    
    House Photo
    Family Photo

    # --- กรอกคำอธิบายสภาพบ้าน ---
    Input House Description    หลังคาบ้านรั่วมีปลวกกิน
    Input Family Description    ครอบครัวมีความขัดแย้ง
    # Input Teacher Comment    ครอบครัวนี้ต้องมีการปรับปรุง
    # --- กดปุ่มบันทึกข้อมูล ---
    Save Visit Home Button

    Capture Page Screenshot With Name    TC1301_Teacher_Visits_Success
    Close Browser







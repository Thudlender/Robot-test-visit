*** Settings ***
Documentation    ชุดการทดสอบสำหรับระบบจัดการข้อมูลบุคลากร (Personnel Management)
Library     SeleniumLibrary
Library    OperatingSystem
Resource     ../resources/keywords.robot
Resource     ../resources/variables.robot
# Resource     ../resources./Variables/Personnel_Variable.robot

*** Variables ***
${FIRST_NAME_FIELD}    id:add-personnel-firstname-input
${LAST_NAME_FIELD}     id:add-personnel-lastname-input
${USER_ID_FIELD}       id:add-personnel-userid-input    
${PHONE_NUMBER_FIELD}  id:add-personnel-phone-input

${PREFIX_ERROR_MSG}    id="error_prefix"
${FIRST_NAME_ERROR_MSG}    id="error_firstname"
${LAST_NAME_ERROR_MSG}     id="error_lastname"
${USER_ID_ERROR_MSG}    id="error_userid"
${PHONE_NUMBER_ERROR_MSG}  id="error_phone"


*** Test Cases ***
    
TC1401 - Add New Personnel Successfully
    [Documentation]    Test case to add new personnel with valid data

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
    # --- Add Personnel Button ---
    Add Teacher     
    # --- กรอกข้อมูลบุคลากร ---
    Prefix Dropdown    นาย 
    Input First Name    สมชาย
    Input Last Name    ใจดี
    Input User ID    055
    Input Phone Number    0457789643
    Submit Personnel Info
    
    Capture Page Screenshot with Name    TC14001_Success
    Close Browser

TC1402 - Add New Personnel without selecting prefix
    [Documentation]    Test case to add new personnel without selecting prefix
   
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
    # --- Add Personnel Button ---
    Add Teacher
    # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
    Input First Name     กิตติศักดิ์    
    Input Last Name     สมบูรณ์
    Input User ID     013
    Input Phone Number     0652249576
    Click Button    xpath=//button[@id="add-personnel-submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="prefix-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="prefix-error"]    กรุณาเลือกคำนำหน้า

    Capture Page Screenshot With Name    TC14002_Validation
    Close Browser

TC1403 - Add New Personnel without First Name
    [Documentation]    Test case to add new personnel without First Name
   
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
    # --- Add Personnel Button ---
    Add Teacher
    # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
    Prefix Dropdown    นาย
    Input Last Name     สมบูรณ์
    Input User ID     013
    Input Phone Number     0652249576
    Click Button    xpath=//button[@id="add-personnel-submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="first_name-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="first_name-error"]    กรุณากรอกชื่อ 

    Capture Page Screenshot With Name    TC14003_Validation
    Close Browser

TC1404- Add New Personnel without Last Name
    [Documentation]    Test case to add new personnel without Last Name
    
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
   # --- Add Personnel Button ---
    Add Teacher
    # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
    Prefix Dropdown    นาย
    Input First Name     กิตติศักดิ์ 
    Input User ID     013
    Input Phone Number     0652249576
    Click Button    xpath=//button[@id="add-personnel-submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="last_name-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="last_name-error"]    กรุณากรอกนามสกุล

    Capture Page Screenshot With Name    TC14004_Validation
    Close Browser

TC1405 Add New Personnel without User ID
    [Documentation]    Test case to add new personnel without User ID
    
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
    # --- Add Personnel Button ---
    Add Teacher
    # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
    Prefix Dropdown    นาย
    Input First Name     กิตติศักดิ์ 
    Input Last Name     สมบูรณ์
    Input Phone Number     0652249576
    Click Button    xpath=//button[@id="add-personnel-submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="user_id-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="user_id-error"]    กรุณากรอกเลขที่ประจำตัวบุคลากร

    Capture Page Screenshot With Name    TC14005_Validation
    Close Browser

TC1406 Add New Personnel without Phone Number
    [Documentation]    Test case to add new personnel without Phone Number
   
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
    # --- Add Personnel Button ---
    Add Teacher
    # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
    Prefix Dropdown    นาย
    Input First Name     กิตติศักดิ์ 
    Input Last Name     สมบูรณ์
    Input User ID     013
    Click Button    xpath=//button[@id="add-personnel-submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="phone-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="phone-error"]    กรุณากรอกเบอร์โทรศัพท์

    Capture Page Screenshot With Name    TC14006_Validation
    Close Browser

TC1407 Add New Personnel But Input English First Name
    [Documentation]    Test case to add new personnel But Input English First Name
    
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
    # --- Add Personnel Button ---
    Add Teacher
    # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
    Prefix Dropdown    นาย
    Input First Name     Kittisak
    Input Last Name     สมบูรณ์
    Input User ID     013
    Input Phone Number     0652249576
    Click Button    xpath=//button[@id="add-personnel-submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="first_name-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="first_name-error"]    จำเป็นต้องเป็นภาษาไทย

    Capture Page Screenshot With Name    TC14007_Validation_EnglishFirstName
    Close Browser

TC1408 Add New Personnel But Input English Last Name
    [Documentation]    Test case to add new personnel But Input English Last Name
    
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
    # --- Add Personnel Button ---
    Add Teacher
    # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
    Prefix Dropdown    นาย
    Input First Name     กิตติศักดิ์
    Input Last Name     Somboon
    Input User ID     013
    Input Phone Number     0652249576
    Click Button    xpath=//button[@id="add-personnel-submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="last_name-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="last_name-error"]    จำเป็นต้องเป็นภาษาไทย

    Capture Page Screenshot With Name    TC14008_Validation_EnglishLastName
    Close Browser

TC1409 Add New Personnel But Input English And SpecialChar To User ID
    [Documentation]    Test case to add new personnel But Input English And SpecialChar To User ID
    
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
    # --- Add Personnel Button ---
    Add Teacher
    # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
    Prefix Dropdown    นาย
    Input First Name     กิตติศักดิ์
    Input Last Name     สมบูรณ์
    Input User ID     zeroonethree#
    Input Phone Number     0652249576
    Click Button    xpath=//button[@id="add-personnel-submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="user_id-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="user_id-error"]    กรุณากรอกเลขที่ประจำตัวบุคลากรให้ถูกต้อง 

    Capture Page Screenshot With Name    TC14009_Validation_EnglishAndSpecialCharUserID
    Close Browser

TC1410 Add New Personnel But Input English And SpecialChar To Phone Number
    [Documentation]    Test case to add new personnel But Input English And SpecialChar To Phone Number
   
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
    # --- Add Personnel Button ---
    Add Teacher
    # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
    Prefix Dropdown    นาย
    Input First Name     กิตติศักดิ์
    Input Last Name     สมบูรณ์
    Input User ID     013
    Input Phone Number     PhoneNumber#
    Click Button    xpath=//button[@id="add-personnel-submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="phone-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="phone-error"]    กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง

    Capture Page Screenshot With Name    TC14010_Validation_EnglishAndSpecialCharPhoneNumber
    Close Browser

TC1411 Edit Personnel Successfully
    [Documentation]    Test case to edit personnel information successfully
    
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
    # --- Edit Personnel Button ---
    Edit personnel
    # --- กรอกข้อมูลบุคลากร
    Prefix Dropdown    นาง
    Input First Name     พิมพร
    Input Last Name     สุขดี
    Input Phone Number     0864479528
    Status Dropdown    ไม่ได้ใช้งานแล้ว
    Save Edit Personnel
 
    Capture Page Screenshot With Name    TC14011_EditPersonnel_Success
    Close Browser

TC1412 Delete Personnel Successfully
    [Documentation]    Test case to delete personnel information successfully
    
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
    Delete personnel

    Capture Page Screenshot With Name    TC14012_Delete_Personnel_Success
    Close Browser

TC1413 Add Admin Role Successfully
    [Documentation]    Test case to add admin role to personnel successfully
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
    # --- Navigate to Admin Role Page ---
    Click Element    xpath=//*[@id="root"]/div[1]/div[2]/ul/li[3]/a
    # --- Toggle Add Admin Role ---
    Toggle Add Admin Role

    Capture Page Screenshot With Name    TC14013_AddAdminRole_Success
    Close Browser

TC1414 Delete Admin Role Successfully
    [Documentation]    Test case to delete admin role from personnel successfully
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
    # --- Navigate to Admin Role Page ---
    Click Element    xpath=//*[@id="root"]/div[1]/div[2]/ul/li[3]/a
    # --- Toggle Delete Admin Role ---
    Toggle Delete Admin Role

    Capture Page Screenshot With Name    TC14014_DeleteAdminRole_Success
    Close Browser



*** Keywords ***

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

Add Teacher
    Click Element   xpath=//*[@id="root"]/div[2]/div/div[2]/div/div[3]/button  

# id:"add_personnel_btn"

Submit Personnel Info
    Click Button    xpath=//button[@id="add-personnel-submit-button"]
    Wait Until Page Contains   เพิ่มข้อมูลครูที่ปรึกษาเรียบร้อย   timeout=10s

Edit personnel
    Click Element    xpath=//*[@id="edit-personnel-button_68d2da4f356d2286cd4060f7"]

Save Edit Personnel
    Click Button    xpath=//*[@id="edit_personnel_68d2da4f356d2286cd4060f7"]/div/form/div[2]/div/button[1]
    Wait Until Page Contains   อัพเดทข้อมูลครูที่ปรึกษาเรียบร้อย   timeout=10s

Delete personnel
    Click Element    xpath=//*[@id="delete-personnel-button_6"]
    # --- Confirm Deletion in Modal --- 
    Click Button    xpath=/html/body/div[2]/div/div[6]/button[1]
    Wait Until Page Contains   ลบข้อมูลเรียบร้อย   timeout=10s

Status Dropdown
    [Arguments]    ${STATUS}
    Select From List By Label    xpath=//select[@id="status"]    ${STATUS}

Select Option
    [Arguments]    ${OPTION}
    Select From List By Label    xpath=//*[@id="selectedOption"]    ${OPTION}

Toggle Add Admin Role
    Click Button    xpath=//*[@id="admin-role-toggle_9"]
    Wait Until Page Contains   เพิ่มสิทธ์ผู้ดูแลให้ นาย กิตติศักดิ์ สำเร็จ   timeout=10s

Toggle Delete Admin Role
    Click Button    xpath=//*[@id="admin-role-toggle_9"] 
    # --- Confirm Deletion in Modal --- 
    Click Button    xpath=/html/body/div[2]/div/div[6]/button[1]
    Wait Until Page Contains   ลบสิทธ์ผู้ดูแลให้ นายกิตติศักดิ์ สำเร็จ   timeout=10s

Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${folder}=       Set Variable    ${EXECDIR}/results/Personnel_results
    Create Directory    ${folder}
    ${filename}=     Set Variable    ${folder}/${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}


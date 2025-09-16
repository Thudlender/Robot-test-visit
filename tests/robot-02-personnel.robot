*** Settings ***
Documentation    ชุดการทดสอบสำหรับระบบจัดการข้อมูลบุคลากร (Personnel Management)
...               ครอบคลุมการทดสอบฟังก์ชันเพิ่มบุคลากรใหม่
...               และการตรวจสอบความถูกต้องของข้อมูล (Validation) บนฟอร์ม
Library     SeleniumLibrary
Resource     ../resources/keywords.robot
Resource     ../resources/variables.robot

*** Variables ***
${PREFIX_ERROR_MSG}  xpath=//*[@id="add_personnel"]/div/form/div/div[1]/div
${FIRST_NAME_ERROR_MSG}    กรุณากรอกชื่อ
${LAST_NAME_ERROR_MSG}     กรุณากรอกนามสกุล
${USER_ID_ERROR_MSG}       กรุณากรอกเลขที่ประจำตัวบุคลากร
${PHONE_NUMBER_ERROR_MSG}  

${CONFIRM_DELETE_BUTTON}  id:confirm_delete_personnel
${CANCEL_DELETE_BUTTON}   id:cancel_delete_personnel
# --- ลบข้อมูล Personnel สำเร็จ ---
${SUCCESS_ALERT}            xpath=//div[text()='ลบข้อมูลเรียบร้อย']

*** Test Cases ***
TC14001 - Add New Personnel Successfully
    [Documentation]    Test case to add new personnel with valid data
    [Tags]             add, smoke, positive, personnel, regression
    [Setup]            Open Google To Login Page

    # --- Login ---
    Click Element    id:btn-login
    # --- Verify Login Page ---
    Handle Google Login

    Click Element     id:add_personnel_btn

    # --- กรอกข้อมูลบุคลากร ---
    Select From List By Label    นาย
    Input First Name    กิตติศักดิ์
    Input Last Name    สมบูรณ์
    Input User ID    013
    Input Phone Number    0652249576
    Submit Personnel Info
    Page Should Contain    เพิ่มข้อมูลเรียบร้อย
    
    Capture Page Screenshot with Name    TC14001_Success
    [Teardown]    Close Browser

# TC14002 - Add New Personnel without selecting prefix
#     [Documentation]    Test case to add new personnel without selecting prefix
#     [Tags]             validation, negative, personnel
#     [Setup]            Open Google To Login Page

#     Click Element    id:btn-login

#     # --- Verify Login Page ---
#     Page Should Contain    รายชื่อบุคลากร
#     Click Element     id:add_personnel_btn

#     # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
#     Input First Name     กิตติศักดิ์    
#     Input Last Name     สมบูรณ์
#     Input User ID     013
#     Input Phone Number     0652249576
#     Submit Personnel Info

#     # 3. ตรวจสอบว่าข้อความแจ้งเตือนของ "ชื่อ" แสดงขึ้นมาอย่างถูกต้อง
#     # Validation Message Should Be Visible ......
#     # --- ตรวจสอบผลลัพธ์ ---
#     Page Should Contain    กรุณาเลือกคำนำหน้า
    
#     Page Should Contain    กรุณากรอกนามสกุล
#     Page Should Contain    กรุณากรอกรหัสนักศึกษา/รหัสพนักงาน
#     Page Should Contain    กรุณากรอกหมายเลขโทรศัพท์

#     Capture Page Screenshot With Name    TC14002_Validation
#     [Teardown]    Close Browser

# TC14003 - Add New Personnel without First Name
#     [Documentation]    Test case to add new personnel without First Name
#     [Tags]             validation, negative, personnel
#     [Setup]            Open Google To Login Page

#     Click Element    id:btn-login

#     # --- Verify Login Page ---
#     Page Should Contain    รายชื่อบุคลากร
#     Click Element     id:add_personnel_btn

#     # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
#     Select From List By Label    นาย
#     Input Last Name     สมบูรณ์
#     Input User ID     013
#     Input Phone Number     0652249576
#     Submit Personnel Info

#     # 3. ตรวจสอบว่าข้อความแจ้งเตือนของ "ชื่อ" แสดงขึ้นมาอย่างถูกต้อง
#     # Validation Message Should Be Visible ......
#     # --- ตรวจสอบผลลัพธ์ ---
#     Page Should Contain    กรุณากรอกชื่อ

#     Capture Page Screenshot With Name    TC14003_Validation
#     [Teardown]    Close Browser

# TC14004- Add New Personnel without Last Name
#     [Documentation]    Test case to add new personnel without Last Name
#     [Tags]             validation, negative, personnel
#     [Setup]            Open Google To Login Page

#     Click Element    id:btn-login

#     # --- Verify Login Page ---
#     Page Should Contain    รายชื่อบุคลากร
#     Click Element     id:add_personnel_btn

#     # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
#     Select From List By Label    นาย
#     Input First Name     กิตติศักดิ์ 
#     Input User ID     013
#     Input Phone Number     0652249576
#     Submit Personnel Info

#     # 3. ตรวจสอบว่าข้อความแจ้งเตือนของ "ชื่อ" แสดงขึ้นมาอย่างถูกต้อง
#     # Validation Message Should Be Visible ......
#     # --- ตรวจสอบผลลัพธ์ ---
#     Page Should Contain    กรุณากรอกนามสกุล

#     Capture Page Screenshot With Name    TC14004_Validation
#     [Teardown]    Close Browser

# TC14005 Add New Personnel without User ID
#     [Documentation]    Test case to add new personnel without User ID
#     [Tags]             validation, negative, personnel
#     [Setup]            Open Google To Login Page

#     Click Element    id:btn-login

#     # --- Verify Login Page ---
#     Page Should Contain    รายชื่อบุคลากร
#     Click Element     id:add_personnel_btn

#     # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
#     Select From List By Label    นาย
#     Input First Name     กิตติศักดิ์ 
#     Input Last Name     สมบูรณ์
#     Input Phone Number     0652249576
#     Submit Personnel Info

#     # 3. ตรวจสอบว่าข้อความแจ้งเตือนของ "ชื่อ" แสดงขึ้นมาอย่างถูกต้อง
#     # Validation Message Should Be Visible ......
#     # --- ตรวจสอบผลลัพธ์ ---
#     Page Should Contain    กรุณากรอกรหัสนักศึกษา/รหัสพนักงาน

#     Capture Page Screenshot With Name    TC14005_Validation
#     [Teardown]    Close Browser

# TC14006 Add New Personnel without Phone Number
#     [Documentation]    Test case to add new personnel without Phone Number
#     [Tags]             validation, negative, personnel
#     [Setup]            Open Google To Login Page

#     Click Element    id:btn-login

#     # --- Verify Login Page ---
#     Page Should Contain    รายชื่อบุคลากร
#     Click Element     id:add_personnel_btn

#     # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
#     Select From List By Label    นาย
#     Input First Name     กิตติศักดิ์ 
#     Input Last Name     สมบูรณ์
#     Input User ID     013
#     Submit Personnel Info

#     # 3. ตรวจสอบว่าข้อความแจ้งเตือนของ "ชื่อ" แสดงขึ้นมาอย่างถูกต้อง
#     # Validation Message Should Be Visible ......
#     # --- ตรวจสอบผลลัพธ์ ---
#     Page Should Contain    กรุณากรอกหมายเลขโทรศัพท์

#     Capture Page Screenshot With Name    TC14006_Validation
#     [Teardown]    Close Browser

# TC14007 Add New Personnel But Input English First Name
#     [Documentation]    Test case to add new personnel But Input English First Name
#     [Tags]             validation, negative, personnel
#     [Setup]            Open Google To Login Page

#     Click Element    id:btn-login

#     # --- Verify Login Page ---
#     Page Should Contain    รายชื่อบุคลากร
#     Click Element     id:add_personnel_btn

#     # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
#     Select From List By Label    นาย
#     Input First Name     Kittisak
#     Input Last Name     สมบูรณ์
#     Input User ID     013
#     Input Phone Number     0652249576
#     Submit Personnel Info

#     # 3. ตรวจสอบว่าข้อความแจ้งเตือนของ "ชื่อ" แสดงขึ้นมาอย่างถูกต้อง
#     # Validation Message Should Be Visible ......
#     # --- ตรวจสอบผลลัพธ์ ---
#     Page Should Contain    จำเป็นต้องเป็นภาษาไทย

#     Capture Page Screenshot With Name    TC14007_Validation_EnglishFirstName
#     [Teardown]    Close Browser

# TC14008 Add New Personnel But Input English Last Name
#     [Documentation]    Test case to add new personnel But Input English Last Name
#     [Tags]             validation, negative, personnel
#     [Setup]            Open Google To Login Page

#     Click Element    id:btn-login

#     # --- Verify Login Page ---
#     Page Should Contain    รายชื่อบุคลากร
#     Click Element     id:add_personnel_btn

#     # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
#     Select From List By Label    นาย
#     Input First Name     กิตติศักดิ์
#     Input Last Name     Somboon
#     Input User ID     013
#     Input Phone Number     0652249576
#     Submit Personnel Info

#     # 3. ตรวจสอบว่าข้อความแจ้งเตือนของ "ชื่อ" แสดงขึ้นมาอย่างถูกต้อง
#     # Validation Message Should Be Visible ......
#     # --- ตรวจสอบผลลัพธ์ ---
#     Page Should Contain    จำเป็นต้องเป็นภาษาไทย

#     Capture Page Screenshot With Name    TC14008_Validation_EnglishLastName
#     [Teardown]    Close Browser

# TC14009 Add New Personnel But Input English And SpecialChar To User ID
#     [Documentation]    Test case to add new personnel But Input English And SpecialChar To User ID
#     [Tags]             validation, negative, personnel
#     [Setup]            Open Google To Login Page

#     Click Element    id:btn-login

#     # --- Verify Login Page ---
#     Page Should Contain    รายชื่อบุคลากร
#     Click Element     id:add_personnel_btn

#     # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
#     Select From List By Label    นาย
#     Input First Name     กิตติศักดิ์
#     Input Last Name     สมบูรณ์
#     Input User ID     zeroonethree#
#     Input Phone Number     0652249576
#     Submit Personnel Info

#     # 3. ตรวจสอบว่าข้อความแจ้งเตือนของ "ชื่อ" แสดงขึ้นมาอย่างถูกต้อง
#     # Validation Message Should Be Visible ......
#     # --- ตรวจสอบผลลัพธ์ ---
#     Page Should Contain    กรุณากรอกเลขที่ประจำตัวบุคลากรให้ถูกต้อง

#     Capture Page Screenshot With Name    TC14009_Validation_EnglishAndSpecialCharUserID
#     [Teardown]    Close Browser

# TC14010 Add New Personnel But Input English And SpecialChar To Phone Number
#     [Documentation]    Test case to add new personnel But Input English And SpecialChar To Phone Number
#     [Tags]             validation, negative, personnel
#     [Setup]            Open Google To Login Page

#     Click Element    id:btn-login

#     # --- Verify Login Page ---
#     Page Should Contain    รายชื่อบุคลากร
#     Click Element     id:add_personnel_btn

#     # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
#     Select From List By Label    นาย
#     Input First Name     กิตติศักดิ์
#     Input Last Name     สมบูรณ์
#     Input User ID     013
#     Input Phone Number     PhoneNumber#
#     Submit Personnel Info

#     # 3. ตรวจสอบว่าข้อความแจ้งเตือนของ "ชื่อ" แสดงขึ้นมาอย่างถูกต้อง
#     # Validation Message Should Be Visible ......
#     # --- ตรวจสอบผลลัพธ์ ---
#     Page Should Contain    กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง

#     Capture Page Screenshot With Name    TC14010_Validation_EnglishAndSpecialCharPhoneNumber
#     [Teardown]    Close Browser

# TC14011 Edit Personnel Successfully
#     [Documentation]    Test case to edit personnel information successfully
#     [Tags]             edit, personnel, positive
#     [Setup]            Open Google To Login Page

#     Click Element    id:btn-login

#     # --- Verify Login Page ---
#     Page Should Contain    รายชื่อบุคลากร
#     Click Element     id:edit_personnel

#     # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
#     # Select From List By Label    นางสาว
#     # Input First Name     พิมพร
#     # Input Last Name     สุขดี
#     # Input Phone Number     0864479528
#     # Submit Personnel Info id:save_edit_personnel

#     Capture Page Screenshot With Name    TC14011_EditPersonnel_Success
#     [Teardown]    Close Browser

# TC14012 Delete Personnel Successfully
#     [Documentation]    Test case to delete personnel information successfully
#     [Tags]             smoke, positive, personnel, regression
#     [Setup]            Open Google To Login Page

#     Click Element    id:btn-login

#     # --- Verify Login Page ---
#     Page Should Contain    รายชื่อบุคลากร
#     Click Element     id:delete-personnel

#     # Submit Personnel Info id:confirm_delete_personnel

#     Capture Page Screenshot With Name    TC14012_Delete_Personnel_Success
#     [Teardown]    Close Browser

*** Keywords ***
Sign in 
    Click Element    id:"btn-login"

Add Teacher
    Click Element    id:"add_personnel_btn"

Add Personnel Info
    Click Element    xpath=//button[@id="add-personnel-submit-button"]

Submit Personnel Info
    Click Button    xpath=//button[@id="add-personnel-submit-button"]
    Page Should Contain    เพิ่มข้อมูลเรียบร้อย

# Validation Message Should Be Visible
# [Arguments]    ${PREFIX_ERROR_MSG}  
#     Wait Until Element Is Visible    ${PREFIX_ERROR_MSG}   timeout=5s
#     Element Should Be Visible        ${PREFIX_ERROR_MSG}...............

Delete Personnel By Name
    [Arguments]    ${personnel_name}
    # 1. สร้าง Locator แบบ Dynamic เพื่อหาปุ่มถังขยะของคนที่ต้องการลบ
    #    - ค้นหาแถว (tr) ที่มีคอลัมน์ (td) ที่มีข้อความตรงกับชื่อที่ระบุ
    #    - เมื่อเจอแถวนั้นแล้ว ให้หาปุ่มลบที่อยู่ในแถวนั้น
    ${delete_button_locator}=    Set Variable    xpath=//tr[.//td[contains(text(),'${personnel_name}')]]//button[contains(@class,'delete')]
    
    # 2. คลิกที่ปุ่มถังขยะ
    Wait Until Element Is Visible    ${delete_button_locator}
    Click Element                  ${delete_button_locator}

     # --- ส่วนที่เพิ่มเข้ามาเพื่อจัดการ Success Alert ---
    # 3. รอให้ Success Alert "ปรากฏขึ้นมา"
    Wait Until Page Contains Element    ${SUCCESS_ALERT}    timeout=10s
    Log                             Success alert is visible.

    # 4. รอให้ Success Alert "หายไป"
    #    (Pop-up แบบนี้มักจะหายไปเองในไม่กี่วินาที)
    Wait Until Page Does Not Contain Element    ${SUCCESS_ALERT}    timeout=10s
    Log                             Success alert has disappeared.



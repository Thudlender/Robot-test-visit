*** Settings ***
Documentation    ชุดการทดสอบสำหรับระบบจัดการข้อมูลบุคลากร (Personnel Management)
Library     SeleniumLibrary
Library    OperatingSystem
Resource     ../resources/keywords.robot
Resource     ../resources/variables.robot

*** Variables ***
${PREFIX_DROPDOWN}    id:prefix_add
${FIRST_NAME_FIELD}    id:first_name_add
${LAST_NAME_FIELD}     id:last_name_add
${USER_ID_FIELD}       id:user_id_add
${PHONE_NUMBER_FIELD}  id:phone_add

${PREFIX_DROPDOWN_EDIT}    id:prefix_edit
${FIRST_NAME_FIELD_EDIT}    id:first_name_edit
${LAST_NAME_FIELD_EDIT}     id:last_name_edit
${PHONE_NUMBER_FIELD_EDIT}  id:phone_edit
${STATUS_DROPDOWN}          id:status_edit

${selected_prefix} =    Get Selected List Label    ${PREFIX_DROPDOWN}
${selected_status} =    Get Selected List Label    ${STATUS_DROPDOWN}

${PREFIX_ERROR_MSG}    id="prefix-error" 
${FIRST_NAME_ERROR_MSG}    id="first_name-error" 
${LAST_NAME_ERROR_MSG}     //*[@id="last_name-error"]
${USER_ID_ERROR_MSG}    id="error_userid"
${PHONE_NUMBER_ERROR_MSG}  id="error_phone"

${ADD_PERSONNEL_SUBMIT_BUTTON}    xpath=//button[@id="add-personnel-submit-button"]


*** Test Cases ***
    
TC1401 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มบัญชีคุณครูที่ปรึกษาสำเร็จ
    [Documentation]    ทดสอบการเพิ่มบัญชีคุณครูที่ปรึกษาใหม่โดยเจ้าหน้าที่ฝ่ายทะเบียน

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
    Input First Name    สมรักษ์
    Input Last Name    ศรัทธา
    Input User ID    022
    Input Phone Number    0686548694
    Submit Personnel Info Success
    
    Capture Page Screenshot with Name    TC1401_Success
    Close Browser

TC1402 - เพิ่มบุคลากรใหม่โดยไม่กรอกหรือเลือกข้อมูลใดๆเลย
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
    # --- กดปุ่มบันทึกโดยไม่กรอกข้อมูลใดๆ ---
    Submit Personnel No Info Error

    Capture Page Screenshot With Name    TC1402_Validation
    Close Browser

TC1403 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มบัญชีคุณครูที่ปรึกษาไม่สำเร็จ(กรอกข้อมูลทั้งหมดเป็นภาษาอังกฤษและตัวอักษรพิเศษ)
    [Documentation]    ทดสอบการเพิ่มบัญชีคุณครูที่ปรึกษาใหม่โดยเจ้าหน้าที่ฝ่ายทะเบียน โดยกรอกข้อมูลทั้งหมดเป็นภาษาอังกฤษ
   
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
    Input First Name     Somrak@
    Input Last Name     Sattha%
    Input User ID     UserID^
    Input Phone Number     PhoneNumber#
    Submit Personnel Eng Info Error

    Capture Page Screenshot With Name    TC1403_Validation
    Close Browser

TC1404 เจ้าหน้าที่ฝ่ายทะเบียนแก้ไขข้อมูลบัญชีคุณครูที่ปรึกษาสำเร็จ
    [Documentation]    ทดสอบการแก้ไขข้อมูลบัญชีคุณครูที่ปรึกษาโดยเจ้าหน้าที่ฝ่ายทะเบียนสำเร็จ
    
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

    # # --- (Optional) ตรวจสอบว่าข้อมูลเดิมถูกต้อง ---
    # Element Text Should Be    ${FIRST_NAME_FIELD}    สมสมร
    # Should Be Equal As Strings    ${selected_prefix}    นาย
    # Should Be Equal As Strings    ${selected_status}    ใช้งานอยู่
    # --- กรอกข้อมูลบุคลากร ---   
    Prefix Dropdown Edit    นางสาว
    Input First Name Edit    พิมพรหญิง
    Input Last Name Edit    สุขดี
    Input Phone Number Edit    0864479528
    Status Dropdown Edit    ไม่ได้ใช้งานแล้ว
    Save Edit Personnel
 
    Capture Page Screenshot With Name    TC1404_EditPersonnel_Success
    Close Browser

TC1405 เจ้าหน้าที่ฝ่ายทะเบียนลบบัญชีคุณครูที่ปรึกษาสำเร็จ
    [Documentation]    ทดสอบการลบบัญชีคุณครูที่ปรึกษาโดยเจ้าหน้าที่ฝ่ายทะเบียนสำเร็จ
    
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

    Capture Page Screenshot With Name    TC1405_Delete_Personnel_Success
    Close Browser

TC1406 เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มสิทธิบทบาทผู้ดูแลเป็นเจ้าหน้าที่สำเร็จ
    [Documentation]    ทดสอบการเพิ่มสิทธิบทบาทผู้ดูแลเป็นเจ้าหน้าที่สำเร็จ
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
    Sleep    3s
    # --- Toggle Add Admin Role ---
    Toggle Add Admin Role

    Capture Page Screenshot With Name    TC1406_AddAdminRole_Success
    Close Browser

TC1407 เจ้าหน้าที่ฝ่ายทะเบียนลบสิทธิบทบาทผู้ดูแลสำเร็จ
    [Documentation]    ทดสอบการลบสิทธิบทบาทผู้ดูแลสำเร็จ
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
    Sleep    3s
    # --- Toggle Delete Admin Role ---
    Toggle Delete Admin Role

    Capture Page Screenshot With Name    TC1407_DeleteAdminRole_Success
    Close Browser



*** Keywords ***

Prefix Dropdown
    [Arguments]    ${PREFIX}
    Select From List By Label    ${PREFIX_DROPDOWN}    ${PREFIX}
   

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


Prefix Dropdown Edit
    [Arguments]    ${PREFIX}
    # ใช้อันเดียวกับ 'Add' ได้ ถ้า Locator เหมือนกัน
    Select From List By Label    ${PREFIX_DROPDOWN_EDIT}    ${PREFIX}

Input First Name Edit
    [Arguments]    ${FIRST_NAME}
    Input Text   ${FIRST_NAME_FIELD_EDIT}    ${FIRST_NAME}

Input Last Name Edit
    [Arguments]    ${LAST_NAME}
    Input Text   ${LAST_NAME_FIELD_EDIT}    ${LAST_NAME}

Input Phone Number Edit
    [Arguments]    ${PHONE_NUMBER}
    Input Text   ${PHONE_NUMBER_FIELD_EDIT}    ${PHONE_NUMBER}

Status Dropdown Edit
    [Arguments]    ${STATUS}
    Select From List By Label    xpath=//select[@id="status"]    ${STATUS}

Edit personnel
    Click Element    xpath=//*[@id="edit-personnel-button_68fc925aff0ca9eb99eeec7d"]

Save Edit Personnel
    Click Button    xpath=//*[@id="edit_personnel_68fc925aff0ca9eb99eeec7d"]/div/form/div[2]/div/button[1]
    Wait Until Page Contains   อัพเดทข้อมูลครูที่ปรึกษาเรียบร้อย   timeout=10s

Add Teacher
    Click Element   xpath=//*[@id="root"]/div[2]/div/div[2]/div/div[3]/button  

Submit Personnel Info Success               
    Click Button    xpath=//*[@id="add-personnel-submit-button"]
    Wait Until Page Contains   เพิ่มข้อมูลครูที่ปรึกษาเรียบร้อย   timeout=10s

Submit Personnel No Info Error                
    Click Button    xpath=//*[@id="add-personnel-submit-button"]
    Wait Until Page Contains    กรุณาเลือกคำนำหน้า                 timeout=3s
    Wait Until Page Contains    กรุณากรอกชื่อ                       timeout=3s
    Wait Until Page Contains    กรุณากรอกนามสกุล                   timeout=3s
    Wait Until Page Contains    กรุณากรอกเลขที่ประจำตัวบุคลากร    timeout=3s
    Wait Until Page Contains    กรุณากรอกเบอร์โทรศัพท์             timeout=3s
    
    Log    All 5 validation messages are present.  

Submit Personnel Eng Info Error                
    Click Button    xpath=//*[@id="add-personnel-submit-button"]
    Wait Until Page Contains    จำเป็นต้องเป็นภาษาไทย                       timeout=3s
    Wait Until Page Contains    จำเป็นต้องเป็นภาษาไทย                   timeout=3s
    Wait Until Page Contains    กรุณากรอกเลขที่ประจำตัวบุคลากรให้ถูกต้อง             timeout=3s
    Wait Until Page Contains    กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง             timeout=3s

    Log    All 4 validation messages are present.



Delete personnel
    Click Element    xpath=//*[@id="delete-personnel-button_4"]
    # --- Confirm Deletion in Modal --- 
    Click Button    xpath=/html/body/div[2]/div/div[6]/button[1]
    Wait Until Page Contains   ลบข้อมูลเรียบร้อย   timeout=10s



# Select Option
#     [Arguments]    ${OPTION}
#     Select From List By Label    xpath=//*[@id="selectedOption"]    ${OPTION}

Toggle Add Admin Role
    Click Button    xpath=//*[@id="admin-role-toggle_5"]
    Wait Until Page Contains   เพิ่มสิทธ์ผู้ดูแลให้ นางสาว ศุภาพิชย์ สำเร็จ   timeout=10s

Toggle Delete Admin Role
    Click Button    xpath=//*[@id="admin-role-toggle_5"]
    # --- Confirm Deletion in Modal --- 
    Click Button    xpath=/html/body/div[2]/div/div[6]/button[1]
    Wait Until Page Contains   ลบสิทธ์ผู้ดูแลให้ นางสาวศุภาพิชย์ สำเร็จ   timeout=10s

Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${folder}=       Set Variable    ${EXECDIR}/results/Personnel_results
    Create Directory    ${folder}
    ${filename}=     Set Variable    ${folder}/${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}


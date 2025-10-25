*** Settings ***
Documentation    ชุดการทดสอบสำหรับระบบจัดการข้อมูลบุคลากร (Personnel Management)
Library     SeleniumLibrary
Library    OperatingSystem
Resource     ../resources/keywords.robot
Resource     ../resources/variables.robot

*** Variables ***
${PREFIX_DROPDOWN}    id:prefix
${FIRST_NAME_FIELD}    id:first_name
${LAST_NAME_FIELD}     id:last_name
${USER_ID_FIELD}       id:user_id    
${PHONE_NUMBER_FIELD}  id:phone


*** Test Cases ***
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
    Sleep    3s
    # --- กรอกข้อมูลบุคลากร ---   
    Prefix Dropdown    นางสาว
    Input First Name     พิมพร
    Input Last Name     สุขดี
    Input Phone Number     0864479528
    Status Dropdown    ไม่ได้ใช้งานแล้ว
    Save Edit Personnel
 
    Capture Page Screenshot With Name    TC14011_EditPersonnel_Success
    Close Browser



*** Keywords ***

Prefix Dropdown
    [Arguments]    ${PREFIX}
    Select From List By Label    ${PREFIX_DROPDOWN}    ${PREFIX}

# Prefix Edit Dropdown
#     [Arguments]    ${PREFIX}
#     Select From List By Label    ${PREFIX_DROPDOWN}    ${PREFIX}   

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
    Click Element    xpath=//*[@id="edit-personnel-button_68fc925aff0ca9eb99eeec7d"]

Save Edit Personnel
    Click Button    xpath=//*[@id="edit_personnel_68fc925aff0ca9eb99eeec7d"]/div/form/div[2]/div/button[1]
    Wait Until Page Contains   อัพเดทข้อมูลครูที่ปรึกษาเรียบร้อย   timeout=10s

Delete personnel
    Click Element    xpath=//*[@id="delete-personnel-button_5"]
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
    Click Button    xpath=//*[@id="admin-role-toggle_7"]
    Wait Until Page Contains   เพิ่มสิทธ์ผู้ดูแลให้ นางสาว ศุภาพิชย์ สำเร็จ   timeout=10s

Toggle Delete Admin Role
    Click Button    xpath=//*[@id="admin-role-toggle_7"] 
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

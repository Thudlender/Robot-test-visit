*** Settings ***
Library     SeleniumLibrary
Library    OperatingSystem
Resource  keywords.robot
Resource  02-personnel-variables.robot
Resource  variables.robot


*** Keywords ***

Add Teacher
    Click Element   xpath=//*[@id="root"]/div[2]/div/div[2]/div/div[3]/button 

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

Submit Personnel Info Success               
    Click Button    xpath=//*[@id="add-personnel-submit-button"]
    Wait Until Page Contains   เพิ่มข้อมูลครูที่ปรึกษาเรียบร้อย   timeout=10s

Prefix Dropdown Edit
    [Arguments]    ${PREFIX}
    Wait Until Element Is Visible    id:prefix_edit    timeout=10s
    Select From List By Label        id:prefix_edit    ${PREFIX}

Select Prefix In Edit Modal
    [Arguments]    ${PREFIX}
    # รอ modal เปิด
    Wait Until Page Contains    แก้ไขข้อมูลบุคลากร    timeout=10s
    # ถ้า dropdown เป็น div wrapper ของ SelectInput
    Click Element    xpath=//div[@id="prefix_edit"]/..
    # รอให้ option ปรากฏ
    Wait Until Page Contains Element    xpath=//div[contains(@class,"option") and text()="${PREFIX}"]
    # คลิก option
    Click Element    xpath=//div[contains(@class,"option") and text()="${PREFIX}"]

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
    ${timestamp}=  Get Current Date    result_format=%Y%m%d_%H%M%S
    ${folder}=       Set Variable    ${EXECDIR}/results/Personnel_results
    Create Directory    ${folder}
    ${filename}=     Set Variable    ${folder}/${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}

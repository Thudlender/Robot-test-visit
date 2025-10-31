*** Settings ***
Library     SeleniumLibrary
Library    OperatingSystem
Resource  keywords.robot
Resource  04-class-variables.robot
Resource  variables.robot

*** Keywords ***

Select Year From Dropdown
    [Arguments]    ${year}
    Select From List By Label    xpath=//*[@id="year-selector"]    ${year}
Add Class Button 
    #--- ปุ่มเพิ่มชั้นเรียน ---
    Click Element    xpath=//*[@id="root"]/div[2]/div/div[2]/div[3]/div[2]/button
    Sleep    2s

Submit Class Error Limit
    Click Button   xpath=//*[@id="add_classroom"]/div/form/div/div[4]/button[1] 
    Wait Until Page Contains    กรุณากรอกเลขชั้นเรียนไม่เกิน 6
    Wait Until Page Contains    กรุณากรอกห้องเรียนไม่เกิน 7

    Log    All 2 validation messages are present.

Submit Already Existing Class Error
    Click Button   xpath=//*[@id="add_classroom"]/div/form/div/div[4]/button[1] 
    Wait Until Page Contains    ชั้นปี 4 ห้องที่ 2 มีอยู่แล้ว  


Submit Class Error No Info
    Click Button   xpath=//*[@id="add_classroom"]/div/form/div/div[4]/button[1] 
    Wait Until Page Contains    กรุณากรอกเลขชั้นเรียน
    Wait Until Page Contains    กรุณากรอกห้องเรียน
    Wait Until Page Contains    กรุณาเลือกครูที่ปรึกษา

    Log    All 3 validation messages are present.


Edit Class Button 
    #--- ปุ่มแก้ไขชั้นเรียน ---
    Click Element    xpath=//*[@id="edit-classroom-button_6"]
    Sleep    2s

Edit Class Button On Different Year
    #--- ปุ่มแก้ไขชั้นเรียน ---
    Click Element    xpath=//*[@id="edit-classroom-button_6"]
    Sleep    2s

Delete Class Button
    #--- ปุ่มลบชั้นเรียน ---
    Click Element    xpath=//*[@id="delete-classroom-button_6"]
    Sleep    2s

Delete Class Confirm
    #--- ยืนยันการลบชั้นเรียน ---
    Click Element    xpath=/html/body/div[2]/div/div[6]/button[1]
    Wait Until Page Contains   ลบชั้นปี 4 ห้องที่ 4 สำเร็จ   timeout=15s

Add Student
    #--- ปุ่มเพิ่มนักเรียนเข้าชั้นเรียน ---
    Click Element    xpath=//*[@id="root"]/div[2]/div/div[2]/div[2]/button[2]
    Sleep    2s

Edit Student Button
    #--- ปุ่มแก้ไขนักเรียนในชั้นเรียน ---
    Click Element    //*[@id="edit-student-button_6"]
    Sleep    2s

Delete Student Button
    #--- ปุ่มลบนักเรียน ---
    Click Element      xpath=//*[@id="delete-student-button_7"]
    Sleep    2s
    #--- ยืนยันการลบนักเรียน ---
    Click Element    xpath=/html/body/div[2]/div/div[6]/button[1]
    Wait Until Page Contains   ลบผู้ใช้ สุธิดา เกษมสุข สำเร็จ   timeout=15s

Select Dropdown Select Prefix Student
    [Arguments]    ${STUDENT_PREFIX}
    Select From List By Label    ${STUDENT_PREFIX_FIELD}    ${STUDENT_PREFIX}

Add Student ID
    [Arguments]    ${STUDENT_ID_NUMBER} 
    Input Text    id=user_id_add    ${STUDENT_ID_NUMBER} 

Add Student Name
    [Arguments]    ${STUDENT_NAME}
    Input Text    id=first_name_add    ${STUDENT_NAME}

Add Student Last Name
    [Arguments]    ${STUDENT_LASTNAME}
    Input Text    id=last_name_add    ${STUDENT_LASTNAME}

Add Class Year
    [Arguments]    ${CLASS_YEAR_NUMBER}
    Input Text    ${CLASS_YEAR_NUMBER_FIELD}    ${CLASS_YEAR_NUMBER}

Add Class Room
    [Arguments]    ${CLASS_ROOM_NUMBER}
    Input Text    ${CLASS_ROOM_NUMBER_FIELD}    ${CLASS_ROOM_NUMBER}

Dropdown Select Teacher Name
    [Arguments]    ${TEACHER_NAME}
    Select From List By Label    ${TEACHER_NAME_DROPDOWN}    ${TEACHER_NAME}



Upload Student Excel File
    ${absolute_path} =    Normalize Path    ${STUDENT_EXCEL_FILE}
    Log    Uploading file from: ${absolute_path}
    File Should Exist    ${absolute_path}
    Choose File    ${EXCEL_UPLOAD_INPUT}    ${absolute_path}
    

Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${folder}=       Set Variable    ${EXECDIR}/results/Class_results
    Create Directory    ${folder}
    ${filename}=     Set Variable    ${folder}/${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}

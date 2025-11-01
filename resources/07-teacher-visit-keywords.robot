*** Settings ***
Library     SeleniumLibrary
Library    OperatingSystem
Resource  keywords.robot
Resource  07-teacher-visit-variables.robot
Resource  variables.robot

*** Keywords ***

ํYear Dropdown
    [Arguments]    ${YEAR}
    Select From List By Label    xpath=//*[@id="year-selector"]    ${YEAR}

Choose Student    
    Click Element  xpath=//*[@id="student_4"]
    

House Photo
    ${absolute_path} =    Normalize Path    ${HOUSE_1_IMAGE}
    Log    File path to upload is: ${absolute_path}
    #--- อัพโหลดรูปภาพถ่ายที่อยู่อาศัย ---
    Choose File    ${HOUSE_PHOTO_INPUT}    ${absolute_path}

Family Photo
    ${absolute_path} =    Normalize Path    ${FAMILY_1_IMAGE}
    Log    File path to upload is: ${absolute_path}
    #--- อัพโหลดรูปภาพถ่ายครอบครัว ---    
    Choose File    ${FAMILY_PHOTO_INPUT}    ${absolute_path}


Input House Description
    [Arguments]    ${HOUSE_DESCRIPTION}
    Input Text    ${INPUT_HOUSE_DESCRIPTION}    ${HOUSE_DESCRIPTION}

Input Family Description
    [Arguments]    ${FAMILY_DESCRIPTION}
    Input Text    ${INPUT_FAMILY_DESCRIPTION}    ${FAMILY_DESCRIPTION}

Input Teacher Comment
    [Arguments]    ${TEACHER_COMMENT}
    Input Text    ${INPUT_TEACHER_COMMENT}     ${TEACHER_COMMENT}
        
Save Visit Home Button
    Click Button    xpath=//*[@id="submit-visithome-button"]
    Wait Until Page Contains    สร้างข้อมูลสำเร็จ    timeout=15s
        

Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${folder}=       Set Variable    ${EXECDIR}/results/Teacher_Visit_results
    Create Directory    ${folder}
    ${filename}=     Set Variable    ${folder}/${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}

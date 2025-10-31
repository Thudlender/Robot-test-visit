*** Settings ***
Library     SeleniumLibrary
Library    OperatingSystem
Resource  keywords.robot
Resource  03-year-variables.robot
Resource  variables.robot

*** Keywords ***
Add Academic Year
    Click Element    xpath=//*[@id="add_year_button"]
    Wait Until Page Contains   สร้างปีการศึกษา 2571 สำเร็จ   timeout=15s

Add Academic Year Limit Error
    Click Element    xpath=//*[@id="add_year_button"]
    Wait Until Page Contains   สร้างปีการศึกษา 2572 ไม่สำเร็จ   timeout=15s

Edit Academic Year
    Double Click Element    ${ACADEMIC_YEAR_FIELD}
    Sleep                   0.3s
    # Press Keys              ${ACADEMIC_YEAR_FIELD}    CTRL+A
    Press Keys              ${ACADEMIC_YEAR_FIELD}    BACKSPACE
    Press Keys              ${ACADEMIC_YEAR_FIELD}    BACKSPACE
    Press Keys              ${ACADEMIC_YEAR_FIELD}    BACKSPACE
    Press Keys              ${ACADEMIC_YEAR_FIELD}    BACKSPACE
    Sleep                   0.3s
    Input Text              ${ACADEMIC_YEAR_FIELD}    2571
    Sleep                   0.3s
    Click Button            xpath=//*[@id="Edit_year_68feb9865d1e6e2460e0505c"]/div/form/div[2]/button[1]
    Wait Until Page Contains   แก้ไขปีการศึกษาเรียบร้อยแล้ว   timeout=15s

Edit Existing Academic Year
    Double Click Element    ${ACADEMIC_YEAR_FIELD}
    Sleep                   0.3s
    # Press Keys              ${ACADEMIC_YEAR_FIELD}    CTRL+A
    Press Keys              ${ACADEMIC_YEAR_FIELD}    BACKSPACE
    Press Keys              ${ACADEMIC_YEAR_FIELD}    BACKSPACE
    Press Keys              ${ACADEMIC_YEAR_FIELD}    BACKSPACE
    Press Keys              ${ACADEMIC_YEAR_FIELD}    BACKSPACE
    Sleep                   0.3s
    Input Text              ${ACADEMIC_YEAR_FIELD}    2568
    Sleep                   0.3s
    Click Button            xpath=//*[@id="Edit_year_68feb9865d1e6e2460e0505c"]/div/form/div[2]/button[1]
    Wait Until Page Contains   ปีการศึกษา 2568 มีอยู่แล้ว   timeout=15s


Edit Academic Year Error 
    Double Click Element    ${ACADEMIC_YEAR_FIELD}
    Sleep                   0.3s
    Input Text              ${ACADEMIC_YEAR_FIELD}    0
    Sleep                   0.3s
    Click Button            xpath=//*[@id="Edit_year_68feb9865d1e6e2460e0505c"]/div/form/div[2]/button[1]
    Wait Until Page Contains   xpath=//*[@id="year-error"]   timeout=15s
    Element Text Should Be    xpath=//*[@id="year-error"]    กรุณากรอกปีการศึกษาให้ถูกต้อง


Delete Academic Year Confirm
    Click Element   xpath=/html/body/div[2]/div/div[6]/button[1]
    Wait Until Page Contains   ลบปีการศึกษา 2571 สำเร็จ   timeout=15s
    

Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${folder}=       Set Variable    ${EXECDIR}/results/Year_results
    Create Directory    ${folder}
    ${filename}=     Set Variable    ${folder}/${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}
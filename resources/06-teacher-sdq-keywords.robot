*** Settings ***
Library     SeleniumLibrary
Library    OperatingSystem
Resource  keywords.robot
Resource  06-teacher-sdq-variables.robot
Resource  variables.robot

*** Keywords ***
ํYear Dropdown
    [Arguments]    ${YEAR}
    Select From List By Label    xpath=//*[@id="year-selector"]    ${YEAR}

Answer SDQ Page 1
    Click Element    xpath=//*[@id="question_3_0"]
    Click Element    xpath=//*[@id="question_8_0"]
    Click Element    xpath=//*[@id="question_13_2"]
    Click Element    xpath=//*[@id="question_16_0"]
    Click Element    xpath=//*[@id="question_24_0"]
    # --- ถัดไปหน้า 2 ---
    Click Button    xpath=//*[@id="next-button-page1"]
    Sleep    2s

Answer SDQ Page 2
    Click Element    xpath=//*[@id="question_5_0"]
    Click Element    xpath=//*[@id="question_7_1"]
    Click Element    xpath=//*[@id="question_12_2"]
    Click Element    xpath=//*[@id="question_18_0"]
    Click Element    xpath=//*[@id="question_22_0"]
    # --- ถัดไปหน้า 3 ---
    Click Button    xpath=//*[@id="next-button-page2"]

Answer SDQ Page 3
    Click Element    xpath=//*[@id="question_2_0"]
    Click Element    xpath=//*[@id="question_10_0"]
    Click Element    xpath=//*[@id="question_15_0"]
    Click Element    xpath=//*[@id="question_21_1"]
    Click Element    xpath=//*[@id="question_25_2"]
    # --- ถัดไปหน้า 4 ---
    Click Button    xpath=///*[@id="next-button-page3"]

Answer SDQ Page 4
    Click Element    xpath=//*[@id="question_6_0"]
    Click Element    xpath=//*[@id="question_11_2"]
    Click Element    xpath=//*[@id="question_14_1"]
    Click Element    xpath=//*[@id="question_19_0"]
    Click Element    xpath=//*[@id="question_23_0"]
    # --- ถัดไปหน้า 5 ---
    Click Button    xpath=//*[@id="next-button-page4"]

Answer SDQ Page 5
    Click Element    xpath=//*[@id="question_1_1"]
    Click Element    xpath=//*[@id="question_4_2"]
    Click Element    xpath=//*[@id="question_9_2"]
    Click Element    xpath=//*[@id="question_17_2"]
    Click Element    xpath=//*[@id="question_20_2"]
    # --- ถัดไปหน้า 6 ---
    Click Button    xpath=//*[@id="next-button-page5"]

Answer SDQ Page 6
    Click Element    xpath=//*[@id="overall_problem_3"]
    Click Element    xpath=//*[@id="problem_time_2"]
    Click Element    xpath=//*[@id="is_uneasy_student_3"]
    Click Element    xpath=//*[@id="is_annoy_student_3"]
    Click Element    xpath=//*[@id="is_difficult_student_0"]
    # --- ส่งแบบฟอร์ม ---
    Click Button    xpath=//*[@id="submit-button"]

Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${folder}=       Set Variable    ${EXECDIR}/results/SDQ_results
    Create Directory    ${folder}
    ${filename}=     Set Variable    ${folder}/${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}

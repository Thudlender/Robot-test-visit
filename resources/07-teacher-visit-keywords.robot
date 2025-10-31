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

Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${folder}=       Set Variable    ${EXECDIR}/results/Teacher_Visit_results
    Create Directory    ${folder}
    ${filename}=     Set Variable    ${folder}/${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}

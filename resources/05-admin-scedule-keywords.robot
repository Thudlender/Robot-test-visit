*** Settings ***
Library     SeleniumLibrary
Library    OperatingSystem
Resource  keywords.robot
Resource  05-admin-scedule-variables.robot
Resource  variables.robot

*** Keywords ***

Select Year From Dropdown
    [Arguments]    ${year}
    Select From List By Label    xpath=//*[@id="year-selector"]    ${year}

Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${folder}=       Set Variable    ${EXECDIR}/results/Admin_Schedule_results
    Create Directory    ${folder}
    ${filename}=     Set Variable    ${folder}/${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}

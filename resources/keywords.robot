*** Settings ***
Library    SeleniumLibrary
Library    ../libs/ChromeHelper.py
Library    DateTime
Resource    ../resources/variables.robot

*** Keywords ***
Open Google
    ${chrome_options}=    Get Chrome Options With Binary    D:\webdriver\chromedriver-win64/chrome.exe
    Open Browser    ${URL}     ${BROWSER}  options=${chrome_options}
    Set Window Size    1920    1080

Input Search Term
    Input Text    name=q    ${SEARCH_TERM1}

Input Search Term 2
    Input Text    name=q    ${SEARCH_TERM2}    

Enter Google Search
    Press Keys    name=q    ENTER

Verify Search Results 
    Page Should Contain    ${SEARCH_RESULT1}

Verify Search Results 2
    Page Should Contain    ${SEARCH_RESULT2}

Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${filename}=     Set Variable    ${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}
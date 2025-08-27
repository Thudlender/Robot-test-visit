*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${BROWSER}          headlesschrome
${SEARCH_TERM1}      robot
${SEARCH_TERM2}      java
${SEARCH_RESULT1}    Robot
${SEARCH_RESULT2}    Java
${URL}              https://www.google.com

*** Test Cases ***
Search Google and Verify Results TC1001
    [Documentation]    Test case to search Google and verify results
    [Tags]    search
    Open Google
    Input Search Term
    Enter Google Search
    Verify Search Results
    Capture Page Screenshot
    Close Browser

Search Google and Verify Results TC1002
    [Documentation]    Test case to search Google and verify results
    [Tags]    search
    Open Google
    Input Search Term 2
    Enter Google Search
    Verify Search Results 2
    Capture Page Screenshot
    Close Browser

*** Keywords ***
Open Google
    Open Browser    ${URL}     ${BROWSER}
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
*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Resource    ../resources/variables.robot

*** Keywords ***
Login With Google OAuth
    [Arguments]    ${username}    ${password}

    # --- เก็บ handle ของหน้าต่างหลักไว้ก่อน ---
    ${main_windows}=    Get Window Handles
    Log To Console    Main window handles: ${main_windows}

    # --- รอให้ popup ของ Google เปิดขึ้น ---
    Wait Until Keyword Succeeds    10x    1s    Popup Window Should Appear

    # --- ดึง handle ของทุกหน้าต่างอีกครั้ง ---
    ${all_windows}=    Get Window Handles
    Log To Console    All windows: ${all_windows}

    # --- สลับไปยัง popup ของ Google OAuth ---
    ${popup_window}=    Set Variable    ${all_windows}[-1]
    Switch Window    ${popup_window}
    Log To Console    Switched to popup window: ${popup_window}

    # --- รอจนกว่า element สำหรับกรอกอีเมลจะปรากฏ ---
    Wait Until Page Contains Element   id=identifierId    timeout=15s

    # --- กรอกอีเมล ---
    Input Text    id=identifierId    ${username}
    Click Element  xpath=//*[@id="identifierNext"]/div/button/span

    # --- รอจนกว่าช่องรหัสผ่านจะปรากฏ ---
    Wait Until Element Is Visible    name=Passwd    timeout=15s
    Input Text    name=Passwd    ${password}
    Click Element    xpath=//*[@id="passwordNext"]/div/button/span

    # --- รอจน popup ปิดลง (กลับเหลือหน้าต่างเดียว) ---
    Wait Until Keyword Succeeds    10x    1s    Popup Window Should Close

    # --- สลับกลับไปยังหน้าต่างหลัก ---
    ${main_windows}=    Get Window Handles
    Switch Window    ${main_windows}[0]
    Log To Console    Switched back to main window: ${main_windows}[0]

# 🔹 Helper Keyword ตรวจว่ามี popup เปิดหรือไม่
Popup Window Should Appear
    ${handles}=    Get Window Handles
    ${count}=    Get Length    ${handles}
    Should Be True    ${count} > 1    msg=Expected popup window to appear, but found only ${count}

# 🔹 Helper Keyword ตรวจว่าปิด popup แล้วหรือยัง
Popup Window Should Close
    ${handles}=    Get Window Handles
    ${count}=    Get Length    ${handles}
    Should Be Equal As Integers    ${count}    1    msg=Expected popup to close, but found ${count} windows




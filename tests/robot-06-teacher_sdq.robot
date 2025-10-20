*** Settings ***
Documentation    ฟังก์ชั่นแบบฟอร์มประเมิน SDQ (คุณครู)
Library     SeleniumLibrary
Library    OperatingSystem
Resource     ../resources/keywords.robot
Resource     ../resources/variables.robot

*** Variables ***
@{ANSWERS_PAGE_1}    ไม่จริง    ไม่จริง    จริง    ไม่จริง    ไม่จริง
@{ANSWERS_PAGE_2}    ไม่จริง    ค่อนข้างจริง    จริง    ไม่จริง    ไม่จริง            
@{ANSWERS_PAGE_3}    ไม่จริง    ไม่จริง    ไม่จริง    ค่อนข้างจริง    จริง
@{ANSWERS_PAGE_4}    ไม่จริง    จริง    ค่อนข้างจริง    ไม่จริง    ไม่จริง
@{ANSWERS_PAGE_5}    ค่อนข้างจริง    จริง    จริง    จริง    จริง
@{ANSWERS_PAGE_6}    ใช่ มีปัญหาอย่างมาก    6-12 เดือน    มาก    มาก    ไม่เลย

*** Test Cases ***

TC9001 - คุณครูทำแบบประเมิน SDQ ประเมินนักเรียนสำเร็จ
    [Documentation]    ทดสอบการประเมิน SDQ ของคุณครู
    # เปิดเบราว์เซอร์ที่ URL ที่กำหนด โดยใช้ browser ที่ระบุ
    Open Browser    ${URL}    ${BROWSER}
    # ขยายหน้าต่างเบราว์เซอร์ให้เต็มจอ เพื่อป้องกันปัญหา element ไม่แสดง
    Maximize Browser Window
    # คลิกที่ checkbox ยอมรับนโยบายความเป็นส่วนตัว
    Click Element    xpath=//*[@id="privacy_checkbox"]
    # คลิกปุ่ม เข้าใจและยอมรับ
    Click Element    xpath=//*[@id="privacy_modal"]/div/div[2]/form/button
    # คลิกปุ่ม login เพื่อเริ่มกระบวนการล็อกอิน
    Click Element    id=btn-login
    # เรียกใช้ keyword สำหรับล็อกอินผ่าน Google OAuth โดยส่ง username และ password
    Login With Google OAuth    ${USERNAME}    ${PASSWORD}
    # รอ 5 วินาที เพื่อให้กระบวนการล็อกอินเสร็จสมบูรณ์
    Sleep    5s
    
    # --- Verify Login Page ---
    Page Should Contain    รายชื่อบุคลากร
    # --- สลับเป็นคุณครู ---
    Click Element  xpath=//*[@id="btn-switch-navbar"]
    Sleep    5s
    # --- เลือกปี ---
    ํYear Dropdown    2568
    Sleep    3s
    # --- เลือกนักเรียน ---
    Click Element  xpath=//*[@id="root"]/div[2]/div/div[4]/div/table/tbody/tr[6]/td[1]
    # --- กดปุ่มประเมิน SDQ ---
    Click Element  xpath=//*[@id="manage_student_68e6bb2e7a3a9c428012c369"]/div/div/a[1]
    Sleep    5s
    # --- ทำแบบฟอร์มประเมิน SDQ ---
    Answer SDQ Page 1
    Answer SDQ Page 2
    Answer SDQ Page 3
    Answer SDQ Page 4
    Answer SDQ Page 5
    Answer SDQ Page 6
    Sleep    3s
    # --- Verify Submit Page ---
    Page Should Contain    เพิ่มข้อมูล SDQ สำเร็จ    timeout=10s

    Capture Page Screenshot With Name    TC9001_SDQ Assessment_Success
    Close Browser

TC9002 - คุณครูทำแบบประเมิน SDQ ประเมินนักเรียนไม่สำเร็จ(กดข้ามหน้าโดยไม่เลือกตัวเลือกข้อใดเลย)
    [Documentation]    ทดสอบการประเมิน SDQ ของคุณครูโดยไม่เลือกตัวเลือกข้อใดเลย
    # เปิดเบราว์เซอร์ที่ URL ที่กำหนด โดยใช้ browser ที่ระบุ
    Open Browser    ${URL}    ${BROWSER}
    # ขยายหน้าต่างเบราว์เซอร์ให้เต็มจอ เพื่อป้องกันปัญหา element ไม่แสดง
    Maximize Browser Window
    # คลิกที่ checkbox ยอมรับนโยบายความเป็นส่วนตัว
    Click Element    xpath=//*[@id="privacy_checkbox"]
    # คลิกปุ่ม เข้าใจและยอมรับ
    Click Element    xpath=//*[@id="privacy_modal"]/div/div[2]/form/button
    # คลิกปุ่ม login เพื่อเริ่มกระบวนการล็อกอิน
    Click Element    id=btn-login
    # เรียกใช้ keyword สำหรับล็อกอินผ่าน Google OAuth โดยส่ง username และ password
    Login With Google OAuth    ${USERNAME}    ${PASSWORD}
    # รอ 5 วินาที เพื่อให้กระบวนการล็อกอินเสร็จสมบูรณ์
    Sleep    5s

    # --- Verify Login Page ---
    Page Should Contain    รายชื่อบุคลากร
    # --- สลับเป็นคุณครู ---
    Click Element  xpath=//*[@id="btn-switch-navbar"]
    # --- เลือกปี ---
    ํYear Dropdown    2568
    # --- เลือกนักเรียน ---
    Click Element  xpath=//*[@id="root"]/div[2]/div/div[4]/div/table/tbody/tr[7]/td[1]
    # --- กดปุ่มประเมิน SDQ ---
    Click Element  xpath=//*[@id="manage_student_68e0f4352e5494aa22a37436"]/div/div/a[1]
    Sleep    5s
    # --- กดบันทึกข้อมูล ---
    Click Button    xpath=//*[@id="submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="root"]/div[2]/div/form/div/div/div[2]/div[1]/div[5]/div[2]    timeout=10s
    Element Text Should Be    xpath=//*[@id="root"]/div[2]/div/form/div/div/div[2]/div[1]/div[5]/div[2]    กรุณาเลือกคำตอบ

    Capture Page Screenshot With Name    TC9001_SDQ Assessment_Error
    Close Browser


*** Keywords ***
ํYear Dropdown
    [Arguments]    ${YEAR}
    Select From List By Label    xpath=//*[@id="year-selector"]    ${YEAR}

Answer SDQ Page 1
    FOR    ${index}    ${answer}    IN ENUMERATE    @{ANSWERS_PAGE_1}
        ${q_index}=    Evaluate    ${index} + 1
        Select Answer    (//div[@class="mr-3 radio"])[${q_index}]    ${answer}
    END
    Click Button    xpath=//*[@id="next-button-page1"]

Answer SDQ Page 2
    FOR    ${index}    ${answer}    IN ENUMERATE    @{ANSWERS_PAGE_2}
        ${q_index}=    Evaluate    ${index} + 1
        Select Answer    (//div[@class="mr-3 radio"])[${q_index}]    ${answer}
    END
    Click Button    xpath=//*[@id="next-button-page2"]

Answer SDQ Page 3
    FOR    ${index}    ${answer}    IN ENUMERATE    @{ANSWERS_PAGE_3}
        ${q_index}=    Evaluate    ${index} + 1
        Select Answer    (//div[@class="mr-3 radio"])[${q_index}]    ${answer}
    END
    Click Button    xpath=///*[@id="next-button-page3"]

Answer SDQ Page 4
    FOR    ${index}    ${answer}    IN ENUMERATE    @{ANSWERS_PAGE_4}
        ${q_index}=    Evaluate    ${index} + 1
        Select Answer    (//div[@class="mr-3 radio"])[${q_index}]    ${answer}
    END
    Click Button    xpath=//*[@id="next-button-page4"]

Answer SDQ Page 5
    FOR    ${index}    ${answer}    IN ENUMERATE    @{ANSWERS_PAGE_5}
        ${q_index}=    Evaluate    ${index} + 1
        Select Answer    (//div[@class="mr-3 radio"])[${q_index}]    ${answer}
    END
    Click Button    xpath=//*[@id="next-button-page5"]

Answer SDQ Page 6
    FOR    ${index}    ${answer}    IN ENUMERATE    @{ANSWERS_PAGE_6}
        ${q_index}=    Evaluate    ${index} + 1
        Select Answer    (//div[@class="mr-3 radio"])[${q_index}]    ${answer}
    END
    Click Button    xpath=//*[@id="submit-button"]

Select Answer
    [Arguments]    ${question_xpath}    ${choice}
    ${option_xpath}=    Set Variable    ${question_xpath}//label[contains(., "${choice}")]
    Click Element    ${option_xpath}


Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${folder}=       Set Variable    ${EXECDIR}/results/SDQ_results
    Create Directory    ${folder}
    ${filename}=     Set Variable    ${folder}/${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}
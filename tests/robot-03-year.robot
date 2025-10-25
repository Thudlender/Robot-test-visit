*** Settings ***
Documentation    ชุดการทดสอบสำหรับระบบปีการศึกษา (Academic Year Management)
Library     SeleniumLibrary
Library    OperatingSystem
Resource     ../resources/keywords.robot
Resource     ../resources/variables.robot

*** Variables ***
${ACADEMIC_YEAR_FIELD}    id=year

*** Test Cases ***

TC1701 - Add year successfully 
    [Documentation]    ทดสอบการเพิ่มปีการศึกษาใหม่
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
    # --- หน้าจัดการปีการศึกษา ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[4]/a
    # --- Delay ---
    Sleep  5s
    # --- ปุ่มเพิ่มปีการศึกษา ---
    Add Academic Year

    Capture Page Screenshot With Name    TC1701_Add_AcademicYear_Success
    Close Browser

TC1702 - Add year till limit error
    [Documentation]    ทดสอบการเพิ่มปีการศึกษาจนถึงขีดจำกัด
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
    # --- หน้าจัดการปีการศึกษา ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[4]/a
    # --- Delay ---
    Sleep  5s
    # --- ปุ่มเพิ่มปีการศึกษา ---
    Add Academic Year Limit Error
    
    Capture Page Screenshot With Name    TC1702_ExistingYear_ErrorLimit
    Close Browser

TC1703 - เจ้าหน้าที่ฝ่ายทะเบียนแก้ไขปีการศึกษาสำเร็จ
    [Documentation]    ทดสอบการแก้ไขปีการศึกษาสำเร็จ
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
    # --- หน้าจัดการปีการศึกษา ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[4]/a
    # --- Delay ---
    Sleep  5s
    # --- กดปุ่ม 3 จุด ---
    Click Element    xpath=//*[@id="dropdown_68fc9b41ff0ca9eb99eeed7c"]
    # --- กดปุ่ม แก้ไข ---
    Click Element    xpath=//*[@id="edit_year_68fc9b41ff0ca9eb99eeed7c"]
    # --- แก้ไขปีการศึกษา ---
    Edit Academic Year   
  

    Capture Page Screenshot With Name    TC1703_EditAcademicYear_Success
    Close Browser

TC1704 - เจ้าหน้าที่ฝ่ายทะเบียนแก้ไขปีการศึกษาไม่สำเร็จ(เพิ่มตัวเลขเกินมา 1 หลัก)
    [Documentation]    ทดสอบการแก้ไขปีการศึกษาโดยเพิ่มตัวเลขเกินมา 1 หลัก
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
    # --- หน้าจัดการปีการศึกษา ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[4]/a
    # --- Delay ---
    Sleep  5s
    # --- กดปุ่ม 3 จุด ---
    Click Element    xpath=//*[@id="dropdown_68fc9d9fff0ca9eb99eeee7d"]
    # --- กดปุ่ม แก้ไข ---
    Click Element    xpath=//*[@id="edit_year_68fc9d9fff0ca9eb99eeee7d"]
    # --- แก้ไขปีการศึกษา ---
    Edit Academic Year Error

    Capture Page Screenshot With Name    TC1704_EditAcademicYear_Error
    Close Browser

TC1705 - เจ้าหน้าที่ฝ่ายทะเบียนแก้ไขปีการศึกษาไม่สำเร็จ(กรอกเลขปีการศึกษาซ้ำปีที่มีอยู่แล้ว)
    [Documentation]    ทดสอบการแก้ไขซ้ำเลขปีการศึกษาที่มีอยู่แล้ว
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
    # --- หน้าจัดการปีการศึกษา ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[4]/a
    # --- Delay ---
    Sleep  5s
    # --- กดปุ่ม 3 จุด ---
    Click Element    xpath=//*[@id="dropdown_68fc9b41ff0ca9eb99eeed7c"]
    # --- กดปุ่ม แก้ไข ---
    Click Element    xpath=//*[@id="edit_year_68fc9b41ff0ca9eb99eeed7c"]
    # --- แก้ไขปีการศึกษาเป็นปีที่มีอยู่แล้ว ---
    Edit Existing Academic Year

    Capture Page Screenshot With Name    TC1705_EditAcademicYear_AlreadyExistsError
    Close Browser

TC1706 - เจ้าหน้าที่ฝ่ายทะเบียนลบปีการศึกษาสำเร็จ
    [Documentation]    ทดสอบการลบปีการศึกษาที่มีอยู่แล้ว
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
    # --- หน้าจัดการปีการศึกษา ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[4]/a
    # --- Delay ---
    Sleep  5s
    # --- กดปุ่ม 3 จุด ---
    Click Element    xpath=//*[@id="dropdown_68fcb049ff0ca9eb99eef218"]
    # --- กดปุ่มลบ ---
    Click Element    xpath=//*[@id="delete_year_68fcb049ff0ca9eb99eef218"]
    # --- กดปุ่มยืนยันการลบ ---
    Delete Academic Year Confirm

    Capture Page Screenshot With Name    TC1706_DeleteAcademicYear_Success
    Close Browser

*** Keywords ***

Add Academic Year
    Click Element    xpath=//*[@id="add_year_button"]
    Wait Until Page Contains   สร้างปีการศึกษา 2570 สำเร็จ   timeout=15s

Add Academic Year Limit Error
    Click Element    xpath=//*[@id="add_year_button"]
    Wait Until Page Contains   สร้างปีการศึกษา 2574 ไม่สำเร็จ   timeout=15s

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
    Click Button            xpath=//*[@id="Edit_year_68fc9b41ff0ca9eb99eeed7c"]/div/form/div[2]/button[1]
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
    Click Button            xpath=//*[@id="Edit_year_68fc9b41ff0ca9eb99eeed7c"]/div/form/div[2]/button[1]
    Wait Until Page Contains   ปีการศึกษา 2568 มีอยู่แล้ว   timeout=15s


Edit Academic Year Error 
    Double Click Element    ${ACADEMIC_YEAR_FIELD}
    Sleep                   0.3s
    Input Text              ${ACADEMIC_YEAR_FIELD}    0
    Sleep                   0.3s
    Click Button            xpath=//*[@id="Edit_year_68fc9d9fff0ca9eb99eeee7d"]/div/form/div[2]/button[1]
    Wait Until Page Contains   xpath=//*[@id="year-error"]   timeout=15s
    Element Text Should Be    xpath=//*[@id="year-error"]    กรุณากรอกปีการศึกษาให้ถูกต้อง


Delete Academic Year Confirm
    Click Element   xpath=/html/body/div[2]/div/div[6]/button[1]
    Wait Until Page Contains   ลบปีการศึกษา 2572 สำเร็จ   timeout=15s
    

Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${folder}=       Set Variable    ${EXECDIR}/results/Year_results
    Create Directory    ${folder}
    ${filename}=     Set Variable    ${folder}/${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}
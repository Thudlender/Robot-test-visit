*** Settings ***
Documentation    ฟังก์ชั่นการจัดการข้อมูลชั้นเรียน (Class Management)
Library     SeleniumLibrary
Library    OperatingSystem
Resource     ../resources/keywords.robot
Resource     ../resources/variables.robot

*** Variables ***
${CLASS_YEAR_NUMBER_FIELD}    id=room_add
${CLASS_ROOM_NUMBER_FIELD}  id=number_add
${TEACHER_NAME_DROPDOWN}    id=teacherId_add
${STUDENT_PREFIX_FIELD}    id=prefix_add 

${UNWANTED_TEACHER_NAME}    พันแสน สมกล้า

${EXCEL_UPLOAD_INPUT}    xpath=//*[@id="upload-excel-button"]
${STUDENT_EXCEL_FILE}    ${EXECDIR}/resources/Student_Excel_File/student4_2.xlsx

*** Test Cases ***

TC1701 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มชั้นเรียนสำเร็จ
    [Documentation]    ทดสอบการเพิ่มชั้นเรียนใหม่
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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- ปุ่มเพิ่มชั้นเรียน ---
    Add Class Button
    # --- กรอกข้อมูลชั้นเรียน ---
    Press Keys              ${CLASS_YEAR_NUMBER_FIELD}    BACKSPACE
    Add Class Year    4
    Press Keys              ${CLASS_ROOM_NUMBER_FIELD}    BACKSPACE
    Add Class Room    6
    Dropdown Select Teacher Name    กิตติศักดิ์ สมบูรณ์
    #--- บันทึกข้อมูลชั้นเรียน ---
    Click Element    xpath=//*[@id="add_classroom"]/div/form/div/div[4]/button[1]
    #--- รอจนกว่าจะมีข้อความยืนยันการสร้างชั้นเรียน ---
    Wait Until Page Contains    สร้างชั้นปี 4 ห้องที่ 6 สำเร็จ   timeout=10s

    Capture Page Screenshot With Name    TC1701_Add_Class_Success
    Close Browser

TC1702 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มชั้นเรียนไม่สำเร็จ(กรอกตัวเลขชั้นปีและเลขห้องเรียนเกินขีดจำกัด)
    [Documentation]    ทดสอบการเพิ่มชั้นเรียนโดยกรณีที่กรอกตัวเลขชั้่นเรียนเกินขีดจำกัด

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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- ปุ่มเพิ่มชั้นเรียน ---
    Add Class Button
    # --- กรอกข้อมูลชั้นเรียน ---
    Press Keys              ${CLASS_YEAR_NUMBER_FIELD}    BACKSPACE
    Add Class Year    7
    Press Keys              ${CLASS_ROOM_NUMBER_FIELD}    BACKSPACE
    Add Class Room    8
    Dropdown Select Teacher Name    กิตติศักดิ์ สมบูรณ์
    #--- บันทึกข้อมูลชั้นเรียน ---
    Submit Class Error Limit

    Capture Page Screenshot With Name    TC1702_Add_Class_Above_Number_Limit
    Close Browser

TC1703 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มชั้นเรียนไม่สำเร็จ(กรอกตัวเลขชั้นเรียนซ้ำกับชั้นที่มีอยู่แล้ว)
    [Documentation]    ทดสอบการเพิ่มเลขชั้นเรียนที่มีอยู่แล้ว

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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- ปุ่มเพิ่มชั้นเรียน ---
    Add Class Button
    # --- กรอกข้อมูลชั้นเรียน ---
    Press Keys              ${CLASS_YEAR_NUMBER_FIELD}    BACKSPACE
    Add Class Year    4
    Press Keys              ${CLASS_ROOM_NUMBER_FIELD}    BACKSPACE
    Add Class Room    2
    Dropdown Select Teacher Name    สมคิด หทัย
    #--- บันทึกข้อมูลชั้นเรียน ---
    Submit Already Existing Class Error

    Capture Page Screenshot With Name    TC1703_Add_Already_Existing_Class
    Close Browser
    



TC1704 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มชั้นเรียนไม่สำเร็จ(ไม่กรอกตัวเลขหรือเลือกตัวเลือกใดๆเลย)
    [Documentation]    ทดสอบการเพิ่มชั้นเรียนโดยกรณีที่ไม่กรอกตัวเลขชั้นเรียน
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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- ปุ่มเพิ่มชั้นเรียน ---
    Add Class Button
    # --- กรอกข้อมูลชั้นเรียน ---
    Press Keys              ${CLASS_YEAR_NUMBER_FIELD}    BACKSPACE
    Press Keys              ${CLASS_ROOM_NUMBER_FIELD}    BACKSPACE
    #--- บันทึกข้อมูลชั้นเรียน ---
    Submit Class Error No Info

    Capture Page Screenshot With Name    TC1704_Add_Class_Year_Error
    Close Browser

TC1705 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มนักเรียนเข้าชั้นเรียนไม่สำเร็จ(ไม่กรอกเลขที่ประจำตัวนักเรียน)
    [Documentation]    ทดสอบการเพิ่มนักเรียนเข้าชั้นเรียน
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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- เลือกชั้นเรียน ---
    Click Element    xpath=//*[@id="classroom-name-4"]
    # --- ปุ่มเพิ่มนักเรียน ---
    Add Student
    # --- กรอกข้อมูลนักเรียน ---
    Select Dropdown Select Prefix Student    เด็กชาย
    Add Student Name    จักรพัต
    Add Student Last Name    กาลแดน

    #--- บันทึกข้อมูลนักเรียน ---
    Click Element    xpath=//*[@id="add-student-submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="user_id-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="user_id-error"]    กรุณากรอกเลขที่ประจำตัวบุคลากร

    Capture Page Screenshot With Name    TC1705_Add_Student_No_ID_Validate
    Close Browser


TC1706 - เจ้าหน้าที่ฝ่ายทะเบียนแก้ไขชั้นเรียนสำเร็จ
    [Documentation]    ทดสอบการแก้ไขชั้นเรียน
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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- กดปุ่มแก้ไขข้อมูลชั้นเรียน ---
    Edit Class Button
    # --- แก้ไขข้อมูลชั้นเรียน ---
    Press Keys              ${CLASS_YEAR_NUMBER_FIELD}    BACKSPACE
    Add Class Year    2
    Press Keys              ${CLASS_ROOM_NUMBER_FIELD}    BACKSPACE
    Add Class Room    2
    Dropdown Select Teacher Name    ศุภาพิชย์ ใจดีมาก
    #--- บันทึกข้อมูลชั้นเรียน แก้ Locator ตรงนี้!!!  ---
    Click Element    xpath=//*[@id="edit_classroom_68e54c1f18c2dc280936b8b9"]/div/form/div/div[4]/button[1]
    #--- รอจนกว่าจะมีข้อความยืนยันการสร้างชั้นเรียน ---
    Wait Until Page Contains    อัพเดตชั้นปี 3 ห้องที่ 4 สำเร็จ   timeout=10s

    Capture Page Screenshot With Name    TC1706_Update_Class_Teacher_Success
    Close Browser


TC1707 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มชั้นเรียนไม่สำเร็จ(เลือกคุณครูที่เคยเลือกในปีการศึกษาเก่าแล้วมาเลือกในปีการศึกษาใหม่)
    [Documentation]    ทดสอบเลือกคุณครูที่เคยเลือกในปีการศึกษาเก่าแล้วมาเลือกในปีการศึกษาใหม่
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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2569
    # --- กดปุ่มแก้ไขข้อมูลชั้นเรียน ---
    Edit Class Button
    # --- แก้ไขข้อมูลชั้นเรียน ---
    Press Keys              ${CLASS_YEAR_NUMBER_FIELD}    BACKSPACE
    Add Class Year    3
    Press Keys              ${CLASS_ROOM_NUMBER_FIELD}    BACKSPACE
    Add Class Room    4

    # @{all_options} =    Get Select List Labels    ${TEACHER_NAME_DROPDOWN}
    # Log List    @{all_options}
    # List Should Not Contain Value    @{all_options}    ${UNWANTED_TEACHER_NAME}
    
    Log    Test Passed: '${UNWANTED_TEACHER_NAME}' was not found in the dropdown, as expected.

    #--- บันทึกข้อมูลชั้นเรียน แก้ Locator ตรงนี้!!!  ---
    Click Element    xpath=//*[@id="edit_classroom_68e54c1f18c2dc280936b8b9"]/div/form/div/div[4]/button[1]
    #--- รอจนกว่าจะมีข้อความยืนยันการสร้างชั้นเรียน ---
    Wait Until Page Contains    อัพเดตชั้นปี 3 ห้องที่ 4 สำเร็จ   timeout=10s

    Capture Page Screenshot With Name     TC1707_Update_Class_Teacher_Success
    Close Browser




############################################################################################################################




TC1708 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มนักเรียนเข้าชั้นเรียนสำเร็จ
    [Documentation]    ทดสอบการเพิ่มนักเรียนเข้าชั้นเรียน
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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- เลือกชั้นเรียน ---
    Click Element    xpath=//*[@id="classroom-name-4"]
    # --- ปุ่มเพิ่มนักเรียน ---
    Add Student
    # --- กรอกข้อมูลนักเรียน ---
    Select Dropdown Select Prefix Student    เด็กชาย
    Add Student ID    40009
    Add Student Name    จักรพัต
    Add Student Last Name    กาลแดน

    #--- บันทึกข้อมูลชั้นเรียน ---
    Click Element    xpath=//*[@id="add-student-submit-button"]
    #--- รอจนกว่าจะมีข้อความยืนยันการสร้างชั้นเรียน ---
    Wait Until Page Contains    เพิ่มข้อมูลนักเรียนสำเร็จ   timeout=10s

    Capture Page Screenshot With Name    TC1708_Add_Student_To_Class_Success
    Close Browser

TC1709 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มนักเรียนเข้าชั้นเรียนไม่สำเร็จ(ไม่กรอกหรือเลือกข้อมูลไดๆเลย)
    [Documentation]    ทดสอบการเพิ่มนักเรียนเข้าชั้นเรียน
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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- เลือกชั้นเรียน ---
    Click Element    xpath=//*[@id="classroom-name-4"]
    # --- ปุ่มเพิ่มนักเรียน ---
    Add Student
    # --- กรอกข้อมูลนักเรียน ---
    Add Student ID    40009
    Add Student Name    จักรพัต
    Add Student Last Name    กาลแดน

    #--- บันทึกข้อมูลนักเรียน ---
    Click Element    xpath=//*[@id="add-student-submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="prefix-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="prefix-error"]    กรุณาเลือกคำนำหน้า

    Capture Page Screenshot With Name    TC1709_Add_Student_Without_Info_Validates
    Close Browser

TC1710 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มนักเรียนเข้าชั้นเรียนไม่สำเร็จ(ไม่กรอกชื่อ)
    [Documentation]    ทดสอบการเพิ่มนักเรียนเข้าชั้นเรียน
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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- เลือกชั้นเรียน ---
    Click Element    xpath=//*[@id="classroom-name-4"]
    # --- ปุ่มเพิ่มนักเรียน ---
    Add Student
    # --- กรอกข้อมูลนักเรียน ---
    Select Dropdown Select Prefix Student    เด็กชาย
    Add Student ID    40009
    Add Student Last Name    กาลแดน

    #--- บันทึกข้อมูลนักเรียน ---
    Click Element    xpath=//*[@id="add-student-submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="first_name-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="first_name-error"]    กรุณากรอกชื่อ

    Capture Page Screenshot With Name    TC1710_Add_Student_NoName_Validate
    Close Browser

TC1711 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มนักเรียนเข้าชั้นเรียนไม่สำเร็จ(ไม่กรอกนามสกุล)
    [Documentation]    ทดสอบการเพิ่มนักเรียนเข้าชั้นเรียน
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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- เลือกชั้นเรียน ---
    Click Element    xpath=//*[@id="classroom-name-4"]
    # --- ปุ่มเพิ่มนักเรียน ---
    Add Student
    # --- กรอกข้อมูลนักเรียน ---
    Select Dropdown Select Prefix Student    เด็กชาย
    Add Student ID    40009
    Add Student Name    จักรพัต

    #--- บันทึกข้อมูลนักเรียน ---
    Click Element    xpath=//*[@id="add-student-submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="last_name-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="last_name-error"]    กรุณากรอกนามสกุล

    Capture Page Screenshot With Name    TC1711_Add_Student_No_Last_Name_Validate
    Close Browser

TC1712 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มนักเรียนเข้าชั้นเรียนไม่สำเร็จ(กรอกเลขประจำตัวนักเรียนเป็นตัวอักษรไทย)
    [Documentation]    ทดสอบการเพิ่มนักเรียนเข้าชั้นเรียน
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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- เลือกชั้นเรียน ---
    Click Element    xpath=//*[@id="classroom-name-4"]
    # --- ปุ่มเพิ่มนักเรียน ---
    Add Student
    # --- กรอกข้อมูลนักเรียน ---
    Select Dropdown Select Prefix Student    เด็กชาย
    Add Student ID    40009
    Add Student Name    จักรพัต
    Add Student Last Name    กาลแดน

    #--- บันทึกข้อมูลนักเรียน ---
    Click Element    xpath=//*[@id="add-student-submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="user_id-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="user_id-error"]    กรุณากรอกเลขที่ประจำตัวบุคลากรให้ถูกต้อง
                                                               # ---- ยังต้องแก้ --------
    Capture Page Screenshot With Name    TC1712_Add_Student_Thai_ID_Validate
    Close Browser

TC1713 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มนักเรียนเข้าชั้นเรียนไม่สำเร็จ(กรอกชื่อเป็นภาษาอังกฤษ)
    [Documentation]    ทดสอบการเพิ่มนักเรียนเข้าชั้นเรียน
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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- เลือกชั้นเรียน ---
    Click Element    xpath=//*[@id="classroom-name-4"]
    # --- ปุ่มเพิ่มนักเรียน ---
    Add Student
    # --- กรอกข้อมูลนักเรียน ---
    Select Dropdown Select Prefix Student    เด็กชาย
    Add Student ID    40009
    Add Student Name    Jakkaphat
    Add Student Last Name    กาลแดน

    #--- บันทึกข้อมูลนักเรียน ---
    Click Element    xpath=//*[@id="add-student-submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="first_name-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="first_name-error"]    จำเป็นต้องเป็นภาษาไทย

    Capture Page Screenshot With Name    TC1713_Add_Student_English_Name_Validate
    Close Browser

TC1714 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มนักเรียนเข้าชั้นเรียนไม่สำเร็จ(กรอกนามสกุลเป็นภาษาอังกฤษ)
    [Documentation]    ทดสอบการเพิ่มนักเรียนเข้าชั้นเรียนไม่สำเร็จ(กรอกนามสกุลเป็นภาษาอังกฤษ)
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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- เลือกชั้นเรียน ---
    Click Element    xpath=//*[@id="classroom-name-4"]
    # --- ปุ่มเพิ่มนักเรียน ---
    Add Student
    # --- กรอกข้อมูลนักเรียน ---
    Select Dropdown Select Prefix Student    เด็กชาย
    Add Student ID    40009
    Add Student Name    จักรพัต
    Add Student Last Name    Kandeang

    #--- บันทึกข้อมูลนักเรียน ---
    Click Element    xpath=//*[@id="add-student-submit-button"]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="last_name-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="last_name-error"]    จำเป็นต้องเป็นภาษาไทย

    Capture Page Screenshot With Name    TC1714_Add_Student_English_Last_Name_Validate
    Close Browser

TC1715 - เจ้าหน้าที่ฝ่ายทะเบียนอัปโหลดไฟล์เอกเซลรายชื่อนักเรียนเข้าชั้นเรียนสำเร็จ
    [Documentation]    ทดสอบการเอัปโหลดไฟล์เอกเซลรายชื่อนักเรียนเข้าชั้นเรียน
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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- เลือกชั้นเรียน ---
    Click Element    xpath=//*[@id="classroom-name-5"]
    # --- ปุ่มอัปโหลด Excel ---
    Upload Student Excel File
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Page Contains    นำเข้าข้อมูลนักเรียนสำเร็จ   timeout=10s

    Capture Page Screenshot With Name    TC1715_Upload_Student_Excel_File_Success
    Close Browser

TC1716 - เจ้าหน้าที่ฝ่ายทะเบียนแก้ไขข้อมูลนักเรียนสำเร็จ
    [Documentation]    ทดสอบการเพิ่มนักเรียนเข้าชั้นเรียน
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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- เลือกชั้นเรียน ---
    Click Element    xpath=//*[@id="classroom-name-4"]
    # --- ปุ่มแก้ไขนักเรียน ---
    Edit Student Button
    # --- กรอกข้อมูลนักเรียน ---
    Select Dropdown Select Prefix Student    นางสาว
    Add Student ID    40009
    Add Student Name    จาตุรงค์
    Add Student Last Name    หยกนกยูง

    #--- บันทึกข้อมูลชั้นเรียน ---
    Click Element    xpath=//*[@id="add-student-submit-button"]
    #--- รอจนกว่าจะมีข้อความยืนยันการสร้างชั้นเรียน ---
    Wait Until Page Contains    แก้ไขข้อมูลนักเรียนสำเร็จ   timeout=10s

    Capture Page Screenshot With Name    TC1716_Edit_Student_In_Class_Success
    Close Browser

TC1717 - เจ้าหน้าที่ฝ่ายทะเบียนลบนักเรียนสำเร็จ
    [Documentation]    ทดสอบการลบนักเรียน
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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- เลือกชั้นเรียน ---
    Click Element    xpath=//*[@id="classroom-name-4"]
    # --- ปุ่มลบนักเรียน ---
    Delete Student Button

    Capture Page Screenshot With Name    TC1717_Delete_Student_In_Class_Success
    Close Browser

TC1718 - เจ้าหน้าที่ฝ่ายทะเบียนลบชั้นเรียนสำเร็จ
    [Documentation]    ทดสอบการลบชั้นเรียน
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
    # --- หน้าจัดการชั้นเรียน ---
    Click Element  xpath=//*[@id="root"]/div[1]/div[2]/ul/li[5]/a
    # --- Delay ---
    Sleep  5s
    # --- เลือกปีการศึกษา ---
    Select Year From Dropdown    2568
    # --- กดปุ่มลบชั้นเรียน ---
    Delete Class Button
    #--- ยืนยันการลบชั้นเรียน ---
    Delete Class Confirm

    Capture Page Screenshot With Name    TC1718_Delete_Class_Success
    Close Browser

*** Keywords ***

Select Year From Dropdown
    [Arguments]    ${year}
    Select From List By Label    xpath=//*[@id="year-selector"]    ${year}
Add Class Button 
    #--- ปุ่มเพิ่มชั้นเรียน ---
    Click Element    xpath=//*[@id="root"]/div[2]/div/div[2]/div[3]/div[2]/button
    Sleep    2s

Submit Class Error Limit
    Click Button   xpath=//*[@id="add_classroom"]/div/form/div/div[4]/button[1] 
    Wait Until Page Contains    กรุณากรอกเลขชั้นเรียนไม่เกิน 6
    Wait Until Page Contains    กรุณากรอกห้องเรียนไม่เกิน 7

    Log    All 2 validation messages are present.

Submit Already Existing Class Error
    Click Button   xpath=//*[@id="add_classroom"]/div/form/div/div[4]/button[1] 
    Wait Until Page Contains    ชั้นปี 4 ห้องที่ 2 มีอยู่แล้ว  


Submit Class Error No Info
    Click Button   xpath=//*[@id="add_classroom"]/div/form/div/div[4]/button[1] 
    Wait Until Page Contains    กรุณากรอกเลขชั้นเรียน
    Wait Until Page Contains    กรุณากรอกห้องเรียน
    Wait Until Page Contains    กรุณาเลือกครูที่ปรึกษา

    Log    All 3 validation messages are present.


Edit Class Button 
    #--- ปุ่มแก้ไขชั้นเรียน ---
    Click Element    xpath=//*[@id="edit-classroom-button_6"]
    Sleep    2s

Edit Class Button On Different Year
    #--- ปุ่มแก้ไขชั้นเรียน ---
    Click Element    xpath=//*[@id="edit-classroom-button_6"]
    Sleep    2s

Delete Class Button
    #--- ปุ่มลบชั้นเรียน ---
    Click Element    xpath=//*[@id="delete-classroom-button_6"]
    Sleep    2s

Delete Class Confirm
    #--- ยืนยันการลบชั้นเรียน ---
    Click Element    xpath=/html/body/div[2]/div/div[6]/button[1]
    Wait Until Page Contains   ลบชั้นปี 4 ห้องที่ 4 สำเร็จ   timeout=15s

Add Student
    #--- ปุ่มเพิ่มนักเรียนเข้าชั้นเรียน ---
    Click Element    xpath=//*[@id="root"]/div[2]/div/div[2]/div[2]/button[2]
    Sleep    2s

Edit Student Button
    #--- ปุ่มแก้ไขนักเรียนในชั้นเรียน ---
    Click Element    //*[@id="edit-student-button_6"]
    Sleep    2s

Delete Student Button
    #--- ปุ่มลบนักเรียน ---
    Click Element      xpath=//*[@id="delete-student-button_7"]
    Sleep    2s
    #--- ยืนยันการลบนักเรียน ---
    Click Element    xpath=/html/body/div[2]/div/div[6]/button[1]
    Wait Until Page Contains   ลบผู้ใช้ สุธิดา เกษมสุข สำเร็จ   timeout=15s

Select Dropdown Select Prefix Student
    [Arguments]    ${STUDENT_PREFIX}
    Select From List By Label    ${STUDENT_PREFIX_FIELD}    ${STUDENT_PREFIX}

Add Student ID
    [Arguments]    ${STUDENT_ID_NUMBER} 
    Input Text    id=user_id_add    ${STUDENT_ID_NUMBER} 

Add Student Name
    [Arguments]    ${STUDENT_NAME}
    Input Text    id=first_name_add    ${STUDENT_NAME}

Add Student Last Name
    [Arguments]    ${STUDENT_LASTNAME}
    Input Text    id=last_name_add    ${STUDENT_LASTNAME}

Add Class Year
    [Arguments]    ${CLASS_YEAR_NUMBER}
    Input Text    ${CLASS_YEAR_NUMBER_FIELD}    ${CLASS_YEAR_NUMBER}

Add Class Room
    [Arguments]    ${CLASS_ROOM_NUMBER}
    Input Text    ${CLASS_ROOM_NUMBER_FIELD}    ${CLASS_ROOM_NUMBER}

Dropdown Select Teacher Name
    [Arguments]    ${TEACHER_NAME}
    Select From List By Label    ${TEACHER_NAME_DROPDOWN}    ${TEACHER_NAME}



Upload Student Excel File
    ${absolute_path} =    Normalize Path    ${STUDENT_EXCEL_FILE}
    Log    Uploading file from: ${absolute_path}
    File Should Exist    ${absolute_path}
    Choose File    ${EXCEL_UPLOAD_INPUT}    ${absolute_path}
    

Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${folder}=       Set Variable    ${EXECDIR}/results/Class_results
    Create Directory    ${folder}
    ${filename}=     Set Variable    ${folder}/${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}

*** Settings ***
Documentation    ฟังก์ชั่นการจัดการข้อมูลชั้นเรียน (Class Management)
Library     SeleniumLibrary
Library    OperatingSystem
Resource     ../resources/keywords.robot
Resource     ../resources/variables.robot

*** Variables ***
${CLASS_YEAR_NUMBER_FIELD}    id=room
${CLASS_ROOM_NUMBER_FIELD}  id=number
${TEACHER_FIELD}    id=teacherId
${STUDENT_PREFIX_FIELD}    id=prefix 


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
    # --- ปุ่มเพิ่มชั้นเรียน ---
    Add Class Button
    # --- กรอกข้อมูลชั้นเรียน ---
    Add Class Year    4
    Add Class Room    6
    Prefix Dropdown Select Teacher    กิตติศักดิ์ สมบูรณ์
    #--- บันทึกข้อมูลชั้นเรียน ---
    Click Element    xpath=//*[@id="add_classroom"]/div/form/div/div[4]/button[1]
    #--- รอจนกว่าจะมีข้อความยืนยันการสร้างชั้นเรียน ---
    Wait Until Page Contains    สร้างชั้นปีที่ 4 ห้องที่ 6 สำเร็จ   timeout=10s

    Capture Page Screenshot With Name    TC1701_Add_Class_Success
    Close Browser

TC1702 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มชั้นเรียนไม่สำเร็จ(กรอกตัวเลขชั้่นเรียนมากกว่าเลข 6)
    [Documentation]    ทดสอบการเพิ่มชั้นเรียนโดยกรณีที่กรอกตัวเลขชั้่นเรียนมากกว่าเลข 6

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
    # --- ปุ่มเพิ่มชั้นเรียน ---
    Add Class Button
    # --- กรอกข้อมูลชั้นเรียน ---
    Add Class Year    7
    Add Class Room    6
    Prefix Dropdown Select Teacher    กิตติศักดิ์ สมบูรณ์
    #--- บันทึกข้อมูลชั้นเรียน ---
    Click Element    xpath=//*[@id="add_classroom"]/div/form/div/div[4]/button[1]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="room-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="room-error"]    กรุณากรอกเลขชั้นเรียนไม่เกิน 6

    Capture Page Screenshot With Name    TC1702_Add_Class_Year_Error_More_Than_6
    Close Browser

TC1703 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มชั้นเรียนไม่สำเร็จ(กรอกตัวเลขชั้่นเรียนมากกว่าเลข 7)
    [Documentation]    ทดสอบการเพิ่มชั้นเรียนโดยกรณีที่กรอกตัวเลขชั้่นเรียนมากกว่าเลข 7
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
    # --- ปุ่มเพิ่มชั้นเรียน ---
    Add Class Button
    # --- กรอกข้อมูลชั้นเรียน ---
    Add Class Year    4
    Add Class Room    8
    Prefix Dropdown Select Teacher    กิตติศักดิ์ สมบูรณ์
    #--- บันทึกข้อมูลชั้นเรียน ---
    Click Element    xpath=//*[@id="add_classroom"]/div/form/div/div[4]/button[1]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="number-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="number-error"]    กรุณากรอกห้องเรียนไม่เกิน 7

    Capture Page Screenshot With Name    TC1703_Add_Class_Room_Error_More_Than_7
    Close Browser

TC1704 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มชั้นเรียนไม่สำเร็จ(ไม่กรอกตัวเลขชั้นเรียน)
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
    # --- ปุ่มเพิ่มชั้นเรียน ---
    Add Class Button
    # --- กรอกข้อมูลชั้นเรียน ---
    Add Class Room    6
    Prefix Dropdown Select Teacher    กิตติศักดิ์ สมบูรณ์
    #--- บันทึกข้อมูลชั้นเรียน ---
    Click Element    xpath=//*[@id="add_classroom"]/div/form/div/div[4]/button[1]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="room-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="room-error"]    กรุณากรอกเลขชั้นเรียน

    Capture Page Screenshot With Name    TC1704_Add_Class_Year_Error
    Close Browser

TC1705 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มชั้นเรียนไม่สำเร็จ(ไม่กรอกตัวเลขห้องเรียน)
    [Documentation]    ทดสอบการเพิ่มชั้นเรียนโดยกรณีที่ไม่กรอกตัวเลขห้องเรียน
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
    # --- ปุ่มเพิ่มชั้นเรียน ---
    Add Class Button
    # --- กรอกข้อมูลชั้นเรียน ---
    Add Class Year    4
    Prefix Dropdown Select Teacher    กิตติศักดิ์ สมบูรณ์
    #--- บันทึกข้อมูลชั้นเรียน ---
    Click Element    xpath=//*[@id="add_classroom"]/div/form/div/div[4]/button[1]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="number-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="number-error"]    กรุณากรอกห้องเรียน

    Capture Page Screenshot With Name    TC1705_Add_Class_Room_Error
    Close Browser

TC1706 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มชั้นเรียนไม่สำเร็จ(ไม่เลือกครูที่ปรึกษา)
    [Documentation]    ทดสอบการเพิ่มชั้นเรียนโดยกรณีที่ไม่เลือกครูที่ปรึกษา
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
    # --- ปุ่มเพิ่มชั้นเรียน ---
    Add Class Button
    # --- กรอกข้อมูลชั้นเรียน ---
    Add Class Year    4
    Add Class Room    6
    #--- บันทึกข้อมูลชั้นเรียน ---
    Click Element    xpath=//*[@id="add_classroom"]/div/form/div/div[4]/button[1]
    # --- ตรวจสอบผลลัพธ์ ---
    Wait Until Element Is Visible    xpath=//*[@id="teacherId-error"]    timeout=10s
    Element Text Should Be    xpath=//*[@id="teacherId-error"]    กรุณาเลือกครูที่ปรึกษา

    Capture Page Screenshot With Name    TC1706_Add_Class_Teacher_Error
    Close Browser

TC1707 - เจ้าหน้าที่ฝ่ายทะเบียนแก้ไขชั้นเรียนสำเร็จ
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
    # --- กดปุ่มแก้ไขข้อมูลชั้นเรียน ---
    Edit Class Button
    # --- แก้ไขข้อมูลชั้นเรียน ---
    Add Class Year    3
    Add Class Room    4
    Prefix Dropdown Select Teacher    ศุภาพิชย์ ใจดีมาก
    #--- บันทึกข้อมูลชั้นเรียน แก้ Locator ตรงนี้!!!  ---
    Click Element    xpath=//*[@id="edit_classroom_68e54c1f18c2dc280936b8b9"]/div/form/div/div[4]/button[1]
    #--- รอจนกว่าจะมีข้อความยืนยันการสร้างชั้นเรียน ---
    Wait Until Page Contains    อัพเดตชั้นปี 3 ห้องที่ 4 สำเร็จ   timeout=10s

    Capture Page Screenshot With Name    TC1707_Update_Class_Teacher_Success
    Close Browser

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
    # --- ปุ่มเพิ่มชั้นเรียน ---
    Add Student
    # --- กรอกข้อมูลชั้นเรียน ---
    Select Dropdown Select Prefix Student    เด็กชาย
    Add Student ID    83747
    Add Student Name    จักรพัต
    Add Student Last Name    กาลแดน

    #--- บันทึกข้อมูลชั้นเรียน ---
    Click Element    //*[@id="add-student-submit-button"]
    #--- รอจนกว่าจะมีข้อความยืนยันการสร้างชั้นเรียน ---
    Wait Until Page Contains    เพิ่มข้อมูลนักเรียนสำเร็จ   timeout=10s

    Capture Page Screenshot With Name    TC1708_Add_Student_To_Class_Success
    Close Browser
    
TC1709 - เจ้าหน้าที่ฝ่ายทะเบียนลบชั้นเรียนสำเร็จ
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
    # --- กดปุ่มลบชั้นเรียน ---
    Delete Class Button
    #--- ยืนยันการลบชั้นเรียน ---
    Delete Class Confirm

    Capture Page Screenshot With Name    TC1708_Delete_Class_Teacher_Success
    Close Browser

*** Keywords ***
Add Class Button 
    #--- ปุ่มเพิ่มชั้นเรียน ---
    Click Element    xpath=//*[@id="root"]/div[2]/div/div[2]/div[3]/div[2]/button
    Sleep    2s

Edit Class Button 
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
    Wait Until Page Contains   ลบชั้นปี 6 ห้องที่ 4 สำเร็จ   timeout=15s

Add Student
    #--- ปุ่มเพิ่มนักเรียนเข้าชั้นเรียน ---
    Click Element    xpath=//*[@id="root"]/div[2]/div/div[2]/div[2]/button[2]
    Sleep    2s

Add Student ID
    [Arguments]    ${STUDENT_ID_NUMBER} 
    Input Text    id=add-student-userid-input    ${STUDENT_ID_NUMBER} 
Select Dropdown Select Prefix Student
    [Arguments]    ${STUDENT_PREFIX}
    Select From List By Label    ${STUDENT_PREFIX_FIELD}    ${STUDENT_PREFIX}

Add Student Name
    [Arguments]    ${STUDENT_NAME}
    Input Text    id=add-student-firstname-input    ${STUDENT_NAME}

Add Student Last Name
    [Arguments]    ${STUDENT_LASTNAME}
    Input Text    id=add-student-lastname-input    ${STUDENT_LASTNAME}

Add Class Year
    [Arguments]    ${CLASS_YEAR_NUMBER}
    Input Text    ${CLASS_YEAR_NUMBER_FIELD}    ${CLASS_YEAR_NUMBER}

Add Class Room
    [Arguments]    ${CLASS_ROOM_NUMBER}
    Input Text    ${CLASS_ROOM_NUMBER_FIELD}    ${CLASS_ROOM_NUMBER}

Prefix Dropdown Select Teacher
    [Arguments]    ${TEACHER_NAME}
    Select From List By Label    ${TEACHER_FIELD}    ${TEACHER_NAME}


Capture Page Screenshot With Name
    [Arguments]    ${test_case_name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${folder}=       Set Variable    ${EXECDIR}/results/Class_results
    Create Directory    ${folder}
    ${filename}=     Set Variable    ${folder}/${test_case_name}_${timestamp}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}

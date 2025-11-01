*** Settings ***
Documentation    ฟังก์ชั่นการจัดการข้อมูลชั้นเรียน (Class Management)
Library     SeleniumLibrary
Library    OperatingSystem
Resource     ../resources/keywords.robot
Resource     ../resources/variables.robot
Resource     ../resources/04-class-keywords.robot


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

TC1705 - เจ้าหน้าที่ฝ่ายทะเบียนแก้ไขชั้นเรียนสำเร็จ
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
    Add Class Year    3
    Press Keys              ${CLASS_ROOM_NUMBER_FIELD}    BACKSPACE
    Add Class Room    4
    Dropdown Select Teacher Name    ศุภาพิชย์ ใจดีมาก
    #--- บันทึกข้อมูลชั้นเรียน แก้ Locator ตรงนี้!!!  ---
    Click Element    xpath=//*[@id="edit_classroom_68e54c1f18c2dc280936b8b9"]/div/form/div/div[4]/button[1]
    #--- รอจนกว่าจะมีข้อความยืนยันการสร้างชั้นเรียน ---
    Wait Until Page Contains    อัพเดตชั้นปี 3 ห้องที่ 4 สำเร็จ   timeout=10s

    Capture Page Screenshot With Name    TC1705_Update_Class_Teacher_Success
    Close Browser


TC1706 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มชั้นเรียนไม่สำเร็จ(เลือกคุณครูที่เคยเลือกในปีการศึกษาเก่าแล้วมาเลือกในปีการศึกษาใหม่)
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

    Capture Page Screenshot With Name     TC1706_Update_Class_Teacher_Success
    Close Browser




############################################################################################################################




TC1707 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มนักเรียนเข้าชั้นเรียนสำเร็จ
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
    Add Student ID    40009

    #--- บันทึกข้อมูลชั้นเรียน ---
    Submit Student Button

    Capture Page Screenshot With Name    TC1707_Add_Student_To_Class_Success
    Close Browser

TC1708 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มนักเรียนเข้าชั้นเรียนไม่สำเร็จ(ไม่กรอกหรือเลือกข้อมูลไดๆเลย)
    [Documentation]    ทดสอบไม่กรอกหรือเลือกข้อมูลไดๆเลย
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
    
    Submit Student Button No Info

    Capture Page Screenshot With Name    TC1708_Add_Student_Without_Info_Validates
    Close Browser


TC1709 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มนักเรียนเข้าชั้นเรียนไม่สำเร็จ(กรอกเลขข้อมูลนักเรียนเป็นตัวอักษรภาษาอังกฤษและตัวพิเศษ)
    [Documentation]    ทดสอบการกรอกเลขข้อมูลนักเรียนเป็นตัวอักษรภาษาอังกฤษและตัวพิเศษ
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
    Add Student Name    Jakkaphat&@
    Add Student Last Name    Kandeang%
    Add Student ID    NumberID#

    #--- บันทึกข้อมูลนักเรียน ---
    Submit Student Button Specail Eng
                                                               # ---- ยังต้องแก้ --------
    Capture Page Screenshot With Name    TC1709_Add_Student_Thai_ID_Validate
    Close Browser

TC1710 - เจ้าหน้าที่ฝ่ายทะเบียนอัปโหลดไฟล์เอกเซลรายชื่อนักเรียนเข้าชั้นเรียนสำเร็จ
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

    Capture Page Screenshot With Name    TC1710_Upload_Student_Excel_File_Success
    Close Browser

TC1711 - เจ้าหน้าที่ฝ่ายทะเบียนแก้ไขข้อมูลนักเรียนสำเร็จ
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
    Select Dropdown Select Prefix Student Edit    นางสาว
    Edit Student ID    40009
    Edit Student Name    จาตุรงค์
    Edit Student Last Name    หยกนกยูง

    #--- บันทึกข้อมูลชั้นเรียน ---
    Click Element    xpath=//*[@id="add-student-submit-button"]
    #--- รอจนกว่าจะมีข้อความยืนยันการสร้างชั้นเรียน ---
    Wait Until Page Contains    แก้ไขข้อมูลนักเรียนสำเร็จ   timeout=10s

    Capture Page Screenshot With Name    TC1711_Edit_Student_In_Class_Success
    Close Browser

TC1712 - เจ้าหน้าที่ฝ่ายทะเบียนลบนักเรียนสำเร็จ
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

    Capture Page Screenshot With Name    TC1712_Delete_Student_In_Class_Success
    Close Browser

TC1713 - เจ้าหน้าที่ฝ่ายทะเบียนลบชั้นเรียนสำเร็จ
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

    Capture Page Screenshot With Name    TC1713_Delete_Class_Success
    Close Browser

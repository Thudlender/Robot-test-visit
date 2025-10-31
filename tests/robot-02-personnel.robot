*** Settings ***
Documentation    ชุดการทดสอบสำหรับระบบจัดการข้อมูลบุคลากร (Personnel Management)
Library     SeleniumLibrary
Library    OperatingSystem
Resource     ../resources/keywords.robot
Resource     ../resources/variables.robot
Resource     ../resources/02-personnel-keywords.robot


*** Test Cases ***
    
TC1401 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มบัญชีคุณครูที่ปรึกษาสำเร็จ
    [Documentation]    ทดสอบการเพิ่มบัญชีคุณครูที่ปรึกษาใหม่โดยเจ้าหน้าที่ฝ่ายทะเบียน
    
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
    # --- Add Personnel Button ---
    Add Teacher     
    # --- กรอกข้อมูลบุคลากร ---
    Prefix Dropdown    นาย 
    Input First Name    สมรักษ์
    Input Last Name    ศรัทธา
    Input User ID    022
    Input Phone Number    0686548694
    Submit Personnel Info Success
    
    Capture Page Screenshot with Name    TC1401_Success
    Close Browser

TC1402 - เพิ่มบุคลากรใหม่โดยไม่กรอกหรือเลือกข้อมูลใดๆเลย
    [Documentation]    ทดสอบการเพิ่มบัญชีคุณครูที่ปรึกษาใหม่โดยเจ้าหน้าที่ฝ่ายทะเบียน โดยกรอกข้อมูลทั้งหมดเป็นภาษาอังกฤษ
   
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
    # --- Add Personnel Button ---
    Add Teacher
    # --- กดปุ่มบันทึกโดยไม่กรอกข้อมูลใดๆ ---
    Submit Personnel No Info Error
    Capture Page Screenshot With Name    TC1402_Validation
    Close Browser

TC1403 - เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มบัญชีคุณครูที่ปรึกษาไม่สำเร็จ(กรอกข้อมูลทั้งหมดเป็นภาษาอังกฤษและตัวอักษรพิเศษ)
    [Documentation]    ทดสอบการเพิ่มบัญชีคุณครูที่ปรึกษาใหม่โดยเจ้าหน้าที่ฝ่ายทะเบียน โดยกรอกข้อมูลทั้งหมดเป็นภาษาอังกฤษ
   
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
    # --- Add Personnel Button ---
    Add Teacher
    # --- กรอกข้อมูลบุคลากรโดยที่ไม่เลือกคำนำหน้า
    Prefix Dropdown    นาย
    Input First Name     Somrak@
    Input Last Name     Sattha%
    Input User ID     UserID^
    Input Phone Number     PhoneNumber#
    Submit Personnel Eng Info Error

    Capture Page Screenshot With Name    TC1403_Validation
    Close Browser

TC1404 เจ้าหน้าที่ฝ่ายทะเบียนแก้ไขข้อมูลบัญชีคุณครูที่ปรึกษาสำเร็จ
    [Documentation]    ทดสอบการแก้ไขข้อมูลบัญชีคุณครูที่ปรึกษาโดยเจ้าหน้าที่ฝ่ายทะเบียนสำเร็จ
    
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
    # --- Edit Personnel Button ---
    Edit personnel

    # --- กรอกข้อมูลบุคลากร ---   
    Prefix Dropdown Edit    นางสาว
    Input First Name Edit    พิมพรหญิง
    Input Last Name Edit    สุขดี
    Input Phone Number Edit    0864479528
    Status Dropdown Edit    ไม่ได้ใช้งานแล้ว
    Save Edit Personnel
 
    Capture Page Screenshot With Name    TC1404_EditPersonnel_Success
    Close Browser

TC1405 เจ้าหน้าที่ฝ่ายทะเบียนลบบัญชีคุณครูที่ปรึกษาสำเร็จ
    [Documentation]    ทดสอบการลบบัญชีคุณครูที่ปรึกษาโดยเจ้าหน้าที่ฝ่ายทะเบียนสำเร็จ
    
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
    Delete personnel

    Capture Page Screenshot With Name    TC1405_Delete_Personnel_Success
    Close Browser

TC1406 เจ้าหน้าที่ฝ่ายทะเบียนเพิ่มสิทธิบทบาทผู้ดูแลเป็นเจ้าหน้าที่สำเร็จ
    [Documentation]    ทดสอบการเพิ่มสิทธิบทบาทผู้ดูแลเป็นเจ้าหน้าที่สำเร็จ
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
    # --- Navigate to Admin Role Page ---
    Click Element    xpath=//*[@id="root"]/div[1]/div[2]/ul/li[3]/a
    Sleep    3s
    # --- Toggle Add Admin Role ---
    Toggle Add Admin Role

    Capture Page Screenshot With Name    TC1406_AddAdminRole_Success
    Close Browser

TC1407 เจ้าหน้าที่ฝ่ายทะเบียนลบสิทธิบทบาทผู้ดูแลสำเร็จ
    [Documentation]    ทดสอบการลบสิทธิบทบาทผู้ดูแลสำเร็จ
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
    # --- Navigate to Admin Role Page ---
    Click Element    xpath=//*[@id="root"]/div[1]/div[2]/ul/li[3]/a
    Sleep    3s
    # --- Toggle Delete Admin Role ---
    Toggle Delete Admin Role

    Capture Page Screenshot With Name    TC1407_DeleteAdminRole_Success
    Close Browser


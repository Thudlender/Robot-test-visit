*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Resource    ../resources/variables.robot

*** Keywords ***
Login With Google OAuth
    [Arguments]    ${username}    ${password}
    # เก็บ handle ของหน้าต่างหลักไว้ก่อน เพื่อใช้กลับมาหลังล็อกอิน
    ${main_window}=    Get Window Handles
    # รอ 5 วินาที เพื่อให้หน้าต่าง popup ของ Google เปิดขึ้น
    Sleep    5s
    # ดึง handle ของทุกหน้าต่าง (หลัก + popup)
    ${all_windows}=    Get Window Handles
    # สลับไปยังหน้าต่าง popup ของ Google OAuth (index 1)
    Switch Window   ${all_windows}[1]
    # รอจนกว่า element สำหรับกรอกอีเมลจะปรากฏ (id=identifierId)
    Wait Until Page Contains Element   id=identifierId    timeout=10s 
    # คลิกที่ช่องกรอกอีเมล
    Click Element     id=identifierId

    # กรอกอีเมลผู้ใช้ลงในช่องกรอกอีเมล
    Input Text    id=identifierId    ${username}
    # รอจนกว่าปุ่มถัดไปจะปรากฏ (xpath)
    Wait Until Element Is Visible    xpath=//*[@id="identifierNext"]/div/button/span   timeout=10s
    # คลิกปุ่มถัดไปหลังกรอกอีเมล
    Click Element  xpath=//*[@id="identifierNext"]/div/button/span 
    # รอจนกว่าช่องกรอกรหัสผ่านจะปรากฏ (name=Passwd)
    Wait Until Element Is Visible    name=Passwd    timeout=10s
    # กรอกรหัสผ่านผู้ใช้
    Input Text    name=Passwd    ${password}
    # คลิกปุ่มถัดไปหลังกรอกรหัสผ่าน
    Click Element    xpath=//*[@id="passwordNext"]/div/button/span
    # รอ 10 วินาที เพื่อให้กระบวนการล็อกอินเสร็จสมบูรณ์
    Sleep    10s
    # สลับกลับไปยังหน้าต่างหลักหลังล็อกอินสำเร็จ
    Switch Window    ${main_window}[0]




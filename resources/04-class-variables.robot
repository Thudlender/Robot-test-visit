*** Variables ***
${CLASS_YEAR_NUMBER_FIELD}    id=room_add
${CLASS_ROOM_NUMBER_FIELD}  id=number_add
${TEACHER_NAME_DROPDOWN}    id=teacherId_add

${STUDENT_PREFIX_DROPDOWN}    id=prefix_add 
${STUDENT_NAME_FIELD}    id=first_name_add
${STUDENT_LAST_NAME_FIELD}    id=last_name_add
${STUDENT_ID_FIELD}    id=user_id_add

${UNWANTED_TEACHER_NAME}    พันแสน สมกล้า

${EXCEL_UPLOAD_INPUT}    xpath=//*[@id="upload-excel-button"]
${STUDENT_EXCEL_FILE}    ${EXECDIR}/resources/Student_Excel_File/student4_2.xlsx
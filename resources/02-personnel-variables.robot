
*** Variables ***
${PREFIX_DROPDOWN}    id:prefix_add
${FIRST_NAME_FIELD}    id:first_name_add
${LAST_NAME_FIELD}     id:last_name_add
${USER_ID_FIELD}       id:user_id_add
${PHONE_NUMBER_FIELD}  id:phone_add

${PREFIX_DROPDOWN_EDIT}    id:prefix_edit
${FIRST_NAME_FIELD_EDIT}    id:first_name_edit
${LAST_NAME_FIELD_EDIT}     id:last_name_edit
${PHONE_NUMBER_FIELD_EDIT}  id:phone_edit
${STATUS_DROPDOWN}          id:status_edit

${selected_prefix} =    Get Selected List Label    ${PREFIX_DROPDOWN}
${selected_status} =    Get Selected List Label    ${STATUS_DROPDOWN}

${PREFIX_ERROR_MSG}    id="prefix-error" 
${FIRST_NAME_ERROR_MSG}    id="first_name-error" 
${LAST_NAME_ERROR_MSG}     //*[@id="last_name-error"]
${USER_ID_ERROR_MSG}    id="error_userid"
${PHONE_NUMBER_ERROR_MSG}  id="error_phone"

${ADD_PERSONNEL_SUBMIT_BUTTON}    xpath=//button[@id="add-personnel-submit-button"]
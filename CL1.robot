*** Settings ***
Library    SeleniumLibrary
Library    RPA.HTTP
Library    RPA.Excel.Files


*** Test Cases ***
Certification level 1
    Login to application
    Download file
    Fetch excel records


*** Keywords ***
Login to application
    Open Browser    https://robotsparebinindustries.com/    chrome 
    Input Text    username    maria
    Input Text    password    thoushallnotpass
    Click Button    xpath://button[contains(text(),'Log in')]
    Wait Until Element Is Visible    xpath://span[contains(text(),'maria')]
    # Click Button    xpath://button[contains(text(),'Log out')]
    # Close Browser

Download file
    Download    https://robotsparebinindustries.com/SalesData.xlsx    target_file=${OUTPUT DIR}${/}excel.xlsx    overwrite=TRUE

Fill form
    [Arguments]    ${salesrecord}
    Input Text    firstname    ${salesrecord}[First Name]
    Input Text    lastname    ${salesrecord}[Last Name]
    Select From List By Value    salestarget    ${salesrecord}[Sales Target]
    Input Text    salesresult    ${salesrecord}[Sales]    
    Click Button    xpath://button[contains(text(),'Submit')]

Fetch excel records

    Open Workbook    D:/Self/VScode/robocorp/my-rsb-robot/excel.xlsx
    ${excel_data}=    Read Worksheet As Table    header=true    # Read the Excel file as a table
    FOR    ${row}    IN    @{excel_data}    # Loop through each row
        Fill form    ${row}    # Print the values of the row
    END

    Close Browser
    








*** Settings ***
Library    SeleniumLibrary
Library    RPA.HTTP
Library    RPA.Excel.Files
Library    RPA.PDF



*** Test Cases ***
Certification level 1
    [Setup]    Login to application
    Download file
    Fetch excel records
    Take screenshot
    Export to pdf
    [Teardown]    Close application


*** Keywords ***
Login to application
    Open Browser    https://robotsparebinindustries.com/    chrome 
    Input Text    username    maria
    Input Text    password    thoushallnotpass
    Click Button    xpath://button[contains(text(),'Log in')]
    Wait Until Element Is Visible    xpath://span[contains(text(),'maria')]
 
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
    ${excel_data}=    Read Worksheet As Table    header=true   
    FOR    ${row}    IN    @{excel_data}   
        Fill form    ${row}    
    END
    

Take screenshot
    Capture Element Screenshot    xpath://div[@class='alert alert-dark sales-summary']
    

Export to pdf
    ${HTMLelement}    Get Element Attribute    id:sales-results    outerHTML
    Html To Pdf     ${HTMLelement}    ${OUTPUT DIR}${/}sales.pdf
    

Close application
    Close Browser

    
    








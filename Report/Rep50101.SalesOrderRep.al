report 50101 SalesOrderRep
{
    ApplicationArea = All;
    Caption = 'SalesOrderRep';
    UsageCategory = Administration;
    DefaultRenderingLayout = SAlesLayout;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            column(No; "No.")
            {
            }
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Line No.");
                column(Document_No_; "Document No.") { }
                column(No_; "No.") { }
                column(Unit_Price; "Unit Price") { }
                column(Description; Description)
                {

                }
                column(Line_No_; "Line No.") { }

            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    rendering
    {
        layout(SAlesLayout)
        {
            LayoutFile = 'Layouts\Salesorder.rdl';
            Type = RDLC;
        }
    }
}

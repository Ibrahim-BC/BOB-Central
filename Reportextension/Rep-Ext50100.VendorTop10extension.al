reportextension 50100 "VendorTop10-extension" extends "Vendor - Top 10 List"
{
    RDLCLayout = 'layouts\Vendor-Top10.rdl';
    dataset
    {
        add(Vendor)
        {
            column(VATBusPostingGroup; "VAT Bus. Posting Group")
            {
            }
            column(VATRegistrationNo; "VAT Registration No.")
            {
            }
            column(myint; myint1)
            {

            }
        }
        modify(vendor)
        {
            trigger OnAfterAfterGetRecord()
            begin

            end;
        }
    }
    trigger OnPreReport()
    var
    begin
        //  MyProcedure();

    end;

    local procedure MyProcedure()
    var
        myInt: Integer;
    begin
        myInt1 := 1;
    end;

    var
        myint1: Integer;
}

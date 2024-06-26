reportextension 50100 "VendorTop10-extension" extends "Vendor - Top 10 List"
{
    dataset
    {
        add(Integer)
        {
            column(VendPurchIncLCY; Vendor."Purchase Inc. (LCY)") { }
            column(TotalVenPurchasesInc; TotalVenPurchasesInc) { }
        }
        modify(Integer)
        {

            trigger OnAfterAfterGetRecord()
            begin
                Vendor.CalcFields("Purchase Inc. (LCY)");

            end;


        }
        modify(Vendor)
        {
            trigger OnAfterAfterGetRecord()
            begin
                CalcFields("Purchase Inc. (LCY)");
                TotalVenPurchasesInc += "Purchase Inc. (LCY)";
            end;
        }

    }
    var
        TotalVenPurchasesInc: Decimal;
}

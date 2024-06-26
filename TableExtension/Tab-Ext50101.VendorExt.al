tableextension 50101 VendorExt extends Vendor
{
    fields
    {
        field(50101; "Purchase Inc. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Editable = false;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                   "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter"),
                                                                                   "Document Type" = filter("Invoice" | "Credit Memo")));
            Caption = 'Purchase Inc. (LCY)';
            FieldClass = FlowField;
        }
    }
}

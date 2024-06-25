tableextension 50100 VendorLedgerEntry extends "Vendor Ledger Entry"
{
    fields
    {
        field(50100; "Purchase Incl. LCY"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Ledger Entry Amount" = const(true),
                                                                                   "Vendor Ledger Entry No." = field("Entry No."),
                                                                                   "Posting Date" = field("Date Filter"),
                                                                                  "Document Type" = filter(Invoice .. "Credit Memo")));

            Caption = 'Purchase Inc. LCY';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

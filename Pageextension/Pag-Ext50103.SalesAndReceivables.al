pageextension 50103 "SalesAndReceivables " extends "Sales & Receivables Setup"
{

    layout
    {
        modify("Customer Nos.")
        {
            Editable = false;
        }
        addbefore("Order Nos.")
        {
            field("Document No Series"; Rec."Document No Series")
            {
                Caption = 'Document NO.';
                ApplicationArea = all;
            }
        }

    }

}

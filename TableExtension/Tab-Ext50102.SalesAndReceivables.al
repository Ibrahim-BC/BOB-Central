tableextension 50102 SalesAndReceivables extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "Document No Series"; Code[20])
        {
            Caption = 'Document No Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

    }
}

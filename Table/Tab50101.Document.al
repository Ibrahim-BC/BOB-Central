table 50101 Document
{
    Caption = 'Document';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; NO; Code[20])
        {
            Caption = 'NO';
        }
        field(2; description; Text[100])
        {
            Caption = 'description';
        }
        field(3; "issued to"; Code[20])
        {
            Caption = 'issued to';
        }
        field(4; "issued to name"; Text[100])
        {
            Caption = 'issued to name';
        }
    }
    keys
    {
        key(PK; NO)
        {
            Clustered = true;
        }
    }
}

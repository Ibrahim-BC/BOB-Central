table 50102 DocumentLine
{
    Caption = 'DocumentLine';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No';
        }
        field(2; "Document No"; Code[20])
        {
            Caption = 'Document No';
            TableRelation = Document.NO;
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(4; "product type"; Enum "Document Product type")
        {
            Caption = 'product type';
        }
        field(5; "Product No"; Code[30])
        {
            Caption = 'Product No';
            TableRelation =
            if ("product type" = const(Item)) Item where(Blocked = const(false))
            else
            if ("product type" = const(Purchase)) "Purchase Header"."No."
            else
            if ("Product type" = const(Sales)) "Sales Header"."No.";
            // "System-Created Entry" = const(false)) "G/L Account" where("Direct Posting" = const(true), "Account Type" = const(Posting), Blocked = const(false))
            // else
            // if (Type = const("G/L Account"), "System-Created Entry" = const(true)) "G/L Account"
            // else
            // if (Type = const("Fixed Asset")) "Fixed Asset"
            // else
            // if (Type = const("Charge (Item)")) "Item Charge"
            // else
            // if (Type = const(Item), "Document Type" = filter(<> "Credit Memo" & <> "Return Order")) Item where(Blocked = const(false), "Purchasing Blocked" = const(false))
            // else
            // if (Type = const(Item), "Document Type" = filter("Credit Memo" | "Return Order")) Item where(Blocked = const(false))
            // else
            // if (Type = const("Allocation Account")) "Allocation Account"
            // else
            // if (Type = const(Resource)) Resource;

        }
    }
    keys
    {
        key(PK; "Line No", "Document No")
        {
            Clustered = true;
        }
    }
}

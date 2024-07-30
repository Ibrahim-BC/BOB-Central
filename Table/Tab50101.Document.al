table 50101 Document
{
    Caption = 'Document';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; NO; Code[20])
        {
            Caption = 'NO';
            trigger OnValidate()
            var

                docmentTable: record Document;
            begin
                if NO <> xRec.NO then
                    if not docmentTable.Get(NO) then begin
                        salesSetup.Get();
                        noseries.TestManual(salesSetup."Document No Series");
                        "No. Series" := '';
                    end;
            end;
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
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; NO)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
    begin
        /*if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Book Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Book Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;*/

        // if No = '' then begin
        //     SalesSetup.Get();
        //     SalesSetup.TestField("Document No Series");
        //     "No. Series" := SalesSetup."Document No Series";
        //     if NoSeries.AreRelated(SalesSetup."Document No Series", xRec."No. Series") then
        //         "No. Series" := xRec."No. Series";
        //     No := NoSeries.GetNextNo("No. Series");
        // end;
    end;

    var
        noseries: Codeunit "No. Series";
        salesSetup: Record "Sales & Receivables Setup";
}

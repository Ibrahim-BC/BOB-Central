page 50103 DocumentCard
{
    ApplicationArea = All;
    Caption = 'DocumentCard';
    PageType = Card;
    SourceTable = "Document";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(NO; Rec.NO)
                {
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    var
                        noseriesmanagement: Codeunit "No. Series";
                        salesrecv: record "Sales & Receivables Setup";
                    begin
                        salesrecv.Get();
                        noseriesmanagement.TestManual(salesrecv."Document No Series");
                        noseriesmanagement.LookupRelatedNoSeries(salesrecv."Document No Series", salesrecv."Document No Series");
                        // rec.NO:=noseriesmanagement.GetLastNoUsed()
                        Rec.NO := noseriesmanagement.GetNextNo(salesrecv."Document No Series");
                        CurrPage.Update();

                    end;
                }
                field(description; Rec.description) { ApplicationArea = all; }
                field("issued to"; Rec."issued to") { ApplicationArea = all; }
                field("issued to name"; Rec."issued to name") { ApplicationArea = all; }
            }
            group(Lines)
            {
                part(DocumentLines; "Document Line subform")
                {
                    ApplicationArea = all;
                    SubPageLink = "Document No" = field(NO);

                }
            }
        }
    }
}

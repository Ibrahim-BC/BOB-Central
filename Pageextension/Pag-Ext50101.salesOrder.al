pageextension 50101 salesOrder extends "Sales Order"
{
    actions
    {
        addfirst(navigation)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                Caption = 'Sales Order rep  ', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;

                trigger OnAction()
                begin
                    Rec.SetFilter("No.", rec."No.");
                    Report.RunModal(50101, true, false, Rec);
                end;
            }
        }
    }
}

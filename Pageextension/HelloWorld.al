
pageextension 50100 CustomerListExt extends "Customer List"
{
    actions
    {
        addafter(Action24)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                Caption = 'Layout selection', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;

                trigger OnAction()
                var
                    reporlayoutselection: Record "Report Layout Selection";
                begin
                    reporlayoutselection.SetTempLayoutSelectedName('layout1');
                    Report.Run(50100, false, false);

                end;
            }
            action(ProgressBar)
            {
                Caption = 'Progress Bar';
                Promoted = true;
                PromotedCategory = process;
                Image = Process;
                trigger OnAction()
                var
                begin

                end;
            }
        }
    }
    trigger OnOpenPage();
    var
    begin

    end;

}
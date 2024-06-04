
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
                ApplicationArea = all;
                Caption = 'Progress Bar';
                Promoted = true;
                PromotedCategory = process;
                PromotedIsBig = true;
                Image = Process;
                trigger OnAction()
                var
                    random: Codeunit RandomAhh;
                    i: Integer;
                begin
                    random.OpenWindow('working #1#######################', false);
                    for i := 1 to 1200 do begin
                        random.UpdateWindow(i, 1200);
                        Sleep(20);
                    end;
                end;
            }
        }
    }
    trigger OnOpenPage();
    var
    begin

    end;

}
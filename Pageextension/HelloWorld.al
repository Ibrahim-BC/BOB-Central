
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
                    totalrec: Integer;
                begin
                    totalrec := 1000;
                    random.OpenWindow('#1##################################', false);
                    for i := 1 to totalrec do begin
                        random.UpdateWindow(i, totalrec);
                        Sleep(5);
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
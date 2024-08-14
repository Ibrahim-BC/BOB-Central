pageextension 50102 ITEM extends "Item List"
{
    actions
    {
        addafter(CopyItem)
        {
            action(SP)
            {
                Caption = 'close SP Date';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                var
                    RandomAhh: Codeunit RandomAhh;
                    NearestDate: Date;
                begin
                    NearestDate := RandomAhh.ClosestDate2(Rec);

                    Message('called Date %1', Format(NearestDate));
                end;
            }
            action(exportxmml)
            {
                Caption = 'export';
                ApplicationArea = all;
                trigger OnAction()
                var
                begin
                    Xmlport.Run(50100, true, false);
                end;
            }
            action(importxmml)
            {
                Caption = 'import';
                ApplicationArea = all;
                trigger OnAction()
                var
                begin
                    Xmlport.Run(50100, true, true);
                end;
            }
        }

    }
}

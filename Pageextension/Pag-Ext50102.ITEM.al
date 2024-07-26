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
        }
    }
}

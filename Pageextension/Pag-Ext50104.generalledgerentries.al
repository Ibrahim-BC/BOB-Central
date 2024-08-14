pageextension 50104 "general ledger entries" extends "General Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field(Comment; Rec.Comment)
            {
                ApplicationArea = all;

            }
        }
    }
    actions
    {
        addafter("&Navigate")
        {
            action(ExportXML)
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                begin
                    Xmlport.Run(50102, false, false);
                end;
            }
            action(IMportXML)
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                begin
                    Xmlport.Run(50102, false, true);
                end;
            }
            action(modify)
            {
                ApplicationArea = all;
                Image = Edit;
                trigger OnAction()
                var
                begin
                    rec.Comment := 'tryyyy';
                    rec.Modify();
                end;
            }
        }
    }
}

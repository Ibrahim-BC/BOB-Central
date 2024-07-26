page 50102 Docment
{
    ApplicationArea = All;
    Caption = 'Docment';
    PageType = List;
    SourceTable = Document;
    CardPageId = DocumentCard;
    Editable = false;

    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(NO; Rec.NO)
                {
                    ToolTip = 'Specifies the value of the NO field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
                field(description; Rec.description)
                {
                    ToolTip = 'Specifies the value of the description field.', Comment = '%';
                }
                field("issued to"; Rec."issued to")
                {
                    ToolTip = 'Specifies the value of the issued to field.', Comment = '%';
                }
                field("issued to name"; Rec."issued to name")
                {
                    ToolTip = 'Specifies the value of the issued to name field.', Comment = '%';
                }
            }
        }
    }
}

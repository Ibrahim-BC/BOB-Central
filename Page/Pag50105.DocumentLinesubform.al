page 50105 "Document Line subform"
{
    ApplicationArea = All;
    //AutoSplitKey = true;
    // MultipleNewLines = true;
    Caption = 'Document Line subform';
    PageType = ListPart;
    SourceTable = DocumentLine;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No"; Rec."Line No")
                {
                    ToolTip = 'Specifies the value of the Line No field.', Comment = '%';
                }

                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Line No field.', Comment = '%';
                }

                field("product type"; Rec."product type")
                {
                    ToolTip = 'Specifies the value of the product type field.', Comment = '%';
                }
                field("Product No"; Rec."Product No")
                {
                    ToolTip = 'Specifies the value of the Product No field.', Comment = '%';
                }
            }
        }
    }
}

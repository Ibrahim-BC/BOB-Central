
report 50100 "rendering rep"
{
    Caption = 'rendering rep';
    ApplicationArea = All;
    UsageCategory = Administration;
    DefaultRenderingLayout = layout1;
    dataset
    {
        dataitem(Item; Item)
        {
            column(No_; "No.")
            {

            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    rendering
    {
        layout(layout1)
        {
            Type = RDLC;
            LayoutFile = 'layouts\layout1.rdlc';
        }
        layout(layout2)
        {
            Type = RDLC;
            LayoutFile = 'layouts\layout2.rdlc';
        }
    }
}

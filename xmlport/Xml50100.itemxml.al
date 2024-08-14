xmlport 50100 itemxml
{
    Caption = 'itemxml';
    Format = VariableText;
    Direction = Both;
    TextEncoding = UTF8;
    UseRequestPage = false;
    TableSeparator = '';//New line
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Itemm; Item)
            {
                AutoUpdate = true;
                AutoReplace = false;
                AutoSave = true;
                fieldelement(Description; Itemm.Description)
                {
                }
                fieldelement(No; Itemm."No.")
                {
                }
                // trigger OnAfterGetRecord()
                // var
                //     item: record item;
                // begin
                //     if Item.Get(Itemm."No.") then
                //         item.Description := Itemm.Description;
                //     item.Modify();

                // end;
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
}

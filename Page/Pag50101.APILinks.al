page 50101 API_Links
{
    ApplicationArea = All;
    Caption = 'API Links';
    PageType = List;
    SourceTable = API_LINKS;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(Reqris)
            {
                Caption = 'Reqres API';


                field(login; Rec.login)
                {
                    Caption = 'Login';
                    ToolTip = 'Specifies the value of the Link field.', Comment = '%';
                }
                field(Users; Rec.Users)
                {
                    Caption = 'Users';
                    ToolTip = 'Specifies the value of the ReqresLink field.', Comment = '%';
                }

            }

        }
    }
}

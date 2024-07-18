page 50100 API_Tutorial
{
    ApplicationArea = All;
    Caption = 'API_Tutorial';
    PageType = List;
    UsageCategory = Administration;

    layout
    {
        // area(Content)
        // {
        //     repeater(General)
        //     {
        //     }
        // }
    }
    actions
    {
        area(Processing)
        {
            action(CallToken)
            {
                Caption = 'Get Token';
                Image = SendTo;

                trigger OnAction()
                var
                    API: Codeunit API;
                begin
                    Message(API.ReadAPI_Token());
                end;
            }
            action(CallUsers)
            {
                Caption = 'Get Users';
                Image = SendTo;

                trigger OnAction()
                var
                    API: Codeunit API;
                begin
                    API.ReadUsers();
                end;
            }
        }
        area(Navigation)
        {
            action(links)
            {
                Caption = 'API Links';
                Image = Links;
                trigger OnAction()
                var
                begin
                    Page.RunModal(50101);
                end;
            }
        }
    }
}

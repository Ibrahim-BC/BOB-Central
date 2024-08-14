xmlport 50102 "General ledger entries"
{
    Caption = 'General ledger entries';
    Format = VariableText;
    TextEncoding = UTF8;
    TableSeparator = '';
    Direction = both;
    Permissions = tabledata "G/L Entry" = M;
    schema
    {
        textelement(RootNodeName)
        {

            tableelement(GLEntry; "G/L Entry")
            {

                AutoSave = false;
                AutoUpdate = false;
                AutoReplace = false;

                fieldelement(JournalTemplName; GLEntry."Journal Templ. Name")
                {
                }
                fieldelement(JournalBatchName; GLEntry."Journal Batch Name")
                {
                }
                fieldelement(documentDate; GLEntry."Document Date")
                { }
                fieldelement(SourceType; GLEntry."Source Type")
                {
                }
                fieldelement(SourceNo; GLEntry."Source No.")
                {
                }
                fieldelement(Description; GLEntry.Description)
                {
                }
                fieldelement(Amount; GLEntry.Amount)
                {
                }
                fieldelement(Comment; GLEntry.Comment)
                {
                    trigger OnAfterAssignField()
                    begin
                        commento := GLEntry.Comment;

                    end;
                }


                trigger OnAfterInsertRecord()
                begin
                    glEntry2.Reset();
                    glEntry2.SetRange("Journal Templ. Name", GLEntry."Journal Templ. Name");
                    glEntry2.SetRange("Journal Batch Name", GLEntry."Journal Batch Name");
                    glEntry2.SetRange("Document Date", GLEntry."Document Date");
                    glEntry2.SetRange("Source Type", GLEntry."Source Type");
                    glEntry2.SetRange("Source No.", GLEntry."Source No.");
                    glEntry2.SetRange(Description, GLEntry.Description);
                    glEntry2.SetRange(Amount, GLEntry.Amount);
                    if glEntry2.FindFirst() then
                        repeat
                            glEntry2.Comment := commento;
                            glEntry2.Modify();
                        until glEntry2.Next() = 0;

                end;

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
    var
        commento: Text;
        glEntry2: Record 17;
}

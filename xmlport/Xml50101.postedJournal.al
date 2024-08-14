xmlport 50101 postedJournal
{
    Caption = 'postedJournal';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(PostedGenJournalLine; "Posted Gen. Journal Line")
            {
                fieldelement(AccountNo; PostedGenJournalLine."Account No.")
                {
                }
                fieldelement(AccountType; PostedGenJournalLine."Account Type")
                {
                }
                fieldelement(Comment; PostedGenJournalLine.Comment)
                {
                }
                fieldelement(Description; PostedGenJournalLine.Description)
                {
                }
                fieldelement(LineNo; PostedGenJournalLine."Line No.")
                {
                }
                fieldelement(JournalBatchName; PostedGenJournalLine."Journal Batch Name")
                {
                }
                fieldelement(JournalTemplateName; PostedGenJournalLine."Journal Template Name")
                {
                }
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

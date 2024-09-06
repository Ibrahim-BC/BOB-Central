// report 50118 PrintLabel
// {
//     Caption = 'PrintLabel';
//     RDLCLayout = './src/ReportLayout/generate.rdl';
//     dataset
//     {
//         dataitem("Label Printing"; "Label Printing")
//         {
//             RequestFilterFields = Printed;
//             dataitem(CopyLoop; "Integer")
//             {
//                 DataItemTableView = SORTING(Number);


//                 column(QR; "Label Printing".QR) { }
//                 column(Description; "Label Printing".Description) { }
//                 column(Barcode; "Label Printing".Barcode) { }
//                 column(LotNo; "Label Printing"."Lot No.") { }
//                 column(ExpiryG; "Label Printing"."Expiry Date") { }
//                 column(SerialNo; "Label Printing"."Serial No.") { }

//                 column(Outputno; OutputNo) { }
//                 column(CopyText; CopyText) { }
//                 column(BarcodeText; BarcodeText) { }
//                 column(Price; Price) { }
//                 column(LCYSYMBOL; LCYSYMBOL) { }
//                 trigger OnAfterGetRecord();
//                 var
//                     HadeelUtil: Codeunit HadeelUtil;
//                     POSTransLine: Record "LSC POS Trans. Line";
//                     POSTerminal: Record "LSC POS Terminal";
//                     POSTransaction: Record "LSC POS Transaction";
//                     GeneralLedgerSetup: Record "General Ledger Setup";
//                     Item: Record Item;
//                 begin
//                     Price := 0;

//                     if Number > 1 then begin

//                         CopyText := FormatDocument.GetCOPYText;
//                         //OutputNo += 1;
//                     end;
//                     GeneralLedgerSetup.FindFirst();
//                     LCYSYMBOL := GeneralLedgerSetup."Local Currency Symbol";
//                     POSTerminal.FindFirst();
//                     if Item.get("Label Printing"."Item No.") then begin
//                         HadeelUtil.GetPrice(POSTerminal."Store No.", "Label Printing"."Item No.", '', "Label Printing"."Unit of Measure", POSTerminal."No.", POSTransLine);
//                         Price := POSTransLine.Amount;
//                         if POSTransaction.get(POSTransLine."Receipt No.") then
//                             POSTransaction.Delete(True);
//                     end;


//                     "Label Printing".Printed := true;
//                     "Label Printing".Modify();
//                 end;

//                 trigger OnPreDataItem();
//                 begin

//                     if NoOfCopies = 0 then
//                         NoOfCopies := 1;

//                     if "Label Printing"."No. Of Copies" > 0 then
//                         NoOfLoops := ABS("Label Printing"."No. Of Copies")
//                     else
//                         NoOfLoops := ABS(NoOfCopies);

//                     CopyText := '';
//                     SETRANGE(Number, 1, NoOfLoops);

//                 end;


//             }

//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {
//                     field("No. Of Copies"; NoOfCopies)
//                     {
//                         ApplicationArea = Advanced;
//                     }
//                 }
//             }
//         }
//     }
//     trigger OnPostReport()
//     var
//     begin
//         LabelRec.Get(entry);
//         LabelRec.Printed := true;
//         LabelRec.Modify();
//     end;

//     var
//         LabelRec: Record "Label Printing";
//         TempBlob: Codeunit "Temp Blob";
//         SwissQRCodeHelper: Codeunit "Swiss QR Code Helper";
//         InStr: InStream;
//         outStreamRep: OutStream;
//         encodetext: Text[300];
//         NoOfCopies: Integer;
//         NoOfLoops: Integer;
//         CopyText: Text[30];
//         OutputNo: Integer;
//         FormatDocument: Codeunit "Format Document";
//         BarcodeText: text;

//         AllowItemLoop: Boolean;
//         RecCount: Integer;
//         entry: Integer;
//         Price: Decimal;
//         LCYSYMBOL: Text;
// }



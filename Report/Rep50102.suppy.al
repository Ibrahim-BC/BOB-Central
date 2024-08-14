report 50102 suppy
{
    // ApplicationArea = All;
    // ProcessingOnly = true;
    // UsageCategory = Administration;
    // dataset
    // {
    //     dataitem(Item; Item)
    //     {
    //         dataitem("Item Unit of Measure"; "Item Unit of Measure")
    //         {
    //             DataItemLink = "Item No." = field("No.");
    //             trigger OnAfterGetRecord()
    //             var
    //                 SuppyIntegration: Codeunit "Suppy Integration";
    //                 itemJson: JsonObject;

    //             begin
    //                 // Message(Code);
    //                 itemJson := SuppyIntegration.GenerateJson(Item."No.", "Item Unit of Measure".Code, "Qty. per Unit of Measure", "Item Unit of Measure"."Suppy Discount %");
    //                 itemsArray.Add(itemJson);
    //             end;
    //         }
    //         trigger OnPreDataItem()
    //         begin
    //             SetRange(Blocked, false);

    //             if GuiAllowed then
    //                 Progress.Open('Processing...@1@@@@@@@@@@@ Item: #2####### Total items: #3#######', ProgressValue, NoOfItem, TotalItems);
    //         end;

    //         trigger OnAfterGetRecord()
    //         var
    //             Barcodes: Record "LSC Barcodes";
    //             BarcodesArray: JsonArray;
    //             BarcodeJson: JsonObject;
    //             barcodeToken: JsonToken;
    //             barcodeValue: JsonValue;
    //             PackSizevalue: JsonValue;
    //             ExpiryValue: JsonValue;
    //             itemJson: JsonObject;
    //             Quantity: Decimal;

    //             OldFilterGr: Integer;
    //             QtySoldNotPst: Decimal;
    //             BOUtils: Codeunit "LSC BO Utils";
    //             VATSetup: Record "VAT Posting Setup";
    //             VAT: Decimal;
    //             TransSales: Record "LSC Trans. Sales Entry";
    //             LastSoldDate: Text;
    //             modifDate: Text;
    //             priceutililty: Codeunit HadeelUtil;
    //             i: Integer;
    //             j: Integer;
    //             arrtxt: Text;

    //             POSTransLine: Record "LSC POS Trans. Line";
    //             PosTransaction: record "LSC POS Transaction";
    //             SuppyIntegration: Codeunit "Suppy Integration";
    //         begin
    //             NoOfItem += 1;
    //             if GuiAllowed then begin
    //                 ProgressValue := Round((NoOfItem / TotalItems) * 10000, 1);
    //                 Progress.Update(1, ProgressValue);
    //                 Progress.Update(2, NoOfItem);
    //             end;

    //             // itemJson := SuppyIntegration.GenerateJson(Item."No.");
    //             //itemsArray.Add(itemJson);


    //         end;

    //     }
    // }
    // trigger OnPreReport()
    // begin
    //     TotalItems := Item.count;
    //     if GuiAllowed then begin
    //         if not Confirm('Do you want to Integrate %1 items to Suppy', true, TotalItems) then
    //             Error('Report stopped');
    //     end;
    // end;

    // trigger OnPostReport()
    // var
    //     ItemsArrtxt: text;
    //     SuppyIntegration: Codeunit "Suppy Integration";
    //     tempblob: Codeunit "Temp Blob";
    //     outstream: OutStream;
    //     instr: InStream;
    //     filename: Text;
    //     arrtest: Text;
    // begin
    //     if GuiAllowed then
    //         Progress.Close();
    //     filename := 'DataToSUPPYJSON.txt';
    //     // Message(StrSubstNo('Integration Successfull\Total items: %1', TotalItems));
    //     itemsArray.WriteTo(ItemsArrtxt);

    //     //arrtest := '[{"Barcodes":["5283001104068"],"Code":"000038","Name":"ABIDO FAHITA SP 50g","UnitSize":"50GR","IsPack":false,"PackSize":1.0,"Quantity":100.0,"MaxOrder":0.0,"Price":0.89,"CurrencyCode":"USD","VATPercent":11.0,"IsActiveOnApp":false,"ModifDate":"2024-05-13","LastSoldDate":"2024-04-17","IsPromoted":false,"DiscPerc":0.0,"OldPrice":0.0,"PromoPrice":0.0,"ExpiryDate":null,"DRSDepositValue":0.0}]';
    //     // tempblob.CreateOutStream(outstream);

    //     // outstream.WriteText(ItemsArrtxt);
    //     // TempBlob.CreateInStream(instr);
    //     // DownloadFromStream(instr, '', '', '', filename);
    //     //Message(ItemsArrtxt);
    //     SuppyIntegration.Item_Integration(ItemsArrtxt);

    //     // SuppyIntegration.PreActionItemNoIntegration();
    //     // SuppyIntegration.PreActionIntegration();

    // end;

    // var
    //     Progress: Dialog;
    //     ProgressValue: Integer;
    //     NoOfItem: Integer;
    //     TotalItems: Integer;
    //     sentItems: Integer;
    //     failedItems: Integer;
    //     Amount: Decimal;
    //     discountPer: decimal;
    //     Price: Decimal;
    //     itemNo: Code[20];
    //     UOM: Code[10];

    //     itemsArray: JsonArray;
}

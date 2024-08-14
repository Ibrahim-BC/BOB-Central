codeunit 50103 suppy
{
    //      trigger OnRun()
    //     begin
    //         PreActionItemNoIntegration();
    //         //jobQueryTEST();
    //         //InsertSuppyOrder2('hi');
    //     end;

    //     procedure Item_Integration(ItemArray: Text)
    //     var
    //         URL: Text;
    //         Client: HttpClient;
    //         ResponseMessage: HttpResponseMessage;
    //         JObject: JsonObject;
    //         JsonText: Text;
    //         Content: HttpContent;
    //         RequestMessage: HttpRequestMessage;
    //         ContentHeaders: HttpHeaders;
    //         RequestHeaders: HttpHeaders;
    //         ErorString: Text;
    //         SalesRecevables: Record "Sales & Receivables Setup";
    //         HASH: Codeunit "Cryptography Management";
    //         HashAlgo: Option SHA256;

    //     begin
    //         SalesRecevables.Get();

    //         URL := SalesRecevables."API URL";

    //         RequestMessage.SetRequestUri(URL);
    //         RequestMessage.Method('POST');
    //         RequestMessage.GetHeaders(RequestHeaders);
    //         RequestHeaders.Add('X-OSP-API-Key', SalesRecevables."X OSP API Key");
    //         RequestHeaders.Add('X-OSP-Signature', SalesRecevables."X OSP Secret Key");
    //         RequestHeaders.Add('X-OSP-Branch', SalesRecevables."X OSP Branch");
    //         Content.WriteFrom(ItemArray);
    //         Content.GetHeaders(ContentHeaders);

    //         if ContentHeaders.Contains('Content-Type') then
    //             ContentHeaders.Remove('Content-Type');

    //         ContentHeaders.Add('Content-Type', 'application/json');
    //         //ContentHeaders.Add('X-OSP-API-Key', SalesRecevables."X OSP API Key");
    //         // ContentHeaders.Add('X-OSP-Signature', SalesRecevables."X OSP Secret Key");
    //         // ContentHeaders.Add('X-OSP-Branch', SalesRecevables."X OSP Branch");
    //         Content.GetHeaders(ContentHeaders);
    //         RequestMessage.Content(Content);


    //         if not Client.Send(RequestMessage, ResponseMessage) then
    //             Error('The call to the web service failed.');

    //         if not ResponseMessage.IsSuccessStatusCode() then
    //             Error('The web service returned an error message:\\'
    //             +
    //             'Status code: '
    //             + Format(ResponseMessage.HttpStatusCode())
    //             +
    //             '\Description: '
    //             + ResponseMessage.ReasonPhrase());

    //         // ResponseMessage.Content.ReadAs(ErorString);
    //         // If ResponseMessage.HttpStatusCode = 200 then
    //         //     Message('Integration successful')
    //         // else
    //         //     Message('Integration Unsuccessful');
    //     end;

    //     procedure Encrypt_test()
    //     var
    //         CryptographyMNGt: Codeunit "Cryptography Management";
    //         HashAlgo: Option SHA256;
    //         SalesRecevables: Record "Sales & Receivables Setup";
    //         hash: Text;
    //         txt: Text;
    //     begin
    //         SalesRecevables.Get();
    //         txt := '[{"Barcodes": ["5285001500178"],"Code": "bob","Name": "Doritos Tortillas chips de maïs goût nature Le paquet de 170g","UnitSize": "170g"}]';

    //         // hash := CryptographyMNGt.GenerateBase64KeyedHash(txt, SalesRecevables."X OSP Secret Key", HashAlgo::SHA256);
    //         //hash := CryptographyMNGt.GenerateBase64KeyedHashAsBase64String(txt, SalesRecevables."X OSP Secret Key", HashAlgo::SHA256);
    //         Message(HASH);
    //     end;

    //     procedure GenerateJson(itemNo: Code[20]; IUOM: Code[20]; PacksizeQTY: Decimal; "Suppy Discount %": Decimal): JsonObject
    //     var
    //         Item: Record Item;
    //         Barcodes: Record "LSC Barcodes";
    //         BarcodesArray: JsonArray;
    //         BarcodeJson: JsonObject;
    //         barcodeToken: JsonToken;
    //         barcodeValue: JsonValue;
    //         PackSizevalue: JsonValue;
    //         ExpiryValue: JsonValue;
    //         LastSoldJValue: JsonValue;
    //         itemJson: JsonObject;
    //         Quantity: Decimal;
    //         Amount: Decimal;
    //         discountPer: decimal;
    //         Price: Decimal;
    //         Amount2: Decimal;
    //         discountPer2: decimal;
    //         Price2: Decimal;

    //         OldFilterGr: Integer;
    //         QtySoldNotPst: Decimal;
    //         BOUtils: Codeunit "LSC BO Utils";
    //         VATSetup: Record "VAT Posting Setup";
    //         VAT: Decimal;
    //         TransSales: Record "LSC Trans. Sales Entry";
    //         LastSoldDate: Text;
    //         modifDate: Text;
    //         priceutililty: Codeunit HadeelUtil;
    //         i: Integer;
    //         j: Integer;
    //         arrtxt: Text;

    //         POSTransLine: Record "LSC POS Trans. Line";
    //         PosTransaction: record "LSC POS Transaction";
    //         isPack: Boolean;
    //         salesRecv: Record "Sales & Receivables Setup";
    //         GeneralSetup: Record "General Ledger Setup";
    //         CurrencyCode: Code[10];

    //         sd: page "LSC Sales Hist. by Period";
    //     begin
    //         salesRecv.Get();
    //         GeneralSetup.Get();
    //         If Item.Get(itemNo) then begin
    //             clear(BarcodesArray);
    //             isPack := true;
    //             if IUOM = item."Base Unit of Measure" then
    //                 isPack := false;

    //             Barcodes.Reset();
    //             Barcodes.SetRange("Item No.", Item."No.");
    //             Barcodes.SetRange("Unit of Measure Code", IUOM);
    //             IF Barcodes.FindFirst() then
    //                 repeat
    //                     BarcodesArray.Add(Barcodes."Barcode No.");
    //                 until Barcodes.Next() = 0;

    //             if salesRecv."Default Quantity" > 0 then
    //                 Quantity := salesRecv."Default Quantity"
    //             else begin
    //                 // OldFilterGr := Item.FilterGroup;
    //                 item.SetFilter("Location Filter", salesRecv."Location Filter");
    //                 item.SetFilter("LSC Store Filter", salesRecv."Store Filter");
    //                 // Item.FilterGroup(4);
    //                 QtySoldNotPst := BOUtils.ReturnQtySoldNotPosted(Item."No.",
    //                 Item.GetFilter("LSC Store Filter"),
    //                 Item.GetFilter("Location Filter"),
    //                 Item.GetFilter("Variant Filter"),
    //                 Item.GetFilter("Date Filter"));
    //                 //Item.FilterGroup(OldFilterGr);
    //                 item.CalcFields(Inventory);
    //                 Quantity := Item.Inventory - QtySoldNotPst;
    //             end;
    //             if item.IsNonInventoriableType() then
    //                 Quantity := 0;


    //             VAT := 0;
    //             if VATSetup.Get('LOCAL', Item."VAT Prod. Posting Group") then
    //                 VAT := VATSetup."VAT %";

    //             TransSales.Reset();
    //             TransSales.SetRange("Item No.", Item."No.");
    //             TransSales.SetCurrentKey(Date);
    //             TransSales.SetAscending(Date, false);
    //             if TransSales.FindFirst() then
    //                 LastSoldDate := Format(TransSales.Date, 0, '<Year4>-<Month,2>-<Day,2>');

    //             modifDate := Format(Item."Last Date Modified", 0, '<Year4>-<Month,2>-<Day,2>');

    //             priceutililty.GetPrice(salesRecv."Store Filter", Item."No.", '', IUOM, 'P101', POSTransLine);
    //             Amount := POSTransLine.Amount;
    //             discountPer := POSTransLine."Discount %";
    //             Price := POSTransLine.Price;
    //             if "Suppy Discount %" > 0 then begin
    //                 discountPer := "Suppy Discount %";
    //                 Amount := Price - Price * (discountPer / 100);
    //             end;
    //             if PosTransaction.get(POSTransLine."Receipt No.") then
    //                 PosTransaction.Delete(True);

    //             CurrencyCode := Item."Currency Code";
    //             if Item."Currency Code" = '' then
    //                 CurrencyCode := GeneralSetup."LCY Code";

    //             itemJson.Add('Barcodes', BarcodesArray.AsToken());
    //             itemJson.Add('Code', Item."No.");
    //             itemJson.Add('Name', Item.Description);
    //             itemJson.Add('UnitSize', Item."Size-Code");
    //             itemJson.Add('IsPack', isPack);
    //             PackSizevalue.SetValueToNull();
    //             itemJson.Add('PackSize', PacksizeQTY);

    //             itemJson.Add('Quantity', Quantity);
    //             itemJson.Add('MaxOrder', item."Suppy Max Quantity");
    //             itemJson.Add('Price', Amount);
    //             itemJson.Add('CurrencyCode', CurrencyCode);
    //             itemJson.Add('VATPercent', VAT);
    //             itemJson.Add('IsActiveOnApp', Item."Enable for Suppy Interface");
    //             itemJson.Add('ModifDate', modifDate);
    //             LastSoldJValue.SetValueToNull();
    //             if LastSoldDate = '' then
    //                 itemJson.Add('LastSoldDate', LastSoldJValue)
    //             else
    //                 itemJson.Add('LastSoldDate', LastSoldDate);
    //             if discountPer = 0 then
    //                 itemJson.Add('IsPromoted', false)
    //             else
    //                 itemJson.Add('IsPromoted', true);

    //             itemJson.Add('DiscPerc', discountPer);
    //             if discountPer > 0 then begin
    //                 itemJson.Add('OldPrice', Price);
    //                 itemJson.Add('PromoPrice', Amount);
    //             end
    //             else begin
    //                 itemJson.Add('OldPrice', 0);
    //                 itemJson.Add('PromoPrice', 0);
    //             end;
    //             ExpiryValue.SetValueToNull();
    //             itemJson.Add('ExpiryDate', ExpiryValue);
    //             itemJson.Add('DRSDepositValue', 0.0);

    //             exit(itemJson);
    //         end;
    //     end;

    //     procedure PreActionIntegration()
    //     var
    //         PreAction: Record "LSC Preaction";
    //         SalesReceivables: Record "Sales & Receivables Setup";
    //         LastPreactionNo: Integer;
    //         tempItem: Record Item temporary;
    //     begin
    //         // SalesReceivables.Get();
    //         // LastPreactionNo := SalesReceivables."last PreAction No";
    //         // PreAction.Reset();
    //         // PreAction.SetFilter("Entry No.", '>%1', LastPreactionNo);
    //         // if PreAction.Findfirst then
    //         //     repeat


    //         //     until PreAction.next() = 0;

    //         tempItem.FindFirst();
    //         Message('%1', tempItem."No.");
    //     end;

    //     procedure PreActionItemNoIntegration()
    //     var
    //         PreAction: Record "LSC Preaction";
    //         SalesReceivables: Record "Sales & Receivables Setup";
    //         LastPreactionNo: Integer;
    //         //  ItemNo: Code[20];
    //         TableNo: Integer;
    //         PreActionKey: text[200];
    //         PriceListline: Record "Price List Line";
    //         itemUOM: Record "Item Unit of Measure";
    //         PeriodicDiscount: Record "LSC Periodic Discount Line";
    //         Barcodes: Record "LSC Barcodes";
    //         Item: Record Item;
    //         itemno: Code[20];
    //         ItemTemp: Record item temporary;
    //         PreActionItemJson: JsonObject;
    //         ItemsArrtxt: text;
    //         itemUnitOfMeasure: Record "Item Unit of Measure";
    //     begin
    //         clear(itemsArray);
    //         SalesReceivables.Get();
    //         LastPreactionNo := SalesReceivables."last PreAction No";
    //         PreAction.Reset();
    //         PreAction.SetFilter("Entry No.", '>%1', LastPreactionNo);
    //         TotalItems := PreAction.Count;
    //         if GuiAllowed then
    //             Progress.Open('Filtering Items...@1@@@@@@@@@@@ Record: #2####### Total Records: #3#######', ProgressValue, NoOfItem, TotalItems);
    //         if PreAction.Findfirst then
    //             repeat
    //                 NoOfItem += 1;
    //                 if GuiAllowed then begin
    //                     ProgressValue := Round((NoOfItem / TotalItems) * 10000, 1);
    //                     Progress.Update(1, ProgressValue);
    //                     Progress.Update(2, NoOfItem);
    //                 end;
    //                 TableNo := PreAction."Table No.";
    //                 PreActionKey := PreAction."Key";
    //                 case TableNo of
    //                     7001:
    //                         begin
    //                             SplitValues(PreAction."Key", FirstElement, SecondElement);
    //                             Evaluate(IntLineNo, SecondElement);
    //                             if PriceListline.Get(FirstElement, IntLineNo) then
    //                                 ItemNo := PriceListline."Product No.";
    //                         end;
    //                     5404:
    //                         begin
    //                             SplitValues(PreAction."Key", FirstElement, SecondElement);
    //                             if itemUOM.Get(FirstElement, SecondElement) then
    //                                 ItemNo := itemUOM."Item No.";
    //                         end;
    //                     99001454:
    //                         begin
    //                             SplitValues(PreAction."Key", FirstElement, SecondElement);
    //                             Evaluate(IntLineNo, SecondElement);
    //                             if PeriodicDiscount.Get(FirstElement, IntLineNo) and (PeriodicDiscount.Type = PeriodicDiscount.Type::Item) then
    //                                 ItemNo := PeriodicDiscount."No.";
    //                         end;
    //                     99001451:
    //                         if Barcodes.Get(PreActionKey) then
    //                             ItemNo := Barcodes."Item No.";
    //                     27:
    //                         if Item.Get(PreActionKey) then
    //                             ItemNo := PreActionKey;
    //                 end;

    //                 if (ItemNo <> '') and (not ItemTemp.Get(ItemNo)) then begin
    //                     ItemTemp.Init();
    //                     ItemTemp."No." := itemno;
    //                     ItemTemp.Insert();
    //                 end;


    //             until PreAction.next() = 0;
    //         if GuiAllowed then
    //             Progress.Close();
    //         TotalItems := ItemTemp.count;
    //         if GuiAllowed then
    //             Progress.Open('Creating JSON...@1@@@@@@@@@@@ Item: #2####### Total Items: #3#######', ProgressValue, NoOfItem, TotalItems);

    //         NoOfItem := 0;
    //         if ItemTemp.FindFirst() then
    //             repeat
    //                 NoOfItem += 1;
    //                 if GuiAllowed then begin
    //                     ProgressValue := Round((NoOfItem / TotalItems) * 10000, 1);
    //                     Progress.Update(1, ProgressValue);
    //                     Progress.Update(2, NoOfItem);
    //                 end;
    //                 itemUnitOfMeasure.Reset();
    //                 itemUnitOfMeasure.SetRange("Item No.", ItemTemp."No.");
    //                 if itemUnitOfMeasure.FindFirst() then
    //                     repeat
    //                         PreActionItemJson := GenerateJson(ItemTemp."No.", itemUnitOfMeasure.Code, itemUnitOfMeasure."Qty. per Unit of Measure", itemUnitOfMeasure."Suppy Discount %");
    //                         itemsArray.Add(PreActionItemJson);
    //                     until itemUnitOfMeasure.Next() = 0;
    //             // PreActionItemJson := GenerateJson(ItemTemp."No.", '');
    //             // itemsArray.Add(PreActionItemJson);

    //             until ItemTemp.Next() = 0;

    //         if GuiAllowed then
    //             Progress.Close();

    //         itemsArray.WriteTo(ItemsArrtxt);
    //         if ItemsArrtxt <> '[]' then
    //             Item_Integration(ItemsArrtxt);



    //         PreAction.Reset();
    //         PreAction.SetAscending("Entry No.", false);
    //         If PreAction.FindFirst() then begin
    //             SalesReceivables."Last Preaction No" := PreAction."Entry No.";
    //             SalesReceivables.Modify();
    //         end;

    //     end;

    //     procedure SplitValues(Values: Text;
    //  var FirstElement: code[20];
    //   var SecondElement: text
    // )
    //     var
    //         UniqueValues: List of [Text];
    //         DelimitedText: Text;
    //         value: Text;
    //     begin
    //         UniqueValues := SplitUniqueValues(';', Values);
    //         FirstElement := Format(UniqueValues.Get(1));
    //         SecondElement := Format(UniqueValues.Get(2));

    //     end;

    //     local procedure SplitUniqueValues(Delimiters: Text; DelimitedText: Text): List of [Text]
    //     var
    //         UniqueValues: List of [Text];
    //         Values: List of [Text];
    //         value: Text;
    //     begin
    //         Values := DelimitedText.Split(Delimiters);
    //         foreach value in Values do
    //             if not UniqueValues.Contains(value) then
    //                 UniqueValues.Add(value);

    //         exit(UniqueValues);
    //     end;

    //     local procedure InsertItemTemp(ItemNo: Code[20]; ItemTemp: Record item temporary)
    //     begin
    //         ItemTemp.Init();
    //         ItemTemp."No." := ItemNo;
    //         ItemTemp.Insert();
    //     end;

    //     procedure SuppyOrderIntegration(OrderID: Text[100]): Text
    //     var
    //         URL: Text;
    //         Client: HttpClient;
    //         ResponseMessage: HttpResponseMessage;
    //         JObject: JsonObject;
    //         JsonText: Text;
    //         Content: HttpContent;
    //         RequestMessage: HttpRequestMessage;
    //         ContentHeaders: HttpHeaders;
    //         RequestHeaders: HttpHeaders;
    //         ResponseString: Text;
    //         SalesRecevables: Record "Sales & Receivables Setup";


    //     begin
    //         SalesRecevables.Get();

    //         URL := SalesRecevables."Order API URL" + OrderID;

    //         RequestMessage.SetRequestUri(URL);
    //         RequestMessage.Method('GET');


    //         RequestMessage.GetHeaders(RequestHeaders);
    //         RequestHeaders.Add('X-OSP-API-Key', SalesRecevables."X OSP API Key");

    //         // Content.GetHeaders(ContentHeaders);

    //         // if ContentHeaders.Contains('Content-Type') then
    //         //     ContentHeaders.Remove('Content-Type');

    //         // ContentHeaders.Add('Content-Type', 'application/json');

    //         //ContentHeaders.Add('X-OSP-API-Key', SalesRecevables."X OSP API Key");

    //         Content.GetHeaders(ContentHeaders);

    //         if not Client.Send(RequestMessage, ResponseMessage) then
    //             Error('The call to the web service failed.');
    //         if not ResponseMessage.IsSuccessStatusCode() then
    //             Error('The web service returned an error message:\\'
    //             +
    //             'Status code: '
    //             + Format(ResponseMessage.HttpStatusCode())
    //             +
    //             '\Description: '
    //             + ResponseMessage.ReasonPhrase());


    //         ResponseMessage.Content.ReadAs(ResponseString);
    //         exit(ResponseString);
    //         //Message(ErorString);

    //         // If ResponseMessage.HttpStatusCode = 200 then
    //         //     Message('Integration successful')
    //         // else
    //         //     Message('Integration Unsuccessful');
    //     end;

    //     procedure InsertSuppyOrder(OrderID: Text)
    //     var
    //         SuppyJson: Text;

    //         SuppyObject: JsonObject;
    //         dataToken: JsonToken;
    //         dataObject: JsonObject;
    //         IdToken: JsonToken;
    //         CreatedAtToken: JsonToken;
    //         totalExludingFeesToken: JsonToken;
    //         feesToTalAmountToken: JsonToken;
    //         CurrencyCodeToken: JsonToken;
    //         feesStructureToken: JsonToken;
    //         feesStructureObject: JsonObject;
    //         ServiceFeesToken: JsonToken;
    //         deliveryFeesToken: JsonToken;
    //         creditCardFeesToken: JsonToken;

    //         totalAmountToken: JsonToken;
    //         discountToken: JsonToken;
    //         ItemsToken: JsonToken;
    //         ItemsArray: JsonArray;
    //         ItemObject: JsonObject;
    //         BarcodesToken: JsonToken;
    //         BarcodesJsonArray: JsonArray;
    //         BarcodesArray: List of [Text[100]];
    //         Barcodes: Text;
    //         barcode: Text;
    //         ItemNo: Text;
    //         items: Record Item;
    //         ProductCodeToken: JsonToken;
    //         QuantityToken: JsonToken;
    //         UnitPriceToken: JsonToken;
    //         discountValueToken: JsonToken;
    //         TotalPriceToken: JsonToken;
    //         LoyaltyInfoToken: JsonToken;
    //         LoyaltyInfoObject: JsonObject;
    //         LoyaltyIdToken: JsonToken;
    //         AmountToRedeemToken: JsonToken;
    //         AmountToRedeemCurrencyCodeToken: JsonToken;
    //         messageObject: JsonObject;
    //         Messagetoken: JsonToken;


    //         ID: Integer;
    //         createdAt: DateTime;
    //         TotalExludingFees: Integer;
    //         FeesTotalAmount: Decimal;
    //         CurrencyCode: Text;
    //         serviceFees: Decimal;
    //         deliveryFees: Decimal;
    //         creditCardFees: Decimal;
    //         totalAmount: Decimal;
    //         discount: Decimal;
    //         productCode: Text;
    //         Quantityjson: Decimal;
    //         UnitPrice: Decimal;
    //         discountValue: Decimal;
    //         TotalPrice: Decimal;
    //         loyaltyId: integer;
    //         amountToRedeem: Decimal;
    //         amountToRedeemCurrencyCode: Text;
    //         ApiMessage: Text;
    //         dataText: text;

    //         BarcodesRec: Record "LSC Barcodes";
    //         POStransactionRec: record "LSC POS Transaction";
    //         POStransLine: Record "LSC POS Trans. Line";
    //         TransInfocodeEntry: Record "LSC Trans. Infocode Entry";
    //         POSSession: Codeunit "LSC POS Session";
    //         POSTrans: Codeunit "LSC POS Transaction";
    //         POSFUNC: Codeunit "LSC POS Functions";
    //         StoreSetup: record "LSC Store";
    //         RetailCalendarManagement: Codeunit "LSC Retail Calendar Management";
    //         RetailCalendar: record "LSC Retail Calendar";
    //         exchangeRate: record "Currency Exchange Rate";


    //         lineNO: Integer;
    //         Rate: Decimal;
    //         AmountLB: Decimal;
    //         transDate: Date;
    //         CheckID: Integer;
    //         SalesRecv: Record "Sales & Receivables Setup";
    //         POSBarcode: Text;
    //         variantcode: code[10];


    //         PosTransaction: Record "LSC POS Transaction";
    //         newLine: Record "LSC POS Trans. Line";
    //         UOM: code[20];
    //         ItemUOM: Record "Item Unit of Measure";
    //         Text103: Label 'UOM %1 is not available for Item %2';
    //         Text101: Label 'Item %1 does not exist';
    //         Text102: Label 'Invalid VAT setup on Item %1';
    //         Text104: Label 'Item %1 is blocked';
    //         posterminal: Record "LSC POS Terminal";
    //         CannotBeBlank: Label '%1 cannot be blank';
    //         ExtVarVal: Record "LSC Extd. Variant Values";
    //         VatSetup: Record "VAT Posting Setup";
    //         BOUtils: Codeunit "LSC BO Utils";
    //         ItemStatusLink: Record "LSC Item Status Link";

    //         SuppyDiscount: Boolean;
    //     begin
    //         SuppyDiscount := false;
    //         SalesRecv.Get();

    //         // SuppyJson := SuppyOrderIntegration(OrderID);

    //         //SuppyJson := '{"data":{"id":138618456,"createdAt":"2024-05-23T09:07:36.1315784+00:00","currencyCode":"USD","currencyId":1,"totalExludingFees":30.52,"feesTotalAmount":0.67,"remainingToBePaidByCustomer":31.19,"feesStructure":{"serviceFees":0,"serviceFeeTaxAmount":0,"deliveryFees":0.67,"creditCardFees":0,"conciergeFees":0,"paymentAdditionalFees":0},"totalAmount":31.19,"discount":0,"items":[{"barcodes":["5289000061852"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"000998","quantity":2,"unitPrice":2,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":2,"drsAmount":0,"isABundle":false,"orderItemId":6566895,"isPartOfABundle":false}],"customerInfo":{"name":"Samer SWAIDAN","phoneNumber":"96178950664","loyaltyInfo":{"useLoyaltyForPayment":false,"loyaltyAccountCode":null,"loyaltyAccountId":null,"amountToRedeem":0,"pointsToRedeem":0,"currencyCode":null}},"paymentInfo":[{"formOfPayment":"CoD","amount":31.19,"promoReference":null,"partnerRefCode":null}]},"error":0,"success":true,"message":""}';
    //         SuppyJson := '{"data":{"id":138618456,"createdAt":"2024-05-23T09:07:36.1315784+00:00","currencyCode":"USD","currencyId":1,"totalExludingFees":30.52,"feesTotalAmount":0.67,"remainingToBePaidByCustomer":31.19,"feesStructure":{"serviceFees":0,"serviceFeeTaxAmount":0,"deliveryFees":0.67,"creditCardFees":0,"conciergeFees":0,"paymentAdditionalFees":0},"totalAmount":31.19,"discount":0,"items":[{"barcodes":["5289000061852"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"000998","quantity":2,"unitPrice":2,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":2,"drsAmount":0,"isABundle":false,"orderItemId":6566895,"isPartOfABundle":false},{"barcodes":["5283007400119"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"001628","quantity":1,"unitPrice":2,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":2,"drsAmount":0,"isABundle":false,"orderItemId":6566896,"isPartOfABundle":false},{"barcodes":["788930470130"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"015950","quantity":1,"unitPrice":2.22,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":2.22,"drsAmount":0,"isABundle":false,"orderItemId":6566897,"isPartOfABundle":false},{"barcodes":["5283007400164"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"051136","quantity":1,"unitPrice":1.11,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":1.11,"drsAmount":0,"isABundle":false,"orderItemId":6566898,"isPartOfABundle":false},{"barcodes":["5285001101948"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"005847","quantity":1,"unitPrice":6.22,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":6.22,"drsAmount":0,"isABundle":false,"orderItemId":6566899,"isPartOfABundle":false},{"barcodes":["5285001101917"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"005846","quantity":1,"unitPrice":1.89,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":1.89,"drsAmount":0,"isABundle":false,"orderItemId":6566900,"isPartOfABundle":false},{"barcodes":["5285000833987"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"007467","quantity":1,"unitPrice":3.56,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":3.56,"drsAmount":0,"isABundle":false,"orderItemId":6566901,"isPartOfABundle":false},{"barcodes":["5285000835677"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"007472","quantity":1,"unitPrice":1.84,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":1.84,"drsAmount":0,"isABundle":false,"orderItemId":6566902,"isPartOfABundle":false},{"barcodes":["5285000834892"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"007462","quantity":1,"unitPrice":2,"originalPrice":2,"isPromoted":true,"discountValue":50,"totalPrice":1,"drsAmount":0,"isABundle":false,"orderItemId":6566903,"isPartOfABundle":false},{"barcodes":["5285000838814"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"028096","quantity":1,"unitPrice":4.67,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":4.67,"drsAmount":0,"isABundle":false,"orderItemId":6566904,"isPartOfABundle":false}],"customerInfo":{"name":"Samer SWAIDAN","phoneNumber":"96178950664","loyaltyInfo":{"useLoyaltyForPayment":false,"loyaltyAccountCode":null,"loyaltyAccountId":null,"amountToRedeem":0,"pointsToRedeem":0,"currencyCode":null}},"paymentInfo":[{"formOfPayment":"CoD","amount":31.19,"promoReference":null,"partnerRefCode":null}]},"error":0,"success":true,"message":""}';
    //         if SuppyObject.ReadFrom(SuppyJson) then begin


    //             SuppyObject.Get('data', dataToken);
    //             dataToken.WriteTo(dataText);
    //             if dataText = 'null' then
    //                 Error('Order Id %1 provided have no data or is not valid ', OrderID);
    //             dataObject := dataToken.AsObject();
    //             dataObject.Get('id', IdToken);
    //             dataObject.Get('createdAt', CreatedAtToken);
    //             dataObject.Get('totalExludingFees', totalExludingFeesToken);
    //             dataObject.Get('feesTotalAmount', feesToTalAmountToken);
    //             dataObject.Get('currencyCode', CurrencyCodeToken);
    //             dataObject.Get('feesStructure', feesStructureToken);
    //             feesStructureObject := feesStructureToken.AsObject();
    //             feesStructureObject.Get('serviceFees', ServiceFeesToken);
    //             feesStructureObject.Get('deliveryFees', deliveryFeesToken);
    //             feesStructureObject.Get('creditCardFees', creditCardFeesToken);

    //             dataObject.Get('totalAmount', totalAmountToken);
    //             dataObject.Get('discount', discountToken);


    //             ID := IdToken.AsValue().AsInteger();

    //             createdAt := CreatedAtToken.AsValue().AsDateTime();
    //             TotalExludingFees := totalExludingFeesToken.AsValue().AsInteger();
    //             FeesTotalAmount := feesToTalAmountToken.AsValue().AsDecimal();
    //             CurrencyCode := CurrencyCodeToken.AsValue().AsText();
    //             serviceFees := ServiceFeesToken.AsValue().AsDecimal();
    //             deliveryFees := deliveryFeesToken.AsValue().AsDecimal();
    //             creditCardFees := creditCardFeesToken.AsValue().AsDecimal();
    //             totalAmount := totalAmountToken.AsValue().AsDecimal();
    //             discount := discountToken.AsValue().AsDecimal();

    //             transDate := DT2Date(createdAt);

    //             exchangeRate.Reset();
    //             exchangeRate.SetFilter("Currency Code", 'LBP');
    //             exchangeRate.SetAscending("Starting Date", false);
    //             if exchangeRate.FindFirst() then
    //                 Rate := exchangeRate."LSC POS Exchange Rate Amount";

    //             dataObject.Get('items', ItemsToken);
    //             ItemsArray := ItemsToken.AsArray();
    //             foreach ItemsToken in ItemsArray do begin
    //                 SuppyDiscount := false;
    //                 ItemNo := '';
    //                 POSBarcode := '';
    //                 ItemObject := ItemsToken.AsObject();
    //                 ItemObject.Get('barcodes', BarcodesToken);
    //                 BarcodesJsonArray := BarcodesToken.AsArray();
    //                 foreach BarcodesToken in BarcodesJsonArray do begin
    //                     Barcodes := BarcodesToken.AsValue().AsText();
    //                     IF not BarcodesRec.Get(Barcodes) then
    //                         Error(StrSubstNo('%1 Barcode is either not Valid or not in system', Barcodes))
    //                     else
    //                         posbarcode := Barcodes;

    //                 end;
    //                 ItemObject.Get('productCode', ProductCodeToken);
    //                 ItemObject.Get('quantity', QuantityToken);
    //                 ItemObject.Get('unitPrice', UnitPriceToken);
    //                 ItemObject.Get('totalPrice', TotalPriceToken);
    //                 ItemObject.Get('discountValue', discountvalueToken);
    //                 productCode := ProductCodeToken.AsValue().AsText();
    //                 Quantityjson := QuantityToken.AsValue().AsDecimal();
    //                 UnitPrice := UnitPriceToken.AsValue().AsDecimal();
    //                 TotalPrice := TotalPriceToken.AsValue().AsDecimal();
    //                 discountValue := discountValueToken.AsValue().AsDecimal();
    //                 lineNO := lineNO + 10000;


    //                 //if ItemNo <> '' then begin
    //                 if POSBarcode <> '' then begin

    //                     BarcodesRec.Get(POSBarcode);

    //                     ItemNo := BarcodesRec."Item No.";
    //                     UOM := BarcodesRec."Unit of Measure Code";
    //                     If ItemUOM.get(ItemNo, UOM) then begin
    //                         if ItemUOM."Suppy Discount %" > 0 then
    //                             SuppyDiscount := true;
    //                     end;
    //                     PosTransaction.SetRange("Receipt No.", ReceiptNO);

    //                     /////newTRans
    //                     Clear(PosTransaction);
    //                     PosTransaction."Staff ID" := StaffID;
    //                     PosTransaction.Validate("Receipt No.", ReceiptNo);
    //                     PosTransaction.Validate("Store No.", StoreNo);
    //                     PosTransaction.Validate("POS Terminal No.", terminalNO);
    //                     Clear(POStransLine);
    //                     //PosTransaction.Insert;
    //                     ////Setvars
    //                     if not StoreSetup.Get(PosTransaction."Store No.") then
    //                         Clear(StoreSetup);

    //                     POSSession.SetStore(PosTransaction."Store No.");
    //                     POSSession.SetTerminal(PosTransaction."POS Terminal No.");
    //                     if not PosTerminal.Get(PosTransaction."POS Terminal No.") then
    //                         Clear(PosTerminal);
    //                     PosTransaction."Gen. Bus. Posting Group" := StoreSetup."Store Gen. Bus. Post. Gr.";
    //                     PosTransaction."VAT Bus.Posting Group" := StoreSetup."Store VAT Bus. Post. Gr.";
    //                     PosTransaction."Transaction Type" := PosTransaction."Transaction Type"::Sales;
    //                     PosTransaction."Trans. Date" := Today;
    //                     PosTransaction."Original Date" := PosTransaction."Trans. Date";
    //                     PosTransaction."Trans Time" := Time;
    //                     PosTransaction."Trans. Date" :=
    //                       RetailCalendarManagement.GetStoreTransactionDate(
    //                         StoreSetup."No.", RetailCalendar."Calendar Type"::"Opening Hours",
    //                         PosTransaction."Trans. Date", PosTransaction."Trans Time");
    //                     PosTransaction.Validate("Trans. Currency Code", StoreSetup."Currency Code");
    //                     //
    //                     //PosTransaction."Currency Factor" := 1;
    //                     //
    //                     PosTransaction.Modify;
    //                     PosTransaction.SetRange(PosTransaction."Receipt No.", ReceiptNo);
    //                     StoreNo := PosTransaction."Store No.";
    //                     terminalNO := PosTransaction."POS Terminal No.";
    //                     StaffID := PosTransaction."Staff ID";

    //                     PosFunc.LoadOfferTables(true);
    //                     PosFunc.PosTransDiscLoad(ReceiptNo);
    //                     ////OnActivateForm
    //                     POSSession.SetStore(PosTransaction."Store No.");
    //                     POSSession.SetTerminal(PosTransaction."POS Terminal No.");
    //                     POSSession.SetStaff(PosTransaction."Staff ID");
    //                     if not PosTerminal.Get(PosTransaction."POS Terminal No.") then
    //                         Clear(PosTerminal);
    //                     ///// ItemValidate(ItemNo, VariantCode, UOM);
    //                     if PosTransaction."POS Terminal No." = '' then
    //                         Error(CannotBeBlank, PosTransaction.FieldCaption("POS Terminal No."));

    //                     if PosTransaction."Store No." = '' then
    //                         Error(CannotBeBlank, PosTransaction.FieldCaption("Store No."));

    //                     if ItemNo = '' then
    //                         Error(CannotBeBlank, ExtVarVal.FieldCaption("Item No."));

    //                     Clear(NewLine);

    //                     NewLine."Receipt No." := ReceiptNo;
    //                     NewLine."Store No." := PosTransaction."Store No.";
    //                     NewLine."POS Terminal No." := PosTransaction."POS Terminal No.";
    //                     NewLine."Entry Type" := NewLine."Entry Type"::Item;
    //                     if ItemNo <> '' then begin
    //                         NewLine.Number := ItemNo;
    //                         if not PosFunc.LoadItem(NewLine) then
    //                             Error(Text101, ItemNo);
    //                         Items.Get(NewLine.Number);
    //                         if not VatSetup.Get(PosTransaction."VAT Bus.Posting Group", Items."VAT Prod. Posting Group") then
    //                             if (Items."VAT Bus. Posting Gr. (Price)" = '') or not
    //                                 VatSetup.Get(Items."VAT Bus. Posting Gr. (Price)", Items."VAT Prod. Posting Group") then
    //                                 Error(Text102, ItemNo);
    //                         // if (Items."Sales Unit of Measure" <> '') and not ItemUOM.Get(Items."No.", Items."Sales Unit of Measure") and (UOM = '') then
    //                         //    Error(Text103, Items."Sales Unit of Measure", Items."No.");
    //                         if BOUtils.IsBlockSaleOnPOS(Items."No.", '', NewLine."Variant Code", StoreSetup."No.", StoreSetup."Location Code", Today,
    //                           ItemStatusLink) then
    //                             Error(Text104, ItemNo);
    //                         // if VariantCode <> '' then
    //                         //     NewLine."Variant Code" := VariantCode;
    //                         // //if UOM <> '' then
    //                         // //    NewLine.Validate("Unit of Measure", UOM);

    //                         // newLine.validate("Barcode No.", POSBarcode);
    //                         // newLine."Unit of Measure" := UOM;
    //                         // NewLine.Validate(NewLine.Number, NewLine.Number);

    //                         // //NewLine.validate("Discount %", discountValue);
    //                         // NewLine.Validate(Quantity, Quantityjson);


    //                         if SuppyDiscount then begin
    //                             newLine."Barcode No." := POSBarcode;
    //                             NewLine.Validate(NewLine.Number, NewLine.Number);
    //                             newLine."Unit of Measure" := UOM;
    //                             newLine.Price := UnitPrice;
    //                             AmountLB := TotalPrice * Rate;
    //                             NewLine.Validate(Quantity, Quantityjson);
    //                             newLine.Validate("Discount %", discountValue);
    //                             newLine."Discount Amount" := UnitPrice * discountValue / 100;
    //                             newline."Periodic Disc. %" := discountValue;
    //                             newline."Periodic Discount Amount" := UnitPrice * discountValue / 100;
    //                             newLine.Amount := TotalPrice;
    //                             newLine.AmountLBP := AmountLB;
    //                         end
    //                         else begin
    //                             if VariantCode <> '' then
    //                                 NewLine."Variant Code" := VariantCode;

    //                             newLine.validate("Barcode No.", POSBarcode);
    //                             newLine."Unit of Measure" := UOM;
    //                             NewLine.Validate(NewLine.Number, NewLine.Number);
    //                             NewLine.Validate(Quantity, Quantityjson);
    //                         end;

    //                     end;
    //                     POStransLine.Copy(NewLine);
    //                     if POStransLine.Price = 0 then
    //                         Error(StrSubstNo('Item %1 with barcode %2 is not Priced', ItemNo, POSBarcode));

    //                     POStransLine.InsertLine;

    //                     POStransLine.Get(POStransLine."Receipt No.", POStransLine."Line No.");
    //                     Items.Get(POStransLine.Number);

    //                     //if not SuppyDiscount then begin
    //                     PosFunc.PosTransDiscFlush;//do not remove
    //                     // PosFunc.ChangeVATBusOnLine(PosTransaction);//do not remove
    //                     //PosFunc.RecalcSlip(PosTransaction);//do not remove
    //                     // end;
    //                 end;
    //             end;
    //             POStransLine.Reset();
    //             POStransLine.SetRange("POS Terminal No.", terminalNO);
    //             POStransLine.SetRange("Store No.", storeNo);
    //             POStransLine.SetRange("Receipt No.", ReceiptNO);


    //             if POStransLine.FindLast() then
    //                 lineNO := POStransLine."Line No." + 10000;

    //             POStransLine.Init();
    //             POStransLine."Receipt No." := ReceiptNO;
    //             POStransLine.Validate("Line No.", 10);
    //             POStransLine."Store No." := storeNo;
    //             POStransLine."Created by Staff ID" := StaffID;
    //             POStransLine."Entry Type" := POStransLine."Entry Type"::FreeText;
    //             POStransLine.Description := StrSubstNo('Order ID %1', CurrInput);
    //             /// POStransLine.number := CurrInput;
    //             POStransLine.quantity := 0;
    //             POStransLine."Trans. Date" := transDate;
    //             POStransLine.Insert(true);
    //             if FeesTotalAmount <> 0 then begin
    //                 lineNO := lineNO + 10000;
    //                 POStransLine.Init();

    //                 POStransLine."Receipt No." := ReceiptNO;
    //                 POStransLine."Line No." := lineNO;
    //                 POStransLine."Store No." := storeNo;
    //                 POStransLine."Entry Type" := POStransLine."Entry Type"::IncomeExpense;
    //                 POStransLine.Number := SalesRecv."Total Fees IncExp";

    //                 POStransLine."Created by Staff ID" := StaffID;
    //                 POStransLine.Description := 'Total Fees';
    //                 POStransLine.Validate(Price, FeesTotalAmount);
    //                 POStransLine.Quantity := 1;
    //                 POStransLine.Validate(Amount, FeesTotalAmount);
    //                 POStransLine."Trans. Date" := transDate;

    //                 AmountLB := FeesTotalAmount * Rate;
    //                 POStransLine.AmountLBP := AmountLB;

    //                 POStransLine.Insert(True);

    //             end;
    //             // //if not SuppyDiscount then begin
    //             // PosFunc.PosTransDiscFlush;//do not remove
    //             // PosFunc.ChangeVATBusOnLine(PosTransaction);//do not remove
    //             // PosFunc.RecalcSlip(PosTransaction);//do not remove
    //             //                                    // end;

    //         end;


    //     end;

    //     procedure GetSuppyOrderId(MenuLine: Record "LSC POS Menu Line")
    //     var
    //         POStransactionRec: record "LSC POS Transaction";
    //         POStransLine: Record "LSC POS Trans. Line";
    //         TransInfocodeEntry: Record "LSC Trans. Infocode Entry";

    //         POSSession: Codeunit "LSC POS Session";
    //         POSTrans: Codeunit "LSC POS Transaction";
    //         //MenuLine:record "LSC POS Menu Line";

    //         TableSpecificInfocode: Record "LSC Table Specific Infocode";
    //         Infocode: Record "LSC Infocode";
    //         lPOSTransLine: Record "LSC POS Trans. Line";


    //         Posctrl: Codeunit "LSC POS Control Interface";
    //         POSGUI: Codeunit "LSC POS GUI";
    //         transactionheader: record "LSC Transaction Header";

    //     begin
    //         CurrInput := '';
    //         terminalNO := POSSession.TerminalNo();
    //         ReceiptNO := POSTrans.GetReceiptNo();
    //         StaffID := POSSession.StaffID();
    //         storeNo := postrans.GetStoreNo();


    //         CurrInput := posctrl.GetInputText('#SUPPYINPUT');
    //         if CurrInput = '' then
    //             error('Please enter an Order Id to continue');


    //         TransInfocodeEntry.Reset();
    //         TransInfocodeEntry.SetRange("Store No.", storeNo);
    //         transInfocodeEntry.SetFilter(Infocode, '%1', 'SUPPY ID');
    //         TransInfocodeEntry.SetRange(Information, CurrInput);
    //         if TransInfocodeEntry.FindFirst() then
    //             Error('Order with ID : %1 is already in system', CurrInput)
    //         else begin
    //             InsertSuppyOrder2(CurrInput);
    //             POSTransInfocodeEntry.Init();
    //             POSTransInfocodeEntry.Validate("Receipt No.", ReceiptNO);
    //             POSTransInfocodeEntry."Transaction Type" := POSTransInfocodeEntry."Transaction Type"::Header;
    //             POSTransInfocodeEntry."Line No." := 0;
    //             POSTransInfocodeEntry.Validate(Infocode, 'SUPPY ID');
    //             POSTransInfocodeEntry."Entry Line No." := 0;
    //             POSTransInfocodeEntry.Validate("Store No.", storeNo);
    //             POSTransInfocodeEntry.Information := CurrInput;
    //             POSTransInfocodeEntry.Insert();


    //         end;




    //     end;

    //     procedure InsertSuppyOrder2(OrderID: Text)
    //     var
    //         SuppyJson: Text;

    //         SuppyObject: JsonObject;
    //         dataToken: JsonToken;
    //         dataObject: JsonObject;
    //         feesStructureToken: JsonToken;
    //         feesStructureObject: JsonObject;
    //         ItemsToken: JsonToken;
    //         ItemsArray: JsonArray;
    //         ItemObject: JsonObject;
    //         BarcodesToken: JsonToken;
    //         BarcodesJsonArray: JsonArray;
    //         BarcodesArray: List of [Text[100]];
    //         Barcodes: Text;
    //         barcode: Text;
    //         ItemNo: Text;
    //         items: Record Item;



    //         ID: Integer;
    //         createdAt: DateTime;
    //         TotalExludingFees: Decimal;
    //         FeesTotalAmount: Decimal;
    //         CurrencyCode: Text;
    //         serviceFees: Decimal;
    //         deliveryFees: Decimal;
    //         creditCardFees: Decimal;
    //         totalAmount: Decimal;
    //         discount: Decimal;
    //         productCode: Text;
    //         Quantityjson: Decimal;
    //         UnitPrice: Decimal;
    //         OriginalPrice: Decimal;
    //         discountValue: Decimal;
    //         TotalPrice: Decimal;
    //         loyaltyId: integer;
    //         amountToRedeem: Decimal;
    //         amountToRedeemCurrencyCode: Text;
    //         ApiMessage: Text;
    //         dataText: text;

    //         BarcodesRec: Record "LSC Barcodes";
    //         POStransactionRec: record "LSC POS Transaction";
    //         POStransLine: Record "LSC POS Trans. Line";
    //         TransInfocodeEntry: Record "LSC Trans. Infocode Entry";
    //         POSSession: Codeunit "LSC POS Session";
    //         POSTrans: Codeunit "LSC POS Transaction";
    //         POSFUNC: Codeunit "LSC POS Functions";
    //         StoreSetup: record "LSC Store";
    //         RetailCalendarManagement: Codeunit "LSC Retail Calendar Management";
    //         RetailCalendar: record "LSC Retail Calendar";
    //         exchangeRate: record "Currency Exchange Rate";


    //         lineNO: Integer;
    //         Rate: Decimal;
    //         AmountLB: Decimal;
    //         transDate: Date;
    //         CheckID: Integer;
    //         SalesRecv: Record "Sales & Receivables Setup";
    //         POSBarcode: Text;
    //         variantcode: code[10];


    //         PosTransaction: Record "LSC POS Transaction";
    //         newLine: Record "LSC POS Trans. Line";
    //         UOM: code[20];
    //         ItemUOM: Record "Item Unit of Measure";
    //         Text103: Label 'UOM %1 is not available for Item %2';
    //         Text101: Label 'Item %1 does not exist';
    //         Text102: Label 'Invalid VAT setup on Item %1';
    //         Text104: Label 'Item %1 is blocked';
    //         posterminal: Record "LSC POS Terminal";
    //         CannotBeBlank: Label '%1 cannot be blank';
    //         ExtVarVal: Record "LSC Extd. Variant Values";
    //         VatSetup: Record "VAT Posting Setup";
    //         BOUtils: Codeunit "LSC BO Utils";
    //         ItemStatusLink: Record "LSC Item Status Link";
    //         SuppyDiscount: Boolean;
    //         barcodeDisc: Text;
    //         periodicDics: Record "LSC Periodic Discount";
    //         periodicDiscLine: Record "LSC Periodic Discount Line";



    //         POSTransactionEvents: Codeunit "LSC POS Transaction Events";
    //         isHandled: Boolean;
    //         InfoTextDescription, InfoTextDescription2 : Text;
    //         POSLINES: Codeunit "LSC POS Trans. Lines";
    //         DT: Record "LSC POS Trans. Per. Disc. Type";
    //         PosPriceUtil: Codeunit "LSC POS Price Utility";
    //         OldAmount: Decimal;
    //         LineDiscBefore: Boolean;
    //         LineDiscAfter: Boolean;
    //         LineDiscChange: Boolean;
    //         PosOfferExt: Codeunit "LSC POS Offer Ext. Utility";
    //         DiscChangedMsg: Label 'Discount changed';
    //         OposUtil: Codeunit "LSC POS OPOS Utility";
    //         CurrInput2: text;
    //         ForDiccLine: Text;
    //     begin
    //         SuppyDiscount := false;
    //         SalesRecv.Get();

    //         SuppyJson := SuppyOrderIntegration(OrderID);

    //         //SuppyJson := '{"data":{"id":138618456,"createdAt":"2024-05-23T09:07:36.1315784+00:00","currencyCode":"USD","currencyId":1,"totalExludingFees":30.52,"feesTotalAmount":0.67,"remainingToBePaidByCustomer":31.19,"feesStructure":{"serviceFees":0,"serviceFeeTaxAmount":0,"deliveryFees":0.67,"creditCardFees":0,"conciergeFees":0,"paymentAdditionalFees":0},"totalAmount":31.19,"discount":0,"items":[{"barcodes":["5289000061852"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"000998","quantity":2,"unitPrice":2,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":2,"drsAmount":0,"isABundle":false,"orderItemId":6566895,"isPartOfABundle":false}],"customerInfo":{"name":"Samer SWAIDAN","phoneNumber":"96178950664","loyaltyInfo":{"useLoyaltyForPayment":false,"loyaltyAccountCode":null,"loyaltyAccountId":null,"amountToRedeem":0,"pointsToRedeem":0,"currencyCode":null}},"paymentInfo":[{"formOfPayment":"CoD","amount":31.19,"promoReference":null,"partnerRefCode":null}]},"error":0,"success":true,"message":""}';
    //         // SuppyJson := '{"data":{"id":138618456,"createdAt":"2024-05-23T09:07:36.1315784+00:00","currencyCode":"USD","currencyId":1,"totalExludingFees":30.52,"feesTotalAmount":0.67,"remainingToBePaidByCustomer":31.19,"feesStructure":{"serviceFees":0,"serviceFeeTaxAmount":0,"deliveryFees":0.67,"creditCardFees":0,"conciergeFees":0,"paymentAdditionalFees":0},"totalAmount":31.19,"discount":0,"items":[{"barcodes":["5289000061852"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"000998","quantity":2,"unitPrice":2,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":2,"drsAmount":0,"isABundle":false,"orderItemId":6566895,"isPartOfABundle":false},{"barcodes":["5283007400119"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"001628","quantity":1,"unitPrice":2,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":2,"drsAmount":0,"isABundle":false,"orderItemId":6566896,"isPartOfABundle":false},{"barcodes":["788930470130"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"015950","quantity":1,"unitPrice":2.22,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":2.22,"drsAmount":0,"isABundle":false,"orderItemId":6566897,"isPartOfABundle":false},{"barcodes":["5283007400164"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"051136","quantity":1,"unitPrice":1.11,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":1.11,"drsAmount":0,"isABundle":false,"orderItemId":6566898,"isPartOfABundle":false},{"barcodes":["5285001101948"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"005847","quantity":1,"unitPrice":6.22,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":6.22,"drsAmount":0,"isABundle":false,"orderItemId":6566899,"isPartOfABundle":false},{"barcodes":["5285001101917"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"005846","quantity":1,"unitPrice":1.89,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":1.89,"drsAmount":0,"isABundle":false,"orderItemId":6566900,"isPartOfABundle":false},{"barcodes":["5285000833987"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"007467","quantity":1,"unitPrice":3.56,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":3.56,"drsAmount":0,"isABundle":false,"orderItemId":6566901,"isPartOfABundle":false},{"barcodes":["5285000835677"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"007472","quantity":1,"unitPrice":1.84,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":1.84,"drsAmount":0,"isABundle":false,"orderItemId":6566902,"isPartOfABundle":false},{"barcodes":["5285000834892"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"007462","quantity":2,"unitPrice":7.5,"originalPrice":10,"isPromoted":true,"discountValue":10,"totalPrice":15,"drsAmount":0,"isABundle":false,"orderItemId":6566903,"isPartOfABundle":false},{"barcodes":["5285000838814"],"scaleBarcode":null,"isWeightVariable":false,"productCode":"028096","quantity":1,"unitPrice":4.67,"originalPrice":0,"isPromoted":false,"discountValue":0,"totalPrice":4.67,"drsAmount":0,"isABundle":false,"orderItemId":6566904,"isPartOfABundle":false}],"customerInfo":{"name":"Samer SWAIDAN","phoneNumber":"96178950664","loyaltyInfo":{"useLoyaltyForPayment":false,"loyaltyAccountCode":null,"loyaltyAccountId":null,"amountToRedeem":0,"pointsToRedeem":0,"currencyCode":null}},"paymentInfo":[{"formOfPayment":"CoD","amount":31.19,"promoReference":null,"partnerRefCode":null}]},"error":0,"success":true,"message":""}';
    //         if SuppyObject.ReadFrom(SuppyJson) then begin


    //             SuppyObject.Get('data', dataToken);
    //             dataToken.WriteTo(dataText);
    //             if dataText = 'null' then
    //                 Error('Order Id %1 provided have no data or is not valid ', OrderID);
    //             dataObject := dataToken.AsObject();
    //             dataObject.Get('feesStructure', feesStructureToken);
    //             feesStructureObject := feesStructureToken.AsObject();
    //             ID := ReadJSONobject(dataObject, 'id').AsInteger();
    //             createdAt := ReadJSONobject(dataObject, 'createdAt').AsDateTime();
    //             TotalExludingFees := ReadJSONobject(dataObject, 'totalExludingFees').AsDecimal();
    //             FeesTotalAmount := ReadJSONobject(dataObject, 'feesTotalAmount').AsInteger();
    //             CurrencyCode := ReadJSONobject(dataObject, 'currencyCode').AsText();
    //             serviceFees := ReadJSONobject(feesStructureObject, 'serviceFees').AsDecimal();
    //             deliveryFees := ReadJSONobject(feesStructureObject, 'deliveryFees').AsDecimal();
    //             creditCardFees := ReadJSONobject(feesStructureObject, 'creditCardFees').AsDecimal();
    //             totalAmount := ReadJSONobject(dataObject, 'totalAmount').AsDecimal();
    //             discount := ReadJSONobject(dataObject, 'discount').AsDecimal();

    //             transDate := DT2Date(createdAt);

    //             exchangeRate.Reset();
    //             exchangeRate.SetFilter("Currency Code", 'LBP');
    //             exchangeRate.SetAscending("Starting Date", false);
    //             if exchangeRate.FindFirst() then
    //                 Rate := exchangeRate."LSC POS Exchange Rate Amount";

    //             dataObject.Get('items', ItemsToken);
    //             ItemsArray := ItemsToken.AsArray();
    //             foreach ItemsToken in ItemsArray do begin
    //                 ItemNo := '';
    //                 POSBarcode := '';
    //                 SuppyDiscount := false;
    //                 ItemObject := ItemsToken.AsObject();
    //                 ItemObject.Get('barcodes', BarcodesToken);
    //                 BarcodesJsonArray := BarcodesToken.AsArray();
    //                 foreach BarcodesToken in BarcodesJsonArray do begin
    //                     Barcodes := BarcodesToken.AsValue().AsText();
    //                     IF not BarcodesRec.Get(Barcodes) then
    //                         Error(StrSubstNo('%1 Barcode is either not Valid or not in system', Barcodes))
    //                     else
    //                         posbarcode := Barcodes;

    //                 end;
    //                 productCode := ReadJSONobject(ItemObject, 'productCode').AsText();
    //                 Quantityjson := ReadJSONobject(ItemObject, 'quantity').AsDecimal();
    //                 UnitPrice := ReadJSONobject(ItemObject, 'unitPrice').AsDecimal();
    //                 OriginalPrice := ReadJSONobject(ItemObject, 'originalPrice').AsDecimal();
    //                 TotalPrice := ReadJSONobject(ItemObject, 'totalPrice').AsDecimal();
    //                 discountValue := ReadJSONobject(ItemObject, 'discountValue').AsDecimal();

    //                 lineNO := lineNO + 10000;
    //                 if POSBarcode <> '' then begin
    //                     BarcodesRec.Get(POSBarcode);
    //                     ItemNo := BarcodesRec."Item No.";
    //                     UOM := BarcodesRec."Unit of Measure Code";
    //                     If ItemUOM.get(ItemNo, UOM) then begin
    //                         if ItemUOM."Suppy Discount %" > 0 then
    //                             SuppyDiscount := true;
    //                     end;
    //                     PosTransaction.SetRange("Receipt No.", ReceiptNO);

    //                     Clear(PosTransaction);
    //                     PosTransaction."Staff ID" := StaffID;
    //                     PosTransaction.Validate("Receipt No.", ReceiptNo);
    //                     PosTransaction.Validate("Store No.", StoreNo);
    //                     PosTransaction.Validate("POS Terminal No.", terminalNO);
    //                     Clear(POStransLine);
    //                     if not StoreSetup.Get(PosTransaction."Store No.") then
    //                         Clear(StoreSetup);

    //                     POSSession.SetStore(PosTransaction."Store No.");
    //                     POSSession.SetTerminal(PosTransaction."POS Terminal No.");
    //                     if not PosTerminal.Get(PosTransaction."POS Terminal No.") then
    //                         Clear(PosTerminal);
    //                     PosTransaction."Gen. Bus. Posting Group" := StoreSetup."Store Gen. Bus. Post. Gr.";
    //                     PosTransaction."VAT Bus.Posting Group" := StoreSetup."Store VAT Bus. Post. Gr.";
    //                     PosTransaction."Transaction Type" := PosTransaction."Transaction Type"::Sales;
    //                     PosTransaction."Trans. Date" := Today;
    //                     PosTransaction."Original Date" := PosTransaction."Trans. Date";
    //                     PosTransaction."Trans Time" := Time;
    //                     PosTransaction."Trans. Date" :=
    //                       RetailCalendarManagement.GetStoreTransactionDate(
    //                         StoreSetup."No.", RetailCalendar."Calendar Type"::"Opening Hours",
    //                         PosTransaction."Trans. Date", PosTransaction."Trans Time");
    //                     PosTransaction.Validate("Trans. Currency Code", StoreSetup."Currency Code");
    //                     PosTransaction.Modify;
    //                     PosTransaction.SetRange(PosTransaction."Receipt No.", ReceiptNo);
    //                     StoreNo := PosTransaction."Store No.";
    //                     terminalNO := PosTransaction."POS Terminal No.";
    //                     StaffID := PosTransaction."Staff ID";

    //                     PosFunc.LoadOfferTables(true);
    //                     PosFunc.PosTransDiscLoad(ReceiptNo);

    //                     POSSession.SetStore(PosTransaction."Store No.");
    //                     POSSession.SetTerminal(PosTransaction."POS Terminal No.");
    //                     POSSession.SetStaff(PosTransaction."Staff ID");
    //                     if not PosTerminal.Get(PosTransaction."POS Terminal No.") then
    //                         Clear(PosTerminal);

    //                     if PosTransaction."POS Terminal No." = '' then
    //                         Error(CannotBeBlank, PosTransaction.FieldCaption("POS Terminal No."));

    //                     if PosTransaction."Store No." = '' then
    //                         Error(CannotBeBlank, PosTransaction.FieldCaption("Store No."));

    //                     if ItemNo = '' then
    //                         Error(CannotBeBlank, ExtVarVal.FieldCaption("Item No."));

    //                     Clear(NewLine);

    //                     NewLine."Receipt No." := ReceiptNo;
    //                     NewLine."Store No." := PosTransaction."Store No.";
    //                     NewLine."POS Terminal No." := PosTransaction."POS Terminal No.";
    //                     NewLine."Entry Type" := NewLine."Entry Type"::Item;
    //                     if ItemNo <> '' then begin
    //                         NewLine.Number := ItemNo;
    //                         if not PosFunc.LoadItem(NewLine) then
    //                             Error(Text101, ItemNo);
    //                         Items.Get(NewLine.Number);
    //                         if not VatSetup.Get(PosTransaction."VAT Bus.Posting Group", Items."VAT Prod. Posting Group") then
    //                             if (Items."VAT Bus. Posting Gr. (Price)" = '') or not
    //                                 VatSetup.Get(Items."VAT Bus. Posting Gr. (Price)", Items."VAT Prod. Posting Group") then
    //                                 Error(Text102, ItemNo);
    //                         if BOUtils.IsBlockSaleOnPOS(Items."No.", '', NewLine."Variant Code", StoreSetup."No.", StoreSetup."Location Code", Today,
    //                           ItemStatusLink) then
    //                             Error(Text104, ItemNo);
    //                         if VariantCode <> '' then
    //                             NewLine."Variant Code" := VariantCode;
    //                         NewLine.Validate(NewLine.Number, NewLine.Number);
    //                         newLine."Unit of Measure" := UOM;
    //                         NewLine.Validate(Quantity, Quantityjson);
    //                         if SuppyDiscount then begin
    //                             newLine."Barcode No." := POSBarcode;
    //                             newLine.Validate(Price, OriginalPrice);

    //                         end
    //                         else
    //                             newLine.validate("Barcode No.", POSBarcode);

    //                     end
    //                     else
    //                         Error('Empty Item NO for Barcode %1', POSBarcode);

    //                     POStransLine.Copy(NewLine);
    //                     if POStransLine.Price = 0 then
    //                         Error(StrSubstNo('Item %1 with barcode %2 is not Priced', ItemNo, POSBarcode));

    //                     POStransLine.InsertLine;
    //                     if SuppyDiscount then begin
    //                         LineDiscBefore := PosOfferExt.TransLineDiscOfferTypeExists(POStransLine, DT.DiscType::Line);
    //                         PosPriceUtil.InsertTransDiscPercent(POStransLine, 0, DT.DiscType::Line, '');
    //                         POStransLine.Validate(POStransLine."Line Disc. %", 0);
    //                         OldAmount := POStransLine.Amount;

    //                         PosPriceUtil.InsertTransDiscPercent(POStransLine, discountValue, DT.DiscType::Line, '');

    //                         POStransLine.Validate("Line Disc. %", discountValue);
    //                         LineDiscAfter := PosOfferExt.TransLineDiscOfferTypeExists(POStransLine, DT.DiscType::Line);
    //                         if LineDiscAfter then
    //                             PosOfferExt.ProcessLinePreTotal(PosTransaction, POStransLine, '');
    //                         LineDiscChange := LineDiscBefore or LineDiscAfter;
    //                         POStrans.WriteMgrStatus();
    //                         POStrans.CalcTotals;
    //                     end;


    //                     POStransLine.Get(POStransLine."Receipt No.", POStransLine."Line No.");
    //                     Items.Get(POStransLine.Number);

    //                     PosFunc.PosTransDiscFlush;//do not remove
    //                     PosFunc.ChangeVATBusOnLine(PosTransaction);//do not remove
    //                     PosFunc.RecalcSlip(PosTransaction);//do not remove


    //                 end
    //                 else
    //                     Error('This transaction has an Item without Barcode');
    //             end;
    //             POStransLine.Reset();
    //             POStransLine.SetRange("POS Terminal No.", terminalNO);
    //             POStransLine.SetRange("Store No.", storeNo);
    //             POStransLine.SetRange("Receipt No.", ReceiptNO);


    //             if POStransLine.FindLast() then
    //                 lineNO := POStransLine."Line No." + 10000;

    //             POStransLine.Init();
    //             POStransLine."Receipt No." := ReceiptNO;
    //             POStransLine.Validate("Line No.", 10);
    //             POStransLine."Store No." := storeNo;
    //             POStransLine."Created by Staff ID" := StaffID;
    //             POStransLine."Entry Type" := POStransLine."Entry Type"::FreeText;
    //             POStransLine.Description := StrSubstNo('Order ID %1', CurrInput);
    //             POStransLine.quantity := 0;
    //             POStransLine."Trans. Date" := transDate;
    //             POStransLine.Insert(true);
    //             if FeesTotalAmount <> 0 then begin
    //                 lineNO := lineNO + 10000;
    //                 POStransLine.Init();
    //                 POStransLine."Receipt No." := ReceiptNO;
    //                 POStransLine."Line No." := lineNO;
    //                 POStransLine."Store No." := storeNo;
    //                 POStransLine."Entry Type" := POStransLine."Entry Type"::IncomeExpense;
    //                 POStransLine.Number := SalesRecv."Total Fees IncExp";
    //                 POStransLine."Created by Staff ID" := StaffID;
    //                 POStransLine.Description := 'Total Fees';
    //                 POStransLine.Validate(Price, FeesTotalAmount);
    //                 POStransLine.Quantity := 1;
    //                 POStransLine.Validate(Amount, FeesTotalAmount);
    //                 POStransLine."Trans. Date" := transDate;
    //                 AmountLB := FeesTotalAmount * Rate;
    //                 POStransLine.AmountLBP := AmountLB;
    //                 POStransLine.Insert(True);

    //             end;

    //         end;


    //     end;

    //     // procedure jobQueryTEST()
    //     // var
    //     //     myInt: Integer;
    //     //     salesRECv: Record "Sales & Receivables Setup";

    //     // begin
    //     //     salesRECv.Get();
    //     //     salesRECv."Last Preaction No" := salesRECv."Last Preaction No" + 1;
    //     //     salesRECv.Modify();
    //     // end;

    //     local procedure ReadJSONobject(JsonObject: JsonObject; JSONkey: Text[100]): JsonValue
    //     var
    //         JsonToken: JsonToken;
    //     begin
    //         JsonObject.Get(JSONkey, JsonToken);
    //         exit(JsonToken.AsValue());
    //     end;
    //     //  procedure WriteMgrStatus()
    //     // begin
    //     //     if PosTransaction."Receipt No." = '' then
    //     //         exit;

    //     //     if not PosTransaction.Get(PosTransaction."Receipt No.") then
    //     //         exit;

    //     //     if POSSESSION.MgrKey and (PosTransaction."Manager Key" = PosTransaction."Manager Key"::Off) then begin
    //     //         REC."Manager Key" := REC."Manager Key"::On;
    //     //         if REC.Modify then;
    //     //     end;

    //     //     if not (POSSESSION.ManagerID in ['', REC."Manager ID"]) then begin
    //     //         REC."Manager ID" := POSSESSION.ManagerID;
    //     //         if REC.Modify then;
    //     //     end;
    //     // end;


    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction", 'OnBeforeDiscPrPressed', '', true, true)]
    //     local procedure "LSC POS Transaction_OnBeforeDiscPrPressed"
    //     (
    //         var LineRec: Record "LSC POS Trans. Line";
    //         var IsHandled: Boolean
    //     )
    //     begin
    //         // LineRec.Validate("Line Disc. %", discountValue2);
    //         // LineRec.Modify();
    //     end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction", 'OnAfterDiscPrPressed', '', true, true)]
    //     local procedure "LSC POS Transaction_OnAfterDiscPrPressed"
    //     (
    //         var LineRec: Record "LSC POS Trans. Line";
    //         var IsHandled: Boolean
    //     )
    //     begin

    //     end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction", 'OnBeforeInsertTransDiscPercent', '', true, true)]
    //     local procedure "LSC POS Transaction_OnBeforeInsertTransDiscPercent"(var LineRec: Record "LSC POS Trans. Line")
    //     begin
    //         // LineRec.Validate("Periodic Disc. %", 0);
    //         // LineRec.Validate("Periodic Discount Amount", 0);
    //         //LineRec.modify();
    //     end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnAfterDiscPrDiscountLine', '', true, true)]
    //     local procedure "LSC POS Transaction Events_OnAfterDiscPrDiscountLine"
    //     (
    //         var POSTransaction: Record "LSC POS Transaction";
    //         var POSTransLine: Record "LSC POS Trans. Line";
    //         var CurrInput: Text
    //     )
    //     begin
    //         // POSTransLine.Validate("Periodic Disc. %", 0);
    //         // POSTransLine.Validate("Periodic Discount Amount", 0);
    //         // // POSTransLine.modify();
    //     end;


    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnAfterDiscPrNegativeDiscountLine', '', true, true)]
    //     local procedure "LSC POS Transaction Events_OnAfterDiscPrNegativeDiscountLine"
    //     (
    //         var POSTransaction: Record "LSC POS Transaction";
    //         var POSTransLine: Record "LSC POS Trans. Line";
    //         var CurrInput: Text
    //     )
    //     begin

    //     end;





    //     var
    //         Progress: Dialog;
    //         ProgressValue: Integer;
    //         NoOfItem: Integer;
    //         TotalItems: Integer;
    //         FirstElement: code[20];
    //         SecondElement: text;
    //         PriceList: record "Price List Line";
    //         IntLineNo: Integer;
    //         itemsArray: JsonArray;
    //         CurrInput: text;
    //         terminalNO: Code[10];
    //         ReceiptNO: Code[20];
    //         StaffID: Code[20];
    //         storeNo: Code[10];
    //         POSTransInfocodeEntry: Record "LSC POS Trans. Infocode Entry";
    //         discountValue2: Decimal;
}

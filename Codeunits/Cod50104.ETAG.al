// codeunit 50104 ETAG
// {

//     procedure SyncItem(Rec: Record Item; ShowMessages: Boolean; Token: Text)
//     var
//         Funcs: Codeunit MazenESLIntegration;
//         PublicKey: Text;
//         APIResponse: Text[500];
//         APIResponse2: Text[500];
//         NewPrice: Decimal;
//         OldPrice: Decimal;
//         DiscountPerc: Decimal;
//         attrCategory: Text;
//         attrName: Text;
//         AP: Code[20];
//         SalesSetup: Record "Sales & Receivables Setup";
//         POSTransHeader: Record "LSC POS Transaction";
//         POSTransLine: Record "LSC POS Trans. Line";
//         HadeelUtil: Codeunit HadeelUtil;
//         POSTerminal: Record "LSC POS Terminal";
//         CurrencyExchangeRate: Record "Currency Exchange Rate";
//         GeneralLedgerSetup: Record "General Ledger Setup";
//         ETag: record ETag;
//         PosTransaction: record "LSC POS Transaction";
//         ETagTemplate: Record EtagTemplate;
//     begin
//         //PublicKey := Funcs.getPublicKey();
//         SalesSetup.get();
//         GeneralLedgerSetup.get();
//         if SalesSetup."Enable ETag" then begin
//             Etag.SetRange("Item No.", rec."No.");
//             if not ETag.FindFirst() then begin
//                 if GuiAllowed and ShowMessages then
//                     Message('No Etag for this item');
//                 exit;
//             end;
//             //////
//             // if (SalesSetup."Etag LBP Template" = '') or (SalesSetup."Etag USD Template" = '') then Error('Template Setup is missing in Sales & Receivables Setup');
//             /////////

//             POSTerminal.FindFirst();

//             HadeelUtil.GetPrice(POSTerminal."Store No.", Rec."No.", '', '', POSTerminal."No.", POSTransLine);

//             OldPrice := Round(CurrencyExchangeRate.POSExchangeLCYTOFCY(Today, GeneralLedgerSetup."Fresh Currency Code", POSTransLine."Org. Price Inc. VAT"), 0.01);
//             NewPrice := round(CurrencyExchangeRate.POSExchangeLCYTOFCY(Today, GeneralLedgerSetup."Fresh Currency Code", POSTransLine.Amount), 0.01);
//             DiscountPerc := round(POSTransLine."Discount %", 0.01);
//             if PosTransaction.get(POSTransLine."Receipt No.") then
//                 PosTransaction.Delete(True);
//             // if Rec."Currency Code" = '' then begin
//             //     attrCategory := SalesSetup."Etag LBP Template";
//             //     attrName := SalesSetup."Etag LBP Template";
//             // end
//             // else begin

//             ////////
//             // attrCategory := SalesSetup."Etag USD Template";
//             // attrName := SalesSetup."Etag USD Template";

//             //attrName := SalesSetup."Etag Category";

//             ///////////
//             // end;

//             if Token = '' then
//                 Token := getToken(ShowMessages);



//             repeat
//                 //attrName := '';
//                 if ETagTemplate.Get(ETag."Template Code") then begin
//                     attrCategory := ETagTemplate."Template Name";
//                     attrName := ETagTemplate."Serial Name";

//                 end;
//                 APIResponse := Funcs.updateEScLPrice(token, attrCategory, attrName, Format(OldPrice * 100, 0, '<Integer>'), Format(NewPrice * 100, 0, '<Integer>'), Rec."No.", Rec.Description, Format(DiscountPerc * 100, 0, '<Integer>'), ShowMessages);
//                 AP := SalesSetup."Etag MacAddress";
//                 APIResponse2 := Funcs.tagBinding(token, ETag."Item No.", ETag."No.", AP, ShowMessages);
//             until ETag.Next() = 0;



//             if GuiAllowed and ShowMessages then
//                 Message('Done!');
//         end;
//     end;


//     procedure getPublicKey() publickey: Text;

//     var
//         httprequest: HttpRequestMessage;
//         HtttpClient: HttpClient;
//         ResponseMessage: HttpResponseMessage;
//         contentHeaders: HttpHeaders;

//         JObject: JsonObject;
//         content: HttpContent;
//         URI: Text[100];
//         ContentType: Text[35];
//         textMessage: Text[1000];

//     begin
//         URI := 'http://esl-eu.zkong.com/zk/user/getErpPublicKey';
//         ContentType := 'application/json;charset=utf-8';

//         contentHeaders.Clear();
//         content.GetHeaders(contentHeaders);
//         contentHeaders.Remove('Content-Type');
//         contentHeaders.Add('Content-Type', ContentType);
//         content.GetHeaders(contentHeaders);
//         httprequest.GetHeaders(contentHeaders);

//         httprequest.Content(content);
//         httprequest.SetRequestUri(URI);
//         httprequest.Method := 'GET';

//         HtttpClient.Send(httprequest, ResponseMessage);
//         ResponseMessage.Content().ReadAs(publickey);

//     end;

//     procedure getToken(ShowMessages: Boolean) token: Text;
//     var
//         httprequest: HttpRequestMessage;
//         HtttpClient: HttpClient;
//         ResponseMessage: HttpResponseMessage;
//         contentHeaders: HttpHeaders;

//         JObject: JsonObject;
//         content: HttpContent;
//         TextBody: Text[1000];
//         URI: Text[100];
//         ContentType: Text[35];
//         textMessage: Text[1000];
//         regex: Codeunit Regex;
//         regexString: Text[100];
//         maches: Record Matches;
//         responseJson: JsonObject; //Text[300];
//         ResultJsonToken: JsonToken;
//         TokenValue: Text;
//         SalesSetup: Record "Sales & Receivables Setup";
//     begin
//         SalesSetup.get();

//         URI := 'http://esl-eu.zkong.com/zk/user/login';
//         ContentType := 'application/json;charset=utf-8';

//         JObject.Add('account', 'IOSAPI');
//         JObject.Add('loginType', 3);
//         //JObject.Add('password', 'Bd3+GL9OlNVxhAVJdwrp16wzCO87nDIxQdX31U+4zB3gy+L8JfKh2dHf8MIe6yV6WdK5gPBRWi+j2Ej3BS0WQjKnGwWO6oLMWfwoF8/xLS04dUfrZ8YLSQHn0koJZpYUoFQv5J7qNE05QZZZJQuIwwTwMPLHsu/tIA7G8YZp8hM=');
//         JObject.Add('password', SalesSetup."Etag Password");
//         JObject.WriteTo(TextBody);
//         content.WriteFrom(TextBody);

//         contentHeaders.Clear();
//         content.GetHeaders(contentHeaders);
//         contentHeaders.Remove('Content-Type');
//         contentHeaders.Add('Content-Type', ContentType);
//         content.GetHeaders(contentHeaders);
//         httprequest.GetHeaders(contentHeaders);

//         httprequest.Content(content);
//         httprequest.SetRequestUri(URI);
//         httprequest.Method := 'POST';

//         HtttpClient.Send(httprequest, ResponseMessage);
//         ResponseMessage.Content().ReadAs(token);

//         if not ResponseMessage.IsSuccessStatusCode() and ShowMessages then
//             Error('The web service returned an error message:\\' + 'Status code: ' + Format(ResponseMessage.HttpStatusCode()) + '\Description: ' + ResponseMessage.ReasonPhrase());

//         responseJson.ReadFrom(token);

//         responseJson.Get('data', ResultJsonToken);

//         ResultJsonToken.WriteTo(TokenValue);

//         responseJson.ReadFrom(TokenValue);//now responseJson contains "data" key only json object
//         responseJson.Get('token', ResultJsonToken);
//         ResultJsonToken.WriteTo(TokenValue);

//         token := Text.DelChr(TokenValue, '=', '"');

//         if GuiAllowed and ShowMessages then
//             Message('inside funcs - the token response is %1', token);

//     end;


//     procedure updateESLPrice(token: Text; attrCategory: Text[50]; attrName: Text[50]; OldPrice: Text; NewPrice: Text; barcode: Code[100]; prodDesc: Text[100]; DiscountPerc: Text; ShowMessages: Boolean) returnText: Text;
//     var
//         httprequest: HttpRequestMessage;
//         HtttpClient: HttpClient;
//         ResponseMessage: HttpResponseMessage;
//         contentHeaders: HttpHeaders;

//         JObject: JsonObject;
//         itemList: JsonArray;
//         itemJobject: JsonObject;
//         content: HttpContent;
//         TextBody: Text[1000];
//         URI: Text[100];
//         ContentType: Text[50];
//         textMessage: Text[1000];
//         SalesSetup: Record "Sales & Receivables Setup";
//     begin
//         SalesSetup.get();

//         ContentType := 'application/json;charset=utf-8';
//         URI := 'http://esl-eu.zkong.com/zk/item/batchImportItem';

//         // JObject.Add('storeId', '1700810935705');
//         // JObject.Add('merchantId', '1695626271707');
//         // JObject.Add('agencyId', '1558577702698');

//         JObject.Add('storeId', SalesSetup."Etag StoreId");
//         JObject.Add('merchantId', SalesSetup."Etag MerchantId");
//         JObject.Add('agencyId', SalesSetup."Etag AgencyId");

//         Clear(itemJobject);
//         itemJobject.add('attrCategory', attrCategory);
//         itemJobject.add('attrName', attrName);
//         itemJobject.add('barCode', barcode);
//         itemJobject.add('productCode', barcode);
//         itemJobject.add('itemTitle', prodDesc);
//         itemJobject.add('price', NewPrice);
//         itemJobject.add('originalPrice', OldPrice);
//         itemJobject.add('memberPrice', DiscountPerc);
//         itemList.Add(itemJobject);


//         JObject.Add('itemList', itemList);
//         //textMessage := '{"storeId": "1700810935705","merchantId": "1695626271707","agencyId": "1558577702698","itemList": {"attrCategory": "default","attrName": "default","barCode": "1896-S","itemTitle": "ATHENS Desk","price": 1800}}';
//         JObject.WriteTo(textMessage);
//         //JObject.ReadFrom(textMessage);

//         JObject.WriteTo(TextBody);
//         content.WriteFrom(TextBody);

//         contentHeaders.Clear();
//         content.GetHeaders(contentHeaders);
//         //contentHeaders.Remove('Authorization');
//         //contentHeaders.Add('Authorization', token);
//         HtttpClient.DefaultRequestHeaders().Add('Authorization', token);
//         contentHeaders.Remove('Content-Type');
//         contentHeaders.Add('Content-Type', ContentType);
//         content.GetHeaders(contentHeaders);

//         httprequest.GetHeaders(contentHeaders);

//         httprequest.Content(content);//:= content;
//         httprequest.SetRequestUri(URI);
//         httprequest.Method := 'POST';

//         HtttpClient.Send(httprequest, ResponseMessage);
//         ResponseMessage.Content().ReadAs(returnText);
//         if GuiAllowed and ShowMessages then
//             Message('nested json is %1\%2', textMessage, returnText);
//     end;

//     procedure tagBinding(token: Text; barcode: Text[20]; tagBarcode: Code[20]; AP: Code[20]; ShowMessages: Boolean) returnText: Text;
//     var
//         storeID: Integer;

//         httprequest: HttpRequestMessage;
//         HtttpClient: HttpClient;
//         ResponseMessage: HttpResponseMessage;
//         contentHeaders: HttpHeaders;
//         JObject: JsonObject;
//         itemList: JsonArray;
//         itemJobject: JsonObject;
//         content: HttpContent;
//         TextBody: Text[1000];
//         URI: Text[100];
//         ContentType: Text[50];
//         SalesSetup: Record "Sales & Receivables Setup";
//         ESLIntegrationLog: Record "ESL Integration Log";
//     begin
//         SalesSetup.get();

//         ContentType := 'application/json;charset=utf-8';
//         URI := 'http://esl-eu.zkong.com/zk/bind/bindItemPriceTag/1';

//         JObject.Add('itemBarCode', barcode);
//         JObject.Add('priceTagCode', tagBarcode);
//         JObject.Add('storeId', SalesSetup."Etag StoreId");
//         JObject.Add('apMac', AP);

//         JObject.WriteTo(TextBody);
//         content.WriteFrom(TextBody);

//         if GuiAllowed and ShowMessages then
//             Message('the binding request body: %1', TextBody);

//         contentHeaders.Clear();
//         content.GetHeaders(contentHeaders);
//         //contentHeaders.Remove('Authorization');
//         //contentHeaders.Add('Authorization', token);
//         HtttpClient.DefaultRequestHeaders().Add('Authorization', token);
//         contentHeaders.Remove('Content-Type');
//         contentHeaders.Add('Content-Type', ContentType);
//         content.GetHeaders(contentHeaders);

//         httprequest.GetHeaders(contentHeaders);

//         httprequest.Content(content);
//         httprequest.SetRequestUri(URI);
//         httprequest.Method := 'POST';

//         HtttpClient.Send(httprequest, ResponseMessage);
//         ResponseMessage.Content().ReadAs(returnText);
//         if GuiAllowed and ShowMessages then
//             Message('binding API response: \%1', returnText);

//         ESLIntegrationLog.Reset();
//         ESLIntegrationLog.Date := Today();
//         ESLIntegrationLog."Etag No." := tagBarcode;
//         ESLIntegrationLog."Item No." := barcode;
//         ESLIntegrationLog.Message := returnText;
//         ESLIntegrationLog.Insert();


//     end;

// }


codeunit 50102 API
{
    procedure CallAPI_Token(): Text
    var
        URL: Text;
        Client: HttpClient;//to POST or Get

        Content: HttpContent;//Contenttype Header And Body
        RequestMessage: HttpRequestMessage;//Request Headers And Content
        ContentHeaders: HttpHeaders;//Request Header ( Content-Type auth )
        ResponseString: Text;
        RequestBody: Text;
        ResponseMessage: HttpResponseMessage; //API Response
        API_links: Record API_LINKS;
    begin

        //API_links.Get();
        // URL := API_links.login;
        URL := 'https://reqres.in/api/login';

        // if Client.send is Used
        // RequestMessage.SetRequestUri(URL);
        //  RequestMessage.Method('POST');


        RequestBody := '{"email": "eve.holt@reqres.in","password": "cityslicka"}';
        Content.WriteFrom(RequestBody);

        Content.GetHeaders(ContentHeaders);
        if ContentHeaders.Contains('Content-Type') then
            ContentHeaders.Remove('Content-Type');

        ContentHeaders.Add('Content-Type', 'Application/json');

        // if Client.send is Used
        // RequestMessage.Content(Content); 
        // if not Client.Send(RequestMessage, ResponseMessage) then
        //     Error('The call to the web service failed.');
        If not Client.Post(URL, Content, ResponseMessage) then
            Error('The call to the web service failed.');
        if not ResponseMessage.IsSuccessStatusCode() then
            Error('The web service returned an error message:\\'
            +
            'Status code: '
            + Format(ResponseMessage.HttpStatusCode())
            +
            '\Description: '
            + ResponseMessage.ReasonPhrase());


        ResponseMessage.Content.ReadAs(ResponseString);

        exit(ResponseString);
    end;

    procedure ReadAPI_Token(): Text
    var
        ResonseBearerToken: Text;
        JsonObject: JsonObject;
        BearerJSONToken: JsonToken;
        BearerToken: Text;

    begin
        ResonseBearerToken := CallAPI_Token();
        Message(ResonseBearerToken);

        If JsonObject.ReadFrom(ResonseBearerToken) then begin
            JsonObject.Get('token', BearerJSONToken);
            BearerToken := BearerJSONToken.AsValue().AsText();
            exit(BearerToken);
        end;
    end;

    procedure Call_Users(): Text
    var
        URL: Text;
        Client: HttpClient;//to POST or Get
        Content: HttpContent;//Contenttype Header And Body
        RequestMessage: HttpRequestMessage;//Request Headers And Content
        RquestHeaders: HttpHeaders;
        ContentHeaders: HttpHeaders;//Content's Header ( Content-Type)
        ResponseString: Text;
        RequestBody: Text;
        ResponseMessage: HttpResponseMessage; //API Response
        bearerToken: text;
        API_links: Record API_LINKS;
    begin
        bearerToken := ReadAPI_Token();
        //API_links.Get();
        //URL := API_links.Users;
        URL := 'https://reqres.in/api/users';

        RequestMessage.SetRequestUri(URL);
        RequestMessage.Method('GET');

        RequestMessage.GetHeaders(RquestHeaders);
        RquestHeaders.Add('Authorization', 'bearer ' + bearerToken);

        Content.GetHeaders(ContentHeaders);
        if ContentHeaders.Contains('Content-Type') then
            ContentHeaders.Remove('Content-Type');

        ContentHeaders.Add('Content-Type', 'Application/json');
        RequestMessage.Content(Content);
        if not Client.Send(RequestMessage, ResponseMessage) then
            Error('The call to the web service failed.');

        if not ResponseMessage.IsSuccessStatusCode() then
            Error('The web service returned an error message:\\'
            +
            'Status code: '
            + Format(ResponseMessage.HttpStatusCode())
            +
            '\Description: '
            + ResponseMessage.ReasonPhrase());


        ResponseMessage.Content.ReadAs(ResponseString);
        Message(ResponseString);
        exit(ResponseString)
    end;

    procedure ReadUsers()
    var
        USers: text;

        UsersObject: JsonObject;
        pageToken: JsonToken;
        page: Integer;
        DataToken: JsonToken;
        dataArray: JsonArray;
        dataObject: JsonObject;

        firstnameToken: JsonToken;
        firstname: text;
        count: Integer;
    begin
        count := 0;
        USers := Call_Users();
        If UsersObject.ReadFrom(USers) then begin
            UsersObject.Get('page', PageToken);
            page := pageToken.AsValue().AsInteger();
            Message('Page :' + Format(page));
            UsersObject.Get('data', DataToken);
            dataArray := DataToken.AsArray();
            foreach DataToken in dataArray do begin
                count += 1;
                dataObject := DataToken.AsObject();
                dataObject.Get('first_name', firstnameToken);
                firstname := firstnameToken.AsValue().AsText();
                Message(StrSubstNo('Element %1 Firstname: %2 ', count, firstname));
            end;
        end;
    end;



}

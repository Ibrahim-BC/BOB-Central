codeunit 50100 RandomAhh
{
    ///////////  | PROGRESS BAR Ahh 
    procedure ProgressBar(Counter: Integer; MAxValue: Integer): Text
    var
        Percentage: Integer;
    begin
        if MAxValue = 0 then
            Percentage := 0
        else
            Percentage := Round(Counter / MAxValue * 100, 1);
        exit(ProgressBar(Percentage));
    end;

    procedure ProgressBar(Percentage: Decimal) ReturnValue: Text
    var
        i: Integer;
        fillcount: Integer;
        ProgressBarTxt: Label '%1%2%3', Comment = '%1 = First Half of Progress Bar; %2 Percentage Text; %3 Second Half of Progress Bar ';
    begin
        FillCount := round(Percentage / 2.777777778, 1);
        ReturnValue := PadStr('', fillcount, '█');
        ReturnValue := PadStr(ReturnValue, 36, '▒');

        ReturnValue := StrSubstNo(ProgressBarTxt, CopyStr(ReturnValue, 1, 18), Format(Percentage, 4, '<Integer>') + '% ', CopyStr(ReturnValue, 19, 18));

        // for i := 1 to FillCount do
        //     ReturnValue += '🖕🏻';
        // for i := FillCOunt to 50 do
        //     ReturnValue += '✊🏻';

        // ReturnValue := StrSubstNo(ProgressBarTxt, CopyStr(ReturnValue, 1, 50), Format(Percentage, 4, '<Integer>') + '% ', CopyStr(ReturnValue, 51, 100));
    end;

    procedure OpenWindow(DialogString: text; ShowEstimatedEndTime: Boolean)
    var
        WindowString: Text;
        ProgressBarPlaceHolderTxt: Label '#20###############################################', Comment = '%20 = Progress Bar Text', Locked = true;
        itemprogressText: label '\\Item: #30#################################################';
        TotalitemprogressText: label '\\Total Items: #31#################################################';
        ElapsedTimeTxt: Label '\\Elapsed time :.................. #21#############', Comment = '%21 = Elapsed Time';
        EstimatedTimeLeftTxt: Label '\Estimated time left :...... #22#############', Comment = '%22 = Estimated time left';
        EstimatedEndTimeTxt: label '\Estimated end time :..... #23#############', Comment = '%23 = Calculated End Time';
    begin
        if not IsGuiAllowed() then
            exit;

        StartTime := 0DT;
        WindowString := DialogString;
        if WindowString = '' then
            WindowString := ProgressBarPlaceHolderTxt
        else
            WindowString := WindowString + '\\' + ProgressBarPlaceHolderTxt + itemprogressText + TotalitemprogressText;

        if ShowEstimatedEndTime then begin
            WindowString := WindowString + ElapsedTimeTxt + EstimatedTimeLeftTxt + EstimatedEndTimeTxt;
            StartTime := CurrentDateTime;
        end;

        Window.open(WindowString);
        LastUpdate := CreateDateTime(19000101D, 100000T);
    end;

    procedure UpdateWindow(Counter: Integer; NoOfRecords: Integer);
    var
        //ProgressBar: Codeunit "Progress Bar TBHLG";
        EndTime: DateTime;
        CurrDuration: Duration;
        EstimatedDuration: Duration;

    begin
        if CurrentDateTime < LastUpdate + 1000 then
            exit;

        if Counter = 0 then
            exit;

        Window.Update(20, ProgressBar(Counter, NoOfRecords));
        Window.Update(30, Counter);
        Window.Update(31, NoOfRecords);
        LastUpdate := CurrentDateTime;

        if StartTime = 0DT then
            exit;

        CurrDuration := CurrentDateTime - StartTime;
        EstimatedDuration := ROUND((CurrentDateTime - StartTime) * 100 / (Counter / NoOfRecords * 100), 100);
        EndTime := StartTime + EstimatedDuration;
        Window.Update(21, FormatDuration(CurrDuration));

        IF CurrDuration <= 2000 then
            exit;

        Window.Update(22, FormatDuration(EstimatedDuration - CurrDuration));
        Window.Update(23, Format(EndTime, 0, '<Hours24>:<Minutes,2>:<Seconds,2>'));

    end;

    procedure UpdateWindow(DialogFieldNo: Integer; DialogValue: Text);
    begin
        if not IsGuiAllowed() then
            exit;

        Window.Update(DialogFieldNo, DialogValue);
    end;

    procedure UpdateWindow(DialogFieldNo: Integer; DialogValue: Text; Counter: Integer; NoOfRecords: Integer);
    begin
        if not IsGuiAllowed() then
            exit;

        UpdateWindow(DialogFieldNo, DialogValue);
        UpdateWindow(Counter, NoOfRecords);
    end;

    local procedure FormatDuration(NewDuration: Duration): Text;
    var
        Minutes: Integer;
        Seconds: Integer;
        MinuteAndSecondsTxt: Label '%1 Minutes, %2 Seconds', Comment = '%1 = Minutes passed ; %2 = Seconds Passed';
        SecondsTxt: Label '%1 Seconds', Comment = '%1 = Seconds Passed';
    begin
        NewDuration := Round(NewDuration / 1000, 1);
        Minutes := Round(NewDuration / 60, 1, '<');
        Seconds := NewDuration - (Minutes * 60);
        IF Minutes > 0 then
            exit(StrSubstNo(MinuteAndSecondsTxt, Minutes, Seconds))
        ELSE
            exit(StrSubstNo(SecondsTxt, Seconds));
    END;

    local procedure IsGuiAllowed() GuiIsAllowed: Boolean
    var
        Handled: Boolean;
    begin
        OnBeforeGuiAllowed(GuiIsAllowed, Handled);
        if Handled then
            exit;
        exit(GuiAllowed());
    end;

    /// <summary>
    /// Raises an event to be able to change the return of IsGuiAllowed function. Used for testing.
    /// </summary>
    [InternalEvent(false)]
    procedure OnBeforeGuiAllowed(var Result: Boolean; var Handled: Boolean)
    begin
    end;
    ///////////   PROGRESS BAR Ahh |  


    procedure ClosestDate(Item: Record Item): Date
    var
        PriceListHeader: Record "Price List Header";
        Pricelistline: Record "Price List Line";
        RefDate: Date;
        biggerDate: Date;
        lowerdate: Date;

        lowerref: Integer;
        biggerref: Integer;
    begin
        RefDate := 20240622D;

        Pricelistline.Reset();
        Pricelistline.SetRange("Product No.", Item."No.");
        Pricelistline.SetFilter("Starting Date", '<=%1', RefDate);


        if Pricelistline.FindFirst() then begin
            Message(format(Pricelistline."Starting Date"));
            lowerdate := Pricelistline."Starting Date";
        end;
        Pricelistline.SetFilter("Starting Date", '>=%1', RefDate);
        Pricelistline.SetCurrentKey("Starting Date");
        Pricelistline.SetAscending("Starting Date", true);
        if Pricelistline.FindFirst() then begin
            Message(format(Pricelistline."Starting Date"));
            biggerDate := Pricelistline."Starting Date";
        end;
        lowerref := RefDate - lowerdate;
        Message(Format(lowerref));
        biggerref := biggerDate - RefDate;
        Message(Format(biggerref));

        if biggerref < lowerref then
            RefDate := biggerDate
        else
            RefDate := lowerdate;

        Message(StrSubstNo('Date is %1', Format(RefDate)));
        exit(RefDate);
    end;

    procedure ClosestDate2(Item: Record Item): Date
    var
        PriceListHeader: Record "Price List Header";
        Pricelistline: Record "Price List Line";
        RefDate: Date;
        biggerDate: Date;
        lowerdate: Date;

        lowerref: Integer;
        biggerref: Integer;
    begin
        RefDate := 20240517D;

        Pricelistline.Reset();
        Pricelistline.SetRange("Product No.", Item."No.");
        Pricelistline.SetFilter("Starting Date", '<=%1', RefDate);
        PriceListLine.SetFilter("Ending Date", '>%1|%2', RefDate, 0D);
        if PriceListLine.FindLast() then
            message(Format(Pricelistline.SystemRowVersion));
        if PriceListLine.FindFirst() then
            message(Format(Pricelistline.SystemRowVersion));
    end;


    var
        LastUpdate: DateTime;
        StartTime: DateTime;
        Window: Dialog;
}
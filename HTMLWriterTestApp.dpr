program HTMLWriterTestApp;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uHTMLWriter in 'uHTMLWriter.pas';

var
  TempHTML: string;
  Temp: THTMLWriter;
begin
  try
     Temp := THTMLWriter.CreateDocument;//('html', chaCanHaveAttributes);
     TempHTML := Temp
                  .AddHead
                    .AddAttribute('dweezle')
                    .AddText('farble')
                  .CloseTag
                  .OpenBody
                  .AddAttribute('ding')
                    .OpenSpan
                      .AddAttribute('this', 'that')
                      .AddStyle('font: italic')
                      .OpenDiv
                        .AddAttribute('floo')
                        .AddText('Blah')
                      .CloseTag
                    .CloseTag
                    .AddText('Hoorah')
                    .AddBoldText(' Shadooby')
                    .OpenBold
                      .AddText('Goombah')
                    .CloseTag
                  .CloseTag
                  .CloseTag
                  .CloseTag
              .AsHTML;
     WriteLn(TempHTML);
     ReadLn;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

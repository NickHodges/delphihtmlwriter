program HTMLWriterTestApp;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uHTMLWriter in 'uHTMLWriter.pas',
  IHTML4 in 'C:\Users\nhodges.GATEWAY\Desktop\di199906kw\code2\IHTML4.pas',
  PasParser in 'C:\Users\nhodges.GATEWAY\Desktop\di199906kw\code2\PasParser.pas';

var
  TempHTML: string;
  Temp: THTMLWriter;
begin
  try
     Temp := THTMLWriter.CreateDocument;//('html', chaCanHaveAttributes);
     TempHTML := Temp
                  .AddHead
                    .AddAttribute('dweezle')
                    .AddRawText('farble')
                  .CloseTag
                  .OpenBody
                  .AddAttribute('ding')
                    .OpenSpan
                      .AddAttribute('this', 'that')
                      .AddStyle('font: italic')
                      .OpenDiv
                        .AddAttribute('floo')
                        .AddRawText('Blah')
                      .CloseTag
                    .CloseTag
                    .AddRawText('Hoorah')
                    .AddBoldText(' Shadooby')
                    .OpenBold
                      .AddRawText('Goombah')
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

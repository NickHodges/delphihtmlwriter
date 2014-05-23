program HTMLWriterTestApp_XE6;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  HTMLWriterIntf,
  uHTMLWriter in 'uHTMLWriter.pas';

var
  TempHTML: string;
  Temp: IHTMLWriter;
begin
  try
     Temp := HTMLWriterCreateDocument;
     TempHTML := Temp
                  .OpenHead
                    .AddAttribute('dweezle')
                    .AddText('farble')
                  .CloseTag
                  .OpenBody.AddAttribute('ding')
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
              .AsHTML;
     WriteLn(TempHTML);
     ReadLn;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

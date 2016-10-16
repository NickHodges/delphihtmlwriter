program HTMLWriterTestAppTests;

{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  TestInsight.Client,
  TestInsight.Dunit,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  TestuHTMLWriter in 'TestuHTMLWriter.pas',
  uHTMLWriter in '..\uHTMLWriter.pas',
  HTMLWriterUtils in '..\HTMLWriterUtils.pas',
  HTMLWriterIntf in '..\HTMLWriterIntf.pas',
  LoadSaveIntf in '..\LoadSaveIntf.pas',
  FinalBuilder.XMLTestRunner in '..\FinalBuilder.XMLTestRunner.pas',
  XMLTestRunner2 in 'XMLTestRunner2.pas';

{$R *.RES}

function IsTestInsightRunning: Boolean;
var
  client: ITestInsightClient;
begin
  client := TTestInsightRestClient.Create;
  client.StartedTesting(0);
  Result := not client.HasError;
end;

begin
  Application.Initialize;
  if IsTestInsightRunning then
  begin
    TestInsight.DUnit.RunRegisteredTests
  end else
  begin
    if IsConsole then
    {$IFDEF USEXML}
      XMLTestRunner.RunRegisteredTests('HTMLWriterTestAppTests.xml').Free
    {$ELSE}
      TextTestRunner.RunRegisteredTests(rxbHaltOnFailures).Free
    {$ENDIF}
    else
      GUITestRunner.RunRegisteredTests;
  end;
end.



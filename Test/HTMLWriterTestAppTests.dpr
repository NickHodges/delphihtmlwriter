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
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  TestuHTMLWriter in 'TestuHTMLWriter.pas',
  uHTMLWriter in '..\uHTMLWriter.pas',
  HTMLWriterUtils in '..\HTMLWriterUtils.pas';

{$R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    TextTestRunner.RunRegisteredTests(rxbHaltOnFailures).Free
//    XMLTestRunner.RunRegisteredTests('HTMLWriterTestAppTests.xml').Free
  else
    GUITestRunner.RunRegisteredTests;
end.


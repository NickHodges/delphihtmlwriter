unit TestuHTMLWriter;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework, SysUtils, uHTMLWriter, HTMLWriterUtils;

type
  // Test methods for class THTMLWriter

  TestTHTMLWriter = class(TTestCase)
  strict private
    FHTMLWriter: THTMLWriter;
    function HTMLWriterFactory(aTagName: string): THTMLWriter;
    function HTML(aString: string): string;
  private

  public
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure TestAddLineBreak;
    procedure TestAddSpanTextWithStyle;
    procedure TestAddDivTextWithStyle;
    procedure TestAddSpanTextWithID;
    procedure TestAddDivTextWithID;
    procedure TestCloseComment;
    procedure TestOpenComment;
    procedure TestAddMetaNamedContent;
    procedure TestAddComment;
    procedure TestAsHTML;
    procedure TestAddText;
    procedure TestAddHead;
    procedure TestOpenBody;
    procedure TestOpenMeta;
    procedure TestOpenParagraph;
    procedure TestOpenParagraphWithStyle;
    procedure TestOpenParagraphWithID;
    procedure TestAddParagraphTextWithStyle;
    procedure TestAddParagraphTextWithID;
    procedure TestOpenSpan;
    procedure TestOpenDiv;
    procedure TestOpenBlockQuote;
    procedure TestAddParagraphText;
    procedure TestAddSpanText;
    procedure TestAddDivText;
    procedure TestAddBlockQuoteText;
    procedure TestOpenBold;
    procedure TestOpenItalic;
    procedure TestOpenUnderline;
    procedure TestOpenEmphasis;
    procedure TestOpenStrong;
    procedure TestOpenPre;
    procedure TestOpenCite;
    procedure TestAddBoldText;
    procedure TestAddItalicText;
    procedure TestAddUnderlinedText;
    procedure TestAddEmphasisText;
    procedure TestAddStrongText;
    procedure TestAddPreformattedText;
    procedure TestAddCitationText;
    procedure TestOpenHeading1;
    procedure TestOpenHeading2;
    procedure TestOpenHeading3;
    procedure TestOpenHeading4;
    procedure TestOpenHeading5;
    procedure TestOpenHeading6;
    procedure TestAddHeading1Text;
    procedure TestAddHeading2Text;
    procedure TestAddHeading3Text;
    procedure TestAddHeading4Text;
    procedure TestAddHeading5Text;
    procedure TestAddHeading6Text;
    procedure TestAddStyle;
    procedure TestAddClass;
    procedure TestAddID;
    procedure TestAddAttribute;
    procedure TestCloseTag;
  end;
  // Test methods for class IGetHTML

  TestIGetHTML = class(TTestCase)
  strict private
    FIGetHTML: IGetHTML;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAsHTML;
  end;

implementation

procedure TestTHTMLWriter.SetUp;
begin
  FHTMLWriter := nil;
end;

procedure TestTHTMLWriter.TearDown;
begin

end;

procedure TestTHTMLWriter.TestAsHTML;
begin
  // This gets tested so much below, and it is so simple, that we don't
  // really need much testing here....

  CheckEquals('<html></html>', HTMLWriterFactory('html').CloseTag.AsHTML);
end;

procedure TestTHTMLWriter.TestAddText;
var
  aString: string;
  ExpectedValue: string;
  Result: string;
begin
  aString := 'this';
  ExpectedValue := HTML(aString); // '<html>this</html>';
  FHTMLWriter := HTMLWriterFactory('html');
  FHTMLWriter.AddText(aString);
  Result := FHTMLWriter.CloseTag.AsHTML;
  CheckEquals(ExpectedValue, Result);

  // arbitrary tags
  aString := 'this';
  ExpectedValue := Format('<%s>%s</%s>', [aString, aString, aString]);
  FHTMLWriter := HTMLWriterFactory('this');
  FHTMLWriter.AddText(aString);
  Result := FHTMLWriter.CloseTag.AsHTML;
  CheckEquals(ExpectedValue, Result);

  // try adding text with brackets in it
  aString := '<groob>';
  ExpectedValue := HTML(aString);
  FHTMLWriter := HTMLWriterFactory('html');
  FHTMLWriter.AddText(aString);
  Result := FHTMLWriter.CloseTag.AsHTML;
  CheckEquals(ExpectedValue, Result);

end;

procedure TestTHTMLWriter.TestAddHead;
var
  ExpectedValue: string;
  TestResult: string;
begin
  FHTMLWriter := HTMLWriterFactory('html');
  ExpectedValue := HTML('<head></head>');
  // Multiple close tags should be fine
  TestResult := FHTMLWriter.AddHead.CloseTag.CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedValue, TestResult);
end;

procedure TestTHTMLWriter.TestOpenBody;
var
  TestResult: string;
  ExpectedResult: string;
begin
  TestResult := HTMLWriterFactory('html').OpenBody.AsHTML;
  ExpectedResult := '<html><body';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenBody.CloseTag.AsHTML;
  ExpectedResult := '<html><body></body>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenBody.CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><body></body></html>';
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestOpenParagraph;
var
  TestResult: string;
  ExpectedResult: string;
begin
  TestResult := HTMLWriterFactory('html').OpenParagraph.AsHTML;
  ExpectedResult := '<html><p';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenParagraph.CloseTag.AsHTML;
  ExpectedResult := '<html><p></p>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenParagraph.CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><p></p></html>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenParagraph.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><p>blah</p></html>';
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestOpenParagraphWithID;
var
  TestResult: string;
  ExpectedResult: string;
  TempStyle: string;
begin
  TempStyle := 'nerster: hormle';
  ExpectedResult := HTML(Format('<p id="%s"></p>', [TempStyle]));
  TestResult := HTMLWriterFactory('html').OpenParagraphWithID(TempStyle).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestOpenParagraphWithStyle;
var
  TestResult: string;
  ExpectedResult: string;
  TempStyle: string;
begin
  TempStyle := 'nerster: hormle';
  ExpectedResult := HTML(Format('<p style="%s"></p>', [TempStyle]));
  TestResult := HTMLWriterFactory('html').OpenParagraphWithStyle(TempStyle).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddParagraphTextWithStyle;
var
  TestResult: string;
  ExpectedResult: string;
  TempStyle: string;
  TempText: string;
begin
  TempStyle := 'nerster: hormle';
  TempText := 'jimkast';
  ExpectedResult := HTML(Format('<p style="%s">%s</p>', [TempStyle, TempText]));
  TestResult := HTMLWriterFactory('html').AddParagraphTextWithStyle(TempText, TempStyle).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddParagraphTextWithID;
var
  TestResult: string;
  ExpectedResult: string;
  TempStyle: string;
  TempText: string;
begin
  TempStyle := 'nerster: hormle';
  TempText := 'jimkast';
  ExpectedResult := HTML(Format('<p id="%s">%s</p>', [TempStyle, TempText]));
  TestResult := HTMLWriterFactory('html').AddParagraphTextwithID(TempText, TempStyle).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestOpenSpan;
var
  TestResult: string;
  ExpectedResult: string;
begin
  TestResult := HTMLWriterFactory('html').OpenSpan.AsHTML;
  ExpectedResult := '<html><span';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenSpan.CloseTag.AsHTML;
  ExpectedResult := '<html><span></span>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenSpan.CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><span></span></html>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenSpan.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><span>blah</span></html>';
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestOpenDiv;
var
  TestResult: string;
  ExpectedResult: string;
begin
  TestResult := HTMLWriterFactory('html').OpenDiv.AsHTML;
  ExpectedResult := '<html><div';
  // TODO: Validate method results
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenDiv.CloseTag.AsHTML;
  ExpectedResult := '<html><div></div>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenDiv.CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><div></div></html>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenDiv.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><div>blah</div></html>';
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestOpenBlockQuote;
var
  TestResult: string;
  ExpectedResult: string;
begin
  TestResult := HTMLWriterFactory('html').OpenBlockQuote.AsHTML;
  ExpectedResult := '<html><blockquote';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenBlockQuote.CloseTag.AsHTML;
  ExpectedResult := '<html><blockquote></blockquote>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenBlockQuote.CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><blockquote></blockquote></html>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenBlockQuote.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><blockquote>blah</blockquote></html>';
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestAddParagraphText;
var
  TestResult, ExpectedResult: string;
  TempString: string;
begin
  TempString := 'grundle';

  ExpectedResult := '<html><p>' + TempString + '</p>';
  TestResult := HTMLWriterFactory('html').AddParagraphText(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML('<p>' + TempString + '</p>');
  TestResult := HTMLWriterFactory('html').AddParagraphText(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestAddSpanText;
var
  TestResult, ExpectedResult: string;
  TempString: string;
begin
  TempString := 'grundle';

  ExpectedResult := '<html><span>' + TempString + '</span>';
  TestResult := HTMLWriterFactory('html').AddSpanText(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML('<span>' + TempString + '</span>');
  TestResult := HTMLWriterFactory('html').AddSpanText(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddDivText;
var
  TestResult, ExpectedResult: string;
  TempString: string;
begin
  TempString := 'grundle';

  ExpectedResult := '<html><div>' + TempString + '</div>';
  TestResult := HTMLWriterFactory('html').AddDivText(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML('<div>' + TempString + '</div>');
  TestResult := HTMLWriterFactory('html').AddDivText(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddDivTextWithID;
var
  TempID: string;
  TempString: string;
  TestResult: string;
  ExpectedResult: string;
begin
  TempString := 'flooble';
  TempID := 'main';
  ExpectedResult := HTML(Format('<div id="%s">%s</div>', [TempID, TempString]));
  TestResult := HTMLWriterFactory(cHTML).AddDivTextWithID(TempString, TempID).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddDivTextWithStyle;
var
  TempStyle: string;
  TempString: string;
  TestResult: string;
  ExpectedResult: string;
begin
  TempString := 'flooble';
  TempStyle := 'border-top:1px solid #c9d7f1;font-size:1px';
  ExpectedResult := HTML(Format('<div style="%s">%s</div>', [TempStyle, TempString]));
  TestResult := HTMLWriterFactory(cHTML).AddDivTextWithStyle(TempString, TempStyle).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestOpenBold;
var
  TestResult: string;
  ExpectedResult: string;
begin
  TestResult := HTMLWriterFactory('html').OpenBold.AsHTML;
  ExpectedResult := '<html><b';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenBold.CloseTag.AsHTML;
  ExpectedResult := '<html><b></b>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenBold.CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><b></b></html>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenBold.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><b>blah</b></html>';
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestOpenEmphasis;
var
  TestResult: string;
  ExpectedResult: string;
begin
  TestResult := HTMLWriterFactory('html').OpenEmphasis.AsHTML;
  ExpectedResult := '<html><em';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenEmphasis.CloseTag.AsHTML;
  ExpectedResult := '<html><em></em>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenEmphasis.CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><em></em></html>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenEmphasis.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><em>blah</em></html>';
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestOpenStrong;
var
  TestResult: string;
  ExpectedResult: string;
begin
  TestResult := HTMLWriterFactory('html').OpenStrong.AsHTML;
  ExpectedResult := '<html><strong';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenStrong.CloseTag.AsHTML;
  ExpectedResult := '<html><strong></strong>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenStrong.CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><strong></strong></html>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenStrong.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><strong>blah</strong></html>';
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestOpenPre;
var
  TestResult: string;
  ExpectedResult: string;
begin
  TestResult := HTMLWriterFactory('html').OpenPre.AsHTML;
  ExpectedResult := '<html><pre';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenPre.CloseTag.AsHTML;
  ExpectedResult := '<html><pre></pre>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenPre.CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><pre></pre></html>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenPre.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><pre>blah</pre></html>';
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestOpenCite;
var
  TestResult: string;
  ExpectedResult: string;
begin
  TestResult := HTMLWriterFactory('html').OpenCite.AsHTML;
  ExpectedResult := '<html><cite';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenCite.CloseTag.AsHTML;
  ExpectedResult := '<html><cite></cite>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenCite.CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><cite></cite></html>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenCite.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><cite>blah</cite></html>';
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestOpenComment;
var
  TestResult: string;
  TempString: string;
  ExpectedResult: string;
begin
  TempString := 'wertybin';
  ExpectedResult := HTML(Format('<!-- %s -->', [TempString]));
  TestResult := HTMLWriterFactory(cHTML).OpenComment.AddText(TempString).CloseComment.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestCloseComment;
var
  TestResult: string;
  TempString: string;
  ExpectedResult: string;
begin
  TempString := 'gloppet';
  ExpectedResult := HTML(Format('<span><!-- %s --></span>', [TempString]));
  TestResult := HTMLWriterFactory(cHTML).OpenSpan.OpenComment.AddText(TempString).CloseComment.CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddComment;
var
  TestResult: string;
  TempString: string;
  ExpectedResult: string;
begin
  TempString := 'gropter';
  ExpectedResult := HTML(Format('<!-- %s -->', [TempString]));
  TestResult := HTMLWriterFactory(cHTML).AddComment(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestOpenItalic;
var
  TestResult: string;
  ExpectedResult: string;
begin
  TestResult := HTMLWriterFactory('html').OpenItalic.AsHTML;
  ExpectedResult := '<html><i';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenItalic.CloseTag.AsHTML;
  ExpectedResult := '<html><i></i>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenItalic.CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><i></i></html>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenItalic.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><i>blah</i></html>';
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestOpenMeta;
var
  TestResult: string;
  ExpectedResult: string;
begin
  ExpectedResult := '<html><head><meta /></head></html>';
  TestResult := HTMLWriterFactory(cHTML).AddHead.OpenMeta.CloseTag.CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  { TODO -oNick : Need to test that an exception gets raised if OpenMeta is called outside a <head> tag. }

end;

procedure TestTHTMLWriter.TestOpenUnderline;
var
  TestResult: string;
  ExpectedResult: string;
begin
  TestResult := HTMLWriterFactory('html').OpenUnderline.AsHTML;
  ExpectedResult := '<html><u';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenUnderline.CloseTag.AsHTML;
  ExpectedResult := '<html><u></u>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenUnderline.CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><u></u></html>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenUnderline.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><u>blah</u></html>';
  CheckEquals(ExpectedResult, TestResult);

end;

function TestTHTMLWriter.HTML(aString: string): string;
begin
  Result := Format('<html>%s</html>', [aString]);
end;

function TestTHTMLWriter.HTMLWriterFactory(aTagName: string): THTMLWriter;
begin
  if FHTMLWriter <> nil then
  begin
    FHTMLWriter.Free;
    FHTMLWriter := nil;
  end;
  Result := THTMLWriter.Create(aTagName);
end;

procedure TestTHTMLWriter.TestAddBlockQuoteText;
var
  TestResult, ExpectedResult: string;
  TempString: string;
begin
  TempString := 'grundle';

  ExpectedResult := '<html><blockquote>' + TempString + '</blockquote>';
  TestResult := HTMLWriterFactory('html').AddBlockQuoteText(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML('<blockquote>' + TempString + '</blockquote>');
  TestResult := HTMLWriterFactory('html').AddBlockQuoteText(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestAddBoldText;
var
  TestResult, ExpectedResult: string;
  TempString: string;
begin
  TempString := 'grundle';

  ExpectedResult := '<html><b>' + TempString + '</b>';
  TestResult := HTMLWriterFactory('html').AddBoldText(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML('<b>' + TempString + '</b>');
  TestResult := HTMLWriterFactory('html').AddBoldText(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestAddItalicText;
var
  TestResult, ExpectedResult: string;
  TempString: string;
begin
  TempString := 'grundle';

  ExpectedResult := '<html><i>' + TempString + '</i>';
  TestResult := HTMLWriterFactory('html').AddItalicText(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML('<i>' + TempString + '</i>');
  TestResult := HTMLWriterFactory('html').AddItalicText(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestAddLineBreak;
var
  TestResult: string;
  ExpectedResult: string;
begin
  ExpectedResult := HTML('<br />');
  TestResult := HTMLWriterFactory(cHTML).AddLineBreak().CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML('<br>');
  TestResult := HTMLWriterFactory(cHTML).AddLineBreak(cvNoValue, ucsDoNotUseCloseSlash).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML('<br clear="left">');
  TestResult := HTMLWriterFactory(cHTML).AddLineBreak(cvLeft, ucsDoNotUseCloseSlash).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML('<br clear="left" />');
  TestResult := HTMLWriterFactory(cHTML).AddLineBreak(cvLeft, ucsUseCloseSlash).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestAddMetaNamedContent;
var
  TestResult, ExpectedResult: string;
  TempName: string;
  TempContent: string;
begin
  TempName := 'Snerdo';
  TempContent := 'derfle';
  ExpectedResult := '<html><head><meta name="%s" content="%s" /></head></html>';
  ExpectedResult := Format(ExpectedResult, [TempName, TempContent]);
  TestResult := HTMLWriterFactory(cHTML).AddHead.OpenMeta.AddMetaNamedContent(TempName, TempContent).CloseTag.CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestAddUnderlinedText;
var
  TestResult, ExpectedResult: string;
  TempString: string;
begin
  TempString := 'grundle';

  ExpectedResult := '<html><u>' + TempString + '</u>';
  TestResult := HTMLWriterFactory('html').AddUnderlinedText(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML('<u>' + TempString + '</u>');
  TestResult := HTMLWriterFactory('html').AddUnderlinedText(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestAddEmphasisText;
var
  TestResult, ExpectedResult: string;
  TempString: string;
  TempTag: string;
begin
  TempString := 'grundle';
  TempTag := 'em';

  ExpectedResult := Format('<html><%s>%s</%s>', [TempTag, TempString, TempTag]);
  TestResult := HTMLWriterFactory('html').AddEmphasisText(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML(Format('<%s>%s</%s>', [TempTag, TempString, TempTag]));
  TestResult := HTMLWriterFactory('html').AddEmphasisText(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddStrongText;
var
  TestResult, ExpectedResult: string;
  TempString: string;
  TempTag: string;
begin
  TempString := 'grundle';
  TempTag := 'strong';

  ExpectedResult := Format('<html><%s>%s</%s>', [TempTag, TempString, TempTag]);
  TestResult := HTMLWriterFactory('html').AddStrongText(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML(Format('<%s>%s</%s>', [TempTag, TempString, TempTag]));
  TestResult := HTMLWriterFactory('html').AddStrongText(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddPreformattedText;
var
  TestResult, ExpectedResult: string;
  TempString: string;
  TempTag: string;
begin
  TempString := 'grundle';
  TempTag := 'pre';

  ExpectedResult := Format('<html><%s>%s</%s>', [TempTag, TempString, TempTag]);
  TestResult := HTMLWriterFactory('html').AddPreformattedText(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML(Format('<%s>%s</%s>', [TempTag, TempString, TempTag]));
  TestResult := HTMLWriterFactory('html').AddPreformattedText(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddCitationText;
var
  TestResult, ExpectedResult: string;
  TempString: string;
  TempTag: string;
begin
  TempString := 'grundle';
  TempTag := 'cite';

  ExpectedResult := Format('<html><%s>%s</%s>', [TempTag, TempString, TempTag]);
  TestResult := HTMLWriterFactory('html').AddCitationText(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML(Format('<%s>%s</%s>', [TempTag, TempString, TempTag]));
  TestResult := HTMLWriterFactory('html').AddCitationText(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestOpenHeading1;
var
  TestResult: string;
  ExpectedResult: string;
begin
  TestResult := HTMLWriterFactory('html').OpenHeading1.AsHTML;
  ExpectedResult := '<html><h1';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading1.CloseTag.AsHTML;
  ExpectedResult := '<html><h1></h1>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading1.CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><h1></h1></html>';
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading1.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := '<html><h1>blah</h1></html>';
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestOpenHeading2;
var
  TestResult: string;
  ExpectedResult: string;
  TempTag: string;
begin
  TempTag := 'h2';
  TestResult := HTMLWriterFactory('html').OpenHeading2.AsHTML;
  ExpectedResult := Format('<html><%s', [TempTag]);
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading2.CloseTag.AsHTML;
  ExpectedResult := Format('<html><%s></%s>', [TempTag, TempTag]); ;
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading2.CloseTag.CloseTag.AsHTML;
  ExpectedResult := Format('<html><%s></%s></html>', [TempTag, TempTag]);
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading2.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := Format('<html><%s>blah</%s></html>', [TempTag, TempTag]);
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestOpenHeading3;
var
  TestResult: string;
  ExpectedResult: string;
  TempTag: string;
begin
  TempTag := 'h3';
  TestResult := HTMLWriterFactory('html').OpenHeading3.AsHTML;
  ExpectedResult := Format('<html><%s', [TempTag]);
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading3.CloseTag.AsHTML;
  ExpectedResult := Format('<html><%s></%s>', [TempTag, TempTag]); ;
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading3.CloseTag.CloseTag.AsHTML;
  ExpectedResult := Format('<html><%s></%s></html>', [TempTag, TempTag]);
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading3.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := Format('<html><%s>blah</%s></html>', [TempTag, TempTag]);
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestOpenHeading4;
var
  TestResult: string;
  ExpectedResult: string;
  TempTag: string;
begin
  TempTag := 'h4';
  TestResult := HTMLWriterFactory('html').OpenHeading4.AsHTML;
  ExpectedResult := Format('<html><%s', [TempTag]);
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading4.CloseTag.AsHTML;
  ExpectedResult := Format('<html><%s></%s>', [TempTag, TempTag]); ;
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading4.CloseTag.CloseTag.AsHTML;
  ExpectedResult := Format('<html><%s></%s></html>', [TempTag, TempTag]);
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading4.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := Format('<html><%s>blah</%s></html>', [TempTag, TempTag]);
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestOpenHeading5;
var
  TestResult: string;
  ExpectedResult: string;
  TempTag: string;
begin
  TempTag := 'h5';
  TestResult := HTMLWriterFactory('html').OpenHeading5.AsHTML;
  ExpectedResult := Format('<html><%s', [TempTag]);
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading5.CloseTag.AsHTML;
  ExpectedResult := Format('<html><%s></%s>', [TempTag, TempTag]); ;
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading5.CloseTag.CloseTag.AsHTML;
  ExpectedResult := Format('<html><%s></%s></html>', [TempTag, TempTag]);
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading5.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := Format('<html><%s>blah</%s></html>', [TempTag, TempTag]);
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestOpenHeading6;
var
  TestResult: string;
  ExpectedResult: string;
  TempTag: string;
begin
  TempTag := 'h6';
  TestResult := HTMLWriterFactory('html').OpenHeading6.AsHTML;
  ExpectedResult := Format('<html><%s', [TempTag]);
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading6.CloseTag.AsHTML;
  ExpectedResult := Format('<html><%s></%s>', [TempTag, TempTag]); ;
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading6.CloseTag.CloseTag.AsHTML;
  ExpectedResult := Format('<html><%s></%s></html>', [TempTag, TempTag]);
  CheckEquals(ExpectedResult, TestResult);

  TestResult := HTMLWriterFactory('html').OpenHeading6.AddText('blah').CloseTag.CloseTag.AsHTML;
  ExpectedResult := Format('<html><%s>blah</%s></html>', [TempTag, TempTag]);
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddHeading1Text;
var
  TestResult, ExpectedResult: string;
  TempString: string;
  TempTag: string;
begin
  TempString := 'grundle';
  TempTag := 'h1';

  ExpectedResult := Format('<html><%s>%s</%s>', [TempTag, TempString, TempTag]);
  TestResult := HTMLWriterFactory('html').AddHeading1Text(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML(Format('<%s>%s</%s>', [TempTag, TempString, TempTag]));
  TestResult := HTMLWriterFactory('html').AddHeading1Text(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddHeading2Text;
var
  TestResult, ExpectedResult: string;
  TempString: string;
  TempTag: string;
begin
  TempString := 'grundle';
  TempTag := 'h2';

  ExpectedResult := Format('<html><%s>%s</%s>', [TempTag, TempString, TempTag]);
  TestResult := HTMLWriterFactory('html').AddHeading2Text(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML(Format('<%s>%s</%s>', [TempTag, TempString, TempTag]));
  TestResult := HTMLWriterFactory('html').AddHeading2Text(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddHeading3Text;
var
  TestResult, ExpectedResult: string;
  TempString: string;
  TempTag: string;
begin
  TempString := 'grundle';
  TempTag := 'h3';

  ExpectedResult := Format('<html><%s>%s</%s>', [TempTag, TempString, TempTag]);
  TestResult := HTMLWriterFactory('html').AddHeading3Text(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML(Format('<%s>%s</%s>', [TempTag, TempString, TempTag]));
  TestResult := HTMLWriterFactory('html').AddHeading3Text(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddHeading4Text;
var
  TestResult, ExpectedResult: string;
  TempString: string;
  TempTag: string;
begin
  TempString := 'grundle';
  TempTag := 'h4';

  ExpectedResult := Format('<html><%s>%s</%s>', [TempTag, TempString, TempTag]);
  TestResult := HTMLWriterFactory('html').AddHeading4Text(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML(Format('<%s>%s</%s>', [TempTag, TempString, TempTag]));
  TestResult := HTMLWriterFactory('html').AddHeading4Text(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddHeading5Text;
var
  TestResult, ExpectedResult: string;
  TempString: string;
  TempTag: string;
begin
  TempString := 'grundle';
  TempTag := 'h5';

  ExpectedResult := Format('<html><%s>%s</%s>', [TempTag, TempString, TempTag]);
  TestResult := HTMLWriterFactory('html').AddHeading5Text(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML(Format('<%s>%s</%s>', [TempTag, TempString, TempTag]));
  TestResult := HTMLWriterFactory('html').AddHeading5Text(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddHeading6Text;
var
  TestResult, ExpectedResult: string;
  TempString: string;
  TempTag: string;
begin
  TempString := 'grundle';
  TempTag := 'h6';

  ExpectedResult := Format('<html><%s>%s</%s>', [TempTag, TempString, TempTag]);
  TestResult := HTMLWriterFactory('html').AddHeading6Text(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML(Format('<%s>%s</%s>', [TempTag, TempString, TempTag]));
  TestResult := HTMLWriterFactory('html').AddHeading6Text(TempString).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddStyle;
var
  TestResult, ExpectedResult: string;
  TempStyle: string;
  TempString: string;
begin
  TempStyle := 'font-size: small';
  TempString := 'blooker';
  ExpectedResult := Format('<span style="%s"', [TempStyle]);
  TestResult := HTMLWriterFactory('span').AddStyle(TempStyle).AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := ExpectedResult + '>' + TempString;
  TestResult := HTMLWriterFactory('span').AddStyle(TempStyle).AddText(TempString).AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := ExpectedResult + '</span>';
  TestResult := HTMLWriterFactory('span').AddStyle(TempStyle).AddText(TempString).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestAddClass;
var
  TestResult, ExpectedResult: string;
  TempClassName: string;
begin
  TempClassName := 'harbie';

  ExpectedResult := Format('<html><span class="%s"', [TempClassName]);
  TestResult := HTMLWriterFactory('html').OpenSpan.AddClass(TempClassName).AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML(Format('<span class="%s"></span>', [TempClassName]));
  TestResult := HTMLWriterFactory('html').OpenSpan.AddClass(TempClassName).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddID;
var
  TestResult, ExpectedResult: string;
  TempClassName: string;
begin
  TempClassName := 'harbie';

  ExpectedResult := Format('<html><span id="%s"', [TempClassName]);
  TestResult := HTMLWriterFactory('html').OpenSpan.AddID(TempClassName).AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := HTML(Format('<span id="%s"></span>', [TempClassName]));
  TestResult := HTMLWriterFactory('html').OpenSpan.AddID(TempClassName).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddAttribute;
var
  TestResult: string;
  TempTagName: string;
  TempAttributeName, TempAttributeValue: string;
  ExpectedResult: string;
begin
  TempTagName := 'treaster';
  TempAttributeName := 'thresa';
  TempAttributeValue := 'grenar';

  ExpectedResult := Format('<%s %s></%s>', [TempTagName, TempAttributeName, TempTagName]);
  TestResult := HTMLWriterFactory(TempTagName).AddAttribute(TempAttributeName).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

  ExpectedResult := Format('<%s %s="%s"></%s>', [TempTagName, TempAttributeName, TempAttributeValue, TempTagName]);
  TestResult := HTMLWriterFactory(TempTagName).AddAttribute(TempAttributeName, TempAttributeValue).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestCloseTag;
var
  TestResult: string;
  TempTagName: string;
  ExpectedResult: string;
begin
  // Close tag is tested all over the place, so we'll juat have one basic
  // test here
  TempTagName := 'gretis';
  ExpectedResult := Format('<%s></%s>', [TempTagName, TempTagName]);
  TestResult := HTMLWriterFactory(TempTagName).CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);

end;

procedure TestTHTMLWriter.TestAddSpanTextWithStyle;
var
  TempStyle: string;
  TempString: string;
  TestResult: string;
  ExpectedResult: string;
begin
  TempString := 'flooble';
  TempStyle := 'border-top:1px solid #c9d7f1;font-size:1px';
  ExpectedResult := HTML(Format('<span style="%s">%s</span>', [TempStyle, TempString]));
  TestResult := HTMLWriterFactory(cHTML).AddSpanTextWithStyle(TempString, TempStyle).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestTHTMLWriter.TestAddSpanTextWithID;
var
  TempID: string;
  TempString: string;
  TestResult: string;
  ExpectedResult: string;
begin
  TempString := 'flooble';
  TempID := 'main';
  ExpectedResult := HTML(Format('<span id="%s">%s</span>', [TempID, TempString]));
  TestResult := HTMLWriterFactory(cHTML).AddSpanTextWithID(TempString, TempID).CloseTag.CloseTag.AsHTML;
  CheckEquals(ExpectedResult, TestResult);
end;

procedure TestIGetHTML.SetUp;
begin
end;

procedure TestIGetHTML.TearDown;
begin
  FIGetHTML := nil;
end;

procedure TestIGetHTML.TestAsHTML;
var
  ReturnValue: string;
begin
  ReturnValue := FIGetHTML.AsHTML;
end;

initialization

// Register any test cases with the test runner
RegisterTest(TestTHTMLWriter.Suite);

end.

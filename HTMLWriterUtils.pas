unit HTMLWriterUtils;

interface

uses SysUtils;

type
  IGetHTML = interface
    function AsHTML: string;
  end;

type
  EHTMLWriterException = class(Exception);
    EHTMLWriterEmptyTagException = class(EHTMLWriterException);
    EHTMLWriterOpenTagRequiredException = class(EHTMLWriterException);
    EMetaOnlyInHeadTagHTMLException = class(EHTMLWriterException);
    ENotInMetaTagHTMLException = class(EHTMLWriterException);

  type

    TCanHaveAttributes = (chaCanHaveAttributes, chaCannotHaveAttributes);
    TFormatType = (ftBold, ftItalic, ftUnderline, ftEmphasis, ftStrong, ftSubscript, ftSuperscript, ftPreformatted, ftCitation);
    THeadingType = (htHeading1, htHeading2, htHeading3, htHeading4, htHeading5, htHeading6);

    TTagState = (tsBracketOpen, tsCommentOpen, tsTagOpen, tsTagClosed, tsInHeadTag, tsInBodyTag, tsUseSlashClose);
    TTagStates = set of TTagState;

  const
    TFormatTypeStrings: array [TFormatType] of string = ('b', 'i', 'u', 'em', 'strong', 'sub', 'sup', 'pre', 'cite');
    THeadingTypeStrings: array [THeadingType] of string = ('h1', 'h2', 'h3', 'h4', 'h5', 'h6');

    cDiv = 'div';
    cSpan = 'span';
    cHTML = 'html';
    cHead = 'head';
    cBody = 'body';
    cBlockQuote = 'blockquote';
    cClass = 'class';
    cStyle = 'style';
    cID = 'id';
    cMeta = 'meta';
    cName = 'name';
    cContent = 'content';
    cParagraph = 'p';

    cClosingTag = '%s</%s>';
    cOpenBracket = '<';
    cOpenBracketSlash = '</';
    cCloseBracket = '>';
    cCloseSlashBracket = '/>';
    cComment = '!--';
    cCloseComment = '-->';
    cSpace = ' ';

function StringIsEmpty(Str: string; aUseTrim: Boolean = True): Boolean;
function MakeOpenTag(aTag: string): string;
function MakeCloseTag(aTag: string): string;

implementation


function StringIsEmpty(Str: string; aUseTrim: Boolean = True): Boolean;
begin
  Result := Str = EmptyStr;
  if (not Result) and aUseTrim then
  begin
    Result := Trim(Str) = EmptyStr;
  end;
end;

function MakeOpenTag(aTag: string): string;
begin
  Result := Format('<%s>', [aTag]);
end;

function MakeCloseTag(aTag: string): string;
begin
  Result := Format('</%s>', [aTag]);
end;


end.


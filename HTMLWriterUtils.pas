{
  ***** BEGIN LICENSE BLOCK *****
  * Version: MPL 1.1
  *
  * The contents of this file are subject to the Mozilla Public License Version
  * 1.1 (the "License"); you may not use this file except in compliance with
  * the License. You may obtain a copy of the License at
  * http://www.mozilla.org/MPL/
  *
  * Software distributed under the License is distributed on an "AS IS" basis,
  * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  * for the specific language governing rights and limitations under the
  * License.
  *
  * The Original Code is Delphi HTMLWriter
  *
  * The Initial Developer of the Original Code is
  * Nick Hodges
  *
  * Portions created by the Initial Developer are Copyright (C) 2010
  * the Initial Developer. All Rights Reserved.
  *
  * Contributor(s):
  *
  * ***** END LICENSE BLOCK *****
  }

unit HTMLWriterUtils;

interface

uses SysUtils, Classes;

type
  ILoadSave = interface
    procedure LoadFromFile(const FileName: string); overload;
    procedure LoadFromFile(const FileName: string; Encoding: TEncoding); overload;
    procedure LoadFromStream(Stream: TStream); overload;
    procedure LoadFromStream(Stream: TStream; Encoding: TEncoding); overload;
    procedure SaveToFile(const FileName: string); overload;
    procedure SaveToFile(const FileName: string; Encoding: TEncoding); overload;
    procedure SaveToStream(Stream: TStream); overload;
    procedure SaveToStream(Stream: TStream; Encoding: TEncoding); overload;
  end;

resourcestring
  StrATagsBracketMust = 'A tag''s bracket must be open to add an attribute.  The Current tag is %s and the attribute being added is %s';
  strTagNameRequired = 'The aTagName parameter of the THTMLWriter constructor cannot be an empty string.';
  strOpenBracketImpossible = 'It should be impossible that the bracket is open here. Seeing this error means a very bad logic problem.';
  strAMetaTagCanOnly = 'This tag can only be added inside a <head> tag.';
  strThisMethodCanOnly = 'This method can only be called inside a <meta> tag.';
  strClosingClosedTag = 'An attempt is being made to close a tag that is already closed.';
  strMustBeInList = 'A list must be open in order to call CloseList.';
  strMustBeInTable = 'A table must be open in order to call this.';
  strMustBeInComment = 'A comment must be open in order to call CloseComment';

type
  IGetHTML = interface
    function AsHTML: string;
  end;

  THTMLWidth = record
    Width: integer;
    IsPercentage: Boolean;
    constructor Create(aWidth: integer; aIsPercentage: Boolean);
    function AsPercentage: string;
  end;

type
  EHTMLWriterException = class(Exception);
    EHTMLWriterEmptyTagException = class(EHTMLWriterException);
    EHTMLWriterOpenTagRequiredException = class(EHTMLWriterException);
    EHeadTagRequiredHTMLException = class(EHTMLWriterException);
    ETryingToCloseClosedTag = class(EHTMLWriterException);
    ENotInListTagException = class(EHTMLWriterException);
    ENotInTableTagException = class(EHTMLWriterException);
    ENotInCommentTagException = class(EHTMLWriterException);

  type

    TCanHaveAttributes = (chaCanHaveAttributes, chaCannotHaveAttributes);
    TFormatType = (ftBold, ftItalic, ftUnderline, ftEmphasis, ftStrong, ftSubscript, ftSuperscript, ftPreformatted, ftCitation);
    THeadingType = (htHeading1, htHeading2, htHeading3, htHeading4, htHeading5, htHeading6);

    TTagState = (tsBracketOpen, tsCommentOpen, tsTagOpen, tsTagClosed, tsInHeadTag, tsInBodyTag, tsUseSlashClose, tsInListTag, tsInTableTag, tsInTableRowTag);
    TTagStates = set of TTagState;

    TClearValue = (cvNoValue, cvNone, cvLeft, cvRight, cvAll);
    TUseCloseSlash = (ucsUseCloseSlash, ucsDoNotUseCloseSlash);
    TBulletShape = (bsNone, bsDisc, bsCircle, bsSquare);
    TNumberType = (ntNone, ntNumber, ntUpperCase, ntLowerCase, ntUpperRoman, ntLowerRoman);

    TPercentage = 1 .. 100;

  const
    TFormatTypeStrings: array [TFormatType] of string = ('b', 'i', 'u', 'em', 'strong', 'sub', 'sup', 'pre', 'cite');
    THeadingTypeStrings: array [THeadingType] of string = ('h1', 'h2', 'h3', 'h4', 'h5', 'h6');
    TClearValueStrings: array [TClearValue] of string = ('', 'none', 'left', 'right', 'all');
    TBulletShapeStrings: array [TBulletShape] of string = ('', 'disc', 'circle', 'square');
    TNumberTypeStrings: array [TNumberType] of string = ('', '1', 'A', 'a', 'I', 'i');

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
    cAnchor = 'a';
    cHREF = 'href';
    cImage = 'img';
    cURL = 'url';
    cSource = 'src';
    cHardRule = 'hr';
    cBreak = 'br';
    cUnorderedList = 'ul';
    cOrderedList = 'ol';
    cListItem = 'li';
    cClear = 'clear';
    cType = 'type';
    cTable = 'table';
    cBorder = 'border';
    cCellPadding = 'cellpadding';
    cCellSpacing = 'cellspacing';
    cWidth = 'width';
    cTableRow = 'tr';
    cTableData = 'td';
    cTableHeader = 'th';
    cTitle = 'title';
    cScript = 'script';

    { TODO -oNick : Add these formatting tags }
    cAcronym = 'acronym';
    cAbbreviation = 'abbr';
    cAddress = 'address';
    cBDO = 'bdo';
    cBig = 'big';
    cCenter = 'center';
    cCode = 'code';
    cDelete = 'del';
    cDefinition = 'dfn';
    cFont = 'font';
    cInsert = 'ins';
    cKeyboard = 'kdb';
    cQuotation = 'q';
    cSample = 'samp';
    cSmall = 'small';
    cStrike = 'strike';
    cSubscript = 'sub';
    cSuperscript = 'sup';
    cTeletype = 'tt';
    cVariable = 'var';

    cClosingTag = '%s</%s>';
    cOpenBracket = '<';
    cOpenBracketSlash = '</';
    cCloseBracket = '>';
    cCloseSlashBracket = '/>';
    cComment = '!--';
    cCloseComment = '-->';
    cSpace = ' ';


    cHTML401Strict       = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">';
    cHTML401Transitional = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">';
    cHTML401Frameset     = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">';
    cXHTML10Strict       = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">';
    cXHTML10Transitional = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">';
    cXHTML10Frameset     = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">';
    cXHTML11             = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">';


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

{ THTMLWidth }

function THTMLWidth.AsPercentage: string;
begin
  Result := '';
  if IsPercentage then
  begin
    Result := Format('%d%%', [Width]);
  end;
end;

constructor THTMLWidth.Create(aWidth: integer; aIsPercentage: Boolean);
begin
  Width := aWidth;
  IsPercentage := aIsPercentage;
end;

end.

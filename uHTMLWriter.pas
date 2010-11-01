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

unit uHTMLWriter;

interface

uses
  SysUtils, HTMLWriterUtils;

type
  /// <summary>A class for creating HTML.&#160; THTMLWriter uses the fluent
  /// interface.  It can be used to create either complete HTML documents or
  /// chunks of HTML.  By using the fluent interface, you can link together
  /// number of methods to create a complete document.</summary>
  THTMLWriter = class(TInterfacedObject, IGetHTML)
  private
    FHTML: string;
    FCurrentTagName: string;
    FTagState: TTagStates;
    FParent: THTMLWriter;
    FCanHaveAttributes: TCanHaveAttributes;
    procedure AddToHTML(const aString: string);
    function AddTag(aString: string; aCanAddAttributes: TCanHaveAttributes = chaCanHaveAttributes): THTMLWriter;
    function AddFormattedText(aString: string; aFormatType: TFormatType): THTMLWriter;
    function OpenFormatTag(aFormatType: TFormatType; aCanAddAttributes: TCanHaveAttributes = chaCannotHaveAttributes): THTMLWriter;
    function AddHeadingText(aString: string; aHeadingType: THeadingType): THTMLWriter;
    function InHeadTag: Boolean;
    function InBodyTag: Boolean;
    function InCommentTag: Boolean;
    function TagIsOpen: Boolean;
    function InMetaTag: Boolean;
    function InListTag: Boolean;
    function InTableTag: Boolean;
    function InTableRowTag: Boolean;
    procedure CloseSlashBracket;
    procedure CloseCommentTag;
    procedure CleanUpTagState;
  strict protected
    function CloseBracket: THTMLWriter;
  public
{$REGION 'Documentation'}
    /// <summary>Creates an instance of THTMLWriter by passing in any arbitrary tag.&#160; Use this constructur if
    /// you want to create a chunk of HTML code not associated with a document.</summary>
    /// <param name="aTagName">The text for the tag you are creating.&#160; For instance, if you want to create a
    /// &lt;span&gt; tag, you should pass 'span' as the value</param>
    /// <param name="aCanAddAttributes">Indicates if the tag should be allowed to have attributes. For instance,
    /// normally the &lt;b&gt; doesn't have attributes.&#160; Set this to False if you want to ensure that the tag
    /// will not have any attributes.</param>
    /// <exception cref="EHTMLWriterEmptyTagException">raised if an empty tag is passed as the aTagName
    /// parameter</exception>
    /// <seealso cref="CreateDocument">The CreateDocument constructor</seealso>
{$ENDREGION}
    constructor Create(aTagName: string; aCanAddAttributes: TCanHaveAttributes = chaCanHaveAttributes);
    constructor CreateDocument;
{$REGION 'Documentation'}
    /// <summary>Returns a string containing the current HTML for the
    /// HTMLWriter</summary>
    /// <remarks>This property will return the HTML in whatever state it is
    /// in when called.&#160; This may mean that brackets or even tags are
    /// open, attributes hanging undone, etc.&#160;</remarks>
{$ENDREGION}
    function AsHTML: string;
    /// <summary>Adds a &lt;head&gt; tag to the document.&#160;</summary>
    function AddHead: THTMLWriter;
    function OpenBody: THTMLWriter;
    // Block types
    function OpenParagraph: THTMLWriter;
    function OpenParagraphWithStyle(aStyle: string): THTMLWriter;
    function OpenParagraphWithID(aID: string): THTMLWriter;
    function OpenSpan: THTMLWriter;
    function OpenDiv: THTMLWriter;
    function OpenBlockQuote: THTMLWriter;

    function OpenComment: THTMLWriter;
    function OpenMeta: THTMLWriter;

    /// <summary>Adds the passed in text to the HTML inside of a &lt;p&gt; tag.</summary>
    /// <param name="aString">The text to be added into the &lt;p&gt; tag.</param>
    function AddParagraphText(aString: string): THTMLWriter;
{$REGION 'Documentation'}
    /// <summary>Adds theh passed in text into a &lt;p&gt; tag and adds in the given Style attribute.</summary>
    /// <param name="aString">The text to be added within the &lt;p&gt; tag.</param>
    /// <param name="aStyle">The value for the Style attribute&#160;to be added to the &lt;p&gt; tag.</param>
{$ENDREGION}
    function AddParagraphTextWithStyle(aString: string; aStyle: string): THTMLWriter;
    function AddParagraphTextWithID(aString: string; aID: string): THTMLWriter;

    // Span
    function AddSpanText(aString: string): THTMLWriter;
    function AddSpanTextWithStyle(aString: string; aStyle: string): THTMLWriter;
    function AddSpanTextWithID(aString: string; aID: string): THTMLWriter;

    function AddDivText(aString: string): THTMLWriter;
    function AddDivTextWithStyle(aString: string; aStyle: string): THTMLWriter;
    function AddDivTextWithID(aString: string; aID: string): THTMLWriter;

    function AddBlockQuoteText(aString: string): THTMLWriter;
    function AddComment(aCommentText: string): THTMLWriter;

    /// <summary>Opens up a &lt;b&gt; tag. Once a tag is open, it can be added to as desired.</summary>
    function OpenBold: THTMLWriter;
    /// <summary>Opens up a &lt;i&gt; tag. Once a tag is open, it can be added to as desired.</summary>
    function OpenItalic: THTMLWriter;
    /// <summary>Opens up a &lt;u&gt; tag. Once a tag is open, it can be added to as desired.</summary>
    function OpenUnderline: THTMLWriter;
    function OpenEmphasis: THTMLWriter;
    function OpenStrong: THTMLWriter;
    function OpenPre: THTMLWriter;
    function OpenCite: THTMLWriter;

    function AddBoldText(aString: string): THTMLWriter;
    function AddItalicText(aString: string): THTMLWriter;
    function AddUnderlinedText(aString: string): THTMLWriter;
    function AddEmphasisText(aString: string): THTMLWriter;
    function AddStrongText(aString: string): THTMLWriter;
    function AddPreformattedText(aString: string): THTMLWriter;
    function AddCitationText(aString: string): THTMLWriter;

    // Headings

    function OpenHeading1: THTMLWriter;
    function OpenHeading2: THTMLWriter;
    function OpenHeading3: THTMLWriter;
    function OpenHeading4: THTMLWriter;
    function OpenHeading5: THTMLWriter;
    function OpenHeading6: THTMLWriter;

    function AddHeading1Text(aString: string): THTMLWriter;
    function AddHeading2Text(aString: string): THTMLWriter;
    function AddHeading3Text(aString: string): THTMLWriter;
    function AddHeading4Text(aString: string): THTMLWriter;
    function AddHeading5Text(aString: string): THTMLWriter;
    function AddHeading6Text(aString: string): THTMLWriter;

    // CSS Formatting
    function AddStyle(aStyle: string): THTMLWriter;
    function AddClass(aClass: string): THTMLWriter;
    function AddID(aID: string): THTMLWriter;
{$REGION 'Documentation'}
    /// <summary>Adds any text to the HTML.&#160;</summary>
    /// <param name="aString">The string to be added</param>
    /// <remarks>AddText will close the current tag and then add the text passed in the string parameter</remarks>
{$ENDREGION}
    function AddText(aString: string): THTMLWriter;
{$REGION 'Documentation'}
    /// <summary>AddRawText will inject the passed in string directly into the HTML.&#160;</summary>
    /// <param name="aString">The text to be added to the HTML</param>
    /// <remarks>AddRawText&#160;will not make any other changes to open tags or open brackets.&#160; It just injects
    /// the passed text directly onto the HTML.</remarks>
{$ENDREGION}
    function AddRawText(aString: string): THTMLWriter;

    // Miscellaneous Stuff
{$REGION 'Documentation'}
    /// <summary>Adds an attribute to the current tag.&#160; The tag must have its bracket open.&#160;</summary>
    /// <exception cref="EHTMLWriterOpenTagRequiredException">Raised when this method is called on a tag that doesn't
    /// have it's bracket open.</exception>
{$ENDREGION}
    function AddAttribute(aString: string; aValue: string = ''): THTMLWriter;
    function AddMetaNamedContent(aName: string; aContent: string): THTMLWriter;

    /// <summary>Closes an open tag.</summary>
    function CloseTag: THTMLWriter;
    function CloseComment: THTMLWriter;
    function CloseList: THTMLWriter;

    function OpenImage: THTMLWriter; overload;
    function OpenImage(aImageSource: string): THTMLWriter; overload;
    function AddImage(aImageSource: string): THTMLWriter;

    function AddLineBreak(const aClearValue: TClearValue = cvNoValue; aUseCloseSlash: TUseCloseSlash = ucsUseCloseSlash): THTMLWriter;
    function AddHardRule(const aAttributes: string = ''; aUseCloseSlash: TUseCloseSlash = ucsUseCloseSlash): THTMLWriter;

    function OpenAnchor: THTMLWriter; overload;
    function OpenAnchor(const aHREF: string; aText: string): THTMLWriter; overload;
    function AddAnchor(const aHREF: string; aText: string): THTMLWriter;

    // Table Support
    function OpenTable: THTMLWriter; overload;
    function OpenTable(aBorder: integer): THTMLWriter; overload;
    function OpenTable(aBorder: integer; aCellPadding: integer): THTMLWriter; overload;
    function OpenTable(aBorder: integer; aCellPadding: integer; aCellSpacing: integer): THTMLWriter; overload;
    function OpenTable(aBorder: integer; aCellPadding: integer; aCellSpacing: integer; aWidth: integer): THTMLWriter; overload;
    { TODO -oNick : Think about how to do percentage widths }

    function OpenTableRow: THTMLWriter;
    function OpenTableData: THTMLWriter;
    function AddTableData(aText: string): THTMLWriter;

    // list

    function OpenUnorderedList(aBulletShape: TBulletShape = bsNone): THTMLWriter;
    function OpenOrderedList(aNumberType: TNumberType = ntNone): THTMLWriter;
    function OpenListItem: THTMLWriter;
    function AddListItem(aText: string): THTMLWriter;
  end;

implementation

{ THTMLWriter }

function THTMLWriter.CloseBracket: THTMLWriter;
begin
  if (tsBracketOpen in FTagState) and (not(tsCommentOpen in FTagState)) then
  begin
    FHTML := FHTML + cCloseBracket;
    Include(FTagState, tsTagOpen);
    Exclude(FTagState, tsBracketOpen);
  end;
  Result := Self;
end;

function THTMLWriter.CloseComment: THTMLWriter;
begin
  if not InCommentTag then
  begin
    raise ENotInCommentTagException.Create(strMustBeInComment);
  end;
  Result := CloseTag;
end;

procedure THTMLWriter.CloseCommentTag;
begin
  FHTML := FHTML + cSpace + cCloseComment;
  Exclude(FTagState, tsCommentOpen);
  Exclude(FTagState, tsTagOpen);
  Include(FTagState, tsTagClosed);
end;

function THTMLWriter.CloseList: THTMLWriter;
begin
  if not InListTag then
  begin
    raise ENotInListTagException.Create(strMustBeInList);
  end;
  Result := CloseTag;
end;

procedure THTMLWriter.CloseSlashBracket;
begin
  FHTML := FHTML + cSpace + cCloseSlashBracket;
  Exclude(FTagState, tsUseSlashClose);
  Exclude(FTagState, tsTagOpen);
end;

function THTMLWriter.CloseTag: THTMLWriter;
begin
  if tsTagClosed in FTagState then
  begin
    raise ETryingToCloseClosedTag.Create(strClosingClosedTag);
  end;

  if not(tsUseSlashClose in FTagState) and (not(tsCommentOpen in FTagState)) then
  begin
    CloseBracket;
  end;

  if (tsBracketOpen in FTagState) and (not(tsUseSlashClose in FTagState)) and (not(tsCommentOpen in FTagState)) then
  begin
    Assert(False, strOpenBracketImpossible);
  end;

  if tsUseSlashClose in FTagState then
  begin
    CloseSlashBracket;
  end;

  if InCommentTag then
  begin
    CloseCommentTag;
  end;

  if TagIsOpen then
  begin
    FHTML := Format(cClosingTag, [FHTML, FCurrentTagName]);
  end;

  CleanUpTagState;

  FParent.FHTML := Self.FHTML;
  Result := FParent;
end;

constructor THTMLWriter.Create(aTagName: string; aCanAddAttributes: TCanHaveAttributes = chaCanHaveAttributes);
begin
  if StringIsEmpty(aTagName) then
  begin
    raise EHTMLWriterEmptyTagException.Create(strTagNameRequired);
  end;
  FCurrentTagName := aTagName;
  FCanHaveAttributes := chaCanHaveAttributes;
  FHTML := cOpenBracket + FCurrentTagName;
  FTagState := FTagState + [tsBracketOpen];
  FParent := Self;
end;

constructor THTMLWriter.CreateDocument;
begin
  Create(cHTML, chaCanHaveAttributes);
end;

function THTMLWriter.InBodyTag: Boolean;
begin
  Result := tsInBodyTag in FTagState;
end;

function THTMLWriter.InCommentTag: Boolean;
begin
  Result := tsCommentOpen in FTagState;
end;

function THTMLWriter.TagIsOpen: Boolean;
begin
  Result := tsTagOpen in FTagState;
end;

function THTMLWriter.InHeadTag: Boolean;
begin
  Result := tsInHeadTag in FTagState;
end;

function THTMLWriter.InListTag: Boolean;
begin
  Result := tsInListTag in FTagState;
end;

function THTMLWriter.InMetaTag: Boolean;
begin
  Result := FCurrentTagName = cMeta;
end;

function THTMLWriter.InTableRowTag: Boolean;
begin
  Result := tsInTableRowTag in FTagState;
end;

function THTMLWriter.InTableTag: Boolean;
begin
  Result := tsInTableTag in FTagState;
end;

function THTMLWriter.OpenBold: THTMLWriter;
begin
  Result := OpenFormatTag(ftBold);
end;

function THTMLWriter.OpenCite: THTMLWriter;
begin
  Result := OpenFormatTag(ftCitation);
end;

function THTMLWriter.OpenEmphasis: THTMLWriter;
begin
  Result := OpenFormatTag(ftEmphasis);
end;

procedure THTMLWriter.AddToHTML(const aString: string);
begin
  FHTML := FHTML + aString;
end;

function THTMLWriter.OpenFormatTag(aFormatType: TFormatType; aCanAddAttributes: TCanHaveAttributes = chaCannotHaveAttributes): THTMLWriter;
begin
  Result := AddTag(TFormatTypeStrings[aFormatType], chaCannotHaveAttributes);
end;

function THTMLWriter.OpenHeading1: THTMLWriter;
begin
  Result := AddTag(THeadingTypeStrings[htHeading1]);
end;

function THTMLWriter.OpenHeading2: THTMLWriter;
begin
  Result := AddTag(THeadingTypeStrings[htHeading2]);
end;

function THTMLWriter.OpenHeading3: THTMLWriter;
begin
  Result := AddTag(THeadingTypeStrings[htHeading3]);
end;

function THTMLWriter.OpenHeading4: THTMLWriter;
begin
  Result := AddTag(THeadingTypeStrings[htHeading4]);
end;

function THTMLWriter.OpenHeading5: THTMLWriter;
begin
  Result := AddTag(THeadingTypeStrings[htHeading5]);
end;

function THTMLWriter.OpenHeading6: THTMLWriter;
begin
  Result := AddTag(THeadingTypeStrings[htHeading6]);
end;

function THTMLWriter.OpenImage: THTMLWriter;
begin
  Result := AddTag(cImage);
  Include(Result.FTagState, tsUseSlashClose);
end;

function THTMLWriter.OpenImage(aImageSource: string): THTMLWriter;
begin
  Result := AddTag(cImage).AddAttribute(cSource, aImageSource);
  Include(Result.FTagState, tsUseSlashClose);
end;

function THTMLWriter.AddImage(aImageSource: string): THTMLWriter;
begin
  Result := OpenImage(aImageSource).CloseTag;
end;

function THTMLWriter.OpenItalic: THTMLWriter;
begin
  Result := OpenFormatTag(ftItalic);
end;

function THTMLWriter.OpenListItem: THTMLWriter;
begin
  if not InListTag then
  begin
    raise ENotInListTagException.Create(strMustBeInList);
  end;
  Result := AddTag(cListItem);
end;

function THTMLWriter.OpenMeta: THTMLWriter;
begin
  if not InHeadTag then
  begin
    raise EMetaOnlyInHeadTagHTMLException.Create(strAMetaTagCanOnly);
  end;
  Result := AddTag(cMeta);
  Include(Result.FTagState, tsUseSlashClose);
end;

function THTMLWriter.OpenStrong: THTMLWriter;
begin
  Result := OpenFormatTag(ftStrong);
end;

function THTMLWriter.OpenTable: THTMLWriter;
begin
  Result := OpenTable(-1, -1, -1);
end;

function THTMLWriter.OpenTable(aBorder: integer): THTMLWriter;
begin
  Result := OpenTable(aBorder, -1, -1);
end;

function THTMLWriter.OpenTable(aBorder: integer; aCellPadding: integer): THTMLWriter;
begin
  Result := OpenTable(aBorder, aCellPadding, -1);
end;

function THTMLWriter.OpenTable(aBorder, aCellPadding, aCellSpacing: integer): THTMLWriter;
begin
  Result := OpenTable(aBorder, aCellPadding, aCellSpacing, -1);
end;

function THTMLWriter.OpenTable(aBorder: integer; aCellPadding: integer; aCellSpacing: integer; aWidth: integer): THTMLWriter;
begin
  Result := AddTag(cTable);
  if aBorder >= 0 then
  begin
    Result := Result.AddAttribute(cBorder, IntToStr(aBorder));
  end;
  if aCellPadding >= 0 then
  begin
    Result := Result.AddAttribute(cCellPadding, IntToStr(aCellPadding));
  end;
  if aCellSpacing >= 0 then
  begin
    Result := Result.AddAttribute(cCellSpacing, IntToStr(aCellSpacing));
  end;
  if aWidth >= 0 then
  begin
    Result := Result.AddAttribute(cWidth, IntToStr(aWidth));
  end;

  Result.FTagState := Result.FTagState + [tsInTableTag];

end;

function THTMLWriter.OpenTableData: THTMLWriter;
begin
  if not InTableRowTag then
  begin
    raise ENotInTableTagException.Create(strMustBeInList);
  end;
  Result := AddTag(cTableData);
end;

function THTMLWriter.OpenTableRow: THTMLWriter;
begin
  if not InTableTag then
  begin
    raise ENotInTableTagException.Create(strMustBeInList);
  end;
  Result := AddTag(cTableRow);
  Result.FTagState := Result.FTagState + [tsInTableRowTag];
end;

function THTMLWriter.OpenUnderline: THTMLWriter;
begin
  Result := OpenFormatTag(ftUnderline);
end;

function THTMLWriter.OpenUnorderedList(aBulletShape: TBulletShape = bsNone): THTMLWriter;
begin
  Result := AddTag(cUnorderedList);
  if aBulletShape <> bsNone then
  begin
    Result := Result.AddAttribute(cType, TBulletShapeStrings[aBulletShape]);
  end;
  Result.FTagState := Result.FTagState + [tsInListTag];
end;

function THTMLWriter.OpenOrderedList(aNumberType: TNumberType): THTMLWriter;
begin
  Result := AddTag(cOrderedList);
  if aNumberType <> ntNone then
  begin
    Result := Result.AddAttribute(cType, TNumberTypeStrings[aNumberType]);
  end;
  Result.FTagState := Result.FTagState + [tsInListTag];
end;

procedure THTMLWriter.CleanUpTagState;
begin
  FTagState := FTagState + [tsTagClosed] - [tsTagOpen];

  if (FCurrentTagName = cUnorderedList) and InListTag then
  begin
    Exclude(FTagState, tsInListTag);
  end;

  if (FCurrentTagName = cOrderedList) and InListTag then
  begin
    Exclude(FTagState, tsInListTag);
  end;

  if (FCurrentTagName = cTable) and InTableTag then
  begin
    Exclude(FTagState, tsInTableTag);
  end;

  if (FCurrentTagName = cHead) and InHeadTag then
  begin
    Exclude(FTagState, tsInHeadTag);
  end;

  if (FCurrentTagName = cBody) and InBodyTag then
  begin
    Exclude(FTagState, tsInBodyTag);
  end;

  if (FCurrentTagName = cTableRow) and InTableRowTag then
  begin
    Exclude(FTagState, tsInTableRowTag);
  end;
  FCurrentTagName := '';
end;

function THTMLWriter.AddTableData(aText: string): THTMLWriter;
begin
  if not InTableRowTag then
  begin
    raise ENotInTableTagException.Create(strMustBeInList);
  end;
  Result := OpenTableData.AddText(aText).CloseTag;
end;

function THTMLWriter.AddTag(aString: string; aCanAddAttributes: TCanHaveAttributes = chaCanHaveAttributes): THTMLWriter;
begin
  CloseBracket;
  Result := THTMLWriter.Create(aString, aCanAddAttributes);
  Result.FHTML := Self.FHTML + Result.FHTML;
  Result.FTagState := Result.FTagState + [tsBracketOpen];
  Result.FParent := Self;
end;

function THTMLWriter.OpenComment: THTMLWriter;
begin
  CloseBracket;
  Result := THTMLWriter.Create(cComment, chaCannotHaveAttributes);
  Result.FHTML := Self.FHTML + Result.FHTML + cSpace;
  Result.FTagState := Result.FTagState + [tsCommentOpen];
  Result.FParent := Self;
end;

function THTMLWriter.AsHTML: string;
begin
  Result := FHTML;
end;

function THTMLWriter.AddText(aString: string): THTMLWriter;
begin
  CloseBracket;
  FHTML := FHTML + aString;
  Result := Self;
end;

function THTMLWriter.AddHardRule(const aAttributes: string = ''; aUseCloseSlash: TUseCloseSlash = ucsUseCloseSlash): THTMLWriter;
begin
  CloseBracket;
  FHTML := FHTML + cOpenBracket + cHardRule;
  if not StringIsEmpty(aAttributes) then
  begin
    FHTML := FHTML + cSpace + aAttributes;
  end;
  case aUseCloseSlash of
    ucsUseCloseSlash:
      begin
        FHTML := FHTML + ' />';
      end;
    ucsDoNotUseCloseSlash:
      begin
        FHTML := FHTML + '>';
      end;
  end;
  Result := Self;
end;

function THTMLWriter.AddHead: THTMLWriter;
begin
  Result := AddTag(cHead, chaCanHaveAttributes);
  Result.FTagState := Result.FTagState + [tsInHeadTag];
end;

function THTMLWriter.AddHeading1Text(aString: string): THTMLWriter;
begin
  Result := AddHeadingText(aString, htHeading1);
end;

function THTMLWriter.AddHeading2Text(aString: string): THTMLWriter;
begin
  Result := AddHeadingText(aString, htHeading2);
end;

function THTMLWriter.AddHeading3Text(aString: string): THTMLWriter;
begin
  Result := AddHeadingText(aString, htHeading3);
end;

function THTMLWriter.AddHeading4Text(aString: string): THTMLWriter;
begin
  Result := AddHeadingText(aString, htHeading4);
end;

function THTMLWriter.AddHeading5Text(aString: string): THTMLWriter;
begin
  Result := AddHeadingText(aString, htHeading5);
end;

function THTMLWriter.AddHeading6Text(aString: string): THTMLWriter;
begin
  Result := AddHeadingText(aString, htHeading6);
end;

function THTMLWriter.OpenAnchor: THTMLWriter;
begin
  Result := AddTag(cAnchor);
end;

function THTMLWriter.OpenAnchor(const aHREF: string; aText: string): THTMLWriter;
begin
  Result := OpenAnchor.AddAttribute(cHREF, aHREF).AddText(aText);
end;

function THTMLWriter.OpenBlockQuote: THTMLWriter;
begin
  Result := AddTag(cBlockQuote, chaCanHaveAttributes);
end;

function THTMLWriter.OpenBody: THTMLWriter;
begin
  Result := AddTag(cBody, chaCanHaveAttributes);
end;

function THTMLWriter.AddBlockQuoteText(aString: string): THTMLWriter;
begin
  Result := AddTag(cBlockQuote, chaCannotHaveAttributes);
  Result.AddText(aString);
end;

function THTMLWriter.AddBoldText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftBold)
end;

function THTMLWriter.AddCitationText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftCitation);
end;

function THTMLWriter.AddClass(aClass: string): THTMLWriter;
begin
  Result := AddAttribute(cClass, aClass);
end;

function THTMLWriter.AddComment(aCommentText: string): THTMLWriter;
begin
  Result := OpenComment.AddText(aCommentText).CloseComment;
end;

function THTMLWriter.AddDivText(aString: string): THTMLWriter;
begin
  Result := AddTag(cDiv, chaCannotHaveAttributes);
  Result.AddText(aString);
end;

function THTMLWriter.AddDivTextWithID(aString, aID: string): THTMLWriter;
begin
  Result := OpenDiv.AddID(aID).AddText(aString).CloseTag;
end;

function THTMLWriter.AddDivTextWithStyle(aString, aStyle: string): THTMLWriter;
begin
  Result := OpenDiv.AddStyle(aStyle).AddText(aString).CloseTag;
end;

function THTMLWriter.AddEmphasisText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftEmphasis)
end;

function THTMLWriter.AddSpanText(aString: string): THTMLWriter;
begin
  Result := AddTag(cSpan, chaCannotHaveAttributes);
  Result.AddText(aString);
end;

function THTMLWriter.AddSpanTextWithID(aString, aID: string): THTMLWriter;
begin
  Result := OpenSpan.AddID(aID).AddText(aString).CloseTag;
end;

function THTMLWriter.AddSpanTextWithStyle(aString, aStyle: string): THTMLWriter;
begin
  Result := OpenSpan.AddStyle(aStyle).AddText(aString).CloseTag;
end;

function THTMLWriter.AddStrongText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftStrong)
end;

function THTMLWriter.AddUnderlinedText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftUnderline)
end;

function THTMLWriter.AddID(aID: string): THTMLWriter;
begin
  Result := AddAttribute(cID, aID);
end;

function THTMLWriter.AddItalicText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftItalic)
end;

function THTMLWriter.AddLineBreak(const aClearValue: TClearValue = cvNoValue; aUseCloseSlash: TUseCloseSlash = ucsUseCloseSlash): THTMLWriter;
begin
  CloseBracket;
  FHTML := FHTML + cOpenBracket + cBreak;
  if aClearValue <> cvNoValue then
  begin
    FHTML := Format('%s %s="%s"', [FHTML, cClear, TClearValueStrings[aClearValue]]);
  end;
  case aUseCloseSlash of
    ucsUseCloseSlash:
      begin
        FHTML := FHTML + cSpace + cCloseSlashBracket;
      end;
    ucsDoNotUseCloseSlash:
      begin
        FHTML := FHTML + cCloseBracket;
      end;
  end;

  Result := Self;
end;

function THTMLWriter.AddListItem(aText: string): THTMLWriter;
begin
  Result := OpenListItem.AddText(aText).CloseTag;
end;

function THTMLWriter.AddMetaNamedContent(aName, aContent: string): THTMLWriter;
begin
  if not InMetaTag then
  begin
    raise ENotInMetaTagHTMLException.Create(StrThisMethodCanOnly);
  end;
  Result := AddAttribute(cName, aName).AddAttribute(cContent, aContent);
end;

function THTMLWriter.AddParagraphText(aString: string): THTMLWriter;
begin
  Result := AddTag(cParagraph, chaCannotHaveAttributes);
  Result.AddText(aString);
end;

function THTMLWriter.AddParagraphTextWithID(aString, aID: string): THTMLWriter;
begin
  Result := OpenParagraph.AddID(aID).AddText(aString).CloseTag;
end;

function THTMLWriter.AddParagraphTextWithStyle(aString, aStyle: string): THTMLWriter;
begin
  Result := OpenParagraph.AddStyle(aStyle).AddText(aString).CloseTag;
end;

function THTMLWriter.AddPreformattedText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftPreformatted)
end;

function THTMLWriter.AddRawText(aString: string): THTMLWriter;
begin
  FHTML := FHTML + aString;
  Result := Self;
end;

function THTMLWriter.OpenParagraphWithID(aID: string): THTMLWriter;
begin
  Result := OpenParagraph.AddID(aID);
end;

function THTMLWriter.OpenParagraph: THTMLWriter;
begin
  Result := AddTag(cParagraph, chaCanHaveAttributes);
end;

function THTMLWriter.OpenParagraphWithStyle(aStyle: string): THTMLWriter;
begin
  Result := OpenParagraph.AddStyle(aStyle);
end;

function THTMLWriter.OpenPre: THTMLWriter;
begin
  Result := OpenFormatTag(ftPreformatted);
end;

function THTMLWriter.OpenSpan: THTMLWriter;
begin
  Result := AddTag(cSpan, chaCanHaveAttributes);
end;

function THTMLWriter.AddStyle(aStyle: string): THTMLWriter;
begin
  Result := AddAttribute(cStyle, aStyle);
end;

function THTMLWriter.OpenDiv: THTMLWriter;
begin
  Result := AddTag(cDiv, chaCanHaveAttributes);
end;

function THTMLWriter.AddFormattedText(aString: string; aFormatType: TFormatType): THTMLWriter;
begin
  Result := AddTag(TFormatTypeStrings[aFormatType], chaCannotHaveAttributes);
  Result.AddText(aString);
end;

function THTMLWriter.AddHeadingText(aString: string; aHeadingType: THeadingType): THTMLWriter;
begin
  Result := AddTag(THeadingTypeStrings[aHeadingType], chaCannotHaveAttributes);
  Result.AddText(aString);
end;

function THTMLWriter.AddAnchor(const aHREF: string; aText: string): THTMLWriter;
begin
  Result := OpenAnchor.AddAttribute(cHREF, aHREF).AddText(aText).CloseTag;
end;

function THTMLWriter.AddAttribute(aString: string; aValue: string = ''): THTMLWriter;
begin
  if not(tsBracketOpen in FTagState) then
  begin
    EHTMLWriterOpenTagRequiredException.CreateFmt(StrATagsBracketMust, [Self.FCurrentTagName, aString]);
  end;
  AddToHTML(' ');
  AddToHTML(aString);
  if aValue <> '' then
  begin
    AddToHTML(Format('="%s"', [aValue]));
  end;
  Result := Self;
end;

end.

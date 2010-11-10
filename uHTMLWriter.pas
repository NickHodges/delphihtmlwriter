unit uHTMLWriter;

interface

uses
  SysUtils, HTMLWriterUtils, Classes, Generics.Collections;
{$REGION 'License'}
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
{$ENDREGION}

type
{$REGION 'Documentation'}
  /// <summary>A class for creating HTML.&#160; THTMLWriter uses the fluent
  /// interface.  It can be used to create either complete HTML documents or
  /// chunks of HTML.  By using the fluent interface, you can link together
  /// number of methods to create a complete document.</summary>
{$ENDREGION}
  THTMLWriter = class(TInterfacedObject, IGetHTML, ILoadSave)
  private
    FHTML: TStringBuilder;
    FClosingTags: TStack<string>;
    FCurrentTagName: string;
    FTagState: TTagStates;
    FParent: THTMLWriter;
    FCanHaveAttributes: TCanHaveAttributes;
    procedure AddToHTML(const aString: string);
    function AddTag(aString: string; aCloseTagType: TCloseTagType = ctNormal; aCanAddAttributes: TCanHaveAttributes = chaCanHaveAttributes): THTMLWriter;
    function AddFormattedText(aString: string; aFormatType: TFormatType): THTMLWriter;
    function OpenFormatTag(aFormatType: TFormatType; aCanAddAttributes: TCanHaveAttributes = chaCannotHaveAttributes): THTMLWriter;
    function AddHeadingText(aString: string; aHeadingType: THeadingType): THTMLWriter;
{$REGION 'In Tag Type Methods'}
    function InHeadTag: Boolean;
    function InBodyTag: Boolean;
    function InCommentTag: Boolean;
    function TagIsOpen: Boolean;
    function InFormTag: Boolean;
    function InFieldSetTag: Boolean;
    function InListTag: Boolean;
    function InTableTag: Boolean;
    function InTableRowTag: Boolean;
{$ENDREGION}
{$REGION 'Close and Clean Methods'}
    procedure CloseSlashBracket;
    procedure CloseCommentTag;

    function CloseBracket: THTMLWriter;
    procedure CleanUpTagState;
{$ENDREGION}
{$REGION 'Check Methods'}
    procedure CheckInHeadTag;
    procedure CheckInCommentTag;
    procedure CheckInListTag;
    procedure CheckInFieldSetTag;
    procedure CheckInTableRowTag;
    procedure CheckInTableTag;
    procedure CheckBracketOpen(aString: string);
    procedure PushClosingTagOnStack(aCloseTagType: TCloseTagType; aString: string = '');
{$ENDREGION}
  public
    { DONE : Add support for <!DOCTYPE> tag }
    { TODO : Add support for CRLF }
{$REGION 'Constructors'}
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
    constructor Create(aTagName: string; aCloseTagType: TCloseTagType = ctNormal; aCanAddAttributes: TCanHaveAttributes = chaCanHaveAttributes);

    /// <summary>The CreateDocument constructor will create a standard HTML document.</summary>
    constructor CreateDocument; overload;
    constructor CreateDocument(aDocType: THTMLDocType); overload;
    destructor Destroy; override;
{$ENDREGION}
{$REGION 'Main Section Methods'}
    /// <summary>Opens a&lt;head&gt; tag to the document.&#160;</summary>
    function OpenHead: THTMLWriter;
{$REGION 'Documentation'}
    /// <summary>Opens a &lt;meta&gt; tag.</summary>
    /// <exception cref="EHeadTagRequiredHTMLException">Raised if an attempt&#160;is made&#160;to call this method
    /// when not inside a &lt;head&gt; tag.</exception>
    /// <remarks>Note that this method can only be called from within &lt;head&gt; tag.&#160; If it is called from
    /// anywhere else, it will raise an exception.</remarks>
{$ENDREGION}
    function OpenMeta: THTMLWriter;
    function OpenBase: THTMLWriter;
    function AddBase(aHREF: string): THTMLWriter; overload;

    /// <summary>Adds a &lt;base /&gt; tag to the HTML.</summary>
    /// <remarks>Note:&#160; this method can only be called inside an open &lt;head&gt; tag.</remarks>
    function AddBase(aTarget: TTargetType; aFrameName: string = ''): THTMLWriter; overload;

    /// <summary>Opens a &lt;title&gt; tag.</summary>
    function OpenTitle: THTMLWriter;
{$REGION 'Documentation'}
    /// <summary>Adds a &lt;title&gt; tag including the passed in text.</summary>
    /// <param name="aTitleText">The text to be placed inside the &lt;title&gt;&lt;/title&gt; tag</param>
    /// <remarks>There is no need to close this tag manually.&#160; All "AddXXXX" methods close themselves.</remarks>
{$ENDREGION}
    function AddTitle(aTitleText: string): THTMLWriter;
    function AddMetaNamedContent(aName: string; aContent: string): THTMLWriter;

    /// <summary>Opens a &lt;body&gt; tag.</summary>
    function OpenBody: THTMLWriter;
{$ENDREGION}
{$REGION 'Text Block Methods'}
    /// <summary>Opens a &lt;p&gt; tag.&#160;</summary>
    function OpenParagraph: THTMLWriter;
    /// <summary>Opens a &lt;p&gt; tag and gives it the passed in style="" attribute</summary>
    /// <param name="aStyle">The CSS-based text to be included in the style attribute for the &lt;p&gt; tag.</param>
    function OpenParagraphWithStyle(aStyle: string): THTMLWriter;
    function OpenParagraphWithID(aID: string): THTMLWriter;

    /// <summary>Opens a &lt;span&gt; tag.</summary>
    function OpenSpan: THTMLWriter;

    /// <summary>Opens a &lt;div&gt; tag.</summary>
    function OpenDiv: THTMLWriter;

    /// <summary>Opens a &lt;blockquote&gt; tag.</summary>
    function OpenBlockQuote: THTMLWriter;
{$REGION 'Documentation'}
    /// <summary>Adds the passed in text to the HTML inside of a &lt;p&gt; tag.</summary>
    /// <param name="aString">The text to be added into the &lt;p&gt; tag.</param>
{$ENDREGION}
    function AddParagraphText(aString: string): THTMLWriter;
{$REGION 'Documentation'}
    /// <summary>Adds theh passed in text into a &lt;p&gt; tag and adds in the given Style attribute.</summary>
    /// <param name="aString">The text to be added within the &lt;p&gt; tag.</param>
    /// <param name="aStyle">The value for the Style attribute&#160;to be added to the &lt;p&gt; tag.</param>
{$ENDREGION}
    function AddParagraphTextWithStyle(aString: string; aStyle: string): THTMLWriter;
    function AddParagraphTextWithID(aString: string; aID: string): THTMLWriter;

    /// <summary>Adds text inside of a &lt;span&gt; tag.</summary>
    /// <param name="aString">The text to be added inside of the &lt;span&gt;&lt;/span&gt; tag.</param>
    function AddSpanText(aString: string): THTMLWriter;
    function AddSpanTextWithStyle(aString: string; aStyle: string): THTMLWriter;
    function AddSpanTextWithID(aString: string; aID: string): THTMLWriter;

    function AddDivText(aString: string): THTMLWriter;
    function AddDivTextWithStyle(aString: string; aStyle: string): THTMLWriter;
    function AddDivTextWithID(aString: string; aID: string): THTMLWriter;
{$ENDREGION}
{$REGION 'General Formatting Methods'}
    /// <summary>Opens up a &lt;b&gt; tag. Once a tag is open, it can be added to as desired.</summary>
    function OpenBold: THTMLWriter;
    /// <summary>Opens up a &lt;i&gt; tag. Once a tag is open, it can be added to as desired.</summary>
    function OpenItalic: THTMLWriter;
    /// <summary>Opens up a &lt;u&gt; tag. Once a tag is open, it can be added to as desired.</summary>
    function OpenUnderline: THTMLWriter;
    /// <summary>Opens a &lt;em&gt; tag.</summary>
    function OpenEmphasis: THTMLWriter;
    /// <summary>Opens a &lt;strong&gt; tag.</summary>
    function OpenStrong: THTMLWriter;
    /// <summary>Opens a &lt;pre&gt; tag.</summary>
    function OpenPre: THTMLWriter;
    /// <summary>Opens a &lt;cite&gt; tag.</summary>
    function OpenCite: THTMLWriter;
    /// <summary>Opens a &lt;acronym&gt; tag.</summary>
    function OpenAcronym: THTMLWriter;
    function OpenAbbreviation: THTMLWriter;
    function OpenAddress: THTMLWriter;
    function OpenBDO: THTMLWriter;
    /// <summary>Opens a &lt;big&gt; tag.</summary>
    function OpenBig: THTMLWriter;
    /// <summary>Opens a &lt;center&gt; tag.</summary>
    function OpenCenter: THTMLWriter;
    /// <summary>Opens a &lt;code&gt; tag.</summary>
    function OpenCode: THTMLWriter;
    /// <summary>Opens a &lt;delete&gt; tag.</summary>
    function OpenDelete: THTMLWriter;
    /// <summary>Opens a &lt;dfn&gt; tag.</summary>
    function OpenDefinition: THTMLWriter;
    /// <summary>Opens a &lt;font&gt; tag.</summary>
    function OpenFont: THTMLWriter;

    function OpenKeyboard: THTMLWriter;
    function OpenQuotation: THTMLWriter;
    /// <summary>Opens a &lt;sample&gt; tag.</summary>
    function OpenSample: THTMLWriter;
    /// <summary>Opens a &lt;small&gt; tag.</summary>
    function OpenSmall: THTMLWriter;
    /// <summary>Opens a &lt;strike&gt; tag.</summary>
    function OpenStrike: THTMLWriter;
    /// <summary>Opens a &lt;tt&gt; tag.</summary>
    function OpenTeletype: THTMLWriter;
    /// <summary>Opens a &lt;var&gt; tag.</summary>
    function OpenVariable: THTMLWriter;

    function AddBoldText(aString: string): THTMLWriter;
    function AddItalicText(aString: string): THTMLWriter;
    function AddUnderlinedText(aString: string): THTMLWriter;
    function AddEmphasisText(aString: string): THTMLWriter;
    function AddStrongText(aString: string): THTMLWriter;
    function AddPreformattedText(aString: string): THTMLWriter;
    function AddCitationText(aString: string): THTMLWriter;
    function AddBlockQuoteText(aString: string): THTMLWriter;

    function AddAcronymText(aString: string): THTMLWriter;
    function AddAbbreviationText(aString: string): THTMLWriter;
    function AddAddressText(aString: string): THTMLWriter;
    function AddBDOText(aString: string): THTMLWriter;
    function AddBigText(aString: string): THTMLWriter;
    function AddCenterText(aString: string): THTMLWriter;
    function AddCodeText(aString: string): THTMLWriter;
    function AddDeleteText(aString: string): THTMLWriter;
    function AddDefinitionText(aString: string): THTMLWriter;
    function AddFontText(aString: string): THTMLWriter;
    function AddKeyboardText(aString: string): THTMLWriter;
    function AddQuotationText(aString: string): THTMLWriter;
    function AddSampleText(aString: string): THTMLWriter;
    function AddSmallText(aString: string): THTMLWriter;
    function AddStrikeText(aString: string): THTMLWriter;
    function AddTeletypeText(aString: string): THTMLWriter;
    function AddValiableText(aString: string): THTMLWriter;
{$ENDREGION}
{$REGION 'Heading Methods'}
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
{$ENDREGION}
{$REGION 'CSS Formatting Methods'}
    // CSS Formatting
    function AddStyle(aStyle: string): THTMLWriter;
    function AddClass(aClass: string): THTMLWriter;
    function AddID(aID: string): THTMLWriter;
{$ENDREGION}
{$REGION 'Miscellaneous Methods'}
{$REGION 'Documentation'}
    /// <summary>Adds an attribute to the current tag.&#160; The tag must have its bracket open.&#160;</summary>
    /// <param name="aString">The name of the attribute to be added.&#160; If this is the only parameter passed in,
    /// then this string should contain the entire attribute string.</param>
    /// <param name="aValue">Optional parameter.&#160; If this value is passed, then the first parameter become the
    /// <i>name</i>, and this one the <i>value</i>, in a <i>name=value</i> pair.</param>
    /// <exception cref="EHTMLWriterOpenTagRequiredException">Raised when this method is called on a tag that doesn't
    /// have it's bracket open.</exception>
{$ENDREGION}
    function AddAttribute(aString: string; aValue: string = ''): THTMLWriter;
    function AddLineBreak(const aClearValue: TClearValue = cvNoValue; aUseCloseSlash: TUseCloseSlash = ucsUseCloseSlash): THTMLWriter;
    function AddHardRule(const aAttributes: string = ''; aUseCloseSlash: TUseCloseSlash = ucsUseCloseSlash): THTMLWriter;
    function OpenComment: THTMLWriter;
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
{$REGION 'Documentation'}
    /// <summary>Returns a string containing the current HTML for the
    /// HTMLWriter</summary>
    /// <remarks>This property will return the HTML in whatever state it is
    /// in when called.&#160; This may mean that brackets or even tags are
    /// open, attributes hanging undone, etc.&#160;</remarks>
{$ENDREGION}
    function AsHTML: string;
    function AddComment(aCommentText: string): THTMLWriter;

    function OpenScript: THTMLWriter;
    function AddScript(aScriptText: string): THTMLWriter;
{$ENDREGION}
{$REGION 'CloseTag methods'}
    /// <summary>Closes an open tag.</summary>
    function CloseTag: THTMLWriter;
    function CloseComment: THTMLWriter;
    function CloseList: THTMLWriter;
{$ENDREGION}
{$REGION 'Image Methods'}
    function OpenImage: THTMLWriter; overload;
    function OpenImage(aImageSource: string): THTMLWriter; overload;
    function AddImage(aImageSource: string): THTMLWriter;
{$ENDREGION}
{$REGION 'Anchor Methods'}
    function OpenAnchor: THTMLWriter; overload;
    function OpenAnchor(const aHREF: string; aText: string): THTMLWriter; overload;
    function AddAnchor(const aHREF: string; aText: string): THTMLWriter;
{$ENDREGION}
{$REGION 'Table Support Methods'}
{$REGION 'Documentation'}
    /// <summary>Opens a &lt;table&gt; tag</summary>
    /// <remarks>You cannot use other table related tags (&lt;tr&gt;, &lt;td&gt;, etc.) until a &lt;table&gt; tag is
    /// open.</remarks>
{$ENDREGION}
    function OpenTable: THTMLWriter; overload;
    function OpenTable(aBorder: integer): THTMLWriter; overload;
    function OpenTable(aBorder: integer; aCellPadding: integer): THTMLWriter; overload;
    function OpenTable(aBorder: integer; aCellPadding: integer; aCellSpacing: integer): THTMLWriter; overload;
    function OpenTable(aBorder: integer; aCellPadding: integer; aCellSpacing: integer; aWidth: THTMLWidth): THTMLWriter; overload;
    { DONE -oNick : Think about how to do percentage widths }

    function OpenTableRow: THTMLWriter;
    function OpenTableData: THTMLWriter;
    function AddTableData(aText: string): THTMLWriter;
{$ENDREGION}
{$REGION 'Form Methods'}
    function OpenForm: THTMLWriter;

    { TODO -oNick : Add all supporting tags to <form> }
{$ENDREGION}
{$REGION 'FieldSet/Legend'}
    // fieldset/legend
    function OpenFieldSet: THTMLWriter;
    function OpenLegend: THTMLWriter;
    function AddLegend(aText: string): THTMLWriter;
{$ENDREGION}
{$REGION 'IFrame support'}
    function OpenIFrame: THTMLWriter; overload;
    function OpenIFrame(aURL: string): THTMLWriter; overload;
    function OpenIFrame(aURL: string; aWidth: THTMLWidth; aHeight: integer): THTMLWriter; overload;
    function AddIFrame(aURL: string; aAlternateText: string): THTMLWriter; overload;
    function AddIFrame(aURL: string; aAlternateText: string; aWidth: THTMLWidth; aHeight: integer): THTMLWriter; overload;
{$ENDREGION}
{$REGION 'List Methods'}
    function OpenUnorderedList(aBulletShape: TBulletShape = bsNone): THTMLWriter;
    function OpenOrderedList(aNumberType: TNumberType = ntNone): THTMLWriter;
    function OpenListItem: THTMLWriter;
    function AddListItem(aText: string): THTMLWriter;
{$ENDREGION}
{$REGION 'Storage Methods'}
    procedure LoadFromFile(const FileName: string); overload; virtual;
    procedure LoadFromFile(const FileName: string; Encoding: TEncoding); overload; virtual;
    procedure LoadFromStream(Stream: TStream); overload; virtual;
    procedure LoadFromStream(Stream: TStream; Encoding: TEncoding); overload; virtual;
    procedure SaveToFile(const FileName: string); overload; virtual;
    procedure SaveToFile(const FileName: string; Encoding: TEncoding); overload; virtual;
    procedure SaveToStream(Stream: TStream); overload; virtual;
    procedure SaveToStream(Stream: TStream; Encoding: TEncoding); overload; virtual;
{$ENDREGION}
    { TODO -oNick : Add <frame>  support even though frames are the spawn of satan. Seriously. They suck. }

    { TODO -oNick : add <map> <area> support so people can build image maps. Which are cool. }

    { TODO -oNick : Add <object> <param> support.  Need to make complete list of missing tags. }

  end;

implementation

{ THTMLWriter }

function THTMLWriter.CloseBracket: THTMLWriter;
begin
  if (tsBracketOpen in FTagState) and (not(tsCommentOpen in FTagState)) then
  begin
    FHTML := FHTML.Append(cCloseBracket);
    Include(FTagState, tsTagOpen);
    Exclude(FTagState, tsBracketOpen);
  end;
  Result := Self;
end;

function THTMLWriter.CloseComment: THTMLWriter;
begin
  CheckInCommentTag;
  Result := CloseTag;
end;

procedure THTMLWriter.CloseCommentTag;
var
  TempTag: string;
begin
  TempTag := FClosingTags.Pop;
  FHTML := FHTML.Append(cSpace).Append(TempTag);
  Exclude(FTagState, tsCommentOpen);
  Exclude(FTagState, tsTagOpen);
  Include(FTagState, tsTagClosed);
end;

function THTMLWriter.CloseList: THTMLWriter;
begin
  CheckInListTag;
  Result := CloseTag;
end;

procedure THTMLWriter.CloseSlashBracket;
var
  TempTag: string;
begin
  TempTag := FClosingTags.Pop;
  FHTML := FHTML.Append(cSpace).Append(TempTag);
  Exclude(FTagState, tsUseSlashClose);
  Exclude(FTagState, tsTagOpen);
end;

{ TODO -oNick : This routine needs to be cleaned up and made more efficient. }
function THTMLWriter.CloseTag: THTMLWriter;
var
  TagToAppend: string;
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
    if FClosingTags.Count = 0 then
    begin
      raise Exception.Create('The stack has nothing, but it should. ');
    end;
    TagToAppend := FClosingTags.Pop;
    FHTML.Append(TagToAppend); // FHTML.Append(cOpenBracketSlash).Append(FCurrentTagName).Append(cCloseBracket);
  end;

  CleanUpTagState;

  FParent.FHTML := Self.FHTML;
  Result := FParent;
end;

constructor THTMLWriter.Create(aTagName: string; aCloseTagType: TCloseTagType = ctNormal; aCanAddAttributes: TCanHaveAttributes = chaCanHaveAttributes);
var
  TagToPush: string;
begin
  if StringIsEmpty(aTagName) then
  begin
    raise EHTMLWriterEmptyTagException.Create(strTagNameRequired);
  end;
  FCurrentTagName := aTagName;
  FCanHaveAttributes := chaCanHaveAttributes;
  FHTML := TStringBuilder.Create;
  FHTML := FHTML.Append(cOpenBracket).Append(FCurrentTagName);
  FTagState := FTagState + [tsBracketOpen];
  FParent := Self;
  FClosingTags := TStack<string>.Create;
  PushClosingTagOnStack(aCloseTagType, aTagName);

//  TagToPush := TTagMaker.MakeCloseTag(aTagName);
//  FClosingTags.Push(TagToPush);
end;

constructor THTMLWriter.CreateDocument(aDocType: THTMLDocType);
begin
  { DONE -oNick : Not yet implemented }
  inherited Create;
  CreateDocument;
  FHTML := FHTML.Insert(0, THTMLDocTypeStrings[aDocType]);
end;

constructor THTMLWriter.CreateDocument;
begin
  Create(cHTML, ctNormal, chaCanHaveAttributes);
end;

destructor THTMLWriter.Destroy;
begin
  FHTML.Free;
  FClosingTags.Free;
  inherited;
end;

function THTMLWriter.InBodyTag: Boolean;
begin
  Result := tsInBodyTag in FTagState;
end;

function THTMLWriter.InCommentTag: Boolean;
begin
  Result := tsCommentOpen in FTagState;
end;

function THTMLWriter.InFieldSetTag: Boolean;
begin
  Result := tsInFieldSetTag in FTagState;
end;

function THTMLWriter.InFormTag: Boolean;
begin
  Result := tsInFormTag in FTagState;
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

function THTMLWriter.OpenCenter: THTMLWriter;
begin
  Result := OpenFormatTag(ftCenter);
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
  FHTML := FHTML.Append(aString);
end;

function THTMLWriter.OpenFieldSet: THTMLWriter;
begin
  Result := AddTag(cFieldSet);
  Result.FTagState := Result.FTagState + [tsInFieldSetTag];
end;

function THTMLWriter.OpenFont: THTMLWriter;
begin
  Result := OpenFormatTag(ftFont);
end;

function THTMLWriter.OpenForm: THTMLWriter;
begin
  Result := AddTag(cForm);
  Result.FTagState := Result.FTagState + [tsInFormTag];
end;

function THTMLWriter.OpenFormatTag(aFormatType: TFormatType; aCanAddAttributes: TCanHaveAttributes = chaCannotHaveAttributes): THTMLWriter;
begin
  Result := AddTag(TFormatTypeStrings[aFormatType], ctNormal, chaCannotHaveAttributes);
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
  Result := AddTag(cImage, ctSlash);
  Include(Result.FTagState, tsUseSlashClose);
end;

function THTMLWriter.OpenIFrame: THTMLWriter;
begin
  Result := AddTag(cIFrame);
end;

function THTMLWriter.OpenIFrame(aURL: string): THTMLWriter;
begin
  Result := OpenIFrame.AddAttribute(cSource, aURL);
end;

function THTMLWriter.OpenIFrame(aURL: string; aWidth: THTMLWidth; aHeight: integer): THTMLWriter;
begin
  Result := OpenIFrame(aURL).AddAttribute(aWidth.WidthString).AddAttribute(cHeight, IntToStr(aHeight));
end;

function THTMLWriter.OpenImage(aImageSource: string): THTMLWriter;
begin
  Result := AddTag(cImage, ctSlash).AddAttribute(cSource, aImageSource);
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

function THTMLWriter.OpenKeyboard: THTMLWriter;
begin
  Result := OpenFormatTag(ftKeyboard);
end;

function THTMLWriter.OpenLegend: THTMLWriter;
begin
  CheckInFieldSetTag;
  Result := AddTag(cLegend);
end;

function THTMLWriter.OpenListItem: THTMLWriter;
begin
  CheckInListTag;
  Result := AddTag(cListItem);
end;

function THTMLWriter.OpenMeta: THTMLWriter;
begin
  CheckInHeadTag;
  Result := AddTag(cMeta, ctSlash);
  Include(Result.FTagState, tsUseSlashClose);
end;

function THTMLWriter.OpenStrike: THTMLWriter;
begin
  Result := OpenFormatTag(ftStrike);
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
  Result := OpenTable(aBorder, aCellPadding, aCellSpacing, THTMLWidth.Create(-1, False));
end;

function THTMLWriter.OpenTable(aBorder: integer; aCellPadding: integer; aCellSpacing: integer; aWidth: THTMLWidth): THTMLWriter;
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
  if aWidth.Width >= 0 then
  begin
    if aWidth.IsPercentage then
    begin
      Result := Result.AddAttribute(cWidth, aWidth.AsPercentage);
    end
    else
    begin
      Result := Result.AddAttribute(aWidth.WidthString);
    end;
  end;

  Result.FTagState := Result.FTagState + [tsInTableTag];

end;

function THTMLWriter.OpenTableData: THTMLWriter;
begin
  CheckInTableRowTag;
  Result := AddTag(cTableData);
end;

function THTMLWriter.OpenTableRow: THTMLWriter;
begin
  CheckInTableTag;
  Result := AddTag(cTableRow);
  Result.FTagState := Result.FTagState + [tsInTableRowTag];
end;

function THTMLWriter.OpenTeletype: THTMLWriter;
begin
  Result := OpenFormatTag(ftTeletype);
end;

function THTMLWriter.OpenTitle: THTMLWriter;
begin
  CheckInHeadTag;
  Result := AddTag(cTitle);
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

function THTMLWriter.OpenVariable: THTMLWriter;
begin
  Result := OpenFormatTag(ftVariable);
end;

procedure THTMLWriter.SaveToFile(const FileName: string);
begin
  SaveToFile(FileName, nil);
end;

procedure THTMLWriter.SaveToFile(const FileName: string; Encoding: TEncoding);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream, Encoding);
  finally
    Stream.Free;
  end;
end;

procedure THTMLWriter.LoadFromFile(const FileName: string; Encoding: TEncoding);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(Stream, Encoding);
  finally
    Stream.Free;
  end;
end;

procedure THTMLWriter.LoadFromFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure THTMLWriter.LoadFromStream(Stream: TStream);
begin
  LoadFromStream(Stream, nil);
end;

procedure THTMLWriter.LoadFromStream(Stream: TStream; Encoding: TEncoding);
var
  SS: TStringStream;
begin
  if Encoding = nil then
  begin
    Encoding := TEncoding.Default;
  end;
  SS := TStringStream.Create('', Encoding);
  try
    SS.LoadFromStream(Stream);
    FHTML.Clear;
    FHTML.Append(SS.DataString);
  finally
    SS.Free;
  end;
end;

procedure THTMLWriter.SaveToStream(Stream: TStream; Encoding: TEncoding);
var
  SS: TStringStream;
begin
  if Encoding = nil then
  begin
    Encoding := TEncoding.Default;
  end;
  SS := TStringStream.Create(FHTML.ToString, Encoding);
  try
    Stream.CopyFrom(SS, SS.Size);
  finally
    SS.Free;
  end;
end;

procedure THTMLWriter.PushClosingTagOnStack(aCloseTagType: TCloseTagType; aString: string = '');
begin
  case aCloseTagType of
    ctNormal:
      FClosingTags.Push(TTagMaker.MakeCloseTag(aString));
    ctSlash:
      FClosingTags.Push(TTagMaker.MakeSlashCloseTag);
    ctComment:
      FClosingTags.Push(TTagMaker.MakeCommentCloseTag);
  end;
end;

procedure THTMLWriter.SaveToStream(Stream: TStream);
begin
  SaveToStream(Stream, nil);
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

{ TODO -oNick : This method needs to be reworked and made more efficient. }
procedure THTMLWriter.CleanUpTagState;
begin
  FTagState := FTagState + [tsTagClosed] - [tsTagOpen];

  if (FCurrentTagName = cFieldSet) and InFieldSetTag then
  begin
    Exclude(FTagState, tsInFieldSetTag);
  end;

  if (FCurrentTagName = cForm) and InFormTag then
  begin
    Exclude(FTagState, tsInFormTag);
  end;

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
  CheckInTableRowTag;
  Result := OpenTableData.AddText(aText).CloseTag;
end;

function THTMLWriter.AddTag(aString: string; aCloseTagType: TCloseTagType = ctNormal; aCanAddAttributes: TCanHaveAttributes = chaCanHaveAttributes): THTMLWriter;
begin
  CloseBracket;
  Result := THTMLWriter.Create(aString, aCloseTagType, aCanAddAttributes);
  Result.FHTML := Self.FHTML.Append(Result.FHTML.ToString);
  Result.FTagState := Self.FTagState + [tsBracketOpen];
  Result.FParent := Self;
//  PushClosingTagOnStack(aCloseTagType, aString);
end;

function THTMLWriter.OpenCode: THTMLWriter;
begin
  Result := OpenFormatTag(ftCode);
end;

function THTMLWriter.OpenComment: THTMLWriter;
begin
  CloseBracket;
  Result := THTMLWriter.Create(cComment, ctComment, chaCannotHaveAttributes);
  Result.FHTML := Self.FHTML.Append(Result.FHTML.ToString).Append(cSpace);
  Result.FTagState := Result.FTagState + [tsCommentOpen];
  Result.FParent := Self;
  // PushClosingTagOnStack(ctComment);
end;

function THTMLWriter.AsHTML: string;
begin
  Result := FHTML.ToString;
end;

function THTMLWriter.AddTeletypeText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftTeletype);
end;

function THTMLWriter.AddText(aString: string): THTMLWriter;
begin
  CloseBracket;
  FHTML := FHTML.Append(aString);
  Result := Self;
end;

function THTMLWriter.AddTitle(aTitleText: string): THTMLWriter;
begin
  CheckInHeadTag;
  Result := OpenTitle.AddText(aTitleText).CloseTag;
end;

function THTMLWriter.AddHardRule(const aAttributes: string = ''; aUseCloseSlash: TUseCloseSlash = ucsUseCloseSlash): THTMLWriter;
begin
  CloseBracket;
  FHTML := FHTML.Append(cOpenBracket).Append(cHardRule);
  if not StringIsEmpty(aAttributes) then
  begin
    FHTML := FHTML.Append(cSpace).Append(aAttributes);
  end;
  case aUseCloseSlash of
    ucsUseCloseSlash:
      begin
        FHTML := FHTML.Append(cSpace).Append(cCloseSlashBracket);
      end;
    ucsDoNotUseCloseSlash:
      begin
        FHTML := FHTML.Append(cCloseBracket);
      end;
  end;
  Result := Self;
end;

function THTMLWriter.OpenHead: THTMLWriter;
begin
  Result := AddTag(cHead, ctNormal, chaCanHaveAttributes);
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

function THTMLWriter.OpenAbbreviation: THTMLWriter;
begin
  Result := OpenFormatTag(ftAbbreviation);
end;

function THTMLWriter.OpenAcronym: THTMLWriter;
begin
  Result := OpenFormatTag(ftAcronym);
end;

function THTMLWriter.OpenAddress: THTMLWriter;
begin
  Result := OpenFormatTag(ftAddress);
end;

function THTMLWriter.OpenAnchor(const aHREF: string; aText: string): THTMLWriter;
begin
  Result := OpenAnchor.AddAttribute(cHREF, aHREF).AddText(aText);
end;

function THTMLWriter.OpenBase: THTMLWriter;
begin
  CheckInHeadTag;
  Result := AddTag(cBase, ctSlash);
  Result.FTagState := Result.FTagState + [tsUseSlashClose];
end;

function THTMLWriter.OpenBDO: THTMLWriter;
begin
  Result := OpenFormatTag(ftBDO);
end;

function THTMLWriter.OpenBig: THTMLWriter;
begin
  Result := OpenFormatTag(ftBig);
end;

function THTMLWriter.OpenBlockQuote: THTMLWriter;
begin
  Result := AddTag(cBlockQuote, ctNormal, chaCanHaveAttributes);
end;

function THTMLWriter.OpenBody: THTMLWriter;
begin
  Result := AddTag(cBody, ctNormal, chaCanHaveAttributes);
end;

function THTMLWriter.AddBase(aHREF: string): THTMLWriter;
begin
  CheckInHeadTag;
  Result := OpenBase.AddAttribute(cHREF, aHREF).CloseTag;
end;

function THTMLWriter.AddBase(aTarget: TTargetType; aFrameName: string = ''): THTMLWriter;
begin
  if aTarget = ttFrameName then
  begin
    Result := OpenBase.AddAttribute(cTarget, aFrameName).CloseTag;
  end
  else
  begin
    Result := OpenBase.AddAttribute(cTarget, TTargetTypeStrings[aTarget]).CloseTag;
  end;
end;

function THTMLWriter.AddBDOText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftBDO);
end;

function THTMLWriter.AddBigText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftBig);
end;

function THTMLWriter.AddBlockQuoteText(aString: string): THTMLWriter;
begin
  Result := AddTag(cBlockQuote, ctNormal, chaCannotHaveAttributes).AddText(aString).CloseTag;
end;

function THTMLWriter.AddBoldText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftBold)
end;

function THTMLWriter.AddCenterText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftCenter);
end;

function THTMLWriter.AddCitationText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftCitation);
end;

function THTMLWriter.AddClass(aClass: string): THTMLWriter;
begin
  Result := AddAttribute(cClass, aClass);
end;

function THTMLWriter.AddCodeText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftCode);
end;

function THTMLWriter.AddComment(aCommentText: string): THTMLWriter;
begin
  Result := OpenComment.AddText(aCommentText).CloseComment;
end;

function THTMLWriter.AddDefinitionText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftDefinition);
end;

function THTMLWriter.AddDeleteText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftDelete);
end;

function THTMLWriter.AddDivText(aString: string): THTMLWriter;
begin
  Result := AddTag(TBlockTypeStrings[btDiv], ctNormal, chaCannotHaveAttributes).AddText(aString).CloseTag;
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

function THTMLWriter.AddSampleText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftSample);
end;

function THTMLWriter.AddScript(aScriptText: string): THTMLWriter;
begin
  Result := OpenScript.AddText(aScriptText).CloseTag;
end;

function THTMLWriter.AddSmallText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftSmall);
end;

function THTMLWriter.AddSpanText(aString: string): THTMLWriter;
begin
  Result := AddTag(TBlockTypeStrings[btSpan], ctNormal, chaCannotHaveAttributes).AddText(aString).CloseTag;
end;

function THTMLWriter.AddSpanTextWithID(aString, aID: string): THTMLWriter;
begin
  Result := OpenSpan.AddID(aID).AddText(aString).CloseTag;
end;

function THTMLWriter.AddSpanTextWithStyle(aString, aStyle: string): THTMLWriter;
begin
  Result := OpenSpan.AddStyle(aStyle).AddText(aString).CloseTag;
end;

function THTMLWriter.AddStrikeText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftStrike);
end;

function THTMLWriter.AddStrongText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftStrong)
end;

function THTMLWriter.AddUnderlinedText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftUnderline)
end;

function THTMLWriter.AddValiableText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftVariable)
end;

function THTMLWriter.AddID(aID: string): THTMLWriter;
begin
  Result := AddAttribute(cID, aID);
end;

function THTMLWriter.AddIFrame(aURL, aAlternateText: string): THTMLWriter;
begin
  Result := OpenIFrame(aURL).AddText(aAlternateText).CloseTag;
end;

function THTMLWriter.AddIFrame(aURL, aAlternateText: string; aWidth: THTMLWidth; aHeight: integer): THTMLWriter;
begin
  Result := OpenIFrame(aURL, aWidth, aHeight).AddText(aAlternateText).CloseTag;
end;

function THTMLWriter.AddItalicText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftItalic)
end;

function THTMLWriter.AddKeyboardText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftKeyboard)
end;

function THTMLWriter.AddLegend(aText: string): THTMLWriter;
begin
  Result := OpenLegend.AddText(aText).CloseTag;
end;

function THTMLWriter.AddLineBreak(const aClearValue: TClearValue = cvNoValue; aUseCloseSlash: TUseCloseSlash = ucsUseCloseSlash): THTMLWriter;
begin
  CloseBracket;
  FHTML := FHTML.Append(cOpenBracket).Append(cBreak);
  if aClearValue <> cvNoValue then
  begin
    FHTML := FHTML.Append(cSpace).AppendFormat('%s="%s"', [cClear, TClearValueStrings[aClearValue]]);
  end;
  case aUseCloseSlash of
    ucsUseCloseSlash:
      begin
        FHTML := FHTML.Append(cSpace).Append(cCloseSlashBracket);
      end;
    ucsDoNotUseCloseSlash:
      begin
        FHTML := FHTML.Append(cCloseBracket);
      end;
  end;

  Result := Self;
end;

function THTMLWriter.AddListItem(aText: string): THTMLWriter;
begin
  Result := OpenListItem.AddText(aText).CloseTag;
end;

procedure THTMLWriter.CheckBracketOpen(aString: string);
begin
  if not(tsBracketOpen in FTagState) then
  begin
    raise EHTMLWriterOpenTagRequiredException.CreateFmt(StrATagsBracketMust, [Self.FCurrentTagName, aString]);
  end;
end;

procedure THTMLWriter.CheckInTableTag;
begin
  if not InTableTag then
  begin
    raise ENotInTableTagException.Create(strMustBeInList);
  end;
end;

procedure THTMLWriter.CheckInTableRowTag;
begin
  if not InTableRowTag then
  begin
    raise ENotInTableTagException.Create(strMustBeInList);
  end;
end;

procedure THTMLWriter.CheckInListTag;
begin
  if not InListTag then
  begin
    raise ENotInListTagException.Create(strMustBeInList);
  end;
end;

procedure THTMLWriter.CheckInCommentTag;
begin
  if not InCommentTag then
  begin
    raise ENotInCommentTagException.Create(strMustBeInComment);
  end;
end;

procedure THTMLWriter.CheckInFieldSetTag;
begin
  if not InFieldSetTag then
  begin
    raise ENotInFieldsetTagException.Create(strNotInFieldTag);
  end;
end;

procedure THTMLWriter.CheckInHeadTag;
begin
  if not InHeadTag then
  begin
    raise EHeadTagRequiredHTMLException.Create(strAMetaTagCanOnly);
  end;
end;

function THTMLWriter.AddMetaNamedContent(aName, aContent: string): THTMLWriter;
begin
  CheckInHeadTag;
  Result := AddAttribute(cName, aName).AddAttribute(cContent, aContent);
end;

function THTMLWriter.AddParagraphText(aString: string): THTMLWriter;
begin
  Result := AddTag(TBlockTypeStrings[btParagraph], ctNormal, chaCannotHaveAttributes).AddText(aString).CloseTag;
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

function THTMLWriter.AddQuotationText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftQuotation)
end;

function THTMLWriter.AddRawText(aString: string): THTMLWriter;
begin
  FHTML := FHTML.Append(aString);
  Result := Self;
end;

function THTMLWriter.OpenParagraphWithID(aID: string): THTMLWriter;
begin
  Result := OpenParagraph.AddID(aID);
end;

function THTMLWriter.OpenParagraph: THTMLWriter;
begin
  Result := AddTag(TBlockTypeStrings[btParagraph], ctNormal, chaCanHaveAttributes);
end;

function THTMLWriter.OpenParagraphWithStyle(aStyle: string): THTMLWriter;
begin
  Result := OpenParagraph.AddStyle(aStyle);
end;

function THTMLWriter.OpenPre: THTMLWriter;
begin
  Result := OpenFormatTag(ftPreformatted);
end;

function THTMLWriter.OpenQuotation: THTMLWriter;
begin
  Result := OpenFormatTag(ftQuotation);
end;

function THTMLWriter.OpenSample: THTMLWriter;
begin
  Result := OpenFormatTag(ftSample);
end;

function THTMLWriter.OpenScript: THTMLWriter;
begin
  Result := AddTag(cScript);
end;

function THTMLWriter.OpenSmall: THTMLWriter;
begin
  Result := OpenFormatTag(ftSmall);
end;

function THTMLWriter.OpenSpan: THTMLWriter;
begin
  Result := AddTag(TBlockTypeStrings[btSpan], ctNormal, chaCanHaveAttributes);
end;

function THTMLWriter.AddStyle(aStyle: string): THTMLWriter;
begin
  Result := AddAttribute(cStyle, aStyle);
end;

function THTMLWriter.OpenDefinition: THTMLWriter;
begin
  Result := OpenFormatTag(ftDefinition);
end;

function THTMLWriter.OpenDelete: THTMLWriter;
begin
  Result := OpenFormatTag(ftDelete);
end;

function THTMLWriter.OpenDiv: THTMLWriter;
begin
  Result := AddTag(TBlockTypeStrings[btDiv], ctNormal, chaCanHaveAttributes);
end;

function THTMLWriter.AddFontText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftFont);
end;

function THTMLWriter.AddFormattedText(aString: string; aFormatType: TFormatType): THTMLWriter;
begin
  Result := AddTag(TFormatTypeStrings[aFormatType], ctNormal, chaCannotHaveAttributes).AddText(aString).CloseTag;
end;

function THTMLWriter.AddHeadingText(aString: string; aHeadingType: THeadingType): THTMLWriter;
begin
  Result := AddTag(THeadingTypeStrings[aHeadingType], ctNormal, chaCannotHaveAttributes).AddText(aString).CloseTag;
end;

function THTMLWriter.AddAbbreviationText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftAbbreviation);
end;

function THTMLWriter.AddAcronymText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftAcronym);
end;

function THTMLWriter.AddAddressText(aString: string): THTMLWriter;
begin
  Result := AddFormattedText(aString, ftAddress);
end;

function THTMLWriter.AddAnchor(const aHREF: string; aText: string): THTMLWriter;
begin
  Result := OpenAnchor.AddAttribute(cHREF, aHREF).AddText(aText).CloseTag;
end;

function THTMLWriter.AddAttribute(aString: string; aValue: string = ''): THTMLWriter;
begin
  CheckBracketOpen(aString);
  AddToHTML(' ');
  AddToHTML(aString);
  if aValue <> '' then
  begin
    AddToHTML(Format('="%s"', [aValue]));
  end;
  Result := Self;
end;

end.

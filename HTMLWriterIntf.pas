unit HTMLWriterIntf;

interface

uses
      HTMLWriterUtils
    , Classes
    , SysUtils
    ;

type

  IHTMLWriter = interface
  ['{7D6CC975-3FAB-453C-8BAB-45D6E55DE376}']
    function GetAttribute(const Name, Value: string): IHTMLWriter;
    function GetErrorLevels: THTMLErrorLevels;
    procedure SetErrorLevels(const Value: THTMLErrorLevels);
    function GetHTML: TStringBuilder;


    function AddTag(aString: string; aCloseTagType: TCloseTagType = ctNormal; aCanAddAttributes: TCanHaveAttributes = chaCanHaveAttributes): IHTMLWriter;
    /// <summary>Opens a&lt;head&gt; tag to the document.  </summary>
    function OpenHead: IHTMLWriter;
    function OpenMeta: IHTMLWriter;
    function OpenBase: IHTMLWriter;
    function OpenBaseFont: IHTMLWriter;
    ///	<summary>Adds a &lt;base /&gt; tag to the HTML.</summary>
    ///	<remarks>Note: This method can only be called inside an open &lt;head&gt; tag.</remarks>
    function AddBase(aTarget: TTargetType; aFrameName: string = ''): IHTMLWriter; overload;
    function AddBase(aHREF: string): IHTMLWriter; overload;
    /// <summary>Opens a &lt;title&gt; tag.</summary>
    function OpenTitle: IHTMLWriter;
    {$REGION 'Documentation'}
    /// <summary>Adds a &lt;title&gt; tag including the passed in text.</summary>
    /// <param name="aTitleText">The text to be placed inside the &lt;title&gt;&lt;/title&gt; tag</param>
    /// <remarks>There is no need to close this tag manually.   All "AddXXXX" methods close themselves.</remarks>
    {$ENDREGION}
    function AddTitle(aTitleText: string): IHTMLWriter;
    function AddMetaNamedContent(aName: string; aContent: string): IHTMLWriter;
    /// <summary>Opens a &lt;body&gt; tag.</summary>
    function OpenBody: IHTMLWriter;
    function OpenParagraph: IHTMLWriter;
    function OpenParagraphWithStyle(aStyle: string): IHTMLWriter;
    function OpenParagraphWithID(aID: string): IHTMLWriter;
    function OpenSpan: IHTMLWriter;
    function OpenDiv: IHTMLWriter;
    function OpenBlockQuote: IHTMLWriter;
    function AddParagraphText(aString: string): IHTMLWriter;
    function AddParagraphTextWithStyle(aString: string; aStyle: string): IHTMLWriter;
    function AddParagraphTextWithID(aString: string; aID: string): IHTMLWriter;
    function AddSpanText(aString: string): IHTMLWriter;
    function AddSpanTextWithStyle(aString: string; aStyle: string): IHTMLWriter;
    function AddSpanTextWithID(aString: string; aID: string): IHTMLWriter;
    function AddDivText(aString: string): IHTMLWriter;
    function AddDivTextWithStyle(aString: string; aStyle: string): IHTMLWriter;
    function AddDivTextWithID(aString: string; aID: string): IHTMLWriter;
    function OpenBold: IHTMLWriter;
    function OpenItalic: IHTMLWriter;
    function OpenUnderline: IHTMLWriter;
    function OpenEmphasis: IHTMLWriter;
    function OpenStrong: IHTMLWriter;
    function OpenPre: IHTMLWriter;
    function OpenCite: IHTMLWriter;
    function OpenAcronym: IHTMLWriter;
    function OpenAbbreviation: IHTMLWriter;
    function OpenAddress: IHTMLWriter;
    function OpenBDO: IHTMLWriter;
    function OpenBig: IHTMLWriter;
    function OpenCenter: IHTMLWriter;
    function OpenCode: IHTMLWriter;
    function OpenDelete: IHTMLWriter;
    function OpenDefinition: IHTMLWriter;
    function OpenFont: IHTMLWriter;
    function OpenKeyboard: IHTMLWriter;
    function OpenQuotation: IHTMLWriter;
    function OpenSample: IHTMLWriter;
    function OpenSmall: IHTMLWriter;
    function OpenStrike: IHTMLWriter;
    function OpenTeletype: IHTMLWriter;
    function OpenVariable: IHTMLWriter;
    function OpenInsert: IHTMLWriter;
    function AddBoldText(aString: string): IHTMLWriter;
    function AddItalicText(aString: string): IHTMLWriter;
    function AddUnderlinedText(aString: string): IHTMLWriter;
    function AddEmphasisText(aString: string): IHTMLWriter;
    function AddStrongText(aString: string): IHTMLWriter;
    function AddPreformattedText(aString: string): IHTMLWriter;
    function AddCitationText(aString: string): IHTMLWriter;
    function AddBlockQuoteText(aString: string): IHTMLWriter;
    function AddAcronymText(aString: string): IHTMLWriter;
    function AddAbbreviationText(aString: string): IHTMLWriter;
    function AddAddressText(aString: string): IHTMLWriter;
    function AddBDOText(aString: string): IHTMLWriter;
    function AddBigText(aString: string): IHTMLWriter;
    function AddCenterText(aString: string): IHTMLWriter;
    function AddCodeText(aString: string): IHTMLWriter;
    function AddDeleteText(aString: string): IHTMLWriter;
    function AddDefinitionText(aString: string): IHTMLWriter;
    function AddFontText(aString: string): IHTMLWriter;
    function AddKeyboardText(aString: string): IHTMLWriter;
    function AddQuotationText(aString: string): IHTMLWriter;
    function AddSampleText(aString: string): IHTMLWriter;
    function AddSmallText(aString: string): IHTMLWriter;
    function AddStrikeText(aString: string): IHTMLWriter;
    function AddTeletypeText(aString: string): IHTMLWriter;
    function AddVariableText(aString: string): IHTMLWriter;
    function AddInsertText(aString: string): IHTMLWriter;
    function OpenHeading1: IHTMLWriter;
    function OpenHeading2: IHTMLWriter;
    function OpenHeading3: IHTMLWriter;
    function OpenHeading4: IHTMLWriter;
    function OpenHeading5: IHTMLWriter;
    function OpenHeading6: IHTMLWriter;
    function AddHeading1Text(aString: string): IHTMLWriter;
    function AddHeading2Text(aString: string): IHTMLWriter;
    function AddHeading3Text(aString: string): IHTMLWriter;
    function AddHeading4Text(aString: string): IHTMLWriter;
    function AddHeading5Text(aString: string): IHTMLWriter;
    function AddHeading6Text(aString: string): IHTMLWriter;
    function AddStyle(aStyle: string): IHTMLWriter;
    function AddClass(aClass: string): IHTMLWriter;
    function AddID(aID: string): IHTMLWriter;
    function AddAttribute(aString: string; aValue: string = ''): IHTMLWriter;
    function AddLineBreak(const aClearValue: TClearValue = cvNoValue; aUseEmptyTag: TIsEmptyTag = ietIsEmptyTag): IHTMLWriter;
    function AddHardRule(const aAttributes: string = ''; aUseEmptyTag: TIsEmptyTag = ietIsEmptyTag): IHTMLWriter;
    function CRLF: IHTMLWriter;
    function Indent(aNumberofSpaces: integer): IHTMLWriter;
    function OpenComment: IHTMLWriter;
    function AddText(aString: string): IHTMLWriter;
    function AddRawText(aString: string): IHTMLWriter;
    function AsHTML: string;
    function AddComment(aCommentText: string): IHTMLWriter;
    function OpenScript: IHTMLWriter;
    function AddScript(aScriptText: string): IHTMLWriter;
    function OpenNoScript: IHTMLWriter;
    function OpenLink: IHTMLWriter;
    function CloseTag(aUseCRLF: TUseCRLFOptions = ucoNoCRLF): IHTMLWriter;
    function CloseComment: IHTMLWriter;
    function CloseList: IHTMLWriter;
    function CloseTable: IHTMLWriter;
    function CloseForm: IHTMLWriter;
    function CloseDocument: IHTMLWriter;
    function OpenImage: IHTMLWriter; overload;
    function OpenImage(aImageSource: string): IHTMLWriter; overload;
    function AddImage(aImageSource: string): IHTMLWriter;
    function OpenAnchor: IHTMLWriter; overload;
    function OpenAnchor(aName: string): IHTMLWriter; overload;
    function OpenAnchor(const aHREF: string; aText: string): IHTMLWriter; overload;
    function AddAnchor(const aHREF: string; aText: string): IHTMLWriter; overload;
    function OpenTable: IHTMLWriter; overload;
    function OpenTable(aBorder: integer): IHTMLWriter; overload;
    function OpenTable(aBorder: integer; aCellPadding: integer): IHTMLWriter; overload;
    function OpenTable(aBorder: integer; aCellPadding: integer; aCellSpacing: integer): IHTMLWriter; overload;
    function OpenTable(aBorder: integer; aCellPadding: integer; aCellSpacing: integer; aWidth: THTMLWidth): IHTMLWriter; overload;
    function OpenTableRow: IHTMLWriter;
    function OpenTableData: IHTMLWriter;
    function AddTableData(aText: string): IHTMLWriter;
    function AddCaption(aCaption: string): IHTMLWriter;
    function OpenForm(aActionURL: string = ''; aMethod: TFormMethod = fmGet): IHTMLWriter;
    function OpenInput: IHTMLWriter; overload;
    function OpenInput(aType: TInputType; aName: string = ''): IHTMLWriter; overload;
    function OpenButton(aName: string): IHTMLWriter;
    function OpenLabel: IHTMLWriter; overload;
    function OpenLabel(aFor: string): IHTMLWriter; overload;
    function OpenFieldSet: IHTMLWriter;
    function OpenLegend: IHTMLWriter;
    function AddLegend(aText: string): IHTMLWriter;
    /// <summary>Opens an &lt;iframe&gt; tag.</summary>
    function OpenIFrame: IHTMLWriter; overload;
    /// <summary>Opens an &lt;iframe&gt; tag and adds a url parameter</summary>
    /// <param name="aURL">The value to be added with the url parameter.</param>
    function OpenIFrame(aURL: string): IHTMLWriter; overload;
    function OpenIFrame(aURL: string; aWidth: THTMLWidth; aHeight: integer): IHTMLWriter; overload;
    function AddIFrame(aURL: string; aAlternateText: string): IHTMLWriter; overload;
    function AddIFrame(aURL: string; aAlternateText: string; aWidth: THTMLWidth; aHeight: integer): IHTMLWriter; overload;
    /// <summary>Opens an unordered list tag (&lt;ul&gt;)</summary>
    /// <param name="aBulletShape">An optional parameter indicating the bullet type that the list should use.</param>
    /// <seealso cref="TBulletShape">TBulletShape</seealso>
    function OpenUnorderedList(aBulletShape: TBulletShape = bsNone): IHTMLWriter;
    {$REGION 'Documentation'}
    /// <summary>Opens an ordered list tag (&lt;ol&gt;)</summary>
    /// <param name="aNumberType">An optional parameter indicating the numbering type that the list should use.</param>
    /// <seealso cref="TNumberType">TNumberType</seealso>
    {$ENDREGION}

    function OpenOrderedList(aNumberType: TNumberType = ntNone): IHTMLWriter;
    /// <summary>Opens a list item (&lt;li&gt;) inside of a list.</summary>
    function OpenListItem: IHTMLWriter;
    /// <summary>Adds a List item (&lt;li&gt;) with the given text</summary>
    /// <param name="aText">The text to be added to the list item.</param>
    function AddListItem(aText: string): IHTMLWriter;
    procedure LoadFromFile(const FileName: string); overload;
    procedure LoadFromFile(const FileName: string; Encoding: TEncoding); overload;
    procedure LoadFromStream(Stream: TStream); overload;
    procedure LoadFromStream(Stream: TStream; Encoding: TEncoding); overload;
    procedure SaveToFile(const FileName: string); overload;
    procedure SaveToFile(const FileName: string; Encoding: TEncoding); overload;
    procedure SaveToStream(Stream: TStream); overload;
    procedure SaveToStream(Stream: TStream; Encoding: TEncoding); overload;
    ///	<summary>Opens a &lt;frameset&gt; tag.</summary>
    ///	<remarks>This tag is not part of the HTML5 specification.</remarks>
    function OpenFrameset: IHTMLWriter;
    {$REGION 'Documentation'}
    /// <summary>Opens a &lt;frame&gt; tag.</summary>
    /// <exception cref="ENotInFrameSetHTMLException">Raised if this is called outside of a &lt;frameset&gt;
    /// tag.</exception>
    ///	<remarks>This tag is not part of the HTML5 specification.</remarks>
    {$ENDREGION}
    function OpenFrame: IHTMLWriter;
    /// <summary>Opens a &lt;noframes&gt; tag.</summary>
    ///	<remarks>This tag is not part of the HTML5 specification.</remarks>
    function OpenNoFrames: IHTMLWriter;
    /// <summary>Opens a &lt;map /&gt; tag</summary>
    function OpenMap: IHTMLWriter;
    /// <summary>Opens an &lt;area /&gt; tag</summary>
    function OpenArea: IHTMLWriter;
    /// <summary>Opens an &lt;object&gt; tag</summary>
    function OpenObject: IHTMLWriter;
    {$REGION 'Documentation'}
    /// <summary>Opens a &lt;param&gt; tag</summary>
    /// <param name="aName">The name for the parameter</param>
    /// <param name="aValue">The value to be assigned to the paramter</param>
    /// <remarks>This tag can only be used inside of an &lt;object&gt; tag.</remarks>
    /// <exception cref="ENotInObjectTagException">Raised if this method is called outside of an &lt;object&gt;
    /// tag</exception>
    {$ENDREGION}
    function OpenParam(aName: string; aValue: string = ''): IHTMLWriter; // name parameter is required
    property Attribute[const Name: string; const Value: string]: IHTMLWriter read GetAttribute; default;
    ///	<summary>Property determining the level of error reporting that the class should provide.</summary>
    property ErrorLevels: THTMLErrorLevels read GetErrorLevels write SetErrorLevels;
    property HTML: TStringBuilder read GetHTML;

end;

implementation

end.

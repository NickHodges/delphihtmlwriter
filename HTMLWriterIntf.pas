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
    function OpenHead: IHTMLWriter;
    function OpenMeta: IHTMLWriter;
    function OpenBase: IHTMLWriter;
    function OpenBaseFont: IHTMLWriter;
    function AddBase(aTarget: TTargetType; aFrameName: string = ''): IHTMLWriter; overload;
    function AddBase(aHREF: string): IHTMLWriter; overload;
    function OpenTitle: IHTMLWriter;
    {$REGION 'Documentation'}
    /// <summary>Adds a &lt;title&gt; tag including the passed in text.</summary>
    /// <param name="aTitleText">The text to be placed inside the &lt;title&gt;&lt;/title&gt; tag</param>
    /// <remarks>There is no need to close this tag manually.   All "AddXXXX" methods close themselves.</remarks>
    {$ENDREGION}
    function AddTitle(aTitleText: string): IHTMLWriter;
    function AddMetaNamedContent(aName: string; aContent: string): IHTMLWriter;
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
    function OpenIFrame: IHTMLWriter; overload;
    function OpenIFrame(aURL: string): IHTMLWriter; overload;
    function OpenIFrame(aURL: string; aWidth: THTMLWidth; aHeight: integer): IHTMLWriter; overload;
    function AddIFrame(aURL: string; aAlternateText: string): IHTMLWriter; overload;
    function AddIFrame(aURL: string; aAlternateText: string; aWidth: THTMLWidth; aHeight: integer): IHTMLWriter; overload;
    function OpenUnorderedList(aBulletShape: TBulletShape = bsNone): IHTMLWriter;
    function OpenOrderedList(aNumberType: TNumberType = ntNone): IHTMLWriter;
    function OpenListItem: IHTMLWriter;
    function AddListItem(aText: string): IHTMLWriter;
    procedure LoadFromFile(const FileName: string); overload;
    procedure LoadFromFile(const FileName: string; Encoding: TEncoding); overload;
    procedure LoadFromStream(Stream: TStream); overload;
    procedure LoadFromStream(Stream: TStream; Encoding: TEncoding); overload;
    procedure SaveToFile(const FileName: string); overload;
    procedure SaveToFile(const FileName: string; Encoding: TEncoding); overload;
    procedure SaveToStream(Stream: TStream); overload;
    procedure SaveToStream(Stream: TStream; Encoding: TEncoding); overload;
    function OpenFrameset: IHTMLWriter;
    function OpenFrame: IHTMLWriter;
    function OpenNoFrames: IHTMLWriter;
    function OpenMap: IHTMLWriter;
    function OpenArea: IHTMLWriter;
    function OpenObject: IHTMLWriter;
    function OpenParam(aName: string; aValue: string = ''): IHTMLWriter; // name parameter is required
    property Attribute[const Name: string; const Value: string]: IHTMLWriter read GetAttribute; default;
    property ErrorLevels: THTMLErrorLevels read GetErrorLevels write SetErrorLevels;
    property HTML: TStringBuilder read GetHTML;

end;

implementation

end.

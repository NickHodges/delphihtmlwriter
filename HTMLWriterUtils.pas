unit HTMLWriterUtils;
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

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  POSSIBILITY OF SUCH DAMAGE.

  }
{$ENDREGION}

interface

uses SysUtils, Classes, Generics.Collections;


resourcestring
  strCaptionMustBeFirst = 'A <caption> tag must be the very first tag after a <table> tag.';
  strATagsBracketMust = 'A tag''s bracket must be open to add an attribute.  The Current tag is %s and the attribute being added is %s';
  strTagNameRequired = 'The aTagName parameter of the THTMLWriter constructor cannot be an empty string.';
  strOpenBracketImpossible = 'It should be impossible that the bracket is open here. Seeing this error means a very bad logic problem.';
  strAMetaTagCanOnly = 'This tag can only be added inside a <head> tag.';
  strThisMethodCanOnly = 'This method can only be called inside a <meta> tag.';
  strClosingClosedTag = 'An attempt is being made to close a tag that is already closed.';
  strMustBeInList = 'A list must be open in order to call CloseList.';
  strMustBeInTable = 'A <table> tag must be open in order to call this.';
  strMustBeInTableRow = 'A <tr> tag must be open to call this.';
  strMustBeInComment = 'A comment must be open in order to call CloseComment';
  strNotInFieldTag = 'A fieldset must be open to add this tag.';
  strNoClosingTag = 'The FClosingTag field is empty, and that should never be the case.';
  strNotInFrameSet = 'A <frame> tag can only be added inside of a <frameset> tag.';
  strNotInMapTag = 'An <area> tag can only be added inside of a <map> tag.';
  strNotInFormTag = 'A <form> tag must be open in order to call this.';
  strMustBeInObject = 'An <object> tag must be open in order to call this.';
  strOtherTagsOpen = 'The document cannot be closed -- there are non-<html> tags still open.';
  strCantOpenCaptionOutsideTable = 'A <caption> tag can only be added immediately after a <table> tag';
  strParamNameRequired = 'The name of a <param> tag cannot be empty';
  strDeprecatedTag = 'The %s tag is deprecated  in HTML %s.x.';
  strMustBeInSelectTag = 'A <select> tag must be open in order to use this tag.';
  strCantOpenColOutsideTable = 'The <col> tag must be opened inside of a <table> tag';
  strBadTagAfterTableContent = 'This tag cannot be added after table content has been added (<tr>, <th>, <tbody>, <tfoot>, etc.)';
  strMustBeInDefinitionList = 'This tag can only be included in a Definition List <dl> tag.';
  strCannotNestDefLists = 'You cannot nest a definition list inside another definition list';
  strCannotAddDefItemWithoutDefTerm = 'You cannot add a <dd> tag except right after a <dl> tag or another <dd> tag';

type
  IGetHTML = interface
    ['{FB072C2E-B4B4-43BE-9D1A-3BB870883144}']
    function AsHTML: string;
  end;

  TIsPercentage = (ipIsPercentage, ipIsNotPercentage);


  /// <summary>A data structure that holds a width, and then publishes that width in various ways useful in
  /// HTML.</summary>
  THTMLWidth = record
    Width: integer;
    IsPercentage: TIsPercentage;
    constructor Create(aWidth: integer; aIsPercentage: TIsPercentage);
    function AsPercentage: string;
    function WidthString: string;
    function WidthAsString: string;
  end;


type
  EHTMLWriterException = class(Exception);
    EEmptyTagHTMLWriterException = class(EHTMLWriterException); // Tested
    EOpenTagRequiredHTMLWriterException = class(EHTMLWriterException); //Tested
    EHeadTagRequiredHTMLException = class(EHTMLWriterException); // Tested
    ETryingToCloseClosedTag = class(EHTMLWriterException); // Tested
    ENotInListTagException = class(EHTMLWriterException); // Tested
    ENotInTableTagException = class(EHTMLWriterException); // Tested
    ENotInCommentTagException = class(EHTMLWriterException); // Tested
    ENotInFieldsetTagException = class(EHTMLWriterException); // Tested
    ENoClosingTagHTMLWriterException = class(EHTMLWriterException);
    ENotInFrameSetHTMLException = class(EHTMLWriterException); // Tested
    ENotInMapTagHTMLException = class(EHTMLWriterException); // Tested
    ENotInFormTagHTMLException = class(EHTMLWriterException); // Tested
    ENotInObjectTagException = class(EHTMLWriterException); // Tested
    EClosingDocumentWithOpenTagsHTMLException = class(EHTMLWriterException); // Tested.
    ETableTagNotOpenHTMLWriterException = class(EHTMLWriterException); // Tested
    EParamNameRequiredHTMLWriterException = class(EHTMLWriterException); // Tested
    ETagIsDeprecatedHTMLWriterException = class(EHTMLWriterException); // Tested
    ENotInSelectTextHTMLWriterException = class(EHTMLWriterException); // Tested
    ECaptionMustBeFirstHTMLWriterException = class(EHTMLWriterException); // Tested
    EBadTagAfterTableContentHTMLWriter = class(EHTMLWriterException); // Tested
    ENotInDefinitionListHTMLError = class(EHTMLWriterException); // Tested
    ECannotNestDefinitionListsHTMLWriterException = class(EHTMLWriterException); // Tested
    ECannotAddDefItemWithoutDefTermHTMLWriterException = class(EHTMLWriterException); //Tested


  type
{$REGION 'Documentation'}
    /// <summary>Enumeration that defines the various states that a tag can be in.</summary>
    /// <remarks>This enumeration is not normally used by itself, but only as part of the TTagStates set type.</remarks>
    /// <seealso cref="TTagStates">TTagStates</seealso>
{$ENDREGION}
    TTagState = (
      /// <summary>Indicates that the current state of the tag is that the left bracket has been added but the right has not been. (e.g. "&lt;span " The tag is able to accept attributes at this point.</summary>
      tsBracketOpen,
      /// <summary>Indicates that the tag is open and the bracket has been added. (e.g. "&lt;span&gt;)"</summary>
      tsTagOpen,
      /// <summary>Indicates that the current HTML is part of a comment.</summary>
      tsCommentOpen,
      /// <summary>Indicates that the tag is currently closed (e.g. "&lt;span&gt;&lt;/span&gt;)"</summary>
      tsTagClosed,
      /// <summary>Indicates that the current HTML is being written inside of a &lt;head&gt; tag.</summary>
      tsInHeadTag,
      /// <summary>Indicates that the current HTML is being written inside of a &lt;body&gt; tag.</summary>
      tsInBodyTag,
      /// <summary>Indicates that the current HTML is being written inside of a &lt;list&gt; tag.</summary>
      tsInListTag,
      /// <summary>Indicates that the current HTML is being written inside of a &lt;object&gt; tag.</summary>
      tsInObjectTag,
      /// <summary>Indicates that the current HTML is being written inside of a &lt;fieldset&gt; tag.</summary>
      tsInFieldSetTag,
      /// <summary>Indicates that the current HTML is being written inside of a &lt;frameset&gt; tag.</summary>
      tsInFrameSetTag,
      /// <summary>Indicates that the current HTML is being written inside of a &lt;map&gt; tag.</summary>
      tsInMapTag,
      tsInDefinitionList,
      tsHasDefinitionTerm,
      tsDefTermIsCurrent,
      tsDefItemIsCurrent

      );
    TTagStates = set of TTagState;

    /// <summary>Enumeration to define possible states of an open &lt;table&gt; tag.</summary>
    TTableState = (
      /// <summary>Indicates that the current HTML is part of a table. (&lt;table&gt;)</summary>
      tbsInTable,
      /// <summary>Indicates that the current HTML is part of a Table Row (&lt;tr&gt;)</summary>
      tbsInTableRowTag,
      tbsTableHasCaption,
      tbsTableHasColGroup,
      tbsTableHasCol,
      tbsTableHasData
                   );
    TTableStates = set of TTableState;

    ///	<remarks>These tags are used to keep track of the cursor inside of a &lt;form&gt; tag.</remarks>
    TFormState = (
      ///	<summary>Indicates that the cursor is curerntly inside of a &lt;form&gt; tag</summary>
      fsInFormTag,
      ///	<summary>Indicates that the cursor is curerntly inside of a &lt;select&gt; tag</summary>
      fsInSelect,
      ///	<summary>Indicates that the cursor is curerntly inside of a &lt;optgroup&gt; tag</summary>
      fsInOptGroup
    );
    TFormStates = set of TFormState;

    TCanHaveAttributes = (
      /// <summary>Indicates that the given tag can accept attributes.</summary>
      chaCanHaveAttributes,
      /// <summary>Indicates that the given tag cannot accept attributes.</summary>
      chaCannotHaveAttributes);

    /// <summary>An enumeration listing the different ways that text can be formatted</summary>
    TFormatType = (
      /// <summary>Formats with a &lt;b&gt; tag</summary>
      ftBold,
      /// <summary>Formats with a &lt;i&gt; tag</summary>
      ftItalic,
      /// <summary>Formats with a &lt;u&gt; tag</summary>
      ftUnderline,
      /// <summary>Formats with a &lt;em&gt; tag</summary>
      ftEmphasis,
      /// <summary>Formats with a &lt;strong&gt; tag</summary>
      ftStrong,
      /// <summary>Formats with a &lt;sub&gt; tag</summary>
      ftSubscript,
      /// <summary>Formats with a &lt;sup&gt; tag</summary>
      ftSuperscript,
      /// <summary>Formats with a &lt;pre&gt; tag</summary>
      ftPreformatted,
      /// <summary>Formats with a &lt;cite&gt; tag</summary>
      ftCitation,
      /// <summary>Formats with a &lt;acronym&gt; tag</summary>
      ftAcronym,
      /// <summary>Formats with a &lt;abbr&gt; tag</summary>
      ftAbbreviation,
      /// <summary>Formats with a &lt;address&gt; tag</summary>
      ftAddress,
      /// <summary>Formats with a &lt;bdo&gt; tag</summary>
      ftBDO,
      /// <summary>Formats with a &lt;big&gt; tag</summary>
      ftBig,
      /// <summary>Formats with a &lt;center&gt; tag</summary>
      ftCenter,
      /// <summary>Formats with a &lt;code&gt; tag</summary>
      ftCode,
      /// <summary>Formats with a &lt;delete&gt; tag</summary>
      ftDelete,
      /// <summary>Formats with a &lt;dfn&gt; tag</summary>
      ftDefinition,
      /// <summary>Formats with a &lt;font&gt; tag</summary>
      ftFont,
      /// <summary>Formats with a &lt;kbd&gt; tag</summary>
      ftKeyboard,
      /// <summary>Formats with a &lt;q&gt; tag</summary>
      ftQuotation,
      /// <summary>Formats with a &lt;samp&gt; tag</summary>
      ftSample,
      /// <summary>Formats with a &lt;small&gt; tag</summary>
      ftSmall,
      /// <summary>Formats with a &lt;strike&gt; tag</summary>
      ftStrike,
      /// <summary>Formats with a &lt;tt&gt; tag</summary>
      ftTeletype,
      /// <summary>Formats with a &lt;var&gt; tag</summary>
      ftVariable,
      /// <summary>Formats with a &lt;ins&gt; tag</summary>
      ftInsert);
    THeadingType = (htHeading1, htHeading2, htHeading3, htHeading4, htHeading5, htHeading6);

    TClearValue = (cvNoValue, cvNone, cvLeft, cvRight, cvAll);
    TIsEmptyTag = (ietIsEmptyTag, ietIsNotEmptyTag);

    ///	<summary>Enumeration to define the different types of bullets that can be used with the &lt;ol&gt; and &lt;ul&gt; tags.</summary>
    ///	<remarks>This type is used in conjunction with the OpenUnorderdedList function</remarks>
    ///	<seealso cref="OpenUnorderedList">OpenUnorderedList</seealso>
    TBulletShape = (
      ///	<summary>Indicates that no bullet should be used</summary>
      bsNone,
      ///	<summary>Indicates that a black disc should be used as the bullet</summary>
      bsDisc,
      ///	<summary>Indicates that a small circle should be used as the bullet</summary>
      bsCircle,
      ///	<summary>Indicates that a black square should be used as the bullet</summary>
      bsSquare
    );
    ///	<summary>Enumeration to define the type of numbering system to use in an ordered list (&lt;ol&gt;)</summary>
    TNumberType = (
      ///	<summary>Indicates that no numbers should be used.</summary>
      ntNone,
      ///	<summary>Indicates the use of Arabic numbers, i.e. 1, 2, 3, 4</summary>
      ntNumber,
      ///	<summary>Indicates the use of capital letters, i.e. A, B, C, D</summary>
      ntUpperCase,
      ///	<summary>Indicates the use of lower-case letters, i.e. a, b, c, d</summary>
      ntLowerCase,
      ///	<summary>Indicates the use of upper case Roman numerals, i.e. I, II, III, IV</summary>
      ntUpperRoman,
      ///	<summary>Indicates the use of lower case Roman numerals, i.e. i, ii, iii, iv</summary>
      ntLowerRoman
    );
    TTargetType = (ttBlank, ttParent, ttSelf, ttTop, ttFrameName);

    ///	<summary>
    ///	  Enumeration to define the kind of closing a given tag requires.
    ///	</summary>
    ///	<remarks>
    ///	  This type is used internally, and should not normally be used by a consuer of HTMLWriter.
    ///	</remarks>
    TCloseTagType = (
      ///	<summary>
      ///	  Use the normal closing tag, i.e. "&gt;"
      ///	</summary>
      ctNormal,

      ///	<summary>
      ///	  Use the empty closing tag, i.e. "/&gt;"
      ///	</summary>
      ctEmpty,

      ///	<summary>
      ///	  Use the comment closing tag, i.e. "--&gt;"
      ///	</summary>
      ctComment
    );

    THTMLDocType = (dtHTML401Strict, dtHTML401Transitional, dtHTML401Frameset, cXHTML10Strict, dtXHTML10Transitional, dtXHTML10Frameset, dtXHTML11);

    TUseCRLFOptions = (ucoUseCRLF, ucoNoCRLF);

    /// <summary>
    /// <para>Indicates the action type to be taken by a &lt;form&gt; tag</para>
    /// </summary>
    TFormMethod = (
      /// <summary>Indicates no action</summary>
      fmNone,
      /// <summary>Indicates a GET action</summary>
      fmGet,
      /// <summary>Indicates a POST action</summary>
      fmPost);

    TInputType = (itButton, itCheckbox, itFile, itHidden, itImage, itPassword, ctRadio, itReset, itSubmit, itText);

    TBlockType = (btDiv, btSpan, btParagraph);

    ///	<summary>
    ///	  Enumeration of the various types of errors that can be checked for.
    ///	</summary>
    THTMLErrorLevel = (
      ///	<summary>
      ///	  Include this member if you want any error checking at all. 
      ///	</summary>
      elErrors,

      ///	<summary>
      ///	  Include this member if you want your HTML to conform to the HTML 4 specification
      ///	</summary>
      elStrictHTML4,

      ///	<summary>
      ///	  Include this member if you want your code to be HTML5 compatible. 
      ///	</summary>
      elStrictHTML5,

      ///	<summary>
      ///	  Include this member if you want your code to conform to the xHTML specification.
      ///	</summary>
      elStrictxhtml
    );

    THTMLErrorLevels = set of THTMLErrorLevel;

  const
    ///	<summary>String array for use with the TFormatType</summary>
    ///	<seealso cref="TFormatType">TFormatType</seealso>
    TFormatTypeStrings: array [TFormatType] of string = ('b', 'i', 'u', 'em', 'strong', 'sub', 'sup', 'pre', 'cite', 'acronym', 'abbr', 'address', 'bdo', 'big', 'center', 'code', 'delete', 'dfn', 'font', 'kbd', 'q', 'samp', 'small', 'strike', 'tt', 'var', 'ins');

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Strings to be used with the THeadingType
    ///	</summary>
    {$ENDREGION}
    THeadingTypeStrings: array [THeadingType] of string = ('h1', 'h2', 'h3', 'h4', 'h5', 'h6');

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Strings to be used with the TClearValue type
    ///	</summary>
    {$ENDREGION}
    TClearValueStrings: array [TClearValue] of string = ('', 'none', 'left', 'right', 'all');

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Strings to be used for the TBulletShape type
    ///	</summary>
    {$ENDREGION}
    TBulletShapeStrings: array [TBulletShape] of string = ('', 'disc', 'circle', 'square');

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Strings to be used for the TNumberType type
    ///	</summary>
    {$ENDREGION}
    TNumberTypeStrings: array [TNumberType] of string = ('', '1', 'A', 'a', 'I', 'i');

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Strings to be used for the TBlockType type
    ///	</summary>
    {$ENDREGION}
    TBlockTypeStrings: array [TBlockType] of string = ('div', 'span', 'p');

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Strings to be used for the TTargetType type
    ///	</summary>
    {$ENDREGION}
    TTargetTypeStrings: array [TTargetType] of string = ('_blank', '_parent', '_self', '_target', '');

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Strings to be used with the TInputType type
    ///	</summary>
    {$ENDREGION}
    TInputTypeStrings: array [TInputType] of string = ('button', 'checkbox', 'file', 'hidden', 'image', 'password', 'radio', 'reset', 'submit', 'text');

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Strings to be used with the TFormMethod type.
    ///	</summary>
    {$ENDREGION}
    TFormMethodStrings: array [TFormMethod] of string = ('', 'get', 'post');

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Strings to be used with the THTMLErrorLevel type
    ///	</summary>
    {$ENDREGION}
    THTMLErrorLevelStrings: array [THTMLErrorLevel] of string = ('', '4.x', '5.x', 'xhmtl');


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
    cform = 'form';
    cInput = 'input';
    cButton = 'button';

    cFieldSet = 'fieldset';
    cLegend = 'legend';
    cFrameset = 'frameset';
    cFrame = 'frame';
    cNoFrames = 'noframes';
    cMap = 'map';
    cArea = 'area';
    cAlt = 'alt';
    cBaseFont = 'basefont';
    cLink = 'link';
    cObject = 'object';
    cParam = 'param';
    cAction = 'action';
    cMethod = 'method';
    cValue = 'value';

    cCRLF = #13#10;

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
    cHeight = 'height';
    cTableRow = 'tr';
    cTableData = 'td';
    cTableHead = 'thead';
    cTableBody = 'tbody';
    cTableFoot = 'tfoot';
    cTableHeader = 'th';
    cTitle = 'title';
    cScript = 'script';
    cNoScript = 'noscript';
    cIFrame = 'iframe';
    cBase = 'base';
    cTarget = 'target';
    cOption = 'option';
    cOptGroup = 'optgroup';
    cCaption = 'caption';
    cLabel = 'label';
    cTextArea = 'textarea';
    cSelect = 'select';
    cFor = 'for';
    cCols = 'cols';
    cRows = 'rows';
    cColGroup = 'colgroup';
    cCol = 'col';

    cDD = 'dd';
    cDT = 'dt';
    cDL = 'dl';

    cOpenBracket = '<';
    cCloseBracket = '>';
    cCloseSlashBracket = '/>';
    cComment = '!--';
    cCloseComment = '-->';
    cSpace = ' ';
    cEmptyString = '';

    THTMLDocTypeStrings: array [THTMLDocType] of string = ('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">', '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">', '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">');

type
    ///	<summary>
    ///	  Type that determines if spaces should count as content or as empty space
    ///	</summary>
    ///	<remarks>
    ///	  Used with TStringIsEmpty class functions
    ///	</remarks>
    TCountSpaces = (
      ///	<summary>
      ///	  Spaces should count as empty space. Use this member when you want a string to be considered empty if it contains spaces.  For instance, a string that consists of nothing but three spaces will be considered empty when this member is passed.
      ///	</summary>
      csSpacesCountAsEmpty,

      ///	<summary>
      ///	  Spaces should count as content.  Use this member when you want spaces to indicate that a string is not empty.  For instance, a string with nothing but three spaces in it would be considered not empty when this member is chosen. 
      ///	</summary>
      csSpacesCountAsContent
    );

 type
    /// <summary>Simple static class to add functionality to string.</summary>
    TStringDecorator = class

      ///	<summary>
      ///	  Determines if a string has content in it or not.
      ///	</summary>
      ///	<param name="aString">
      ///	  The string to be examined for emptiness.
      ///	</param>
      ///	<param name="aSpacesAreContent">
      ///	  An optional parameter that determines if empty spaces should be included. 
      ///	</param>
      class function StringIsEmpty(aString: string; aSpacesAreContent: TCountSpaces = csSpacesCountAsEmpty): Boolean;
      class function StringIsNotEmpty(aString: string; aSpacesAreContent: TCountSpaces = csSpacesCountAsEmpty): Boolean;
    end;

  type

    /// <summary>A class for producing edge tags, including opening and closing tags.</summary>
    TTagMaker = class
      class function MakeOpenTag(aTag: string): string; static;
      class function MakeCloseTag(aTag: string): string; static;
      class function MakeSlashCloseTag: string; static;
      class function MakeCommentCloseTag: string; static;
    end;

implementation

class function TStringDecorator.StringIsEmpty(aString: string; aSpacesAreContent: TCountSpaces = csSpacesCountAsEmpty): Boolean;
begin
  Result := aString = EmptyStr;
  if (not Result) and (aSpacesAreContent = csSpacesCountAsContent) then
  begin
    Result := Trim(aString) = EmptyStr;
  end;
end;

class function TStringDecorator.StringIsNotEmpty(aString: string; aSpacesAreContent: TCountSpaces = csSpacesCountAsEmpty): Boolean;
begin
  Result := not StringIsEmpty(aString, aSpacesAreContent);
end;

class function TTagMaker.MakeCommentCloseTag: string;
begin
  Result := cSpace + cCloseComment;
end;

class function TTagMaker.MakeOpenTag(aTag: string): string;
begin
  Result := Format('<%s>', [aTag]);
end;

class function TTagMaker.MakeSlashCloseTag: string;
begin
  Result := cSpace + cCloseSlashBracket;
end;

class function TTagMaker.MakeCloseTag(aTag: string): string;
begin
  Result := Format('</%s>', [aTag]);
end;

{ THTMLWidth }

function THTMLWidth.AsPercentage: string;
begin
  Result := '';
  if IsPercentage = ipIsPercentage then
  begin
    Result := Format('%d%%', [Width]);
  end;
end;

constructor THTMLWidth.Create(aWidth: integer; aIsPercentage: TIsPercentage);
begin
  Width := aWidth;
  IsPercentage := aIsPercentage;
end;

function THTMLWidth.WidthAsString: string;
begin
  Result := IntToStr(Width);
end;

function THTMLWidth.WidthString: string;
begin
  Result := Format('width="%s"', [IntToStr(Width)]);
end;


end.

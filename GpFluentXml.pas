///<summary>Fluent XML builder.</para>
///</summary>
///<author>Primoz Gabrijelcic</author>
///<remarks><para>
///   (c) 2009 Primoz Gabrijelcic
///   Free for personal and commercial use. No rights reserved.
///
///   Author            : Primoz Gabrijelcic
///   Creation date     : 2009-03-30
///   Last modification : 2009-10-04
///   Version           : 0.2
///</para><para>
///   History:
///     0.2: 2009-10-04
///       - Added node value-setting overloads for AddChild and AddSibling.
///     0.1: 2009-03-30
///       - Created.
///</para></remarks>

unit GpFluentXml;

interface

uses
  OmniXML_Types,
  OmniXML;

type
  IGpFluentXmlBuilder = interface ['{91F596A3-F5E3-451C-A6B9-C5FF3F23ECCC}']
    function  GetXml: IXmlDocument;
  //
    function  AddChild(const name: XmlString): IGpFluentXmlBuilder; overload;
    function  AddChild(const name: XmlString; value: Variant): IGpFluentXmlBuilder; overload;
    function  AddComment(const comment: XmlString): IGpFluentXmlBuilder;
    function  AddProcessingInstruction(const target, data: XmlString): IGpFluentXmlBuilder;
    function  AddSibling(const name: XmlString): IGpFluentXmlBuilder; overload;
    function  AddSibling(const name: XmlString; value: Variant): IGpFluentXmlBuilder; overload;
    function  Anchor(var node: IXMLNode): IGpFluentXmlBuilder;
    function  Mark: IGpFluentXmlBuilder;
    function  Return: IGpFluentXmlBuilder;
    function  SetAttrib(const name, value: XmlString): IGpFluentXmlBuilder;
    function  Up: IGpFluentXmlBuilder;
    property Attrib[const name, value: XmlString]: IGpFluentXmlBuilder
      read SetAttrib; default;
    property Xml: IXmlDocument read GetXml;
  end; { IGpFluentXmlBuilder }

function CreateFluentXml: IGpFluentXmlBuilder;

implementation

uses
  SysUtils,
  Classes,
  OmniXMLUtils;

type
  TGpFluentXmlBuilder = class(TInterfacedObject, IGpFluentXmlBuilder)
  private
    fxbActiveNode : IXMLNode;
    fxbMarkedNodes: IInterfaceList;
    fxbXmlDoc     : IXMLDocument;
  protected
    function ActiveNode: IXMLNode;
  protected
    function GetXml: IXmlDocument;
  public
    constructor Create;
    destructor  Destroy; override;
    function  AddChild(const name: XmlString): IGpFluentXmlBuilder; overload;
    function  AddChild(const name: XmlString; value: Variant): IGpFluentXmlBuilder; overload;
    function  AddComment(const comment: XmlString): IGpFluentXmlBuilder;
    function  AddProcessingInstruction(const target, data: XmlString): IGpFluentXmlBuilder;
    function  AddSibling(const name: XmlString): IGpFluentXmlBuilder; overload;
    function  AddSibling(const name: XmlString; value: Variant): IGpFluentXmlBuilder; overload;
    function  Anchor(var node: IXMLNode): IGpFluentXmlBuilder;
    function  Mark: IGpFluentXmlBuilder;
    function  Return: IGpFluentXmlBuilder;
    function  SetAttrib(const name, value: XmlString): IGpFluentXmlBuilder;
    function  Up: IGpFluentXmlBuilder;
  end; { TGpFluentXmlBuilder }

{ globals }

function CreateFluentXml: IGpFluentXmlBuilder;
begin
  Result := TGpFluentXmlBuilder.Create;
end; { CreateFluentXml }

{ TGpFluentXmlBuilder }

constructor TGpFluentXmlBuilder.Create;
begin
  inherited Create;
  fxbXmlDoc := CreateXMLDoc;
  fxbMarkedNodes := TInterfaceList.Create;
end; { TGpFluentXmlBuilder.Create }

destructor TGpFluentXmlBuilder.Destroy;
begin
  if fxbMarkedNodes.Count > 0 then
    raise Exception.Create('''Mark'' stack is not completely empty');
  inherited;
end; { TGpFluentXmlBuilder.Destroy }

function TGpFluentXmlBuilder.ActiveNode: IXMLNode;
begin
  if assigned(fxbActiveNode) then
    Result := fxbActiveNode
  else begin
    Result := DocumentElement(fxbXmlDoc);
    if not assigned(Result) then
      Result := fxbXmlDoc;
  end;
end; { TGpFluentXmlBuilder.ActiveNode }

function TGpFluentXmlBuilder.AddChild(const name: XmlString): IGpFluentXmlBuilder;
begin
  fxbActiveNode := AppendNode(ActiveNode, name);
  Result := Self;
end; { TGpFluentXmlBuilder.AddChild }

function TGpFluentXmlBuilder.AddChild(const name: XmlString;
  value: Variant): IGpFluentXmlBuilder;
begin
  Result := AddChild(name);
  SetTextChild(fxbActiveNode, XMLVariantToStr(value));
end; { TGpFluentXmlBuilder.AddChild }

function TGpFluentXmlBuilder.AddComment(const comment: XmlString): IGpFluentXmlBuilder;
begin
  ActiveNode.AppendChild(fxbXmlDoc.CreateComment(comment));
  Result := Self;
end; { TGpFluentXmlBuilder.AddComment }

function TGpFluentXmlBuilder.AddProcessingInstruction(const target, data: XmlString):
  IGpFluentXmlBuilder;
begin
  ActiveNode.AppendChild(fxbXmlDoc.CreateProcessingInstruction(target, data));
  Result := Self;
end; { TGpFluentXmlBuilder.AddProcessingInstruction }

function TGpFluentXmlBuilder.AddSibling(const name: XmlString;
  value: Variant): IGpFluentXmlBuilder;
begin
  Result := AddSibling(name);
  SetTextChild(fxbActiveNode, XMLVariantToStr(value));
end; { TGpFluentXmlBuilder.AddSibling }

function TGpFluentXmlBuilder.AddSibling(const name: XmlString): IGpFluentXmlBuilder;
begin
  Result := Up;
  fxbActiveNode := AppendNode(ActiveNode, name);
end; { TGpFluentXmlBuilder.AddSibling }

function TGpFluentXmlBuilder.Anchor(var node: IXMLNode): IGpFluentXmlBuilder;
begin
  node := fxbActiveNode;
  Result := Self;
end; { TGpFluentXmlBuilder.Anchor }

function TGpFluentXmlBuilder.GetXml: IXmlDocument;
begin
  Result := fxbXmlDoc;
end; { TGpFluentXmlBuilder.GetXml }

function TGpFluentXmlBuilder.Mark: IGpFluentXmlBuilder;
begin
  fxbMarkedNodes.Add(ActiveNode);
  Result := Self;
end; { TGpFluentXmlBuilder.Mark }

function TGpFluentXmlBuilder.Return: IGpFluentXmlBuilder;
begin
  fxbActiveNode := fxbMarkedNodes.Last as IXMLNode;
  fxbMarkedNodes.Delete(fxbMarkedNodes.Count - 1);
  Result := Self;
end; { TGpFluentXmlBuilder.Return }

function TGpFluentXmlBuilder.SetAttrib(const name, value: XmlString): IGpFluentXmlBuilder;
begin
  SetNodeAttrStr(ActiveNode, name, value);
  Result := Self;
end; { TGpFluentXmlBuilder.SetAttrib }

function TGpFluentXmlBuilder.Up: IGpFluentXmlBuilder;
begin
  if not assigned(fxbActiveNode) then
    raise Exception.Create('Cannot access a parent at the root level')
  else if fxbActiveNode = DocumentElement(fxbXmlDoc) then
    raise Exception.Create('Cannot create a parent at the document element level')
  else
    fxbActiveNode := ActiveNode.ParentNode;
  Result := Self;
end; { TGpFluentXmlBuilder.Up }

end.

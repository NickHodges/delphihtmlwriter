unit LoadSaveIntf;

{$REGION 'License'}
{
  Copyright (C) 2010 Nick Hodges

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at https://mozilla.org/MPL/2.0/.
}
{$ENDREGION}

interface

uses
      SysUtils
    , Classes
    ;

type
  /// <summary>Interface that describes the functions of loading and saving entities to and from both files and
  /// streams.</summary>
  ILoadSave = interface
  ['{C77722C1-AFB1-4A85-BD09-803C19EB2C28}']
    procedure LoadFromFile(const FileName: string); overload;
    procedure LoadFromFile(const FileName: string; Encoding: TEncoding); overload;
    procedure LoadFromStream(Stream: TStream); overload;
    procedure LoadFromStream(Stream: TStream; Encoding: TEncoding); overload;
    procedure SaveToFile(const FileName: string); overload;
    procedure SaveToFile(const FileName: string; Encoding: TEncoding); overload;
    procedure SaveToStream(Stream: TStream); overload;
    procedure SaveToStream(Stream: TStream; Encoding: TEncoding); overload;
  end;


implementation

end.

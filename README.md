# DelphiHTMLWriter

A Delphi class library for creating HTML using a fluent interface. Supports HTML 4.01, XHTML, and HTML5.

## License

This project is licensed under the [Mozilla Public License 2.0](https://mozilla.org/MPL/2.0/).

## Overview

`THTMLWriter` produces HTML through a fluent (method-chaining) interface. It can generate complete HTML documents or standalone HTML fragments. The library enforces correct tag nesting and raises exceptions when tags are used in invalid contexts.

## Fluent Interface Pattern

Most methods return `IHTMLWriter`, allowing calls to be chained:

```pascal
var
  Doc: IHTMLWriter;
begin
  Doc := HTMLWriterCreateDocument(dtHTML5);
  Doc.OpenHead
        .AddTitle('My Page')
      .CloseTag
      .OpenBody
        .AddHeading1Text('Hello World')
        .AddParagraphText('Welcome to my page.')
        .OpenDiv.AddClass('container')
          .AddBoldText('Important!')
        .CloseTag
      .CloseTag
    .CloseDocument;

  WriteLn(Doc.AsHTML);
end;
```

## Key Concepts

- **Open methods** (`OpenDiv`, `OpenTable`, etc.) add an opening tag and leave it ready for attributes or content. Each must be paired with a `CloseTag` call.
- **Add methods** (`AddBoldText`, `AddParagraphText`, etc.) write a complete open/content/close sequence in one call. No `CloseTag` needed.
- **Attribute methods** (`AddAttribute`, `AddClass`, `AddStyle`, `AddID`, etc.) attach attributes to the currently open tag.
- **Boolean attribute methods** (`AddRequired`, `AddDisabled`, `AddHidden`, etc.) add bare HTML5 boolean attributes.

## Supported Standards

| Standard | Support |
|---|---|
| HTML 4.01 (Strict, Transitional, Frameset) | Full |
| XHTML 1.0 / 1.1 | Full |
| HTML5 | Full |

## HTML5 Features

- **Semantic elements**: `<article>`, `<aside>`, `<details>`, `<figcaption>`, `<figure>`, `<footer>`, `<header>`, `<main>`, `<nav>`, `<section>`, `<summary>`, `<dialog>`, `<picture>`, `<template>`
- **Text-level semantics**: `<mark>`, `<bdi>`, `<ruby>`, `<rt>`, `<rp>`, `<time>`, `<output>`, `<wbr>`
- **Media elements**: `<audio>`, `<video>`, `<source>`, `<track>`, `<canvas>`, `<embed>`
- **Form elements**: `<datalist>`, `<progress>`, `<meter>`, plus all HTML5 input types (`color`, `date`, `email`, `range`, `search`, `tel`, `url`, `week`, etc.)
- **Attribute helpers**: `AddRole`, `AddDataAttribute`, `AddAriaAttribute`, `AddPlaceholder`
- **Boolean attributes**: `AddRequired`, `AddDisabled`, `AddAutofocus`, `AddHidden`, `AddReadonly`, `AddMultiple`, `AddNovalidate`
- **Convenience combos**: `AddFigure` (img + figcaption), `AddDetailsSummary` (summary + details)
- **Deprecation warnings**: Tags deprecated in HTML5 (e.g., `<center>`, `<font>`, `<strike>`, `<frameset>`) raise exceptions when `elStrictHTML5` is enabled
- **DOCTYPE**: `dtHTML5` produces `<!DOCTYPE html>`

## Error Checking

Set `ErrorLevels` to control validation:

```pascal
var Writer: IHTMLWriter;
begin
  Writer := HTMLWriterCreateDocument(dtHTML5);
  Writer.ErrorLevels := Writer.ErrorLevels + [elStrictHTML5];
  // Using deprecated tags will now raise ETagIsDeprecatedHTMLWriterException
end;
```

## Creating HTML

```pascal
// Full document with DOCTYPE
Doc := HTMLWriterCreateDocument(dtHTML5);

// HTML chunk starting from any tag
Chunk := HTMLWriterCreate('div');

// Fragment without a wrapper element
Fragment := HTMLWriterCreateFragment;
```

## Running Tests

The project includes a comprehensive DUnit test suite in the `Test/` directory. Open and run `TestuHTMLWriter.pas` with the Delphi test runner.

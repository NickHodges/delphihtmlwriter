This is a Delphi-based class library that enables the developer to create HTML and HTML documents. It uses the fluent interface to make creating HTML text easy and natural.

THTMLWriter is a class for creating HTML and HTML Documents. THTMLWriter uses the fluent interface. It can be used to create either complete HTML documents or chunks of HTML. By using the fluent interface, you can link together number of methods to create a complete document.

THTMLWriter is very method heavy, but relatively code light. Most of the code simply ends up calling the AddTag method.

Most methods begin with either "Open" or "Add". Methods that start with "Open" will add <tag to the HTML stream (the lack of a closing bracket is purposeful, leaving room for attributes if desired...), leaving it ready for the addition of attributes or other content. The system will automatically close the tag (i.e. add the closing '>' when necessary.

Tags that are started with an "OpenXXX" will require a corresponding call to CloseTag? or one of the other CloseXXX methods. Tags created with "AddXXX" require no CloseTag? call.

Methods that start with "Add" will normally take paramenters and then add content within a complete tag pair. For example, a call to AddBoldText('blah') will result in <b>blah</b> being added to the HTML stream.

Some things to note:

* Any tag that is opened will need to be closed via CloseTag
* Any tag that is added via a AddXXXX call will close itself.
* The rule to follow: Close what you open. Additions take care of themselves.
* As a general rule, THTMLWriter will raise an exception if a tag is placed somewhere that doesn't make sense.
* Certain tags like <meta> and <base> can only be added inside at <head> tag.
* Tags such as <td>, <tr> can only be added inside of a <table> tag
* The same is true for list items inside lists.

Things to work on:

* 100% conformance to xhtml specification
* Support for HTML 5
* Have THTMLWriter produce more human-readable HTML by default

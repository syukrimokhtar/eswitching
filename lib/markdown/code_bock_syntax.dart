import 'package:markdown/markdown.dart' as md;

class CodeBlockSyntax extends md.BlockSyntax {
  static const String _pattern = r'^\[\[code\]\](.*)$';
  @override
  RegExp get pattern => RegExp(_pattern);

  CodeBlockSyntax();

  @override
  md.Node parse(md.BlockParser parser) {
    print(parser);
    var childLines = parseChildLines(parser);

    var content = childLines.join('\n');

    final md.Element el = md.Element('p', [
      md.Element("code", [md.Text(content)]),
    ]);

    return el;
  }

}
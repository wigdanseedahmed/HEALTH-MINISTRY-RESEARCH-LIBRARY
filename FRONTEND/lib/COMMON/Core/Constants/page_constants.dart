import 'package:health_ministry_research_library/imports.dart';

kopenPage(BuildContext context, Widget page) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => page,
    ),
  );
}


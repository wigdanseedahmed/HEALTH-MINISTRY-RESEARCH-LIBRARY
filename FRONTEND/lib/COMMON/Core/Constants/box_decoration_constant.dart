import 'package:health_ministry_research_library/imports.dart';

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.purple, width: 2.0),
  ),
);

BoxDecoration kSignInSignUpContainerDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: logInAndRegistrationButtonColour,
  ),
  borderRadius: BorderRadius.circular(6),
);

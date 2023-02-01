import 'package:health_ministry_research_library/imports.dart';
// import 'package:flutter_medical/routes/signUp.dart';
// import 'package:flutter_medical/routes/signIn.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return const LoginScreenWS();//TODO:SignInPage
    } else {
      return const RegistrationScreenWS();//TODO:SignUpPage
    }
  }
}

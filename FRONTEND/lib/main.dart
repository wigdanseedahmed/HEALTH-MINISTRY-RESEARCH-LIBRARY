import 'package:health_ministry_research_library/imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // NotificationServiceImpl();
  //await Hive.initFlutter();
  runApp(const HealthMinistryResearchLibraryApp());
}

class HealthMinistryResearchLibraryApp extends StatelessWidget {
  const HealthMinistryResearchLibraryApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        fontFamily: "Nunito",
        primaryColor: Colors.red,
        // ignore: deprecated_member_use
        accentColor: Colors.redAccent,
        primaryColorDark: const Color(0xff0029cb),
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) => HealthMinistryResearchLibrary(
        theme: theme,
      ),
    );
  }
}

class HealthMinistryResearchLibrary extends StatefulWidget {
  const HealthMinistryResearchLibrary({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  State<HealthMinistryResearchLibrary> createState() =>
      _HealthMinistryResearchLibraryState();
}

class _HealthMinistryResearchLibraryState
    extends State<HealthMinistryResearchLibrary> {
  late bool userIsLoggedIn = false;

  @override
  void initState() {
    // getUserInfo();
    //initPlatformState();
    getLoggedInState();
    super.initState();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment =
        false; //<--
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF1f1e30),
        systemNavigationBarColor: Color(0xFF1f1e30),
      ),
    );
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInPreference().then((value) {
      setState(() {
        userIsLoggedIn = value!;
      });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Ministry Research Library',
      theme: widget.theme,
      debugShowCheckedModeBanner: false,
      home: ResearchLibraryScreen(),
     /* userIsLoggedIn != null
          ? userIsLoggedIn
              ? const HomeScreenWS()
              : const Authenticate()
          : const Center(child: Authenticate()),*/
    );
  }
}

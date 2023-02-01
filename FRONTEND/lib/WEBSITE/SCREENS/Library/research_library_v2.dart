import 'package:flutter/rendering.dart';
import 'package:health_ministry_research_library/imports.dart';
import 'package:http/http.dart' as http;

import 'dart:ui';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:screen_utils/screen_utils.dart';

class ResearchLibraryScreen extends StatefulWidget {
  const ResearchLibraryScreen({super.key});

  @override
  State<ResearchLibraryScreen> createState() => _ResearchLibraryScreenState();
}

class _ResearchLibraryScreenState extends State<ResearchLibraryScreen> {
  /// Variable used to get RESTful-API
  NetworkHandler networkHandler = NetworkHandler();

  ///VARIABLES USED FOR RETRIEVING USER INFORMATION
  getUserInfo() async {
    UserProfile.personalEmail =
        await CheckSharedPreferences.getUserEmailSharedPreference();
    UserProfile.personalEmail =
        await CheckSharedPreferences.getUserEmailSharedPreference();
    var userInfo = await networkHandler
        .get("${AppUrl.getUserUsingEmail}${UserProfile.personalEmail}");

    //print(userInfo);
    setState(() {
      readUserContent = userInfo['data'];

      UserProfile.personalEmail = userInfo['data']['personnelEmail'];
      UserProfile.username = userInfo['data']['username'];
      UserProfile.firstName = userInfo['data']['firstName'];
      UserProfile.lastName = userInfo['data']['lastName'];
      UserProfile.userPhotoURL = userInfo['data']["userPhotoURL"];
    });
  }

  UserModel readUserContent = UserModel();
  Future<UserModel>? futureUserInformation;

  Future<UserModel> readingUserData() async {
    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse(AppUrl.getUsers);

    /// Create Request to get data and response to read data
    final response = await http.get(
      uri,
      headers: {
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        "Access-Control-Allow-Headers":
            "Content-Type, Access-Control-Allow-Origin, Accept",
        //'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Methods": "POST, DELETE, GET, PUT"
      },
    );
    // print('Response status: ${response.statusCode}');
    // print('Response Enter body: ${response.body}');

    if (response.statusCode == 200) {
      readUserContent = userModelListFromJson(response.body)
          .where(
              (element) => element.personalEmail == UserProfile.personalEmail)
          .toList()[0];
      //print("User Model Info : ${readUserJsonFileContent.firstName}");

      return readUserContent;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  ///VARIABLES USED TO DETERMINE SCREEN SIZE
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  initState() {
    super.initState();

    /// VARIABLES USED TO SCROLL THROUGH SCREEN
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    /// User Model information Variables
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Adapt.init(context);

    return buildViewModelBuilder();
  }

  ///--------------------------------------------------- VIEW MODEL BUILDER ---------------------------------------------------///
  ViewModelBuilder<ResearchLibraryViewModel> buildViewModelBuilder() {
    return ViewModelBuilder<ResearchLibraryViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: buildBody(model, context),
        );
      },
      viewModelBuilder: () => ResearchLibraryViewModel(),
    );
  }

  ///--------------------------------------------------- BODY ---------------------------------------------------///
  buildBody(ResearchLibraryViewModel model, BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 10),
        child: Column(
          children: [
            buildTopBar(),
            buildMainBody(model, context),
          ],
        ),
      ),
    );
  }

  ///------------------------------- TOP BAR -------------------------------///
  buildTopBar() {
    return Column(
      children: [
        UserProfile.username == null
            ? const TopBarMenuWS(
                isLoginOrRegistration: 'Library',
                isSelectedPage: '',
              )
            : TopBarMenuAfterLoginWS(
                isSelectedPage: 'Library',
                user: readUserContent,
              ),
      ],
    );
  }

  ///------------------------------- MAIN BODY -------------------------------///
  buildMainBody(ResearchLibraryViewModel model, BuildContext context) {
    return SizedBox(
      height: Adapt.screenHeight,
      width: Adapt.screenWidth,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildLeft(model),
            buildRight(context, model),
          ],
        ),
      ),
    );
  }

  List<String> favouriteResearch = [
    'assets/images/fortnite.jpg',
    'assets/images/corruption.jpg',
    'assets/images/overpass.jpg',
    'assets/images/maneater.jpg',
    'assets/images/fortnite.jpg',
    'assets/images/corruption.jpg',
    'assets/images/overpass.jpg',
    'assets/images/maneater.jpg',
  ];

  ///------------------------------- RIGHT -------------------------------///
  Widget buildRight(BuildContext context, ResearchLibraryViewModel model) {
    var textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      textStyle: TextStyle(
        color: Colors.grey[600],
        fontFamily: 'WorkSans',
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CupertinoScrollbar(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 37),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildFavourites(textTheme),
                    const Ymargin(25),
                    buildPopular(textTheme),
                    const Ymargin(25),
                    buildResearch(textTheme, context),
                  ],
                ),
              ),
            ),
          ),
          // Xmargin(5.sizeExtensionWidth.toDouble()),
          buildSelectedResearch(textTheme),
        ],
      ),
    );
  }

  ///--------------- SELECTED RESEARCH ---------------///
   buildSelectedResearch(TextTheme textTheme) {
    return Container(
          margin: const EdgeInsets.symmetric(
            vertical: 33,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 32,
          ),
          height: Adapt.screenHeight,
          width: 342,
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(13),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Recently Played',
                      style: textTheme.subtitle1!.copyWith(
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                    const Xmargin(128),
                    Icon(
                      Icons.settings,
                      color: Colors.grey[600],
                      size: 19,
                    ),
                  ],
                ),
                const Ymargin(20),
                Container(
                  height: 360,
                  width: 300,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/the_cycle.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                const Ymargin(18),
                Row(
                  children: [
                    Text(
                      'The Cycle',
                      style: textTheme.subtitle1!.copyWith(
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                    const Xmargin(163),
                    Text(
                      '43%',
                      style: textTheme.subtitle2!.copyWith(
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
                const Ymargin(14),
                LinearPercentIndicator(
                  width: 270,
                  lineHeight: 7.0,
                  percent: 0.43,
                  backgroundColor: Colors.grey[350],
                  progressColor: Colors.blueAccent[400],
                ),
                const Ymargin(20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    bottom: 20,
                  ),
                  child: Container(
                    height: 35,
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent[400],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'Play',
                        style: textTheme.subtitle1!.copyWith(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    bottom: 12,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesome.clock_o,
                        color: Colors.grey[600],
                        size: 17,
                      ),
                      const Xmargin(10),
                      const Text(
                        "You've played 48 hours",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    bottom: 20,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesome.calendar_o,
                        color: Colors.grey[600],
                        size: 15,
                      ),
                      const Xmargin(10),
                      const Text(
                        "Last played 06.07.2020",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 300,
                  height: 100,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Achievements',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const Ymargin(10),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/images/cycle_1.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Xmargin(8),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/images/cycle_2.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Xmargin(8),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/images/cycle_3.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Xmargin(8),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/images/cycle_4.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Xmargin(8),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/images/cycle_5.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.grey[800]!.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  '+58',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Ymargin(20),
                const Text(
                  'Screenshots',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                const Ymargin(10),
                SizedBox(
                  height: 200,
                  width: 300,
                  child: GridView.count(
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    crossAxisCount: 3,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/images/cycle_screen_1.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/cycle_2.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/cycle_5.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/images/cycle_screen_2.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/cycle_3.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey[800]!.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              '+12',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
  }

  ///------------------------------- CENTER MAIN -------------------------------///
  ///--------------- FAVOURITE ---------------///
  Column buildFavourites(TextTheme textTheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Favorites',
            textAlign: TextAlign.left,
            style: textTheme.headline6!.copyWith(
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.w600,
              color: Colors.grey[900],
            ),
          ),
        ),
        const Ymargin(10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),//const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: 150,
             width: 567,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 150,
                    // width: 500,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: favouriteResearch.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              FavouriteResearchCard(
                                  image: favouriteResearch[index]),
                              const Xmargin(6),
                            ],
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: 150,
                  width: 110,
                  child: Card(
                    color: Colors.blueAccent[400],
                    semanticContainer: false,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    // margin: EdgeInsets.all(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///--------------- POPULAR ---------------///
  Column buildPopular(TextTheme textTheme) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Popular Games',
              style: textTheme.headline6!.copyWith(
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.w600,
                color: Colors.grey[900],
              ),
            ),
            const Xmargin(390),
            Icon(
              FontAwesome.long_arrow_right,
              color: Colors.grey[600],
              size: 19,
            ),
          ],
        ),
        const Ymargin(10),
        SizedBox(
          height: 270,
          width: 567,
          child: Card(
            semanticContainer: false,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            elevation: 0,
            child: Row(
              children: [
                Container(
                  width: 320,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/outer_worlds.jpeg'),
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 25,
                  ),
                  child: SizedBox(
                    height: 180,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Colors.grey[800],
                                  size: 17,
                                ),
                                onTap: () {},
                              ),
                              const Xmargin(12),
                              InkWell(
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey[800],
                                  size: 17,
                                ),
                                onTap: () {},
                              ),
                              const Xmargin(100),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesome.dot_circle_o,
                                    color: Colors.grey[800],
                                    size: 12,
                                  ),
                                  const Xmargin(3),
                                  const Icon(
                                    Octicons.primitive_dot,
                                    color: Colors.grey,
                                    size: 8,
                                  ),
                                  const Xmargin(3),
                                  const Icon(
                                    Octicons.primitive_dot,
                                    color: Colors.grey,
                                    size: 8,
                                  ),
                                  const Xmargin(3),
                                  const Icon(
                                    Octicons.primitive_dot,
                                    color: Colors.grey,
                                    size: 8,
                                  ),
                                  const Xmargin(3),
                                  const Icon(
                                    Octicons.primitive_dot,
                                    color: Colors.grey,
                                    size: 8,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Ymargin(20),
                          Text(
                            'The Outer Worlds',
                            style: textTheme.subtitle1!.copyWith(
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          const Ymargin(8),
                          SizedBox(
                            width: 185,
                            child: Text(
                              'The Outer Worlds is a new Single player first-person sci-fi RPG from Obsidian Entertainment and Private Division.',
                              style: textTheme.caption!.copyWith(
                                color: Colors.grey,
                                fontFamily: 'WorkSans',
                              ),
                            ),
                          ),
                          const Ymargin(14),
                          Container(
                            height: 27,
                            width: 75,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent[400],
                              borderRadius:
                              BorderRadius.circular(2),
                            ),
                            child: const Center(
                              child: Text(
                                'Up to -25%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column buildResearch(TextTheme textTheme, BuildContext context) {
    return Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'News',
                            style: textTheme.headline6!.copyWith(
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[900],
                            ),
                          ),
                          const Xmargin(455),
                          Row(
                            children: [
                              Icon(
                                FontAwesome.th_large,
                                color: Colors.grey[600],
                                size: 16,
                              ),
                              const Xmargin(13),
                              Icon(
                                Icons.format_list_bulleted,
                                color: Colors.grey[600],
                                size: 19,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Ymargin(10),
                      buildNewsCard(context),
                    ],
                  );
  }

  ///------------------------------- WIDGETS -------------------------------///

  ///--------------- NEWS CARD ---------------///
  Widget buildNewsCard(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Container(
          height: 340,
          width: 567,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/harley_quinn_2.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        Positioned(
          height: 170,
          width: 567,
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(11),
              bottomRight: Radius.circular(11),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 16,
                sigmaY: 16,
              ),
              child: Container(
                color: Colors.grey[600]!.withOpacity(0.5),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 26,
              vertical: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HARLEY QUINN ARRIVES IN FORTNITE',
                  style: textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Ymargin(4),
                SizedBox(
                  width: 500,
                  child: Text(
                    'The Item Shop features the Harley Quinn Bundle, which includes the Harley Quinn Outfit and Harley Hitter and Punchline Pickaxes. If you’re up for hijinx, Harley arrives with new Challenges that will transform her from Lil Monster XoXo Harley to Always Fantabulous Harley. ',
                    style: textTheme.caption!.copyWith(
                      color: Colors.white,
                      fontFamily: 'WorkSans',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///--------------- LEFT ---------------///
  Widget buildLeft(ResearchLibraryViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Card(
        semanticContainer: false,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        child: Material(
          textStyle: const TextStyle(
            color: Colors.white70,
            fontFamily: 'Lato',
          ),
          child: Container(
            width: 20.sizeExtensionWidth.toDouble(),
            height: 100.sizeExtensionHeight.toDouble(),
            decoration: BoxDecoration(
              color: Colors.blueAccent[400],
            ),
            child: CupertinoScrollbar(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 4.sizeExtensionHeight.toDouble(),
                    ),
                    CupertinoScrollbar(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                left: 2.4.sizeExtensionWidth.toDouble(),
                                right: 1.3.sizeExtensionWidth.toDouble(),
                              ),
                              child: const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/bert_image.jpg'),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'DART VADER',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.7,
                                  child: Text(
                                    '128,564\$',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Ymargin(3.3.sizeExtensionHeight.toDouble()),
                    Center(
                      child: SizedBox(
                        width: 15.sizeExtensionWidth.toDouble(),
                        height: 5.sizeExtensionHeight.toDouble(),
                        child: TextField(
                          style: TextStyle(
                            fontSize: 1.3.sizeExtensionWidth.toDouble(),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                          ),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(),
                            filled: true,
                            fillColor: const Color.fromRGBO(0, 0, 0, 0.2),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              fontSize: 1.2.sizeExtensionWidth.toDouble(),
                              color: const Color.fromRGBO(255, 255, 255, 0.5),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Opacity(
                              opacity: 0.5,
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 1.5.sizeExtensionWidth.toDouble(),
                              ),
                            ),
                            prefixIconConstraints: BoxConstraints(
                                minWidth: 3.sizeExtensionWidth.toDouble()),
                          ),
                        ),
                      ),
                    ),
                    Ymargin(3.4.sizeExtensionHeight.toDouble()),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 3.1.sizeExtensionWidth.toDouble(),
                        bottom: 2.5.sizeExtensionHeight.toDouble(),
                      ),
                      child: Text(
                        'EPIC GAMES',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 1.3.sizeExtensionWidth.toDouble(),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 3.sizeExtensionWidth.toDouble()),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => model.changeFirstIndex(1),
                            child: iconList1(
                              iconData: Icons.home,
                              title: 'Home',
                              active: model.firstIndex == 1,
                            ),
                          ),
                          InkWell(
                            onTap: () => model.changeFirstIndex(2),
                            child: iconList1(
                              iconData: Icons.store,
                              title: 'Store',
                              active: model.firstIndex == 2,
                            ),
                          ),
                          InkWell(
                            onTap: () => model.changeFirstIndex(3),
                            child: iconList1(
                              iconData: FontAwesome.th_large,
                              title: 'Library',
                              active: model.firstIndex == 3,
                            ),
                          ),
                          InkWell(
                            onTap: () => model.changeFirstIndex(4),
                            child: iconList1(
                              iconData: Icons.group,
                              title: 'Community',
                              active: model.firstIndex == 4,
                            ),
                          ),
                          InkWell(
                            onTap: () => model.changeFirstIndex(5),
                            child: iconList1(
                              iconData: Icons.settings,
                              title: 'Settings',
                              active: model.firstIndex == 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Ymargin(3.2.sizeExtensionHeight.toDouble()),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 3.1.sizeExtensionWidth.toDouble(),
                        bottom: 2.5.sizeExtensionHeight.toDouble(),
                      ),
                      child: Text(
                        'PLAYER',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 1.3.sizeExtensionWidth.toDouble(),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 3.sizeExtensionWidth.toDouble()),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => model.changeSecondIndex(1),
                            child: iconList2(
                              iconData: Icons.person,
                              title: 'Profile',
                              active: model.secondIndex == 1,
                            ),
                          ),
                          InkWell(
                            onTap: () => model.changeSecondIndex(2),
                            child: iconList2(
                              iconData: Icons.adjust,
                              title: 'Activity',
                              active: model.secondIndex == 2,
                            ),
                          ),
                          InkWell(
                            onTap: () => model.changeSecondIndex(3),
                            child: iconList2(
                              iconData: Icons.chat_bubble,
                              title: 'Friends',
                              active: model.secondIndex == 3,
                            ),
                          ),
                          InkWell(
                            onTap: () => model.changeSecondIndex(4),
                            child: iconList2(
                              iconData: FontAwesome.cloud_download,
                              title: 'Downloads',
                              active: model.secondIndex == 4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Ymargin(8.sizeExtensionHeight.toDouble()),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 3.1.sizeExtensionWidth.toDouble(),
                        bottom: 2.3.sizeExtensionHeight.toDouble(),
                      ),
                      child: Text(
                        'MESSAGES',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 1.3.sizeExtensionWidth.toDouble(),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 3.1.sizeExtensionWidth.toDouble()),
                      child: CupertinoScrollbar(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/timi.jpg'),
                                  ),
                                  Positioned(
                                      bottom: 1,
                                      right: 0,
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent[400],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Container(
                                            height: 6,
                                            width: 6,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                              const Xmargin(8),
                              Stack(
                                children: [
                                  const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/bolu.jpg'),
                                  ),
                                  Positioned(
                                      bottom: 1,
                                      right: 0,
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent[400],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Container(
                                            height: 6,
                                            width: 6,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                              const Xmargin(8),
                              Stack(
                                children: [
                                  const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/rinz.jpg'),
                                  ),
                                  Positioned(
                                      bottom: 1,
                                      right: 0,
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent[400],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Container(
                                            height: 6,
                                            width: 6,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                              const Xmargin(8),
                              Stack(
                                children: [
                                  const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/llama.png'),
                                  ),
                                  Positioned(
                                      bottom: 1,
                                      right: 0,
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent[400],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Container(
                                            height: 6,
                                            width: 6,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///--------------- ICON LIST 1 ---------------///
  Widget iconList1({
    String? title,
    IconData? iconData,
    bool active = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.8.sizeExtensionHeight.toDouble()),
      child: AnimatedOpacity(
        opacity: active ? 1 : 0.5,
        duration: const Duration(milliseconds: 300),
        child: Row(
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 1.4.sizeExtensionWidth.toDouble(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.4.sizeExtensionWidth.toDouble()),
              child: Text(
                title!,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 1.3.sizeExtensionWidth.toDouble(),
                ),
              ),
            ),
            Padding(
              padding: title!.length > 8
                  ? EdgeInsets.only(left: 4.5.sizeExtensionWidth.toDouble())
                  : EdgeInsets.only(left: 8.sizeExtensionWidth.toDouble()),
              child: active
                  ? Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 1.5.sizeExtensionWidth.toDouble(),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  ///------------------------------- ICON LIST 2 -------------------------------///
  Widget iconList2({
    String? title,
    IconData? iconData,
    bool active = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.9.sizeExtensionHeight.toDouble()),
      child: AnimatedOpacity(
        opacity: active ? 1 : 0.5,
        duration: const Duration(milliseconds: 300),
        child: Row(
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 1.4.sizeExtensionWidth.toDouble(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.4.sizeExtensionWidth.toDouble()),
              child: Text(
                title!,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 1.3.sizeExtensionWidth.toDouble(),
                ),
              ),
            ),
            Padding(
              padding: title!.length > 8
                  ? EdgeInsets.only(left: 4.5.sizeExtensionWidth.toDouble())
                  : EdgeInsets.only(left: 8.2.sizeExtensionWidth.toDouble()),
              child: active
                  ? Icon(
                      Octicons.primitive_dot,
                      color: Colors.white,
                      size: 1.2.sizeExtensionWidth.toDouble(),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class FavouriteResearchCard extends StatelessWidget {
  const FavouriteResearchCard({
    Key? key,
    this.image,
    this.name,
  }) : super(key: key);

  final String? image;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 110,
      child: Card(
        semanticContainer: false,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        child: image == null
            ? name == null
                ? Container()
                : Text(name![0].toUpperCase())
            : Image.asset(
                image!, // 'assets/images/fortnite.jpg',
                fit: BoxFit.cover,
              ),
        // margin: EdgeInsets.all(10),
      ),
    );
  }
}

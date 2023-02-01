import 'package:flutter/rendering.dart';
import 'package:health_ministry_research_library/imports.dart';
import 'package:http/http.dart' as http;

import 'dart:ui';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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

    /// VARIABLE FOR USER DETAIL
    getUserInfo();

    /// VARIABLE FOR SCROLL
    exclusiveScrollController = ScrollController();
    popularNowScrollController = ScrollController();

    // isSearchSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    SizeConfig().init(context);
    Adapt.init(context);

    return buildViewModelBuilder(screenSize);
  }

  ///--------------------------------------------------- VIEW MODEL BUILDER ---------------------------------------------------///
  ViewModelBuilder<ResearchLibraryViewModel> buildViewModelBuilder(
      Size screenSize) {
    return ViewModelBuilder<ResearchLibraryViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: buildBody(model, context, screenSize),
        );
      },
      viewModelBuilder: () => ResearchLibraryViewModel(),
    );
  }

  ///--------------------------------------------------- BODY ---------------------------------------------------///
  buildBody(
      ResearchLibraryViewModel model, BuildContext context, Size screenSize) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width / 10),
            child: buildTopBar(screenSize),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: screenSize.width * 0.05,
              right: screenSize.width * 0.05,
              // top: screenSize.width * 0.02,
              bottom: screenSize.width * 0.06,
            ),
            child: buildMainBody(model, context, screenSize),
          ),
        ],
      ),
    );
  }

  ///------------------------------- TOP BAR -------------------------------///
  buildTopBar(Size screenSize) {
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
  buildMainBody(
      ResearchLibraryViewModel model, BuildContext context, Size screenSize) {
    return SizedBox(
      // height: Adapt.screenHeight * 6,
      width: Adapt.screenWidth,
      child: Container(
        width: screenSize.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(screenSize.width * 0.03),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSideMenu(context, screenSize),
            buildCenterPage(context, screenSize)
          ],
        ),
      ),
    );
  }

  ///---------------------- SIDE MENU ----------------------///
  buildSideMenu(BuildContext context, Size screenSize) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: paneColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenSize.width * 0.03),
            bottomLeft: Radius.circular(screenSize.width * 0.03),
            topRight: Radius.circular(screenSize.width * 0.03),
            bottomRight: Radius.circular(screenSize.width * 0.03),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            UserCard(
              title: "Arab kumar",
              plan: "Premium Plan",
            ),
            Menu(),
            Current(),
          ],
        ),
      ),
    );
  }

  ///---------------------- CENTER PAGE ----------------------///
  buildCenterPage(BuildContext context, Size screenSize) {
    return Expanded(
      flex: 7,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(
          top: 50,
          left: 100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildExplore(context, screenSize),
            const SizedBox(height: 70),
            searchData.isNotEmpty
                ? buildExploreScreen(context, screenSize)
                : buildMainScreen(context, screenSize),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  ///--------------- EXPLORE ---------------///
  buildExplore(BuildContext context, Size screenSize) {
    return SizedBox(
        height: 80,
        width: screenSize.width * 0.8,
        child: Row(
          children: [
            Text(
              "Explore",
              style: GoogleFonts.poppins(
                color: titleColor,
                fontWeight: FontWeight.w700,
                fontSize: 50,
              ),
            ),
            const Spacer(),
            Container(
              height: 80,
              alignment: Alignment.center,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(20, 20),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ]),
              child: TextFormField(
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                controller: searchTextEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Icon(
                      Icons.search,
                      size: 30,
                      color: subtitleColor,
                    ),
                  ),
                  hintText: 'Search',
                  hintStyle: GoogleFonts.poppins(
                    color: subtitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kRegentStBlue),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 25.0,
                  ),
                ),
                onChanged: (text) {
                  getSearch();
                  setState(() {
                    // isSearchSelected = true;
                  });
                },
              ),
            ),
            const SizedBox(
              width: 100,
            ),
          ],
        ));
  }

  ///--------------- MAIN SCREEN ---------------///

  buildMainScreen(BuildContext context, Size screenSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildPopularNowTitle(context, screenSize),
        const SizedBox(height: 20),
        buildPopularNow(context, screenSize),
        const SizedBox(height: 70),
        buildExclusiveTitle(context, screenSize),
        const SizedBox(height: 20),
        buildExclusive(context, screenSize),
        const SizedBox(height: 70),
        buildAll(context, screenSize, 16,
            ResponsiveWidget.isLargeScreen(context) ? 4 : 3),
      ],
    );
  }

  ///------- POPULAR NOW -------///
  late ScrollController? popularNowScrollController = ScrollController();

  buildPopularNowTitle(BuildContext context, Size screenSize) {
    return SizedBox(
      height: 50,
      width: screenSize.width * 0.8,
      child: Row(
        children: [
          Text(
            "Popular Now",
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
          const Spacer(),
          /*SmoothPageIndicator(
                  controller: pageController,
                  count: ((books.length + 1) / 5).roundToDouble().toInt(),
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Color(0xFF8A8A8A),
                    dotColor: Color(0xFFABABAB),
                    dotHeight: 4.8,
                    dotWidth: 6,
                    spacing: 4.8,
                  ),
                ),*/
          CircleAvatar(
            backgroundColor: themeBlue,
            child: IconButton(
              icon: Icon(
                Icons.navigate_before,
                color: titleColor,
              ),
              onPressed: () {
                setState(() {
                  popularNowScrollController!
                      .jumpTo(popularNowScrollController!.offset - 15);
                });
              },
            ),
          ),
          const SizedBox(width: 20),
          CircleAvatar(
            backgroundColor: themeBlue,
            child: IconButton(
              icon: Icon(
                Icons.navigate_next,
                color: titleColor,
              ),
              onPressed: () {
                setState(() {
                  popularNowScrollController!
                      .jumpTo(popularNowScrollController!.offset + 15);
                });
              },
            ),
          ),
          const SizedBox(width: 20),
          ScrollIndicator(
            scrollController: popularNowScrollController!,
            width: 50,
            height: 5,
            indicatorWidth: 20,
            decoration: BoxDecoration(
              color: themeBlue,
              borderRadius: BorderRadius.circular(100),
            ),
            indicatorDecoration: BoxDecoration(
              color: titleColor,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          const SizedBox(width: 100),
        ],
      ),
    );
  }

  buildPopularNow(BuildContext context, Size screenSize) {
    // Positioned( top: screenSize.height * 0.32, right: 0,
    return SizedBox(
      height: 366,
      width: screenSize.width * 0.6,
      child: ListView.builder(
        controller: popularNowScrollController,
        shrinkWrap: true,
        itemCount: books.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, i) {
          return BookCard(
            bookData: books[i],
          );
        },
      ),
    );
  }

  ///------- EXCLUSIVE -------///
  late ScrollController? exclusiveScrollController = ScrollController();

  buildExclusiveTitle(BuildContext context, Size screenSize) {
    return SizedBox(
      height: 50,
      width: screenSize.width * 0.8,
      child: Row(
        children: [
          Text(
            "Exclusives",
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
          const Spacer(),
          /*SmoothPageIndicator(
                  controller: pageController,
                  count: ((books.length + 1) / 5).roundToDouble().toInt(),
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Color(0xFF8A8A8A),
                    dotColor: Color(0xFFABABAB),
                    dotHeight: 4.8,
                    dotWidth: 6,
                    spacing: 4.8,
                  ),
                ),*/
          CircleAvatar(
            backgroundColor: themeBlue,
            child: IconButton(
              icon: Icon(
                Icons.navigate_before,
                color: titleColor,
              ),
              onPressed: () {
                setState(() {
                  exclusiveScrollController!
                      .jumpTo(exclusiveScrollController!.offset - 15);
                });
              },
            ),
          ),
          const SizedBox(width: 20),
          CircleAvatar(
            backgroundColor: themeBlue,
            child: IconButton(
              icon: Icon(
                Icons.navigate_next,
                color: titleColor,
              ),
              onPressed: () {
                setState(() {
                  exclusiveScrollController!
                      .jumpTo(exclusiveScrollController!.offset + 15);
                });
              },
            ),
          ),
          const SizedBox(width: 20),
          ScrollIndicator(
            scrollController: exclusiveScrollController!,
            width: 50,
            height: 5,
            indicatorWidth: 20,
            decoration: BoxDecoration(
              color: themeBlue,
              borderRadius: BorderRadius.circular(100),
            ),
            indicatorDecoration: BoxDecoration(
              color: titleColor,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          const SizedBox(width: 100),
        ],
      ),
    );
  }

  buildExclusive(BuildContext context, Size screenSize) {
    // Positioned( top: screenSize.height * 0.8, right: 0,
    return SizedBox(
      height: 220,
      width: screenSize.width * 0.6,
      child: ListView.builder(
          controller: exclusiveScrollController,
          shrinkWrap: true,
          itemCount: books.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) {
            return ExclusiveCard(
              bookData: books[i],
            );
          }),
    );
  }

  ///------- ALL -------///
  late ScrollController? allScrollController = ScrollController();

  buildAllTitle(BuildContext context, Size screenSize) {
    return SizedBox(
      height: 50,
      width: screenSize.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All",
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  buildAll(BuildContext context, Size screenSize, int crossAxisCount,
      int crossAxisCellCount) {
    // Positioned( top: screenSize.height * 0.8, right: 0,
    return Column(
      children: [
        StaggeredGridView.countBuilder(
          crossAxisCount: crossAxisCount,
          itemCount: books.length,
          addAutomaticKeepAlives: false,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return index == 0
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: buildAllTitle(context, screenSize),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: BookCard(bookData: books[index]),
                  );
          },
          staggeredTileBuilder: (int index) => StaggeredTile.fit(
            (index == 0) ? crossAxisCount : crossAxisCellCount,
          ),
        ),
      ],
    );
  }

  ///--------------- EXPLORE SCREEN ---------------///

  buildExploreScreen(BuildContext context, Size screenSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        searchData.isEmpty
            ? Container()
            : buildSearch(context, screenSize, 16,
                ResponsiveWidget.isLargeScreen(context) ? 4 : 3),
      ],
    );
  }

  ///------- SEARCH -------///
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();
  late ScrollController? searchScrollController = ScrollController();

  List<BookModel> searchData = <BookModel>[];

  buildSearch(BuildContext context, Size screenSize, int crossAxisCount,
      int crossAxisCellCount) {
    // Positioned( top: screenSize.height * 0.8, right: 0,
    return Column(
      children: [
        StaggeredGridView.countBuilder(
          crossAxisCount: crossAxisCount,
          itemCount: searchData.length,
          addAutomaticKeepAlives: false,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: BookCard(bookData: searchData[index]),
            );
          },
          staggeredTileBuilder: (int index) => StaggeredTile.fit(
            (index == 0) ? crossAxisCount : crossAxisCellCount,
          ),
        ),
      ],
    );
  }

  onSearchTextChanged(String? text) async {
    searchData.clear();
    if (text!.isEmpty) {
      // Check textfield is empty or not
      setState(() {});
      return;
    }

    books.forEach((data) {
      if (data.name
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase().toString())) {
        searchData.add(data);
        // If not empty then add search data into search data list
      }
    });

    setState(() {});
  }

  getSearch() async {
    searchData.clear();
    if (searchTextEditingController.text.isEmpty) {
      // Check textfield is empty or not
      setState(() {
        searchData.clear();
      });
      return;
    }

    books.forEach(
      (data) {
        if (data.name.toString().toLowerCase().contains(
            searchTextEditingController.text.toLowerCase().toString())) {
          searchData.add(data);
          // If not empty then add search data into search data list
        } else if (data.author.toString().toLowerCase().contains(
            searchTextEditingController.text.toLowerCase().toString())) {
          searchData.add(data);
          // If not empty then add search data into search data list
        }
      },
    );

    setState(() {});
  }
}

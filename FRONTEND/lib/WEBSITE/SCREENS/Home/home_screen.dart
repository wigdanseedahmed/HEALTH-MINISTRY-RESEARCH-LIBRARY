import 'package:health_ministry_research_library/imports.dart';
import 'package:http/http.dart' as http;

class HomeScreenWS extends StatefulWidget {
  const HomeScreenWS({Key? key}) : super(key: key);

  @override
  State<HomeScreenWS> createState() => _HomeScreenWSState();
}

class _HomeScreenWSState extends State<HomeScreenWS> {
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

  /// VARIABLES USED FOR RETRIEVING ALL USER
  List<UserModel>? allUsersData = <UserModel>[];

  Future<List<UserModel>?> readAllUsersData() async {
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
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      allUsersData = userModelListFromJson(response.body);
      // print("User Model Info : ${readJsonFileContent}");

      return allUsersData;
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
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(1.0),
      child: Scaffold(body: buildBody()),
    );
  }

  ///---------------------------------------------------  FUTURE DATA ---------------------------------------------------///
  FutureBuilder<UserModel> buildFutureBuilderBody() {
    return FutureBuilder<UserModel>(
      future: readingUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return FutureBuilder<List<UserModel>?>(
              future: readAllUsersData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Scaffold(
                      body: buildBody(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                }

                return const CircularProgressIndicator();
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }

        return const CircularProgressIndicator();
      },
    );
  }

  ///--------------------------------------------------- BODY ---------------------------------------------------///
  buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 10),
        child: Column(
          children: [

            buildTopBar(),
            buildMainBody(),
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
          isLoginOrRegistration: 'Home',
          isSelectedPage: '',
        )
            : TopBarMenuAfterLoginWS(
          isSelectedPage: 'Home',
          user: readUserContent,
        ),
      ],
    );
  }

  ///------------------------------- MAIN BODY -------------------------------///
  buildMainBody() {
    return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*Flexible(
                  flex: (MediaQuery.of(context).size.width < 1360) ? 4 : 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: SidebarWS(
                      userData: readUserJsonFileContent,
                      projectData: allProjects[0],
                    ),
                  ),
                ),*/
                Flexible(
                  flex: 9,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // buildHeader(),
                      const SizedBox(height: 40),
                      // buildProgress(),
                      const SizedBox(height: 40),
                      /*buildActiveProject(
                        user: readUserContent,
                        openProjects: allProjectsData
                            .where(
                              (element) =>
                                  element.status == 'Open' &&
                                  element.members!.any((members) =>
                                      members.memberUsername ==
                                      readUserContent.username),
                            )
                            .toList(),
                        crossAxisCount: 6,
                        crossAxisCellCount:
                            ResponsiveWidget.isLargeScreen(context) ? 3 : 2,
                      ),*/
                      const SizedBox(height: 40),
                      /*buildTaskOverview(
                        taskData: readTasksContent,
                        crossAxisCount: 6,
                        crossAxisCellCount:
                            ResponsiveWidget.isLargeScreen(context) ? 3 : 2,
                      ),*/
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                /*Flexible(
                  flex: 4,
                  child: Column(
                    children: [
                      const SizedBox(height: 20 / 2),
                      _buildProfile(userData: readUserJsonFileContent),
                      const Divider(thickness: 1),
                      const SizedBox(height: 20),
                      // _buildTeamMember(data: controller.getMember()),
                      const SizedBox(height: 20),
                      */
                /* Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: GetPremiumCard(onPressed: () {}),
                                ),*/
                /*
                      const SizedBox(height: 20),
                      const Divider(thickness: 1),
                      const SizedBox(height: 20),
                      // _buildRecentMessages(userData: controller.getChatting()),
                    ],
                  ),
                )*/
              ],
            ),
          );
  }
}

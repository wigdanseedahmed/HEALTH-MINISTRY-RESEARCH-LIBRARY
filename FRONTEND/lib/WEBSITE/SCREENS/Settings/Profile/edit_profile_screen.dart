import 'package:health_ministry_research_library/imports.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;

class EditProfileScreenWS extends StatefulWidget {
  static const String id = 'edit profile_screen';

  const EditProfileScreenWS({
    Key? key,
    required this.selectedEditProfileSideMenuItemInt,
  }) : super(key: key);

  final int selectedEditProfileSideMenuItemInt;

  @override
  _EditProfileScreenWSState createState() => _EditProfileScreenWSState();
}

class _EditProfileScreenWSState extends State<EditProfileScreenWS> {
  /// Variables used to add more
  bool addNewLanguage = false;

  /// Variable used to get RESTful-API
  NetworkHandler networkHandler = NetworkHandler();

  /// User Model information Variables
  getUserInfo() async {
    UserProfile.personalEmail =
        await CheckSharedPreferences.getUserEmailSharedPreference();
    UserProfile.personalEmail =
        await CheckSharedPreferences.getUserEmailSharedPreference();
    var userInfo = await networkHandler
        .get("${AppUrl.getUserUsingEmail}${UserProfile.personalEmail}");

    //print(userInfo);
    setState(() {
      UserProfile.username = userInfo['data']['username'];
      UserProfile.firstName = userInfo['data']['firstName'];
      UserProfile.lastName = userInfo['data']['lastName'];
      UserProfile.userPhotoURL= userInfo['data']['userPhotoURL'];
      UserProfile.userPhotoName = userInfo['data']['userPhotoName'];
      UserProfile.userPhotoFile = userInfo['data']['userPhotoFile'];
      UserProfile.nationality = userInfo['data']['nationality'];
      UserProfile.occupation = userInfo['data']['occupation'];
      UserProfile.address = userInfo['data']['address'];
      UserProfile.personalEmail = userInfo['data']['personalEmail'];
      UserProfile.workEmail = userInfo['data']['workEmail'];
    });
  }

  UserModel readUserJsonFileContent = UserModel();
  Future<UserModel>? futureUserInformation;

  Future<UserModel> readingUserJsonData() async {
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
      readUserJsonFileContent = userModelListFromJson(response.body)
          .where((element) => element.personalEmail == UserProfile.personalEmail || element.workEmail == UserProfile.personalEmail)
          .toList()[0];
      //print("User Model Info : ${readUserJsonFileContent.firstName}");

      return readUserJsonFileContent;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<UserModel> writeUserJsonData(
      UserModel selectedTaskInformation) async {
    /// String to URI, using the same url used in the nodejs code
    var uri =
        Uri.parse("${AppUrl.updateUserInformationByEmail}${UserProfile.personalEmail}");

    //print(selectedTaskInformation);

    /// Create Request to get data and response to read data
    final response = await http.put(
      uri,
      headers: {
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        "Access-Control-Allow-Headers":
        "Content-Type, Access-Control-Allow-Origin, Accept",
        'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Methods": "POST, DELETE, GET, PUT"
      },
      body: json.encode(selectedTaskInformation.toJson()),
    );
    // print(response.body);

    if (response.statusCode == 200) {
      // readUserJsonFileContent = UserModel.fromJson(jsonDecode(response.body));

      readUserJsonFileContent = userModelFromJson(response.body);

      return readUserJsonFileContent;
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
  void initState() {
    /// VARIABLES USED TO SCROLL THROUGH SCREEN
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    /// User Model information Variables
    getUserInfo();
    futureUserInformation = readingUserJsonData();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < MediaQuery.of(context).size.height * 0.40
        ? _scrollPosition / (MediaQuery.of(context).size.height * 0.40)
        : 1;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(1.0),
      child: FutureBuilder<UserModel>(
        future: futureUserInformation ,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return buildBody(screenSize);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }

  validateInputs() {
    Navigator.pop(context);
    return;
  }

  buildBody(Size screenSize) {
    return Column(
      children: [
        ProfileAvatarWidget(
          email: UserProfile.personalEmail,
          isEdit: true,
          onClicked: () async {},
        ),
        const SizedBox(height: 40),
        widget.selectedEditProfileSideMenuItemInt == 0
            ? buildPersonalInformation(screenSize)
            : buildPersonalInformation(screenSize),
      ],
    );
  }

  ///------------------------------------- PERSONAL INFORMATION -------------------------------------///

  buildPersonalInformation(Size screenSize) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          EditProfileTitleCardWS(
            rightWidget: null,
            title: "Personal Information",
            onPressedSave: () {
              setState(() {
                readUserJsonFileContent.dateUpdated = DateTime.now();
                futureUserInformation =
                    writeUserJsonData(readUserJsonFileContent);
              });
            },
          ),
          ProfileCardWS(
            title: "First name",
            rightWidget: null,
            initialValue: readUserJsonFileContent.firstName == null
                ? ''
                : readUserJsonFileContent.firstName!,
            onChanged: (firstName) {
              setState(() {
                firstName == ""
                    ? readUserJsonFileContent.firstName = null
                    : readUserJsonFileContent.firstName = firstName;
              });
            },
            onFieldSubmitted: (firstName) {
              setState(() {
                firstName == ""
                    ? readUserJsonFileContent.firstName = null
                    : readUserJsonFileContent.firstName = firstName;
              });
            },
          ),
          ProfileCardWS(
            title: "Last name",
            rightWidget: null,
            initialValue: readUserJsonFileContent.lastName == null
                ? ''
                : readUserJsonFileContent.lastName!,
            onChanged: (lastName) {
              setState(() {
                lastName == ""
                    ? readUserJsonFileContent.lastName = null
                    : readUserJsonFileContent.lastName = lastName;
              });
            },
            onFieldSubmitted: (lastName) {
              setState(() {
                lastName == ""
                    ? readUserJsonFileContent.lastName = null
                    : readUserJsonFileContent.lastName = lastName;
              });
            },
          ),
          ProfileCardWS(
            title: "Username",
            rightWidget: null,
            initialValue: readUserJsonFileContent.username == null
                ? ''
                : readUserJsonFileContent.username!,
            onChanged: (username) {
              setState(() {
                username == ""
                    ? readUserJsonFileContent.username = null
                    : readUserJsonFileContent.username = username;
              });
            },
            onFieldSubmitted: (username) {
              setState(() {
                username == ""
                    ? readUserJsonFileContent.username = null
                    : readUserJsonFileContent.username = username;
              });
            },
          ),
          ProfileCardWS(
            title: "Nationality",
            rightWidget: null,
            initialValue: readUserJsonFileContent.nationality == null
                ? ''
                : readUserJsonFileContent.nationality!,
            onChanged: (nationality) {
              setState(() {
                nationality == ""
                    ? readUserJsonFileContent.nationality = null
                    : readUserJsonFileContent.nationality = nationality;
              });
            },
            onFieldSubmitted: (nationality) {
              setState(() {
                nationality == ""
                    ? readUserJsonFileContent.nationality = null
                    : readUserJsonFileContent.nationality = nationality;
              });
            },
          ),
          ProfileItemCardWS(
            title: "Date of birth",
            rightWidget: SizedBox(
              // height: screenSize.height * 0.2,
              width: screenSize.width * 0.2,
              child: CupertinoDateTextBox(
                fontSize: 15,
                color: DynamicTheme.of(context)?.brightness == Brightness.light
                    ? Colors.grey[700]!
                    : Colors.grey[400]!,
                initialValue: readUserJsonFileContent.userDateOfBirth == null
                    ? DateTime.now()
                    : DateFormat("yyyy-MM-dd")
                        .parse(readUserJsonFileContent.userDateOfBirth!),
                onDateChange: (DateTime? newDate) {
                  //print(newDate);
                  setState(() {
                    newDate == DateTime.now()
                        ? readUserJsonFileContent.userDateOfBirth = null
                        : readUserJsonFileContent.userDateOfBirth =
                            newDate!.toIso8601String();
                  });
                },
                hintText: readUserJsonFileContent.userDateOfBirth == null
                    ? DateFormat().format(DateTime.now())
                    : readUserJsonFileContent.userDateOfBirth!,
              ),
            ),
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          ProfileItemCardWS(
            title: "Gender",
            rightWidget: SizedBox(
              width: screenSize.width * 0.2,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return DropdownSearch<String>(
                  popupElevation: 0.0,
                  showClearButton: true,
                  //clearButtonProps: ,
                  dropdownSearchDecoration: InputDecoration(
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      letterSpacing: 3,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColour,
                        width: 0.3,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColour,
                        width: 0.3,
                      ),
                    ),
                  ),
                  //mode of dropdown
                  mode: Mode.MENU,
                  //to show search box
                  showSearchBox: true,
                  //list of dropdown items
                  items: genderList,
                  onChanged: (String? newValue) {
                    dropDownState(() {
                      newValue == ""
                          ? readUserJsonFileContent.userGender = null
                          : readUserJsonFileContent.userGender = newValue;
                    });
                  },
                  //show selected item
                  selectedItem: readUserJsonFileContent.userGender == null
                      ? ""
                      : readUserJsonFileContent.userGender!,
                );
              }),
            ),
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          ProfileCardWS(
            title: "Personal email",
            rightWidget: null,
            initialValue: readUserJsonFileContent.personalEmail == null
                ? ''
                : readUserJsonFileContent.personalEmail!,
            onChanged: (personalEmail) {
              setState(() {
                personalEmail == ""
                    ? readUserJsonFileContent.personalEmail = null
                    : readUserJsonFileContent.personalEmail = personalEmail;
              });
            },
            onFieldSubmitted: (personalEmail) {
              setState(() {
                personalEmail == ""
                    ? readUserJsonFileContent.personalEmail = null
                    : readUserJsonFileContent.personalEmail = personalEmail;
              });
            },
          ),
          ProfileCardWS(
            title: "Phone number",
            rightWidget: null,
            initialValue: readUserJsonFileContent.phoneNumber == null
                ? ''
                : readUserJsonFileContent.phoneNumber!,
            onChanged: (phoneNumber) {
              setState(() {
                phoneNumber == ""
                    ? readUserJsonFileContent.phoneNumber = null
                    : readUserJsonFileContent.phoneNumber = phoneNumber;
              });
            },
            onFieldSubmitted: (phoneNumber) {
              setState(() {
                phoneNumber == ""
                    ? readUserJsonFileContent.phoneNumber = null
                    : readUserJsonFileContent.phoneNumber = phoneNumber;
              });
            },
          ),
          ProfileCardWS(
            title: "Optional Phone number",
            rightWidget: null,
            initialValue: readUserJsonFileContent.optionalPhoneNumber == null
                ? ''
                : readUserJsonFileContent.optionalPhoneNumber!,
            onChanged: (optionalPhoneNumber) {
              setState(() {
                optionalPhoneNumber == ""
                    ? readUserJsonFileContent.optionalPhoneNumber = null
                    : readUserJsonFileContent.optionalPhoneNumber = optionalPhoneNumber;
              });
            },
            onFieldSubmitted: (optionalPhoneNumber) {
              setState(() {
                optionalPhoneNumber == ""
                    ? readUserJsonFileContent.optionalPhoneNumber = null
                    : readUserJsonFileContent.optionalPhoneNumber = optionalPhoneNumber;
              });
            },
          ),

        ],
      );


  ///------------------- WORK ETHICS -------------------///

}

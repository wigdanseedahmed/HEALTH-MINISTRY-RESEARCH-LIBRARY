import 'package:flutter/cupertino.dart';
import 'package:health_ministry_research_library/imports.dart';

import 'package:http/http.dart' as http;
import 'dart:io' as Io;

class ProfileScreenWS extends StatefulWidget {
  static const String id = 'profile_screen';

  const ProfileScreenWS({
    Key? key,
    required this.readUserContent,
    required this.selectedProfileSideMenuItemInt,
  }) : super(key: key);

  final UserModel readUserContent;
  final int selectedProfileSideMenuItemInt;

  @override
  _ProfileScreenWSState createState() => _ProfileScreenWSState();
}

class _ProfileScreenWSState extends State<ProfileScreenWS>
    with SingleTickerProviderStateMixin {
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    _opacity = _scrollPosition < MediaQuery
        .of(context)
        .size
        .height * 0.40
        ? _scrollPosition / (MediaQuery
        .of(context)
        .size
        .height * 0.40)
        : 1;

    return buildBody();
  }

  buildBody() {
    return Column(
      children: [
        widget.readUserContent.userPhotoFile == null
            ? ClipOval(
          child: Material(
            color: Colors.grey,
            child: SizedBox(
              width: 200,
              height: 200,
              child: Center(
                child: Text(
                  "${widget.readUserContent.firstName![0]}${widget
                      .readUserContent.lastName![0]}",
                  style: TextStyle(
                    fontSize: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(76, 75, 75, 1),
                  ),
                ),
              ),
            ),
          ),
        )
            : ClipOval(
          child: Material(
            color: Colors.transparent,
            child: Ink.image(
              image: MemoryImage(
                  base64Decode(widget.readUserContent.userPhotoFile!)),
              fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        buildName(),
        const SizedBox(
          height: 24,
        ),
        widget.selectedProfileSideMenuItemInt == 0
            ? buildPersonalInformation()
            : buildPersonalInformation(),
      ],
    );
  }


  buildName() =>
      Column(
        children: [
          Text(
            "${widget.readUserContent.firstName} ${widget.readUserContent
                .lastName}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            widget.readUserContent.occupation!,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
        ],
      );

  /// PERSONAL INFORMATION ///
  bool _expandedPersonalInformation = false;

  buildPersonalInformation() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.readUserContent.firstName == null
              ? Container()
              : const ProfileItemCardMA(
            title: "First name",
            rightWidget: null,
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          widget.readUserContent.firstName == null
              ? Container()
              : ProfileItemCardMA(
            title: widget.readUserContent.firstName,
            rightWidget: null,
            callback: () {
              if (kDebugMode) {
                print('Tap Settings Item 01');
              }
            },
            textStyle: kProfileBodyTextStyle,
          ),
          widget.readUserContent.lastName == null
              ? Container()
              : const ProfileItemCardMA(
            title: "Last name",
            rightWidget: null,
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          widget.readUserContent.lastName == null
              ? Container()
              : ProfileItemCardMA(
            title: widget.readUserContent.lastName,
            rightWidget: null,
            callback: () {
              if (kDebugMode) {
                print('Tap Settings Item 01');
              }
            },
            textStyle: kProfileBodyTextStyle,
          ),
          widget.readUserContent.username == null
              ? Container()
              : const ProfileItemCardMA(
            title: "Username",
            rightWidget: null,
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          widget.readUserContent.username == null
              ? Container()
              : ProfileItemCardMA(
            title: widget.readUserContent.username,
            rightWidget: null,
            callback: () {
              if (kDebugMode) {
                print('Tap Settings Item 01');
              }
            },
            textStyle: kProfileBodyTextStyle,
          ),
          widget.readUserContent.nationality == null
              ? Container()
              : const ProfileItemCardMA(
            title: "Nationality",
            rightWidget: null,
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          widget.readUserContent.nationality == null
              ? Container()
              : ProfileItemCardMA(
            title: widget.readUserContent.nationality,
            rightWidget: null,
            callback: () {
              if (kDebugMode) {
                print('Tap Settings Item 01');
              }
            },
            textStyle: kProfileBodyTextStyle,
          ),
          widget.readUserContent.userDateOfBirth == null
              ? Container()
              : const ProfileItemCardMA(
            title: "Date of birth",
            rightWidget: null,
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          widget.readUserContent.userDateOfBirth == null
              ? Container()
              : ProfileItemCardMA(
            title: DateFormat("EEE, MMM d, yyyy").format(
                DateTime.parse(widget.readUserContent.userDateOfBirth!)),
            rightWidget: null,
            callback: () {
              if (kDebugMode) {
                print('Tap Date of birth');
              }
            },
            textStyle: kProfileBodyTextStyle,
          ),
          widget.readUserContent.userGender == null
              ? Container()
              : const ProfileItemCardMA(
            title: "Gender",
            rightWidget: null,
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          widget.readUserContent.userGender == null
              ? Container()
              : ProfileItemCardMA(
            title: widget.readUserContent.userGender,
            rightWidget: null,
            callback: () {
              if (kDebugMode) {
                print('Tap gender');
              }
            },
            textStyle: kProfileBodyTextStyle,
          ),
          widget.readUserContent.personalEmail == null
              ? Container()
              : const ProfileItemCardMA(
            title: "Personal email",
            rightWidget: null,
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          widget.readUserContent.personalEmail == null
              ? Container()
              : ProfileItemCardMA(
            title: widget.readUserContent.personalEmail,
            rightWidget: null,
            callback: () {
              if (kDebugMode) {
                print('Tap Email');
              }
            },
            textStyle: kProfileBodyTextStyle,
          ),
          widget.readUserContent.phoneNumber == null
              ? Container()
              : const ProfileItemCardMA(
            title: "Phone number",
            rightWidget: null,
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          widget.readUserContent.phoneNumber == null
              ? Container()
              : ProfileItemCardMA(
            title: widget.readUserContent.phoneNumber,
            rightWidget: null,
            callback: () {
              if (kDebugMode) {
                print('Tap Settings Item 01');
              }
            },
            textStyle: kProfileBodyTextStyle,
          ),
          widget.readUserContent.optionalPhoneNumber == null
              ? Container()
              : const ProfileItemCardMA(
            title: "Optional Phone number",
            rightWidget: null,
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          widget.readUserContent.optionalPhoneNumber == null
              ? Container()
              : ProfileItemCardMA(
            title: widget.readUserContent.optionalPhoneNumber,
            rightWidget: null,
            callback: () {
              if (kDebugMode) {
                print('Tap Settings Item 01');
              }
            },
            textStyle: kProfileBodyTextStyle,
          ),
        ],
      );


}

import 'package:health_ministry_research_library/imports.dart';

List<UserModel> userModelListFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelListToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.sn,
    this.prefix,
    this.username,
    this.fullName,
    this.firstName,
    this.lastName,
    this.userPhotoURL,
    this.userPhotoFile,
    this.userPhotoName,
    this.nationality,
    this.occupation,
    this.personalEmail,
    this.workEmail,
    this.password,
    this.confirmedPassword,
    this.userHealthScore,
    this.userWeight,
    this.userHeight,
    this.userAge,
    this.userAddress,
    this.userBmi,
    this.userLanguage,
    this.userPhoneNumber,
    this.userGender,
    this.userDateOfBirth,
    this.phoneNumber,
    this.optionalPhoneNumber,
    this.emergencyContactName,
    this.emergencyContactPhoneNumber,
    this.emergencyContactRelationshipToYou,
    this.chronicDiseaseList,
    this.bookmarkedHealthPersonnelList,
    this.bookmarkedHealthFacilitiesList,
    this.dateUpdated,
    this.dateCreate,
    this.selectedTheme,
  });

  int? sn;
  String? prefix;
  String? username;
  String? fullName;
  String? firstName;
  String? lastName;
  String? userPhotoURL;
  String? userPhotoName;
  String? userPhotoFile;
  String? nationality;
  String? occupation;
  String? personalEmail;
  String? workEmail;
  String? password;
  String? confirmedPassword;
  double? userHealthScore;
  double? userWeight;
  double? userHeight;
  String? userAge;
  String? userAddress;
  double? userBmi;
  String? userLanguage;
  String? userPhoneNumber;
  String? optionalPhoneNumber;
  String? userGender;
  String? userDateOfBirth;
  String? phoneNumber;
  String? emergencyContactName;
  String? emergencyContactPhoneNumber;
  String? emergencyContactRelationshipToYou;
  List<String>? chronicDiseaseList;
  List<String>? bookmarkedHealthPersonnelList;
  List<String>? bookmarkedHealthFacilitiesList;
  DateTime? dateUpdated;
  DateTime? dateCreate;
  String? selectedTheme;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        sn: json["sn"] ?? null,
        prefix: json["prefix"] ?? null,
        username: json["username"] ?? null,
        fullName: json["fullName"] ?? null,
        firstName: json["firstName"] ?? null,
        lastName: json["lastName"] ?? null,
        userPhotoURL: json["userPhotoURL"] ?? null,
        userPhotoName: json["userPhotoName"] ?? null,
        userPhotoFile: json["userPhotoFile"] ?? null,
        nationality: json["nationality"] ?? null,
        occupation: json["occupation"] ?? null,
        personalEmail: json["personalEmail"] ?? null,
    workEmail: json["workEmail"] ?? null,
        password: json["password"] ?? null,
        confirmedPassword: json["confirmedPassword"] ?? null,
        userHealthScore: json["userHealthScore"] == null
            ? null
            : json["userHealthScore"].toDouble(),
        userWeight:
            json["userWeight"] == null ? null : json["userWeight"].toDouble(),
        userHeight:
            json["userHeight"] == null ? null : json["userHeight"].toDouble(),
        userAge: json["userAge"] == null ? null : json["userAge"],
        userAddress: json["userAddress"] ?? null,
        userBmi: json["userBmi"] == null ? null : json["userBmi"].toDouble(),
        userLanguage: json["userLanguage"] ?? null,
        userPhoneNumber: json["userPhoneNumber"] ?? null,
        userGender: json["userGender"] ?? null,
        userDateOfBirth: json["userDateOfBirth"] ?? null,
        phoneNumber: json["phoneNumber"] ?? null,
        optionalPhoneNumber: json["optionalPhoneNumber"] ?? null,
        emergencyContactName: json["emergencyContactName"] ?? null,
        emergencyContactPhoneNumber: json["optionalPhoneNumber"] ?? null,
        emergencyContactRelationshipToYou:
            json["emergencyContactRelationshipToYou"] ?? null,
        chronicDiseaseList: json["chronicDiseaseList"] == null
            ? null
            : List<String>.from(json["chronicDiseaseList"].map((x) => x)),
        bookmarkedHealthPersonnelList:
            json["bookmarkedHealthPersonnelList"] == null
                ? null
                : List<String>.from(
                    json["bookmarkedHealthPersonnelList"].map((x) => x)),
        bookmarkedHealthFacilitiesList:
            json["bookmarkedHealthFacilitiesList"] == null
                ? null
                : List<String>.from(
                    json["bookmarkedHealthFacilitiesList"].map((x) => x)),
        dateUpdated: json["dateUpdated"] == null
            ? null
            : DateTime.parse(json["dateUpdated"]),
        dateCreate: json["dateCreate"] == null
            ? null
            : DateTime.parse(json["dateCreate"]),
        selectedTheme: json["selectedTheme"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "sn": sn ?? null,
        "prefix": prefix ?? null,
        "username": username ?? null,
        "fullName": fullName ?? null,
        "firstName": firstName ?? null,
        "lastName": lastName ?? null,
        "userPhotoURL": userPhotoURL ?? null,
        "userPhotoName": userPhotoName ?? null,
        "userPhotoFile": userPhotoFile ?? null,
        "nationality": nationality ?? null,
        "occupation": occupation ?? null,
        "personalEmail": personalEmail ?? null,
    "workEmail": workEmail ?? null,
        "password": password ?? null,
        "confirmedPassword": confirmedPassword ?? null,
        "userHealthScore": userHealthScore ?? null,
        "userWeight": userWeight ?? null,
        "userHeight": userHeight ?? null,
        "userAge": userAge ?? null,
        "userAddress": userAddress ?? null,
        "userBMI": userBmi ?? null,
        "userLanguage": userLanguage ?? null,
        "userPhoneNumber": userPhoneNumber ?? null,
        "userGender": userGender ?? null,
        "userDateOfBirth": userDateOfBirth ?? null,
        "phoneNumber": phoneNumber ?? null,
        "optionalPhoneNumber": optionalPhoneNumber ?? null,
        "emergencyContactName": emergencyContactName ?? null,
        "emergencyContactPhoneNumber": emergencyContactPhoneNumber ?? null,
        "emergencyContactRelationshipToYou":
            emergencyContactRelationshipToYou ?? null,
        "chronicDiseaseList": chronicDiseaseList == null
            ? null
            : List<dynamic>.from(chronicDiseaseList!.map((x) => x)),
        "bookmarkedHealthPersonnelList": bookmarkedHealthPersonnelList == null
            ? null
            : List<dynamic>.from(bookmarkedHealthPersonnelList!.map((x) => x)),
        "bookmarkedHealthFacilitiesList": bookmarkedHealthFacilitiesList == null
            ? null
            : List<dynamic>.from(bookmarkedHealthFacilitiesList!.map((x) => x)),
        "dateUpdated":
            dateUpdated == null ? null : dateUpdated!.toIso8601String(),
        "dateCreate": dateCreate == null ? null : dateCreate!.toIso8601String(),
        "selectedTheme": selectedTheme ?? null,
      };
}

final String name = "Arab Kumar";
final String imageurl =
    "https://instagram.fdel2-1.fna.fbcdn.net/v/t51.2885-19/s150x150/103736470_686303165263059_6517397191909135336_n.jpg?_nc_ht=instagram.fdel2-1.fna.fbcdn.net&_nc_ohc=K5FcjPsvaqoAX8Okfyl&oh=a19c69b6dab3275f1b8fce5d5f02f0a3&oe=5FBF2FA1";


class AppUrl {
  static const String liveBaseURL = "https://remote-ur/api/v1";
  static const String localBaseURL = "http://192.168.1.138:2200";

  // "http://192.168.8.126:3300/api"; for Canar
  // "http://172.20.10.2:3300/api"; for iphone 13
  // "http://172.20.10.4:3300"; for iphone 6 + vpn
  // "http://172.20.10.5:3300/api"; iphone 6
  // "http://192.168.1.106:3300/api"; Work
  // "http://192.168.1.101:3300/api"; Baba

  static const String baseURL = localBaseURL;

  /// RESEARCH LIBRARY
  static const String researchLibraryBaseURL = "$baseURL/research_library";
  // HealthPulseApp.use("/research_library", require("./Routes/Research Library/research_library_document"))

  /// USERS
  static const String userBaseURL = "$baseURL/user"; //liveBaseURL;
  // HealthPulseApp.use("/user", require("./Routes/user"))

  ///------------------------------------------------------------- RESEARCH LIBRARY -------------------------------------------------------------///

  ///------ Get a list of Health Facilities from the DB ------///
  static const String getResearchDocuments = "$researchLibraryBaseURL/";

  // router.get('/', getHealthFacilities);

  static const String getResearchDocument = "$researchLibraryBaseURL/";

  // router.route("/:researchDocumentName").get(middleware.checkToken, getResearchDocument);

  ///------ Update Health Facility information in the DB ------///
  static const String updateResearchDocumentInformationByID =
      "$researchLibraryBaseURL/update/id/";

  // router.put("/update/id/:id", updateResearchDocumentInformationByID);

  static const String updateResearchDocumentInformationByResearchDocumentName =
      "$researchLibraryBaseURL/update/researchDocumentName/";

  // router.put("/update/researchDocumentName/:researchDocumentName", updateResearchDocumentInformationByResearchDocumentName);

  ///------ Delete a Health Facility from the DB ------///
  static const String deleteResearchDocumentByID =
      "$researchLibraryBaseURL/delete/id/";

  // router.delete("/delete/id/:id", deleteResearchDocumentByID);

  static const String deleteResearchDocumentByResearchDocumentName =
      "$researchLibraryBaseURL/delete/researchDocumentName/";

  // router.delete("/delete/researchDocumentName/:researchDocumentName", deleteResearchDocumentByResearchDocumentName);

  ///------------------------------------------------------------- USER -------------------------------------------------------------///

  ///------ Adding and Uploading Image ------///
  static const String addAndUpdateProfileImage = "$userBaseURL/add/image/";

  // router.post("/add/image/:email", upload.single("myFile"), addAndUpdateProfileImage);

  ///------ Get a list of Locations from the DB ------///
  static const String getUsers = "$userBaseURL/";

  // router.get('/', getUsers);

  static const String getUserUsingUsername =
      "$userBaseURL/getUserUsingUsername/";

  // router.get("/getUserUsingUsername/:username", getUserUsingUsername);

  static const String getUserUsingEmail = "$userBaseURL/getUserUsingEmail/";

  // router.get("/getUserUsingEmail/:email", getUserUsingEmail);

  ///------ Check to see if user exists ------///
  static const String checkUsernameExists = "$userBaseURL/checkUsername/";

  // router.route("/checkusername/:username").get(checkUsernameExists);

  static const String checkEmailExists = "$userBaseURL/checkEmail/";

  // router.route("/checkemail/:email").get(checkEmailExists);

  ///------ Login User ------///
  static const String login = "$userBaseURL/login";

  // router.route("/login").post(logIn);

  ///------ Register User ------///
  static const String register = "$userBaseURL/register";

  // router.route("/register").post(register);

  ///------ Update user information in the DB ------///
  static const String updateUserInformationByID = "$userBaseURL/update/id/";

  // router.put("/update/id/:id", updateUserInformationByID);

  static const String updateUserInformationByUsername =
      "$userBaseURL/update/username/";

  // router.put("/update/username/:username", updateUserInformationByUsername);

  static const String updateUserInformationByEmail =
      "$userBaseURL/update/email/";

  // router.put("/update/email/:email", updateUserInformationByEmail);

  ///------ Update user password in the DB ------///
  static const String forgotPasswordUpdateWithUsername =
      "$userBaseURL/users/forgetPassword/username/";

  // router.put("/update/forgetPassword/username/:username", forgotPasswordUpdateWithUsername);

  static const String forgotPasswordUpdateWithEmail =
      "$userBaseURL/update/forgetPassword/email/";

  // router.put("/update/forgetPassword/email/:email", forgotPasswordUpdateWithEmail);

  ///------ Delete a user from the DB ------///
  static const String deleteUserByID = "$userBaseURL/delete/id/";

  // router.delete("/delete/id/:id", deleteUserByID);

  static const String deleteUserByUsername = "$userBaseURL/delete/username/";

  // router.delete("/delete/username/:username", deleteUserByUsername);

  static const String deleteUserByEmail = "$userBaseURL/delete/email/";
// router.delete("/delete/email/:email", deleteUserByEmail);

}

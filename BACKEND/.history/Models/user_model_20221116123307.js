///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- FILES ----------------------///
const {
    vaccineDigitizationSchema,
    VaccineDigitizationModel,
} = require('../Models/Vaccine Digitization/vaccine_digitization_model');


///---------------------- LIBRARIES ----------------------///
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

///------------------------------------------ SCHEMA ------------------------------------------///
var loginUserSchema = new Schema({
    sn: {
        type: Number,
        unique: true
    },
    username: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    personalEmail: {
        type: String,
        unique: true
    },
    workEmail: {
        type: String,
        unique: true
    },
});

var registerUserSchema = new Schema({
    sn: {
        type: Number,
        unique: true
    },
    prefix: {
        type: String,
    },
    username: {
        type: String,
        unique: true
    },
    fullName: {
        type: String
    },
    firstName: {
        type: String
    },
    lastName: {
        type: String
    },
     userPhotoURL: {
        type: String
    },
     userPhotoName : {
        type: String
    },
    userPhotoFile: {
        type: String
    },
    nationality: {
        type: String
    },
    occupation: {
        type: String
    },
    address: {
        type: String
    },
    personalEmail: {
        type: String,
        unique: true
    },
    workEmail: {
        type: String,
        unique: true
    },
    password: {
        type: String
    },
    confirmedPassword: {
        type: String
    },
    userHealthScore: {
        type: Number
    },
    userWeight: {
        type: Number
    },
    userHeight: {
        type: Number
    },
    userAge: {
        type: Number
    },
    userAddress: {
        type: String
    },
    userBMI: {
        type: String
    },
    userLanguage: {
        type: String
    },
    userPhoneNumber: {
        type: String
    },
    userGender: {
        type: String
    },
    userDateOfBirth: {
        type: String
    },
    phoneNumber: {
        type: String
    },
    optionalPhoneNumber: {
        type: String
    },
    emergencyContactName: {
        type: String
    },
    emergencyContactPhoneNumber: {
        type: String
    },
    emergencyContactRelationshipToYou: {
        type: String
    },
    chronicDiseaseList: [String],
    bookmarkedHealthPersonnelList: [String],
    bookmarkedHealthFacilitiesList: [String],
    vaccineCertificatesList: [vaccineDigitizationSchema],
    dateUpdated:  {
        type: Date
    },
    dateCreate:  {
        type: `date`
    },
    selectedTheme: {
        type: String
    },
});



///------------------------------------------ MODEL ------------------------------------------///
// This two schemas will save on the 'users' collection.
var User = mongoose.model('User', loginUserSchema, 'user_data');
var registerUser = mongoose.model('Registered', registerUserSchema, 'user_data');

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = {
    User: User,
    registerUser: registerUser
};
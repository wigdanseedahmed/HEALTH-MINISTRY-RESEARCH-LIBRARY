///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- LIBRARIES ----------------------///
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

///------------------------------------------ SCHEMA ------------------------------------------///
var ResearchDocumentSchema = new Schema({

    ID: {
        type: Number,
    },
    data_source: {
        type: String,
    },
    file_name: {
        type: String,
    },
    ///--------------------- A ~ SOURCE ---------------------///

    ///--------- MANDATORY
    sourceStudyTitle: [String],

    ///--------- RECOMMENDED
    studyIdentifierRecords: [String],
    studyTopics: [String],

    ///--------- OPTIONAL

     ///--------------------- B ~  ---------------------///

    ///--------- MANDATORY
    DOI: {
        type: String,
    },
    objectTitle: {
        type: String,
    },

    ///--------- RECOMMENDED
    version: {
        type: String,
    },

    ///--------- OPTIONAL
    objectOtherIdentifiers: [String],
     objectAdditionalTitles: [String],

     ///--------------------- C ~ AUTHOR ---------------------///

    ///--------- MANDATORY
    creators: [String],

    ///--------- RECOMMENDED

    ///--------- OPTIONAL
contributors: {
        type: String,
    },

    ///--------------------- D ~ DATES ---------------------///

   ///--------- MANDATORY
    creationYear: {
        type: String,
    },

   ///--------- RECOMMENDED

   ///--------- OPTIONAL
    dates: [String],

    ///--------------------- E ~ RESOURCE ---------------------///

   ///--------- MANDATORY
    resourceTypeGeneral: {
        type: String,
    },

   ///--------- RECOMMENDED
    resourceType: {
        type: String,
    },
     description: [String],
     language: {
        type: String,
    },
    relatedIdentifiers: [String],

   ///--------- OPTIONAL
     subjectsOfDataObject: [String],

     ///--------------------- SOURCE ---------------------///

    ///--------- MANDATORY
    publisher: {
        type: String,
    },
    accessType: {
        type: String,
    },
    accessDetails : {
        type: String,
    },
     accessContact : {
        type: String,
    },
     resources: [String],

    ///--------- RECOMMENDED
     otherHostingInstitutions: [String],

    ///--------- OPTIONAL
     rights: [String],
    
});


///------------------------------------------ MODEL ------------------------------------------///
// This two schemas will save on the 'users' collection.
var ResearchDocumentModel = mongoose.model('health_facilities_data', ResearchDocumentSchema, 'health_facilities_data');

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = {
    ResearchDocumentSchema: ResearchDocumentSchema,
    ResearchDocumentModel: ResearchDocumentModel
};
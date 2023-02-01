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

    sourceStudyTitle: {
        type: String,
    },
    studyIdentifierRecordsa : {
        type: String,
    },
    studyTopics	: [String],
    DOI: {
        type: String,
    },
    objectTitle: {
        type: String,
    },
    version: {
        type: String,
    },
    objectOtherIdentifiers: {
        type: String,
    },
     objectAdditionalTitles: {
        type: String,
    }, 
    creators: {
        type: String,
    },
contributors: {
        type: String,
    },
    creationYear: {
        type: String,
    },
    dates: {
        type: String,
    },
    resourceTypeGeneral: {
        type: String,
    },
    resourceType: {
        type: String,
    },
     description : {
        type: String,
    },
     language: {
        type: String,
    },
    relatedIdentifiers: {
        type: String,
    },
     subjectsOfDataObject: {
        type: String,
    },
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
     resources	: {
        type: String,
    },
     otherHostingInstitutions: {
        type: String,
    },
     rights: {
        type: String,
    },
    
    url: {
        type: String,
    },
    
});


///------------------------------------------ MODEL ------------------------------------------///
// This two schemas will save on the 'users' collection.
var ResearchDocumentModel = mongoose.model('health_facilities_data', ResearchDocumentSchema, 'health_facilities_data');

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = {
    ResearchDocumentSchema: ResearchDocumentSchema,
    ResearchDocumentModel: ResearchDocumentModel
};
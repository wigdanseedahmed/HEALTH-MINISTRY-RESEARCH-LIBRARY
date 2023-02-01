///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- FILES ----------------------///
const {ResearchDocumentSchema,
   ResearchDocumentModel} = require("../../Models/Research Library/research_library_model");

///---------------------- LIBRARIES ----------------------///
const config = require("../../config");

const jwt = require("jsonwebtoken");

///---------------------- CONTROLLERS ----------------------///
// Get a list of users from the DB
const getResearchDocuments = ((req,res, next) => {
  // Get all data
  ResearchDocumentModel.find({}).then(function(locations){
       res.send(locations);
  });
});

const getResearchDocument = ( (req, res) => {
  ResearchDocumentModel.findOne({ locationName: req.params.locationName }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      locationName: req.params.locationName,
    });
  });
});


// Update a user information in the DB
const updateResearchDocumentInformationByID= ((req,res, next) => {
    //to access :id ---> req.params.id
    ResearchDocumentModel.findByIdAndUpdate({ _id: req.params.id }, {$set:req.body}).then(function () {
      ResearchDocumentModel.findOne({ _id: req.params.id }).then(function (location) {
            res.send(location);
        });
    });
  });

  // Update a location info in the DB
const updateResearchDocumentInformationByResearchDocumentName= ((req,res, next) => {
    //to access :id ---> req.params.id
    ResearchDocumentModel.findOneAndUpdate({ locationName: req.params.locationName }, {$set:req.body}).then(function () {
      ResearchDocumentModel.findOne({ locationName: req.params.locationName }).then(function (location) {
            res.send(location);
        });
    });
  });

// Delete a user from the DB
const deleteResearchDocumentByID = ((req, res, next) => {
    //to access :id ---> req.params.id
    ResearchDocumentModel.findByIdAndDelete({ _id: req.params.id }).then(function (user) {
        res.send(user);
    });
})

const deleteResearchDocumentByResearchDocumentName = ((req,res, next) => {
  //to access :locationName ---> req.params.locationName
  ResearchDocumentModel.findByIdAndDelete({ locationName: req.params.locationName }).then(function (user) {
    res.send(user);
});
});

///---------------------- EXPORTS ----------------------///
module.exports = {
  getResearchDocuments: getResearchDocuments,
  getResearchDocument: getResearchDocument,
  updateResearchDocumentInformationByID: updateResearchDocumentInformationByID,
  updateResearchDocumentInformationByResearchDocumentName: updateResearchDocumentInformationByResearchDocumentName,
  deleteResearchDocumentByID: deleteResearchDocumentByID,
  deleteResearchDocumentByResearchDocumentName: deleteResearchDocumentByResearchDocumentName,
};
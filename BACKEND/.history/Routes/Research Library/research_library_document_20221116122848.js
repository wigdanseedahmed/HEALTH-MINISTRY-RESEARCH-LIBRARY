///------------------------------------------ IMPORT ------------------------------------------///


///---------------------- FILES ----------------------///
const {
  getResearchDocuments,
  getResearchDocument,
  updateResearchDocumentInformationByID,
  updateResearchDocumentInformationByResearchDocumentName,
  deleteResearchDocumentByID,
  deleteResearchDocumentByResearchDocumentName,
} = require("../../Controller/Research Library/research_library_document_api_controller");


///---------------------- LIBRARIES ----------------------///

let middleware = require("../../middleware");

const jwt = require("jsonwebtoken");

const express = require("express");
const router = express.Router();

///------------------------------------------ ROUTES ------------------------------------------///
///------ Get a list of Health Facilities from the DB ------///
router.get('/', getResearchDocuments);

router.route("/:researchDocumentName").get(middleware.checkToken, getResearchDocument);

///------ Update Health Facility information in the DB ------///
router.put("/update/id/:id", updateResearchDocumentInformationByID);

router.put("/update/researchDocumentName/:ResearchDocumentName", updateResearchDocumentInformationByResearchDocumentName);


///------ Delete a Health Facility from the DB ------///
router.delete("/delete/id/:id", deleteResearchDocumentByID);

router.delete("/delete/researchDocumentName/:researchDocumentName", deleteResearchDocumentByResearchDocumentName);

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = router;
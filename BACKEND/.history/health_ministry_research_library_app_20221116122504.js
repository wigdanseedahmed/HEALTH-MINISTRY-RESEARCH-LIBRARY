const express = require('express');
const bodyParser = require("body-parser");
const mongoose = require('mongoose');

const port = process.env.port || 2200;


// Set up Express app
const HealthPulseApp = express();

// Connect to mongodb
mongoose.connect(
    'mongodb://localhost/health_pulse',
    {
        useNewUrlParser: true,
        useUnifiedTopology: true
    }
);
mongoose.Promise = global.Promise;

const connection = mongoose.connection;
connection.once("open", () => {
    console.log("MongoDb connected");
});

// Middleware to allow users to input output image
HealthPulseApp.use(express.static('public'))

// Body Parse Middleware 
HealthPulseApp.use(bodyParser.json());

// Initialize routes
data = {
    msg: "Welcome on DevStack Blog App development YouTube video series",
    info: "This is a root endpoint",
    Working: "Documentations of other endpoints will be release soon :)",
    request:
        "Hey if you did'nt subscribed my YouTube channle please subscribe it",
};

HealthPulseApp.route("/").get((req, res) => res.json(data));

// CORS
const cors = require('cors');
HealthPulseApp.use(cors({
    origin: '*',
    credentials: true,
    
}));

// Middleware
HealthPulseApp.use("/uploads", express.static("uploads"));
HealthPulseApp.use(express.json());

// Initialize routes

    // RESEARCH LIBRARY
HealthPulseApp.use("/research_library", require("./Routes/Research Library/research_library"))


    // USERS
HealthPulseApp.use("/user", require("./Routes/user"))
//sudanHorizonScannerApp.use("/api", require("./routes/profile"))


// Error handling Middleware
HealthPulseApp.use(function (err, req, res, next) {
    //console.log(err);
    res.status(422).send({ error: err.message });
});

// Listen for requests
HealthPulseApp.listen(port, function () {
    console.log('now listening for requests');
});
const MongoClient = require('mongodb').MongoClient;
const url = process.env.DATABASE_URL;
let _db;

module.exports = {

    connectToServer: function (callback) {
        MongoClient.connect(url, function (err, client) {
            console.log("Connected correctly to MongoDB server");
            _db = client.db('catalog');
            return callback(err);
        });
    },

    getDb: function () {
        return _db;
    }
};





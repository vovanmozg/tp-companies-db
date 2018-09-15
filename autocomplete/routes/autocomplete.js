const express = require('express');
const router = express.Router();
const db = require('../infrastructure/db');

/* GET companies listing. */
router.get('/:term', function (req, res) {
  const term = encodeURI(req.params.term);
  const collection = db.getDb().collection('companies');
  const search = new RegExp('^' + term, 'i');


  const where = {
    tags: term.substring(0, 3),
    company_name: { $regex: search }
  };

  return collection
    .find(where)
    .limit(10)
    .toArray()
    .then(result => res.json(result));

});

module.exports = router;

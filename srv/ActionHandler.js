module.exports.MarkasObsolete = async function (req) {


   var reason = req.data.Reason;
   var ID = req.params[0].ID;
   // Direct update of the entity using the transaction object
   
    // const { Assesment } = cds.entities("btp.cntrl");
    // const tx = cds.transaction(req);
    // return tx.run(UPDATE(Assesment).set({ isObsolete: true , ReasonComments: req.data.Reason }).where({ ID: req.params[0].ID }));

     // Update using Procedures

     //initialize the transaction
       const tx = cds.transaction(req);
      // Define a quesry to call the procedure
      const query = `CALL ST_MARK_OBSOLETE(IN_ASSID =>?, IN_REASONCOMMNETS => ?)`;
      // Execute the procedure with the required parameters
      return await tx.run(query, [ID, reason]); 

}
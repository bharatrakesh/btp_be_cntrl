const cds = require('@sap/cds');
const lo_actionHandler = require('./ActionHandler');

module.exports = cds.service.impl(srv => {

    // implement the action Handler
    srv.on('MarkasObsolete', lo_actionHandler.MarkasObsolete);


    srv.on('READ', 'outputdata', async (req, next) => {
       //  const db = await cds.connect.to('db');
        // const tx = db.transaction(req);
        // const result = await tx.run(SELECT.from('contrlns.OUTPUT_DATA'));
        //connect to the db Table 
        const { Assesment } = cds.entities("btp.cntrl");
        //Initialize the transaction
        const tx = cds.transaction(req);
        // Select all the data from the table
        const result = await tx.run(SELECT.from(Assesment));
        var output = [];
        result.forEach(element => {
            output.push(element);
        });

return output;


        //  console.log("i am in controller.js");
        //     return [{"ID":"gfsdfhj8jkqb88bj", "Name":"Test", "Startdate":"2024-06-01", "Enddate":"2024-06-30", "Duedate":"2024-06-15"}];
    });

    srv.before('READ', 'outputdata', async (req) => {
        console.log("i am in controller.js before read");

    })

    srv.after('READ', 'outputdata', async (data, req) => {
        console.log("i am in controller.js after read");
    })


    srv.before('READ', 'outputdata', async (req) => {
        console.log("i am in controller.js 2nd before");
    })


    // Validation before create
    srv.before('CREATE', 'assesment', async (req) => {

        if (req.data.Startdate > req.data.Enddate) {
            req.error({
                code: 501,
                message: "Start date cannot be later than end date",
                target: "in/Enddate"
            });
        }
        if (req.data.Duedate < req.data.Startdate) {
            req.error({
                code: 501,
                message: "Due date cannot be later than start date",
                target: "in/Duedate"
            });
        }

        req.data.Agenda_id = "Agenda_01";

    })

    srv.after('READ', 'assesment', async (data, req) => {
        //  console.log("i am in controller.js after read assesment");
        data.forEach(element => {
            let status = _calculateStatus(element);
            element.OverallStatus = status.OverallStatus;
            element.OverallStatusCriticality = status.OverallStatusCriticality;

        })
    })
})

function _calculateStatus(data) {
    if (!data.Startdate || !data.Enddate || !data.Duedate) {
        return { "OverallStatus": "In Preparation", "OverallStatusCriticality": 0 };
    }

    else {
        let lv_today = new Date(); lv_today.setHours(0, 0, 0, 0);
        let lv_DueDate = new Date(data.Duedate); lv_DueDate.setHours(0, 0, 0, 0);

        return (lv_DueDate < lv_today) ? { "OverallStatus": "Overdue", "OverallStatusCriticality": 2 } : { "OverallStatus": "On Track", "OverallStatusCriticality": 3 };
    }


}
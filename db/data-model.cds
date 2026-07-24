namespace btp.cntrl;


using { cuid } from '@sap/cds/common';
entity Assesment : cuid {
     Agenda_id : String(30);
     Agenda : String(30) @mandatory;
     Startdate : Date @mandatory;
     Enddate : Date;
     Duedate : Date @mandatory;
     DaysPlanned : Integer @assert.range: [7, 21] @mandatory;
     isObsolete : Boolean;
     virtual OverallStatus : String(5);
     virtual OverallStatusCriticality : Integer;
     ReasonComments : String(100);
}

@CDS.PERSISTENCE.SKIP
entity OUTPUT_DATA {
     key ID         : String(30);
         NAME       : String(30);
         EMAIL_ID   : String(30);
         DEPARTMENT : String(30);
}

entity mediaFile : cuid {
     
     @Core.ContentDisposition.Filename : fileName
     fileName : String(100);

     @Core.IsMediaType : true
     mediaType : String;                /// mediatype field is mandatory for media entity 
     @Core.MediaType : mediaType
     fileContent : LargeBinary;
}

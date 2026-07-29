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

// Media entity for storing media files for the assessment entity. The media entity is linked to the assessment entity via a foreign key relationship. The media entity contains fields for storing the file name, media type, and file content. The media type field is mandatory for the media entity, and the file content field is of type LargeBinary to store binary data.
entity mediaFile : cuid {
     
     @Core.ContentDisposition.Filename : fileName
     fileName : String(100);

     @Core.IsMediaType : true
     mediaType : String;                /// mediatype field is mandatory for media entity 
     @Core.MediaType : mediaType
     fileContent : LargeBinary;
}

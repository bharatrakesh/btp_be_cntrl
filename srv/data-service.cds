using btp.cntrl as contrlns from '../db/data-model';


service Controllerservice @(impl: './controller.js') {

  @readonly
  entity outputdata as select from contrlns.OUTPUT_DATA;

  @odata.draft.enabled
  entity assesment  as select from contrlns.Assesment
    actions {

      action MarkasObsolete (Reason : String(100) );// parameter can have digfferenct name than the entity attribute name
    }
  
  entity mediaFile as select from contrlns.mediaFile;

};

annotate Controllerservice.assesment with
@(UI: {
  LineItem         : [
    {
      $Type: 'UI.DataField',
      Value: Agenda_id,
      Label: 'Agenda ID'
    },
    {
      $Type: 'UI.DataField',
      Value: Agenda,
      Label: 'Agenda'
    },
    {
      $Type: 'UI.DataField',
      Value: Startdate,
      Label: 'Start Date'
    },
    {
      $Type: 'UI.DataField',
      Value: Enddate,
      Label: 'End Date'
    },
    {
      $Type: 'UI.DataField',
      Value: Duedate,
      Label: 'Due Date'
    },
    {
      $Type: 'UI.DataField',
      Value: DaysPlanned,
      Label: 'Days Planned'
    },
    {
      $Type: 'UI.DataField',
      Value: isObsolete,
      Label: 'Is Obsolete'
    },
    {
      $Type: 'UI.DataField',
      Value: ReasonComments,
      Label: 'Reason Comments'
    },
    {
      $Type      : 'UI.DataField',
      Value      : OverallStatus,
      Label      : 'Overall Status',
      Criticality: OverallStatusCriticality
    },
    {
      $Type: 'UI.DataField',
      Value: OverallStatusCriticality,
      Label: 'Overall Status Criticality'
    },

    {
      $Type : 'UI.DataFieldForAction',
      Action: 'MarkasObsolete',
      Label : 'Mark as Obsolete'
    }

  ],
  FieldGroup #Basic: {
    $Type: 'UI.FieldGroupType',
    Data : [
      {
        $Type: 'UI.DataField',
        Value: Agenda,
        Label: 'Agenda'
      },
      {
        $Type: 'UI.DataField',
        Value: Startdate,
        Label: 'Start Date'
      },
      {
        $Type: 'UI.DataField',
        Value: Enddate,
        Label: 'End Date'
      },
      {
        $Type: 'UI.DataField',
        Value: Duedate,
        Label: 'Due Date'
      },
      {
        $Type: 'UI.DataField',
        Value: DaysPlanned,
        Label: 'Days Planned'
      },

      {
        $Type: 'UI.DataField',
        Value: ReasonComments,
        Label: 'Reason Comments'
      },
      {
        $Type      : 'UI.DataField',
        Value      : OverallStatus,
        Label      : 'Overall Status',
        Criticality: OverallStatusCriticality
      },


    ]
  },

  Facets           : [{
    $Type : 'UI.ReferenceFacet',
    Target: @UI.FieldGroup #Basic,
    Label : 'General Information',
    ID    : 'GeneralInformation'
  }]


})

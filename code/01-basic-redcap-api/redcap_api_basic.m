```powerquery
let
    REDCapURL = "YOUR_REDCAP_URL",

    Record = [
        token = "YOUR_PROJECT_TOKEN",
        content = "record",
        format = "csv",
        form = "YOUR_REDCAP_FORM",
        fields = "record_id,group_id",
        filterLogic = "[YOUR_FILTER_FIELD(1)]='1'"
    ],

    Body = Text.ToBinary(
        Uri.BuildQueryString(Record)
    ),

    Options = [
        Headers = [
            #"Content-Type" = "application/x-www-form-urlencoded"
        ],
        Content = Body
    ],

    Result = Web.Contents(
        REDCapURL,
        Options
    ),

    CSV_Imported = Csv.Document(Result)

in
    CSV_Imported

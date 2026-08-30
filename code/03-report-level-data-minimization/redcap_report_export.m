let

    GetREDCapData = () as table =>
        let

            TokenLocal =
                Text.Trim(
                    Text.FromBinary(
                        File.Contents(
                            "YOUR_FIREWALL_LOCATION/TOKEN.txt"
                        )
                    )
                ),

            BaseUrl = "YOUR_REDCAP_URL",

            RawResponse =
                Web.Contents(
                    BaseUrl,
                    [
                        RelativePath = "YOUR_RELATIVE_PATH",

                        Headers = [
                            #"Content-Type" =
                                "application/x-www-form-urlencoded"
                        ],

                        Content =
                            Text.ToBinary(
                                Uri.BuildQueryString(
                                    [
                                        token = TokenLocal,

                                        content = "report",

                                        report_id =
                                            "YOUR_REPORT_ID",

                                        format = "csv"
                                    ]
                                )
                            )
                    ]
                ),

            CsvTable =
                Csv.Document(
                    RawResponse,
                    [
                        Delimiter = ",",
                        Encoding = 65001,
                        QuoteStyle = QuoteStyle.Csv
                    ]
                ),

            PromotedHeaders =
                Table.PromoteHeaders(
                    CsvTable,
                    [PromoteAllScalars = true]
                )

        in
            PromotedHeaders

in

    GetREDCapData()

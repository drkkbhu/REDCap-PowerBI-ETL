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
                                        content = "record",
                                        format = "csv",

                                        form = "YOUR_REDCAP_FORM",

                                        fields =
                                            "record_id,group_id,record_person,hva,dhss_funding,dob,enroll_date,child_enroll_status,hv_pregnant,surv_currdate,bf_form_date,bf_start_age,bf_childage",

                                        filterLogic =
                                            "[YOUR_FILTER_FIELD(1)]='1'"
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

load("render.star", "render")
load("encoding/json.star", "json")
load("encoding/base64.star", "base64")
load("schema.star", "schema")

FIREBOARD_ICON = base64.decode("R0lGODdhDwAWAMZgAAAAAAUCAlgsJQkEA51MPplJPJlKPDMoJgkHB5ZUSRsPDQgEA5NAMxoLCZNCNRoMCQ0JCUk3MxEODgYFBZhWS3xORjAeGxoOC5RNQYE0KDIUDxoODJRNQoE3KjIVEIE2KgEAACcWE2Y5MjQeGoZNRDMdGoNMQwEBAYQ4LDUYEwICApZENx0PDQsGBZtLPgoFBR4QDjYgHIJMQ0IyMOF/bqdzalxBPemBb4xsZ3FHQOF7alZFQo5SSLddThcODa1eUZ1USA4JCFIvKfuYiMR6bnI/N/+ciqlvZYtLQP+fjothWqdZTPyhkW9STsRoWfehk1A/PBsSEa2DfGVLRyYYFbyOh0s6NzQgHcCUjTUrKUgtKLKLhScgH1g2MJBwaxwZGP///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////ywAAAAADwAWAAAHo4AAgoOEhYYBAgGGhicEJ4uFJwWPkIMnBpSQByqXmYsJACqYlQAMoaOVDqePEYUSEwCqoioAFIUVgrIGtBiFGbmntByFHcCzAMOEH8a7yIIggsuxwc4AItHMwoIk2NPHySbdsgW8guEnKKErgi6PyTIAMzQ1Njc4OTo7PD0+P0BBQoYQKWLkCJIkSpYwaeLkCZQoUqZQqWLlCpYsWrZw6eLlSyAAOw==")

YELLOW_TEXT_COLOR="#ffea00"
BLUE_TEXT_COLOR="#0084ff"
RED_TEXT_COLOR="#c20000"

def main(config):
    user = config.str("username")
    passwd = config.str("password")
    if (user == None) or (user == "") or (passwd == None) or (passwd == ""):
        return render.Root(
            child = render.WrappedText("Please set fireboard user and password", width = 50),
        )

    return render.Root(
        child = render.Stack(children=[
            render.Image(src=FIREBOARD_ICON, width=15, height=22),
            render.Padding(pad=(17,4,0,0), child=render.Column(children=[
                render.Marquee(render.Text("Yoder", color=YELLOW_TEXT_COLOR), width=46),
                render.Marquee(render.Row(children=[
                    render.Text("Pit: "),
                    render.Text("240", color=BLUE_TEXT_COLOR),
                    ]),
                    width=46),
            ])),
            render.Padding(pad=(1,23,1,1), child=render.Column(children=[
                render.Marquee(render.Row(children=[
                    render.Text("Probe1: "),
                    render.Text("118", color=BLUE_TEXT_COLOR),
                    render.Text("  "),
                    render.Text("Probe2: "),
                    render.Text("164", color=BLUE_TEXT_COLOR),
                ]),
                width=62),
            ])),
        ])
    )
#    return []
#    return render.Root(
#        child = render.Text("Hello, World!"),
#    )


def get_schema():
    return schema.Schema(
        version = "1",
        fields = [
            schema.Text(
                id = "username",
                name = "username",
                desc = "Fireboard.io username",
                icon = "user",
                default = "",
                ),
            schema.Text(
                id = "password",
                name = "password",
                desc = "Fireboard.io password",
                icon = "key",
                default = "",
                ),
            ],
    );

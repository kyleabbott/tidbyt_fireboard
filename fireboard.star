load("render.star", "render")
load("encoding/json.star", "json")
load("encoding/base64.star", "base64")
load("schema.star", "schema")
load("time.star", "time")
load("cache.star", "cache")
load("humanize.star", "humanize")
load("http.star", "http")

FIREBOARD_ICON = base64.decode("R0lGODdhDwAWAMZgAAAAAAUCAlgsJQkEA51MPplJPJlKPDMoJgkHB5ZUSRsPDQgEA5NAMxoLCZNCNRoMCQ0JCUk3MxEODgYFBZhWS3xORjAeGxoOC5RNQYE0KDIUDxoODJRNQoE3KjIVEIE2KgEAACcWE2Y5MjQeGoZNRDMdGoNMQwEBAYQ4LDUYEwICApZENx0PDQsGBZtLPgoFBR4QDjYgHIJMQ0IyMOF/bqdzalxBPemBb4xsZ3FHQOF7alZFQo5SSLddThcODa1eUZ1USA4JCFIvKfuYiMR6bnI/N/+ciqlvZYtLQP+fjothWqdZTPyhkW9STsRoWfehk1A/PBsSEa2DfGVLRyYYFbyOh0s6NzQgHcCUjTUrKUgtKLKLhScgH1g2MJBwaxwZGP///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////ywAAAAADwAWAAAHo4AAgoOEhYYBAgGGhicEJ4uFJwWPkIMnBpSQByqXmYsJACqYlQAMoaOVDqePEYUSEwCqoioAFIUVgrIGtBiFGbmntByFHcCzAMOEH8a7yIIggsuxwc4AItHMwoIk2NPHySbdsgW8guEnKKErgi6PyTIAMzQ1Njc4OTo7PD0+P0BBQoYQKWLkCJIkSpYwaeLkCZQoUqZQqWLlCpYsWrZw6eLlSyAAOw==")

YODER_IMAGE = base64.decode("/9j/4AAQSkZJRgABAQEBLAEsAAD/4Qx3aHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJYTVAgQ29yZSA0LjQuMC1FeGl2MiI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdEV2dD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlRXZlbnQjIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOkdJTVA9Imh0dHA6Ly93d3cuZ2ltcC5vcmcveG1wLyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBNTTpEb2N1bWVudElEPSJnaW1wOmRvY2lkOmdpbXA6YTUwY2Q5NjUtNDg2YS00YmNiLWE3YTMtZWFlNjk3YjU3ZGViIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjQwZmMzMDY1LTE0NTEtNGUwOS1iNzAzLWM5MGZhZjlmYTVmNiIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOmYwZWI1NzMwLTgxMzYtNDdjMi1hYTBhLTVlODlhZmI5NGE2YSIgZGM6Rm9ybWF0PSJpbWFnZS9qcGVnIiBHSU1QOkFQST0iMi4wIiBHSU1QOlBsYXRmb3JtPSJMaW51eCIgR0lNUDpUaW1lU3RhbXA9IjE2NzgxNDI1OTU4MzgwNTgiIEdJTVA6VmVyc2lvbj0iMi4xMC4zMCIgeG1wOkNyZWF0b3JUb29sPSJHSU1QIDIuMTAiPiA8eG1wTU06SGlzdG9yeT4gPHJkZjpTZXE+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJzYXZlZCIgc3RFdnQ6Y2hhbmdlZD0iLyIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDowOGRlM2UwMC1kYjk0LTQyZTUtYWIxMC02ODYwZGRmMjgyODIiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkdpbXAgMi4xMCAoTGludXgpIiBzdEV2dDp3aGVuPSIyMDIzLTAzLTA2VDE2OjQzOjE1LTA2OjAwIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8P3hwYWNrZXQgZW5kPSJ3Ij8+/+ICsElDQ19QUk9GSUxFAAEBAAACoGxjbXMEMAAAbW50clJHQiBYWVogB+cAAwAGABYAJQAjYWNzcEFQUEwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPbWAAEAAAAA0y1sY21zAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANZGVzYwAAASAAAABAY3BydAAAAWAAAAA2d3RwdAAAAZgAAAAUY2hhZAAAAawAAAAsclhZWgAAAdgAAAAUYlhZWgAAAewAAAAUZ1hZWgAAAgAAAAAUclRSQwAAAhQAAAAgZ1RSQwAAAhQAAAAgYlRSQwAAAhQAAAAgY2hybQAAAjQAAAAkZG1uZAAAAlgAAAAkZG1kZAAAAnwAAAAkbWx1YwAAAAAAAAABAAAADGVuVVMAAAAkAAAAHABHAEkATQBQACAAYgB1AGkAbAB0AC0AaQBuACAAcwBSAEcAQm1sdWMAAAAAAAAAAQAAAAxl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")


YELLOW_TEXT_COLOR = "#ffea00"
BLUE_TEXT_COLOR = "#0084ff"
RED_TEXT_COLOR = "#c20000"

RECENT_TEMP_AGE_MIN = 10

LOGIN_URL = "https://fireboard.io/api/rest-auth/login/"
DEVICES_URL = "https://fireboard.io/api/v1/devices.json"

POST_HEADERS = {"Content-Type": "application/json"}

DEVICE_RESPONSE = '[{"uuid":"11227fbf-2b4c-4bfd-9a6a-08c8e5c8cb0f","id":13417,"title":"Big Joe","hardware_id":"G4KJG32J3","created":"2018-12-15T15:52:03.391Z","latest_temps":[],"device_log":{"versionEspHal":"HAL: V1R2;AVR: 0.0.16;","signallevel":-75,"date":"2023-01-15 22:37:52 UTC","version":"1.2.5","memUsage":"2.7M/4.2M","vBattPer":0.9988374112195121,"bleClientMAC":"","ssid":"smoker","deviceID":"11227fbf-2b4c-4bfd-9a6a-08c8e5c8cb0f","band":"802.11bgn","frequency":"2.4 GHz","versionJava":"7.6.5","macAP":"0e:ec:da:a4:e0:a0","commercialMode":"false","mode":"Managed","boardID":"G4KJG32J3","auxPort":"fbfc-v2","drivesettings":"{\\"p\\":4,\\"s\\":0,\\"d\\":5,\\"ms\\":60,\\"f\\":0,\\"l\\":1}","versionImage":"201703260554","cpuUsage":"57%","onboardTemp":62.212484076433114,"model":"FBX11D","tempFilter":"true","timeZoneBT":"America/Chicago","internalIP":"192.168.120.102","txpower":78,"linkquality":"50/100","macNIC":"b4:e6:2d:ca:10:c1","bleSignalLevel":-71,"uptime":"8:20","diskUsage":"1.3M/16.0M","vBatt":4.142,"versionNode":"5.0.0","contrast":"7","versionUtils":"6.1.3","publicIP":"156.146.70.158","vBattPerRaw":0.979},"last_templog":null,"last_battery_reading":0.9988374112195121,"channels":[{"alerts":[],"id":24908945,"channel":1,"created":"2023-01-15T14:18:28Z","sessionid":4829289,"channel_label":"front","enabled":true},{"alerts":[],"id":24908946,"channel":2,"created":"2023-01-15T14:18:28Z","sessionid":4829289,"channel_label":"back","enabled":true},{"alerts":[],"id":24908947,"channel":3,"created":"2023-01-15T14:18:28Z","sessionid":4829289,"channel_label":"butt1","enabled":true},{"alerts":[],"id":24908948,"channel":4,"created":"2023-01-15T14:18:28Z","sessionid":4829289,"channel_label":"butt2","enabled":true},{"alerts":[],"id":24908949,"channel":5,"created":"2023-01-15T14:18:28Z","sessionid":4829289,"channel_label":"brisket3","enabled":true},{"alerts":[],"id":24908950,"channel":6,"created":"2023-01-15T14:18:28Z","sessionid":4829289,"channel_label":"Channel 6","enabled":true}],"fbj_version":"7.6.5","fbn_version":"5.0.0","fbu_version":"6.1.3","version":"1.2.5","probe_config":"8|0|0.0|8|0|0.0|8|0|0.0|8|0|0.0|8|0|0.0|8|0|0.0","last_drivelog":null,"channel_count":6,"degreetype":2,"model":"FBX11D","active":true},{"uuid":"b8d8ffd3-ac7a-43fb-8025-421a9efde665","id":110553,"title":"Yoder","hardware_id":"G3JD3H84D","created":"2021-05-13T17:27:07.548Z","latest_temps":[],"device_log":{"versionEspHal":"HAL: V1R2;AVR: 0.0.14;","macNIC":"10:52:1c:81:b5:28","signallevel":-42,"date":"2023-03-02 01:51:09 UTC","version":"1.0.36","memUsage":"2.6M/4.2M","vBattPer":0,"yfbVersion":"1.0.36","bleClientMAC":"6c:7a:39:e4:bc:4a","ssid":"Abbott","deviceID":"b8d8ffd3-ac7a-43fb-8025-421a9efde665","band":"802.11bgn","frequency":"2.4 GHz","versionJava":"7.6.5","macAP":"fc:34:97:8b:77:61","commercialMode":"false","mode":"Managed","boardID":"G3JD3H84D","contrast":"7","auxPort":"","drivesettings":"{\\"p\\":0,\\"s\\":0,\\"d\\":0,\\"ms\\":100,\\"f\\":0,\\"l\\":1}","versionImage":"201703260554","cpuUsage":"392%","onboardTemp":85.55000000000001,"model":"YFBX","tempFilter":"true","timeZoneBT":"America/Chicago","internalIP":"192.168.50.45","txpower":78,"yfbModel":"YS640","linkquality":"100/100","bleSignalLevel":-70,"uptime":"2:30","diskUsage":"1.0M/4.0M","vBatt":0,"versionNode":"5.0.0","versionUtils":"6.1.3","vBattPerRaw":0,"publicIP":"68.0.100.57","yfbPower":false},"last_templog":"2023-03-02T01:09:52Z","last_battery_reading":0,"channels":[{"alerts":[],"id":25644131,"channel":1,"created":"2023-03-01T23:20:58Z","sessionid":4993562,"channel_label":"Pit","enabled":true},{"alerts":[],"id":25644132,"channel":2,"created":"2023-03-01T23:20:58Z","sessionid":4993562,"channel_label":"Probe 1","enabled":true},{"alerts":[],"id":25644133,"channel":3,"created":"2023-03-01T23:20:58Z","sessionid":4993562,"channel_label":"Probe 2","enabled":true}],"fbj_version":"7.6.5","fbn_version":"5.0.0","fbu_version":"6.1.3","version":"1.0.36","probe_config":"8|0|0.0|8|0|0.0|8|0|0.0","last_drivelog":{"profiletype":0,"currenttemp":0.0,"userinitiated":false,"modetype":0,"pg_elapsed":0,"drivetype":3,"pg_step_uuid":null,"pg_uuid":null,"degreetype":2,"pg_state":0,"pg_step_index":null,"var1":0.0,"created":"2023-03-02T01:09:50Z","var2":0.0,"powermode":3,"driveper":0.5,"vbatt":0.0,"var3":0.0,"setpoint":0.0,"device_id":110553,"id":1713327227,"pg_step_position":0,"tiedchannel":1,"jsonraw":"{\\"c\\":\\"2023-03-02 01:09:50 UTC\\",\\"d\\":0.5,\\"pt\\":0,\\"mt\\":0,\\"vb\\":0,\\"dr\\":3,\\"tc\\":1,\\"dt\\":2,\\"p\\":0,\\"ct\\":0,\\"u\\":false,\\"programinfo\\":{\\"elapsed\\":0,\\"stepuuid\\":null,\\"lastupdated\\":\\"2023-03-01 23:18:57 UTC\\",\\"state\\":0,\\"uuid\\":null,\\"stepposition\\":0},\\"v1\\":0,\\"v2\\":0,\\"sp\\":0,\\"v3\\":0,\\"pm\\":3}"},"channel_count":3,"degreetype":2,"model":"YFBX","active":true}]'

def time_to_str(time):
    return time.format("2006-01-02T15:04:05Z")

def time_from_str(str):
    return time.parse_time(str)

def minutes_since_time(t):
    now = time.now()
    diff = now - t
    return diff.minutes

def get_cache_key(user, key):
    return user + "-" + key

def get_request_header(user):
    token = cache.get(get_cache_key(user, "auth"))
    return {"Authorization": "Token " + token}

def handle_device_response(user, resp):
#    resp = json.decode(response)
    print("handle device response")
    print("num devices: " + str(len(resp)))
    for dev in resp:
        print("uuid: " + dev["uuid"])
        print("num channels: " + str(len(dev["channels"])))
        if dev["last_templog"]:
            last_time = time_from_str(dev["last_templog"])
            if minutes_since_time(last_time) < RECENT_TEMP_AGE_MIN:
                print("recent temp update, setting active device uuid: " + dev["uuid"])
                cache.set(get_cache_key(user, "active_device"), dev["uuid"], ttl_seconds = 10 * 60)
            print("last time: " + str(last_time) + " (" + str(minutes_since_time(last_time)) + " min)")
            t1 = time_from_str("2023-03-06T19:37:05Z")
            print("minutes: " + str(minutes_since_time(t1)))

def check_devices(user):
    # TODO: remove this
    handle_device_response(user, json.decode(DEVICE_RESPONSE))
    return True
    
    print("making devices request")
    res = http.get(DEVICES_URL, headers = get_request_header(user))
    if res.status_code != 200:
        print("devices request failed with status code: %d - %s" %
             (res.status_code, res.body()))
        return False

    handle_device_response(user, res.json())

def check_login(user, passwd):
    # TODO: remove this
    cache.set(get_cache_key(user, "auth"), "fd1c8222a6867501236fd515dc746844bef27938", ttl_seconds = 24 * 60 * 60)
    return True

    if cache.get(get_cache_key(user, "auth")):
        return True

    print("no auth token cached, performing login")
    auth_body = '{"username":"' + user + '","password":"' + passwd + '"}'
    res = http.post(LOGIN_URL, headers = POST_HEADERS, body = auth_body)
    if res.status_code != 200:
        print("token request failed with status code: %d - %s" %
             (res.status_code, res.body()))
        return False
    resp = res.json()
    if resp["key"]:
        print("caching auth token: " + resp["key"])
        cache.set(get_cache_key(user, "auth"), resp["key"], ttl_seconds = 24 * 60 * 60)
        return True
    
    return False


def main(config):

    # Step 1: login / get token
    user = config.str("username")
    passwd = config.str("password")
    if (user == None) or (user == "") or (passwd == None) or (passwd == ""):
        return render.Root(
            child = render.WrappedText("Please set fireboard user and password", width = 50),
        )

    if not check_login(user, passwd):
        return render.Root(
            child = render.WrappedText("Unable to login to fireboard", width = 50),
        )

    # Step 2: get active device
    check_devices(user)

    # Step 3: get temps
    # Step 4: render

    return render.Root(
        render.Stack(children=[
            render.Image(src=YODER_IMAGE),
            render.Padding(pad=(1,0,6,0), child=render.Column(children=[
                    render.Text("Pit ", color=BLUE_TEXT_COLOR),
                    render.Text("225", color=YELLOW_TEXT_COLOR),
                    ]),
                ),
            render.Padding(pad=(1,22,1,0), child=render.Marquee(render.Row(children=[
                    render.Text("Probe1: ", color=BLUE_TEXT_COLOR),
                    render.Text("118", color=YELLOW_TEXT_COLOR),
                    render.Text("  "),
                    render.Text("Probe2: ", color=BLUE_TEXT_COLOR),
                    render.Text("164", color=YELLOW_TEXT_COLOR),
                ]),
            width=62)
            ),
        ])
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
            render.Padding(pad=(1,23,1,1), child=render.Marquee(render.Row(children=[
                    render.Text("Probe1: "),
                    render.Text("118", color=BLUE_TEXT_COLOR),
                    render.Text("  "),
                    render.Text("Probe2: "),
                    render.Text("164", color=BLUE_TEXT_COLOR),
                ]),
                width=62),
            ),
        ])
    )


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

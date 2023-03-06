load("render.star", "render")
load("encoding/json.star", "json")
load("encoding/base64.star", "base64")
load("schema.star", "schema")
load("time.star", "time")
load("cache.star", "cache")
load("humanize.star", "humanize")
load("http.star", "http")

FIREBOARD_ICON = base64.decode("R0lGODdhDwAWAMZgAAAAAAUCAlgsJQkEA51MPplJPJlKPDMoJgkHB5ZUSRsPDQgEA5NAMxoLCZNCNRoMCQ0JCUk3MxEODgYFBZhWS3xORjAeGxoOC5RNQYE0KDIUDxoODJRNQoE3KjIVEIE2KgEAACcWE2Y5MjQeGoZNRDMdGoNMQwEBAYQ4LDUYEwICApZENx0PDQsGBZtLPgoFBR4QDjYgHIJMQ0IyMOF/bqdzalxBPemBb4xsZ3FHQOF7alZFQo5SSLddThcODa1eUZ1USA4JCFIvKfuYiMR6bnI/N/+ciqlvZYtLQP+fjothWqdZTPyhkW9STsRoWfehk1A/PBsSEa2DfGVLRyYYFbyOh0s6NzQgHcCUjTUrKUgtKLKLhScgH1g2MJBwaxwZGP///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////ywAAAAADwAWAAAHo4AAgoOEhYYBAgGGhicEJ4uFJwWPkIMnBpSQByqXmYsJACqYlQAMoaOVDqePEYUSEwCqoioAFIUVgrIGtBiFGbmntByFHcCzAMOEH8a7yIIggsuxwc4AItHMwoIk2NPHySbdsgW8guEnKKErgi6PyTIAMzQ1Njc4OTo7PD0+P0BBQoYQKWLkCJIkSpYwaeLkCZQoUqZQqWLlCpYsWrZw6eLlSyAAOw==")

YELLOW_TEXT_COLOR = "#ffea00"
BLUE_TEXT_COLOR = "#0084ff"
RED_TEXT_COLOR = "#c20000"

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

def handle_device_response(resp):
#    resp = json.decode(response)
    print("handle device response")
    print("num devices: " + str(len(resp)))
    for dev in resp:
        print("uuid: " + dev["uuid"])
        print("num channels: " + str(len(dev["channels"])))
        if dev["last_templog"]:
            last_time = time_from_str(dev["last_templog"])
            print("last time: " + str(last_time) + " (" + str(minutes_since_time(last_time)) + " min)")
            t1 = time_from_str("2023-03-06T19:37:05Z")
            print("minutes: " + str(minutes_since_time(t1)))

def check_devices(user):
    # TODO: remove this
    handle_device_response(json.decode(DEVICE_RESPONSE))
    return True
    
    print("making devices request")
    res = http.get(DEVICES_URL, headers = get_request_header(user))
    if res.status_code != 200:
        print("devices request failed with status code: %d - %s" %
             (res.status_code, res.body()))
        return False

    handle_device_response(res.json())

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
    
    check_devices(user)

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

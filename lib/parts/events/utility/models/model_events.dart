// To parse this JSON data, do
//
//     final events = eventsFromMap(jsonString);

import 'dart:convert';

ModelEvents eventsFromMap(String str) => ModelEvents.fromMap(json.decode(str));

String eventsToMap(ModelEvents data) => json.encode(data.toMap());

class ModelEvents {
    ModelEvents({
        this.weekday,
    });

    List<Weekday> weekday;

    factory ModelEvents.fromMap(Map<String, dynamic> json) => ModelEvents(
        weekday: List<Weekday>.from(json["weekday"].map((x) => Weekday.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "weekday": List<dynamic>.from(weekday.map((x) => x.toMap())),
    };
}

class Weekday {
    Weekday({
        this.titleofweekday,
        this.daycontents,
    });

    String titleofweekday;
    List<Daycontent> daycontents;

    factory Weekday.fromMap(Map<String, dynamic> json) => Weekday(
        titleofweekday: json["titleofweekday"],
        daycontents: List<Daycontent>.from(json["daycontents"].map((x) => Daycontent.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "titleofweekday": titleofweekday,
        "daycontents": List<dynamic>.from(daycontents.map((x) => x.toMap())),
    };
}

class Daycontent {
    Daycontent({
        this.eventtitle,
        this.eventContent,
        this.castlelv,
    });

    String eventtitle;
    List<String> eventContent;
    List<Castlelv> castlelv;

    factory Daycontent.fromMap(Map<String, dynamic> json) => Daycontent(
        eventtitle: json["eventtitle"],
        eventContent: List<String>.from(json["eventContent"].map((x) => x)),
        castlelv: List<Castlelv>.from(json["castlelv"].map((x) => Castlelv.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "eventtitle": eventtitle,
        "eventContent": List<dynamic>.from(eventContent.map((x) => x)),
        "castlelv": List<dynamic>.from(castlelv.map((x) => x.toMap())),
    };
}

class Castlelv {
    Castlelv({
        this.casltelv,
        this.eventcost,
        this.bluechesttitle,
        this.bluechestvalue,
        this.purplechesttitle,
        this.purplechestvalue,
        this.goldchesttitle,
        this.goldchestvalue,
    });

    String casltelv;
    List<String> eventcost;
    List<String> bluechesttitle;
    List<String> bluechestvalue;
    List<String> purplechesttitle;
    List<String> purplechestvalue;
    List<String> goldchesttitle;
    List<String> goldchestvalue;

    factory Castlelv.fromMap(Map<String, dynamic> json) => Castlelv(
        casltelv: json["casltelv"],
        eventcost: List<String>.from(json["eventcost"].map((x) => x)),
        bluechesttitle: List<String>.from(json["bluechesttitle"].map((x) => x)),
        bluechestvalue: List<String>.from(json["bluechestvalue"].map((x) => x)),
        purplechesttitle: List<String>.from(json["purplechesttitle"].map((x) => x)),
        purplechestvalue: List<String>.from(json["purplechestvalue"].map((x) => x)),
        goldchesttitle: List<String>.from(json["goldchesttitle"].map((x) => x)),
        goldchestvalue: List<String>.from(json["goldchestvalue"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "casltelv": casltelv,
        "eventcost": List<dynamic>.from(eventcost.map((x) => x)),
        "bluechesttitle": List<dynamic>.from(bluechesttitle.map((x) => x)),
        "bluechestvalue": List<dynamic>.from(bluechestvalue.map((x) => x)),
        "purplechesttitle": List<dynamic>.from(purplechesttitle.map((x) => x)),
        "purplechestvalue": List<dynamic>.from(purplechestvalue.map((x) => x)),
        "goldchesttitle": List<dynamic>.from(goldchesttitle.map((x) => x)),
        "goldchestvalue": List<dynamic>.from(goldchestvalue.map((x) => x)),
    };
}

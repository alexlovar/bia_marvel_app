// To parse this JSON data, do

import 'dart:convert';

SeriesResponseModel seriesResponseModelFromMap(String str) => SeriesResponseModel.fromMap(json.decode(str));

String seriesResponseModelToMap(SeriesResponseModel data) => json.encode(data.toMap());

class SeriesResponseModel {
  final int code;
  final String status;
  final String copyright;
  final String attributionText;
  final String attributionHtml;
  final String etag;
  final Data data;

  SeriesResponseModel({
    required this.code,
    required this.status,
    required this.copyright,
    required this.attributionText,
    required this.attributionHtml,
    required this.etag,
    required this.data,
  });

  factory SeriesResponseModel.fromMap(Map<String, dynamic> json) => SeriesResponseModel(
    code: json["code"],
    status: json["status"],
    copyright: json["copyright"],
    attributionText: json["attributionText"],
    attributionHtml: json["attributionHTML"],
    etag: json["etag"],
    data: Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "status": status,
    "copyright": copyright,
    "attributionText": attributionText,
    "attributionHTML": attributionHtml,
    "etag": etag,
    "data": data.toMap(),
  };
}

class Data {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<Result> results;

  Data({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    offset: json["offset"],
    limit: json["limit"],
    total: json["total"],
    count: json["count"],
    results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "offset": offset,
    "limit": limit,
    "total": total,
    "count": count,
    "results": List<dynamic>.from(results.map((x) => x.toMap())),
  };
}

class Result {
  final int id;
  final String title;
  final dynamic description;
  final String resourceUri;
  final List<Url> urls;
  final int startYear;
  final int endYear;
  final String rating;
  final String type;
  final String modified;
  final Thumbnail thumbnail;
  final Creators creators;
  final Characters characters;
  final Stories stories;
  final Characters comics;
  final Characters events;
  final dynamic next;
  final dynamic previous;

  Result({
    required this.id,
    required this.title,
    required this.description,
    required this.resourceUri,
    required this.urls,
    required this.startYear,
    required this.endYear,
    required this.rating,
    required this.type,
    required this.modified,
    required this.thumbnail,
    required this.creators,
    required this.characters,
    required this.stories,
    required this.comics,
    required this.events,
    required this.next,
    required this.previous,
  });

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    resourceUri: json["resourceURI"],
    urls: List<Url>.from(json["urls"].map((x) => Url.fromMap(x))),
    startYear: json["startYear"],
    endYear: json["endYear"],
    rating: json["rating"],
    type: json["type"],
    modified: json["modified"],
    thumbnail: Thumbnail.fromMap(json["thumbnail"]),
    creators: Creators.fromMap(json["creators"]),
    characters: Characters.fromMap(json["characters"]),
    stories: Stories.fromMap(json["stories"]),
    comics: Characters.fromMap(json["comics"]),
    events: Characters.fromMap(json["events"]),
    next: json["next"],
    previous: json["previous"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "description": description,
    "resourceURI": resourceUri,
    "urls": List<dynamic>.from(urls.map((x) => x.toMap())),
    "startYear": startYear,
    "endYear": endYear,
    "rating": rating,
    "type": type,
    "modified": modified,
    "thumbnail": thumbnail.toMap(),
    "creators": creators.toMap(),
    "characters": characters.toMap(),
    "stories": stories.toMap(),
    "comics": comics.toMap(),
    "events": events.toMap(),
    "next": next,
    "previous": previous,
  };
}

class Characters {
  final int available;
  final String collectionUri;
  final List<CharactersItem> items;
  final int returned;

  Characters({
    required this.available,
    required this.collectionUri,
    required this.items,
    required this.returned,
  });

  factory Characters.fromMap(Map<String, dynamic> json) => Characters(
    available: json["available"],
    collectionUri: json["collectionURI"],
    items: List<CharactersItem>.from(json["items"].map((x) => CharactersItem.fromMap(x))),
    returned: json["returned"],
  );

  Map<String, dynamic> toMap() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": List<dynamic>.from(items.map((x) => x.toMap())),
    "returned": returned,
  };
}

class CharactersItem {
  final String resourceUri;
  final String name;

  CharactersItem({
    required this.resourceUri,
    required this.name,
  });

  factory CharactersItem.fromMap(Map<String, dynamic> json) => CharactersItem(
    resourceUri: json["resourceURI"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "resourceURI": resourceUri,
    "name": name,
  };
}

class Creators {
  final int available;
  final String collectionUri;
  final List<CreatorsItem> items;
  final int returned;

  Creators({
    required this.available,
    required this.collectionUri,
    required this.items,
    required this.returned,
  });

  factory Creators.fromMap(Map<String, dynamic> json) => Creators(
    available: json["available"],
    collectionUri: json["collectionURI"],
    items: List<CreatorsItem>.from(json["items"].map((x) => CreatorsItem.fromMap(x))),
    returned: json["returned"],
  );

  Map<String, dynamic> toMap() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": List<dynamic>.from(items.map((x) => x.toMap())),
    "returned": returned,
  };
}

class CreatorsItem {
  final String resourceUri;
  final String name;
  final String role;

  CreatorsItem({
    required this.resourceUri,
    required this.name,
    required this.role,
  });

  factory CreatorsItem.fromMap(Map<String, dynamic> json) => CreatorsItem(
    resourceUri: json["resourceURI"],
    name: json["name"],
    role: json["role"],
  );

  Map<String, dynamic> toMap() => {
    "resourceURI": resourceUri,
    "name": name,
    "role": role,
  };
}

class Stories {
  final int available;
  final String collectionUri;
  final List<StoriesItem> items;
  final int returned;

  Stories({
    required this.available,
    required this.collectionUri,
    required this.items,
    required this.returned,
  });

  factory Stories.fromMap(Map<String, dynamic> json) => Stories(
    available: json["available"],
    collectionUri: json["collectionURI"],
    items: List<StoriesItem>.from(json["items"].map((x) => StoriesItem.fromMap(x))),
    returned: json["returned"],
  );

  Map<String, dynamic> toMap() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": List<dynamic>.from(items.map((x) => x.toMap())),
    "returned": returned,
  };
}

class StoriesItem {
  final String resourceUri;
  final String name;
  final Type? type;

  StoriesItem({
    required this.resourceUri,
    required this.name,
    required this.type,
  });

  factory StoriesItem.fromMap(Map<String, dynamic> json) => StoriesItem(
    resourceUri: json["resourceURI"],
    name: json["name"],
    type: typeValues.map[json["type"]] ,
  );

  Map<String, dynamic> toMap() => {
    "resourceURI": resourceUri,
    "name": name,
    "type": typeValues.reverse[type],
  };
}
// ignore:  constant_identifier_names
enum Type { COVER, INTERIOR_STORY }

final typeValues = EnumValues({
  "cover": Type.COVER,
  "interiorStory": Type.INTERIOR_STORY
});

class Thumbnail {
  final String path;
  final String extension;

  Thumbnail({
    required this.path,
    required this.extension,
  });

  factory Thumbnail.fromMap(Map<String, dynamic> json) => Thumbnail(
    path: json["path"],
    extension: json["extension"],
  );

  Map<String, dynamic> toMap() => {
    "path": path,
    "extension": extension,
  };
}

class Url {
  final String type;
  final String url;

  Url({
    required this.type,
    required this.url,
  });

  factory Url.fromMap(Map<String, dynamic> json) => Url(
    type: json["type"],
    url: json["url"],
  );

  Map<String, dynamic> toMap() => {
    "type": type,
    "url": url,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

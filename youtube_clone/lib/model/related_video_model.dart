class RelatedVideoModel {
  RelatedVideoModel({
    this.kind,
    this.etag,
    this.items,
  });

  String? kind;
  String? etag;
  List<Item>? items;

  factory RelatedVideoModel.fromJson(Map<String, dynamic> json) =>
      RelatedVideoModel(
        kind: json["kind"],
        etag: json["etag"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );
}

class Item {
  Item({
    this.kind,
    this.etag,
    this.id,
    this.snippet,
  });

  ItemKind? kind;
  String? etag;
  Id? id;
  Snippet? snippet;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        etag: json["etag"],
        id: Id.fromJson(json["id"]),
        snippet: Snippet.fromJson(json["snippet"]),
      );
}

class Id {
  Id({
    this.kind,
    this.videoId,
  });

  IdKind? kind;
  String? videoId;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        videoId: json["videoId"],
      );
}

// ignore: constant_identifier_names
enum IdKind { YOUTUBE_VIDEO }

// ignore: constant_identifier_names
enum ItemKind { YOUTUBE_SEARCH_RESULT }

class Snippet {
  Snippet({
    this.publishedAt,
    this.channelId,
    this.title,
    this.description,
    this.thumbnails,
    this.channelTitle,
    this.publishTime,
  });

  DateTime? publishedAt;
  String? channelId;
  String? title;
  String? description;
  Thumbnails? thumbnails;
  String? channelTitle;

  DateTime? publishTime;

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
        publishedAt: DateTime.parse(json["publishedAt"]),
        channelId: json["channelId"],
        title: json["title"],
        description: json["description"],
        thumbnails: Thumbnails.fromJson(json["thumbnails"]),
        channelTitle: json["channelTitle"],
        publishTime: DateTime.parse(json["publishTime"]),
      );
}

////////////////////////////////////////////////////
class High {
  final String url;

  High({required this.url});

  factory High.fromJson(Map<String, dynamic> json) {
    String url = json['url'] ?? '';
    return High(url: url);
  }
}

///////////////////////////////////////////////////
class Thumbnails {
  final High high;

  Thumbnails({required this.high});

  factory Thumbnails.fromJson(Map<String, dynamic> json) {
    High high = High.fromJson(json['high']);
    return Thumbnails(high: high);
  }
}

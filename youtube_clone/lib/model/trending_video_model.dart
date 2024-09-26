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

////////////////////////////////////////////////////
class Snippet {
  final String publishedAt;
  final String channelId;
  final String title;
  final String description;
  final String channelTitle;
  final Thumbnails thumbnails;

  Snippet({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.channelTitle,
    required this.thumbnails,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) {
    final String publishedAt = json['publishedAt'] ?? '';
    final String channelId = json['channelId'] ?? '';
    final String title = json['title'] ?? '';
    final String description = json['description'] ?? '';
    final String channelTitle = json['channelTitle'] ?? '';
    Thumbnails thumbnails = Thumbnails.fromJson(json['thumbnails']);

    return Snippet(
        publishedAt: publishedAt,
        channelId: channelId,
        title: title,
        description: description,
        channelTitle: channelTitle,
        thumbnails: thumbnails);
  }
}
////////////////////////////////////////////////////

class Statistics {
  final String viewCount, likeCount, favoriteCount, commentCount;

  Statistics({
    required this.viewCount,
    required this.likeCount,
    required this.favoriteCount,
    required this.commentCount,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    final String viewCount = json['viewCount'] ?? '';
    final String likeCount = json['likeCount'] ?? '';
    final String favoriteCount = json['favoriteCount'] ?? '';
    final String commentCount = json['commentCount'] ?? '';

    return Statistics(
        viewCount: viewCount,
        likeCount: likeCount,
        favoriteCount: favoriteCount,
        commentCount: commentCount);
  }
}

////////////////////////////////////////////////////
class Item {
  Item({
    required this.kind,
    required this.etag,
    required this.id,
    required this.snippet,
    required this.statistics,
  });

  final String kind;
  final String etag;
  final String id;
  final Snippet snippet;
  final Statistics statistics;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        kind: json["kind"] ?? '',
        etag: json["etag"] ?? '',
        id: json["id"] ?? '',
        snippet: Snippet.fromJson(json["snippet"]),
        statistics: Statistics.fromJson(json["statistics"]),
      );
}

////////////////////////////////////////////////////
class TrendingVideoModel {
  final String kind;
  final String etag;
  final List<Item>? items;

  TrendingVideoModel({
    required this.kind,
    required this.etag,
    required this.items,
  });

  factory TrendingVideoModel.fromJson(Map<String, dynamic> json) =>
      TrendingVideoModel(
        kind: json["kind"] ?? '',
        etag: json["etag"] ?? '',
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );
}

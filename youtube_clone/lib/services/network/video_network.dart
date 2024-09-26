import 'dart:convert';

import 'package:youtube_clone/model/trending_video_model.dart';
import 'package:http/http.dart' as http;

import '../../model/channel_info_model.dart';
import '../../model/related_video_model.dart';
import '../../utils/variables_and_func.dart';

class VideoApi {
  static int x = 0;
  //////////////////
  static Future<TrendingVideoModel> getTrendingVideo(
      // {required String apiKey}
      ) async {
    final client = http.Client();
    final uri = Uri.parse(
        '$baseUrl/videos?key=${keys[x]}&part=snippet&chart=mostPopular&maxResults=50&part=statistics');

    var response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseData = json.decode(response.body);

      print('get TrendingVideo success');
      print(responseData['etag']);
      return TrendingVideoModel.fromJson(responseData);
    } else if (response.statusCode == 403) {
      if (x <= (keys.length) - 2) {
        x = x + 1;
        print(x);
        print(keys[x]);
        return getTrendingVideo();
      } else {
        x = 0;
        print(keys[x]);
        return getTrendingVideo();
      }
    } else {
      print('get TrendingVideo field');
      throw Exception('Get TrendingVideo Field');
    }
  }

  ///////////////////////////////{}
  static Future<RelatedVideoModel> getRelatedVideo(
      {required String videoId}) async {
    final client = http.Client();
    final uri = Uri.parse(
        '$baseUrl/search?part=snippet&relatedToVideoId=$videoId&type=video&key=${keys[x]}&maxResults=50');

    var response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseData = json.decode(response.body);

      print('get getRelatedVideo success');
      print(responseData['etag']);
      return RelatedVideoModel.fromJson(responseData);
    } else if (response.statusCode == 403) {
      if (x <= (keys.length) - 2) {
        x = x + 1;
        print(x);
        print(keys[x]);
        return getRelatedVideo(videoId: videoId);
      } else {
        x = 0;
        print(keys[x]);
        return getRelatedVideo(videoId: videoId);
      }
    } else {
      print('get getRelatedVideo field');
      throw Exception('Get TrendingVideo Field');
    }
  }

  ///////////////////////////////
  static Future<TrendingVideoModel> getMusicVideo(
      // {required String apiKey}
      ) async {
    final client = http.Client();
    final uri = Uri.parse(
        '$baseUrl/videos?part=snippet&part=statistics&videoCategoryId=10&key=${keys[x]}&maxResults=50&chart=mostPopular');

    var response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseData = json.decode(response.body);

      print('get getMusicVideo success');
      print(responseData['etag']);
      return TrendingVideoModel.fromJson(responseData);
    } else if (response.statusCode == 403) {
      if (x <= (keys.length) - 2) {
        x = x + 1;
        print(x);
        print(keys[x]);
        return getMusicVideo();
      } else {
        x = 0;
        print(keys[x]);
        return getMusicVideo();
      }
    } else {
      print('get getMusicVideo field');
      throw Exception('Get TrendingVideo Field');
    }
  }

  ///////////////////////////////
  static Future<TrendingVideoModel> getSportVideo(
      // {required String apiKey}
      ) async {
    final client = http.Client();
    final uri = Uri.parse(
        '$baseUrl/videos?part=snippet&part=statistics&videoCategoryId=17&key=${keys[x]}&maxResults=50&chart=mostPopular');

    var response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseData = json.decode(response.body);

      print('get getSportVideo success');
      print(responseData['etag']);
      return TrendingVideoModel.fromJson(responseData);
    } else if (response.statusCode == 403) {
      if (x <= (keys.length) - 2) {
        x = x + 1;
        print(x);
        print(keys[x]);
        return getSportVideo();
      } else {
        x = 0;
        print(keys[x]);
        return getSportVideo();
      }
    } else {
      print('get getSportVideo field');
      throw Exception('Get TrendingVideo Field');
    }
  }

  ///////////////////////////////
  static Future<TrendingVideoModel> getNewsVideo(
      // {required String apiKey}
      ) async {
    final client = http.Client();
    final uri = Uri.parse(
        '$baseUrl/videos?part=snippet&part=statistics&videoCategoryId=25&key=${keys[x]}&maxResults=50&chart=mostPopular');

    var response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseData = json.decode(response.body);

      print('get getNewsVideo success');
      print(responseData['etag']);
      return TrendingVideoModel.fromJson(responseData);
    } else if (response.statusCode == 403) {
      if (x <= (keys.length) - 2) {
        x = x + 1;
        print(x);
        print(keys[x]);
        return getNewsVideo();
      } else {
        x = 0;
        print(keys[x]);
        return getNewsVideo();
      }
    } else {
      print('get getNewsVideo field');
      throw Exception('Get TrendingVideo Field');
    }
  }

  /////////////////////////////////////////////////
  static Future<RelatedVideoModel> getSearchVideo({required String q}) async {
    final client = http.Client();
    final uri = Uri.parse(
        '$baseUrl/search?key=${keys[x]}&part=snippet&q=$q&maxResults=50&type=video');

    var response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseData = json.decode(response.body);

      print('get getSearchVideo success');
      print(responseData['etag']);
      return RelatedVideoModel.fromJson(responseData);
    } else if (response.statusCode == 403) {
      if (x <= (keys.length) - 2) {
        x = x + 1;
        print(x);
        print(keys[x]);
        return getSearchVideo(q: q);
      } else {
        x = 0;
        print(keys[x]);
        return getSearchVideo(q: q);
      }
    } else {
      print(response.body);
      print('get getSearchVideo field');
      throw Exception('Get getSearchVideo Field');
    }
  }

  /////////////////Get Channel Info////////////////////////////////
  static Future<ChannelinfoModel> getChannelInfo({
    required channelId,
    // required String apiKey
  }) async {
    final client = http.Client();
    final uri = Uri.parse(
        '$baseUrl/channels?part=snippet%2Cstatistics&id=$channelId&key=${keys[x]}&maxResults=50');

    var response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseData = json.decode(response.body);

      print('get channel info success');
      print(responseData['etag']);
      return ChannelinfoModel.fromJson(responseData);
    } else if (response.statusCode == 403) {
      if (x <= (keys.length) - 2) {
        x = x + 1;
        print(x);
        print(keys[x]);
        return getChannelInfo(channelId: channelId);
      } else {
        x = 0;
        print(keys[x]);
        return getChannelInfo(channelId: channelId);
      }
    } else {
      print(response.body);
      print('get channel info field');
      throw Exception('Get channel info Field');
    }
  }

  /////////////////Get Channel Info////////////////////////////////
  static Future<RelatedVideoModel> getVideosInChannel(
      {
      // required String apiKey
      required String channelId}) async {
    final client = http.Client();
    final uri = Uri.parse(
        '$baseUrl/search?part=snippet&channelId=$channelId&type=video&key=${keys[x]}&maxResults=50');

    var response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseData = json.decode(response.body);

      print('get getVideosInChannel success');
      print(responseData['etag']);
      return RelatedVideoModel.fromJson(responseData);
    } else if (response.statusCode == 403) {
      if (x <= (keys.length) - 2) {
        x = x + 1;
        print(x);
        print(keys[x]);
        return getVideosInChannel(channelId: channelId);
      } else {
        x = 0;
        print(keys[x]);
        return getVideosInChannel(channelId: channelId);
      }
    } else {
      print(response.body);
      print('get getVideosInChannel field');
      throw Exception('Get getVideosInChannel Field');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart';
import 'package:imtihon6modl/Pages/Models/Models.dart';


class Network {
  static String BASE_URL = "mockapi.io";

  ///HEADER
  static Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8'
  };

  //Apis
  static String API_LIST = "/posts";

  // static String API_TODO_ONE = "/posts";
  // static String API_CREATE_TODO = "/posts";
  // static String API_UPDATE_TODO = "/posts";
  static String API_DELETE = "/posts";
  // static String API_EDIT_TODO = "/todos";
  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api, params);
    Response response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api, params);
    Response response =
    await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api, params);
    Response response =
    await put(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DEL(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api, params);
    Response response = await delete(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = Map();
    return params;
  }

  static Map<String, String> paramsCreate(CardModel post) {
    Map<String, String> params = Map();
    params.addAll({
      'id': post.id.toString(),
      'cardNumber': post.cardNumber.toString(),
      'CreatedTime': post.CreatedTime.toString(),
      'name':post.name.toString(),
      'sv':post.sv.toString(),
    });
    return params;
  }

  static Map<String, String> paramsUpdate(CardModel post) {
    Map<String, String> params = Map();
    params.addAll({
      'id': post.id.toString(),
      'cardNumber': post.cardNumber.toString(),
      'CreatedTime': post.CreatedTime.toString(),
      'name':post.name.toString(),
      'sv':post.sv.toString(),
    });
    return params;
  }

  /// HTTP  PARSING
  static List<CardModel> parsePostList(String body) {
    List<CardModel> posts = imagejsonFromJson(body);
    return posts;
  }
}

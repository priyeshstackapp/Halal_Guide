import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/src/models/cuisine_model.dart';
import 'package:food_delivery_app/src/models/cuisine_response_model.dart';
import 'package:food_delivery_app/src/models/register_restaurant_model.dart';
import 'package:food_delivery_app/src/models/restaurants_img_upload_model.dart';
import 'package:food_delivery_app/src/models/review_imgupl_response_model.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_map_location_picker/generated/l10n.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dioh;
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/address.dart';
import '../models/filter.dart';
import '../models/restaurant.dart';
import '../models/review.dart';
import '../repository/user_repository.dart';
import '../repository/user_repository.dart' as userRepo;

Future<Stream<Restaurant>> getNearRestaurants(Address myLocation, Address areaLocation) async {
  Uri uri = Helper.getUri('api/restaurants');
  Map<String, dynamic> _queryParams = {};
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Filter filter = Filter.fromJSON(json.decode(prefs.getString('filter') ?? '{}'));

  _queryParams['limit'] = '6';
  if (!myLocation.isUnknown() && !areaLocation.isUnknown()) {
    _queryParams['myLon'] = myLocation.longitude.toString();
    _queryParams['myLat'] = myLocation.latitude.toString();
    _queryParams['areaLon'] = areaLocation.longitude.toString();
    _queryParams['areaLat'] = areaLocation.latitude.toString();
  }
  _queryParams.addAll(filter.toQuery());
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
      return Restaurant.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Restaurant.fromJSON({}));
  }
}

Future<Stream<Restaurant>> getPopularRestaurants(Address myLocation) async {
  Uri uri = Helper.getUri('api/restaurants');
  Map<String, dynamic> _queryParams = {};
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Filter filter = Filter.fromJSON(json.decode(prefs.getString('filter') ?? '{}'));

  _queryParams['limit'] = '6';
  _queryParams['popular'] = 'all';
  if (!myLocation.isUnknown()) {
    _queryParams['myLon'] = myLocation.longitude.toString();
    _queryParams['myLat'] = myLocation.latitude.toString();
  }
  _queryParams.addAll(filter.toQuery());
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
      return Restaurant.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Restaurant.fromJSON({}));
  }
}

Future<Stream<Restaurant>> searchRestaurants(String search, Address address) async {
  Uri uri = Helper.getUri('api/restaurants');
  Map<String, dynamic> _queryParams = {};
  _queryParams['search'] = 'name:$search;description:$search;address:$search';
  _queryParams['searchFields'] = 'name:like;description:like;address:like';
  _queryParams['limit'] = '5';
  if (!address.isUnknown()) {
    _queryParams['myLon'] = address.longitude.toString();
    _queryParams['myLat'] = address.latitude.toString();
    _queryParams['areaLon'] = address.longitude.toString();
    _queryParams['areaLat'] = address.latitude.toString();
  }
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
      return Restaurant.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Restaurant.fromJSON({}));
  }
}

Future<Stream<Restaurant>> getRestaurant(String id, Address address) async {
  Uri uri = Helper.getUri('api/restaurants/$id');
  Map<String, dynamic> _queryParams = {};
  if (!address.isUnknown()) {
    _queryParams['myLon'] = address.longitude.toString();
    _queryParams['myLat'] = address.latitude.toString();
    _queryParams['areaLon'] = address.longitude.toString();
    _queryParams['areaLat'] = address.latitude.toString();
  }
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).map((data) => Restaurant.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Restaurant.fromJSON({}));
  }
}

Future<Stream<Review>> getRestaurantReviews(String id) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}restaurant_reviews?with=user&search=restaurant_id:$id';
  print(url);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
      return Review.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new Review.fromJSON({}));
  }
}

Future<Stream<Review>> getRecentReviews() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}restaurant_reviews?orderBy=updated_at&sortedBy=desc&limit=3&with=user';
  print(url);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', Uri.parse(url)));
    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
      return Review.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new Review.fromJSON({}));
  }
}

Future<Review> addRestaurantReview(Review review, Restaurant restaurant,List<dynamic> images) async {
// Future<Review> addRestaurantReview(Review review, Restaurant restaurant,List<dynamic> images) async {
  // String imageUrl;
  // if(images.isNotEmpty){
  //   for(int i = 0; i<images.length;i++){
  //     imageUrl = await uploadImageCallBack(images[i]);
  //   }
  // }

  // review.media = imageUrl;

  final String url = '${GlobalConfiguration().getString('api_base_url')}restaurant_reviews';
  print(url);
  final client = new http.Client();
  review.user = currentUser.value;
  try {
    final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(review.ofRestaurantToMap(restaurant)),
      // body: json.encode(review.ofRestaurantToMap(restaurant)),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return Review.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return Review.fromJSON({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return Review.fromJSON({});
  }
}

Future<String> uploadImageCallBack(file) async {
  dioh.FormData formData = dioh.FormData.fromMap({
    "file": await dioh.MultipartFile.fromFile(file.path)
  });

  final String uploadUrl = '${GlobalConfiguration().getString('api_base_url')}review-upload?api_token=ItTeYrqUVC0DUxi2xmzUmnhswS6pvPFvGiY3yxj1enSqzycw8vArNioESyQZ';
  print(uploadUrl);

  Dio dio = Dio();

  dioh.Response response = await dio.post(uploadUrl,data: formData);

  print(response.statusCode);
  print(response.data);

  if(response.statusCode==200){
    return response.data['data']['url'];
  }else{
    return null;
  }
}


Future<RestaurantsImageUploadModel> restaurantImageUploadApi(Map<String, dynamic> finalMap) async {

  final String url = '${GlobalConfiguration().getString('api_base_url')}upload/image?api_token=${userRepo.currentUser.value.apiToken}';
  print(url);

  final client = new http.Client();

  try {
    final response = await client.post(
      url,
      // headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: finalMap,
    );

    if (response.statusCode == 200) {
      print(response.body);
      return RestaurantsImageUploadModel.fromJson(json.decode(response.body));
      // return Review.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return RestaurantsImageUploadModel.fromJson({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return RestaurantsImageUploadModel.fromJson({});
  }
}


Future<RegisterRestaurantsData> registerRestaurantPostApi(Map<String, dynamic> finalMap) async {

/*  String imageUrl;
  if(images.isNotEmpty){
    for(int i = 0; i<images.length;i++){
      imageUrl = await uploadImageCallBack(images[i]);
    }
  }
  review.media = imageUrl;*/

  final String url = '${GlobalConfiguration().getString('api_base_url')}restaurants';
  print(url);
  final client = new http.Client();
  // review.user = currentUser.value;
  try {
    final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(finalMap),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return RegisterRestaurantsData.fromJson(json.decode(response.body)['data']);
      // return Review.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return RegisterRestaurantsData.fromJson({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return RegisterRestaurantsData.fromJson({});
  }
}


Future<Stream<CuisineModel>> getCuisineApi() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}cuisines';
  print(url);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', Uri.parse(url)));
    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
      print("remove data $data");
      return CuisineModel.fromJson(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new CuisineModel.fromJson({}));
  }
}


Future<CuisineApi> cuisineUserOwnerShipPostApi(Map<String, dynamic> finalMap) async {


  final String url = '${GlobalConfiguration().getString('api_base_url')}cuisine/restro?api_token=${userRepo.currentUser.value.apiToken}';
  print(url);
  final client = new http.Client();
  try {

    final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(finalMap),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return CuisineApi.fromJson(json.decode(response.body));
      // return Review.fromJSON(json.decode(response.body)['data']);
    } else if(response.statusCode == 404) {
      print(response.body);
      Fluttertoast.showToast(msg: "Duplicate entry");
      return CuisineApi.fromJson({});
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return CuisineApi.fromJson({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return CuisineApi.fromJson({});
  }
}



Future<ReviewImageUploadingData> reviewImageUploadApi(Map<String, dynamic> finalMap) async {

  final String url = '${GlobalConfiguration().getString('api_base_url')}review-upload?api_token=${userRepo.currentUser.value.apiToken}';
  print(url);

  final client = new http.Client();

  try {
    final response = await client.post(
      url,
      // headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: finalMap,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return ReviewImageUploadingData.fromJson(json.decode(response.body));
      // return Review.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return ReviewImageUploadingData.fromJson({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return ReviewImageUploadingData.fromJson({});
  }
}




// Future<Response> addLikePost(Map<String, dynamic> postData) async {
//   String url = App.baseUrlSA + App.wallLike;
//   var headerData = {
//     "Authorization": "Bearer ${appState.accessToken}",
//     "Content-Type": "application/json"
//   };
//   print(url + headerData.toString() + postData.toString());
//   try {
//     Response response =
//         await http.post(url, headers: headerData, body: jsonEncode(postData));
//     print(response.statusCode);
//     EasyLoading.dismiss();
//     if (response != null &&
//         (response.statusCode == 200 || response.statusCode == 201)) {
//       print(response.body);
//       return response;
//     } else {
//       print(response.body);
//       var jsonData = jsonDecode(response.body);
//       Utils().showToast(jsonData['message']);
//       return response;
//     }
//   } catch (e) {
//     print(e);
//     EasyLoading.dismiss();
//     Utils().showToast(e);
//     return null;
//   }
// }

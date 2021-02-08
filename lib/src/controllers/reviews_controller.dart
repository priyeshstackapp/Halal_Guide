// import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/helpers/helper.dart';
import 'package:food_delivery_app/src/models/restaurant.dart';
import 'package:food_delivery_app/src/repository/restaurant_repository.dart';
import 'package:food_delivery_app/src/repository/settings_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/food.dart';
import '../models/order.dart';
import '../models/order_status.dart';
import '../models/review.dart';
import '../repository/food_repository.dart' as foodRepo;
import '../repository/order_repository.dart';
import '../repository/restaurant_repository.dart' as restaurantRepo;

class ReviewsController extends ControllerMVC {
  Review restaurantReview;
  List<Review> foodsReviews = [];
  Order order;
  List<Food> foodsOfOrder = [];
  List<OrderStatus> orderStatus = <OrderStatus>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  List<File> imagesList = [];

  String uploadedImageId = "";
  String imageStr = "";
  List<String> uploadImageList = List();
  List<String> uploadImageListCheck = List();

  TextEditingController youtubeVimeoLink = TextEditingController();

  ReviewsController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.restaurantReview = new Review.init("0");
    this.imagesList = List();
  }

  void listenForOrder({String orderId, String message}) async {
    final Stream<Order> stream = await getOrder(orderId);
    stream.listen((Order _order) {
      setState(() {
        order = _order;
        foodsReviews = List.generate(order.foodOrders.length, (_) => new Review.init("0"));
      });
    }, onError: (a) {
      print(a);
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).verify_your_internet_connection),
      ));
    }, onDone: () {
      getFoodsOfOrder();
      if (message != null) {
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  Restaurant restaurant;

  void listenForRestaurant({String id, String message}) async {
    final Stream<Restaurant> stream = await getRestaurant(id, deliveryAddress.value);
    stream.listen((Restaurant _restaurant) {
      setState(() => restaurant = _restaurant);
    }, onError: (a) {
      print(a);
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  List<Review> reviews = <Review>[];

  void listenForRestaurantReviews({String id, String message}) async {
    final Stream<Review> stream = await getRestaurantReviews(id);
    stream.listen((Review _review) {
      setState(() => reviews.add(_review));
    }, onError: (a) {}, onDone: () {});
  }

  void addOnlyRestaurantReview(Review _review) async {

   /* Map<String, dynamic> mapData = {
      "review":"",
      "rate":"",
      "user_id":"",
      "restaurant_id":"",
      "media":"",
    };*/


    if(youtubeVimeoLink.text != null && youtubeVimeoLink.text.trim().isNotEmpty) {
      uploadImageList.add(youtubeVimeoLink.text);
    }

    String imagesStr = uploadImageList.join(",");

    _review.media = imagesStr;

    restaurantRepo.addRestaurantReview(_review, this.restaurant,).then((value) {

      //4242
      // UserAccessTokenApi();

      print(uploadImageListCheck);

      if((restaurantReview.review != null   && restaurantReview.review.trim().isNotEmpty)
          && (youtubeVimeoLink.text != null && youtubeVimeoLink.text.trim().isNotEmpty)
          &&  (uploadImageListCheck != null && uploadImageListCheck.isNotEmpty)) {
         sendMessageApi(restaurantReview.review, youtubeVimeoLink.text);
      } else if((restaurantReview.review != null && restaurantReview.review.trim().isNotEmpty)
          && (youtubeVimeoLink.text != null && youtubeVimeoLink.text.trim().isNotEmpty)) {
        sendMessageApi(restaurantReview.review, youtubeVimeoLink.text);
      } else if((restaurantReview.review != null && restaurantReview.review.trim().isNotEmpty) && (uploadImageListCheck != null && uploadImageListCheck.isNotEmpty)) {
        for(int i = 0; i < uploadImageList.length; i++) {
          uploadMediaLink(uploadImageListCheck[i], restaurantReview.review);
        }
      } else if(uploadImageListCheck != null && uploadImageListCheck.isNotEmpty) {
        for(int i = 0; i < uploadImageList.length; i++) {
          uploadMediaLink(uploadImageListCheck[0], null);
        }
      } else if(youtubeVimeoLink.text != null && youtubeVimeoLink.text.trim().isNotEmpty) {
        sendMessageApi("", youtubeVimeoLink.text);
      } else if(restaurantReview.review != null && restaurantReview.review.trim().isNotEmpty) {
        sendMessageApi(restaurantReview.review, null);
      }

      Navigator.pop(context,"Yes");

      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).the_restaurant_has_been_rated_successfully),
      ));
    });
  }


  void addFoodReview(Review _review, Food _food) async {
    foodRepo.addFoodReview(_review, _food).then((value) {
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).the_food_has_been_rated_successfully),
      ));
    });
  }

  void addRestaurantReview(Review _review) async {

    restaurantRepo.addRestaurantReview(_review, this.order.foodOrders[0].food.restaurant).then((value) {
      refreshOrder();
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).the_restaurant_has_been_rated_successfully),
      ));
    });
  }

  Future<void> refreshOrder() async {
    listenForOrder(orderId: order.id, message: S.of(context).reviews_refreshed_successfully);
  }

  void getFoodsOfOrder() {
    this.order.foodOrders.forEach((_foodOrder) {
      if (!foodsOfOrder.contains(_foodOrder.food)) {
        foodsOfOrder.add(_foodOrder.food);
      }
    });
  }


  //image uploading
  imageUploadApi (String imageBase64) {
    FocusScope.of(context).unfocus();

    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);

    // Helper.onLoading(context);

    Map<String, dynamic> imageMap = {"file":imageBase64};

    print(imageMap);
    restaurantRepo.reviewImageUploadApi(imageMap).then((value) {

      Helper.hideLoader(loader);

       /* Future.delayed(new Duration(seconds: 3), () {
         Navigator.pop(context); //pop dialog
        // _login();
      }); */

      if (value != null && value.success == true) {
        print(value.message);
        // uploadedImageId = value.data.url;
        uploadImageListCheck.add(value.data.url);
        uploadImageList.add(value.data.url);
        setState((){});
        // int restaurantId = value.id;
        // Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantRegThirdPage(restaurantId: restaurantId)));
      } else {
        print("Some thing wrong");
      }
    });
  }


  //facebook data post

  UserAccessTokenApi () {
    restaurantRepo.getUserAccessToken().then((value) {
      if (value != null && value.statusCode == 200) {
        Map<String, dynamic> responseData = {};
        responseData = json.decode(value.body);
        print(responseData['id']);
        print(responseData['name']);
        pageDetailsApi();
      } else {
        print("Some thing wrong");
      }
    });
  }

  pageDetailsApi () {
    restaurantRepo.getPageDetails().then((value) {
      if (value != null && value.statusCode == 200) {
        Map<String, dynamic> responseData = {};
        responseData = json.decode(value.body);
        print(responseData['id']);
        print(responseData['name']);
      } else {
        print("Some thing wrong");
      }
    });
  }

  Future<bool> sendMessageApi(String messageReview, String videoLink) {

    String message = messageReview;
    String urlLink = videoLink;

    restaurantRepo.postMessage(message, urlLink).then((value) {
      if (value != null && value.statusCode == 200) {
        Map<String, dynamic> responseData = {};
        responseData = json.decode(value.body);
        print(responseData['id']);


        if(uploadImageListCheck != null && uploadImageListCheck.isNotEmpty) {
          for(int i = 0; i < uploadImageList.length; i++) {
            uploadMediaLink(uploadImageListCheck[i], restaurantReview.review);
          }
        }

        return true;
      } else {
        print("Some thing wrong");
        return false;
      }
    });
  }

  uploadMediaLink(String imageUrl, String messageData) {

      String message = messageData;
      String imageLink = imageUrl;
      if(imageLink != null && imageLink.isNotEmpty) {
        restaurantRepo.postMediaLink(message, imageLink).then((value) {
          if (value != null && value.statusCode == 200) {
            Map<String, dynamic> responseData = {};
            responseData = json.decode(value.body);
            print(responseData['id']);
            print(responseData['post_id']);
            if(message != null && message.isNotEmpty)
              updateMediaMessage(responseData['post_id'], message);
          } else {
            print("Some thing wrong");
          }
        });
      }
  }

  updateMediaMessage(String postId, String messageReview) {

    String message = messageReview;
    restaurantRepo.postUpdateMedia(message, postId).then((value) {
      if (value != null && value.statusCode == 200) {
        Map<String, dynamic> responseData = {};
        responseData = json.decode(value.body);
        print(responseData['success']);
      } else {
        print("Some thing wrong");
      }
    });


  }

}

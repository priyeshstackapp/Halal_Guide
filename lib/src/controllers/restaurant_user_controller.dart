import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/models/cuisine_model.dart';
import 'package:food_delivery_app/src/pages/register_user/reg_restaurant_third.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/restaurant_repository.dart' as restaurantRepo;
import '../repository/user_repository.dart' as userRepo;

class RestaurantRegUserController extends ControllerMVC {

  Map<String, dynamic> firstPageData = {};

  // Map sundayOpen, sundayClose = {"time" : "Closed", "index":"0"};
  // Map mondayOpen, mondayClose = {"time" : "Closed", "index":"0"};
  // Map tuesdayOpen, tuesdayClose = {"time" : "Closed", "index":"0"};
  // Map wednesdayOpen, wednesdayClose = {"time" : "Closed", "index":"0"};
  // Map thursdayOpen, thursdayClose = {"time" : "Closed", "index":"0"};
  // Map fridayOpen, fridayClose = {"time" : "Closed", "index":"0"};
  // Map saturdayOpen, saturdayClose = {"time" : "Closed", "index":"0"};

  Map sundayOpen, sundayClose = null;
  Map mondayOpen, mondayClose = null;
  Map tuesdayOpen, tuesdayClose = null;
  Map wednesdayOpen, wednesdayClose = null;
  Map thursdayOpen, thursdayClose = null;
  Map fridayOpen, fridayClose = null;
  Map saturdayOpen, saturdayClose = null;

  bool isOpen = false;
  GlobalKey<ScaffoldState> scaffoldKey;
  String uploadedImageId = "";
  String imageStr = "";
  RestaurantRegUserController() {
    scaffoldKey = new GlobalKey<ScaffoldState>();
  }



  //reg restaurant first screen


  imageUploadApi (String imageBase64) {
  // imageUploadApi (Uint8List uploadedImage, {File file}) {
    String data = selectionsId.join(",");
    print(data);
    // Map<String, dynamic> imageData = {
    //   "field": "image",
    //   "file": uploadedImage,
    // };

    Map<String, dynamic> imageMap = new Map<String, dynamic>();
    imageMap['field'] = 'image';
    imageMap['file'] = imageBase64;

    print(imageMap);
    restaurantRepo.restaurantImageUploadApi(imageMap).then((value) {
      if (value != null && value.success == true) {
        print(value.message);

        uploadedImageId = value.data.image;
        imageStr = value.data.media.url;
        setState((){});
        // int restaurantId = value.id;
        // Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantRegThirdPage(restaurantId: restaurantId)));
      } else {
        print("Some thing wrong");
      }
    });
  }



  //reg restaurant second screen

  registerUserApi() {

    Map<String, dynamic> finalMap = {};
    Map<String, dynamic> mapData = {};

    finalMap.addAll(firstPageData);

    if(isOpen) {
      mapData = {
        "open_24x7" : "1"
      };
    } else {
      mapData = {
        "sunday_start_hour": sundayOpen['index'],
        "sunday_end_hour": sundayClose['index'],
        "monday_start_hour": mondayOpen['index'],
        "monday_end_hour": mondayClose['index'],
        "tuesday_start_hour": tuesdayOpen['index'],
        "tuesday_end_hour": tuesdayClose['index'],
        "wednesday_start_hour": wednesdayOpen['index'],
        "wednesday_end_hour": wednesdayClose['index'],
        "thursday_start_hour": thursdayOpen['index'],
        "thursday_end_hour": thursdayClose['index'],
        "friday_start_hour": fridayOpen['index'],
        "friday_end_hour": fridayClose['index'],
        "saturday_start_hour": saturdayOpen['index'],
        "saturday_end_hour": saturdayClose['index'],
      };
    }

    finalMap.addAll(mapData);
    print(finalMap);

    // Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantRegThirdPage(restaurantId: 2)));

      restaurantRepo.registerRestaurantPostApi(finalMap).then((value) {
        if(value != null && value.id != null) {
          print(value.id);
          int restaurantId = value.id;
          Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantRegThirdPage(restaurantId: restaurantId)));
        }
      });

  }


  //reg restaurant third screen

  //Display cuisines api

  // displayCuisinesApi() {
  //
  //
  //   CuisineModel
  // }

  List<CuisineModel> cuisineData = <CuisineModel>[];
  List<int> selectionsId = [];
  int restaurantId = 0;

  Future<void> displayCuisinesApi() async {
    final Stream<CuisineModel> stream = await restaurantRepo.getCuisineApi();
    stream.listen((CuisineModel _review) {
      setState(() => cuisineData.add(_review));

      print(cuisineData.length);

    }, onError: (a) {}, onDone: () {});
  }

  Future<void> cuisineUserOwnerShipApi () {
    String data = selectionsId.join(",");
    print(data);
    Map<String, dynamic> mapData = {
      "restaurant_id": restaurantId,
      "cuisine_id": data,
      "user_id": userRepo.currentUser.value.id,
    };
    print(mapData);
    restaurantRepo.cuisineUserOwnerShipPostApi(mapData).then((value) {
      if (value != null && value.success == true) {
        print(value.message);

        // Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
        Navigator.of(context).pushNamedAndRemoveUntil('/Pages', (Route<dynamic> route) => false);

        // int restaurantId = value.id;
        // Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantRegThirdPage(restaurantId: restaurantId)));
      }
    });
  }






}
import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/models/cuisine_model.dart';
import 'package:food_delivery_app/src/pages/register_user/reg_restaurant_third.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/restaurant_repository.dart' as restaurantRepo;

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

  RestaurantRegUserController() {

    displayCuisinesApi();
  }

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

    // void addOnlyRestaurantReview(Review _review) async {
      restaurantRepo.registerRestaurantPostApi(finalMap).then((value) {


        if(value != null){
          print(value.id);
          int restaurantId = value.id;
          Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantRegThirdPage(restaurantId: restaurantId)));
        }

        // Navigator.pop(context,"Yes");
     /*   scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).the_restaurant_has_been_rated_successfully),
        ));*/
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

  Future<void> displayCuisinesApi() async {
    final Stream<CuisineModel> stream = await restaurantRepo.getCuisineApi();
    stream.listen((CuisineModel _review) {
      print(_review);
      setState(() => cuisineData.add(_review));
    }, onError: (a) {}, onDone: () {});
  }


}
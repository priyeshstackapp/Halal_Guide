import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/src/models/credit_card.dart';
import 'package:food_delivery_app/src/repository/stripe_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class StripePaymentController extends ControllerMVC {


  bool isRemember = false;

  CreditCard creditCard = new CreditCard();

  StripePaymentController() {

  }


  //Stripe payment add card
  stripAddPaymentApi () {
    // imageUploadApi (Uint8List uploadedImage, {File file}) {

    Map<String, dynamic> cardDataMap = {
      "card[number]": creditCard.number,
      "card[exp_month]": creditCard.expMonth,
      "card[exp_year]": creditCard.expYear,
      "card[cvc]": creditCard.cvc,
      // "card[name]": creditCard,
    };

    print(cardDataMap);
    postAddCardDetailsApi(cardDataMap).then((value) {
      if (value != null && value.id != null) {
        print(value);
        createCustomerApi(value.id);
        // uploadedImageId = value.data.url;
        // uploadImageList.add(value.data.url);
        setState((){});
        // int restaurantId = value.id;
        // Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantRegThirdPage(restaurantId: restaurantId)));
      } else {
        print("Some thing wrong");
      }
    });
  }


  //create customer Id : -
  createCustomerApi (String getToken) {

    Map<String, dynamic> customerMap = {
      // "description": "any",
      "source": getToken,
      // "email": "test@gmail.com",
    };

    print(customerMap);
    postCustomerIdGet(customerMap).then((value) {
      if (value != null && value.id != null) {
        print(value);
        // stripePayApi(value.id);
        if(isRemember) {
          addCustomerIdApi(value.id);
        }
        setState((){});
      } else {
        print("Some thing wrong");
      }
    });
  }



  //web api add customer/card id.
  addCustomerIdApi(String cardId) {
    postCustomerId(cardId).then((value) {
      if (value != null && value.success != true) {
        print(value);
        Fluttertoast.showToast(
          msg: value.message,
          toastLength: Toast.LENGTH_SHORT,
          webBgColor: "#e74c3c",
          timeInSecForIosWeb: 5,
        );
        setState((){});
      } else {
        print("Some thing wrong");
      }
    });
  }


  //image uploading
 /* stripePaymentApi () {
    // imageUploadApi (Uint8List uploadedImage, {File file}) {

    // Map<String, dynamic> cardDataMap = {
    //   "card[number]": imageBase64,
    //   "card[exp_month]": imageBase64,
    //   "card[exp_year]": imageBase64,
    //   "card[cvc]": imageBase64,
    //   "card[name]": imageBase64,
    // };

    Map<String, dynamic> cardDataMap = {};

    print(cardDataMap);
    addCardDetailsApi(cardDataMap).then((value) {
      if (value != null && value.success == true) {
        print(value.message);

        // uploadedImageId = value.data.url;
        // uploadImageList.add(value.data.url);
        setState((){});
        // int restaurantId = value.id;
        // Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantRegThirdPage(restaurantId: restaurantId)));
      } else {
        print("Some thing wrong");
      }
    });
  }*/


}

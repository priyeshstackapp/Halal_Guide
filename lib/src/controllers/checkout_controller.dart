import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/src/helpers/helper.dart';
import 'package:food_delivery_app/src/models/stripe_getcard_model.dart';
import 'package:food_delivery_app/src/repository/stripe_repository.dart';
import '../../generated/l10n.dart';
import '../models/cart.dart';
import '../models/credit_card.dart';
import '../models/food_order.dart';
import '../models/order.dart';
import '../models/order_status.dart';
import '../models/payment.dart';
import '../repository/order_repository.dart' as orderRepo;
import '../repository/settings_repository.dart' as settingRepo;
import '../repository/user_repository.dart' as userRepo;
import 'cart_controller.dart';

class CheckoutController extends CartController {
  Payment payment;
  CreditCard creditCard = new CreditCard();
  bool loading = true;
  List<CreditCard> creditCardList = List();
  List<StripeGetCardModel> rememberAllCardShow = List();

  bool isRemember = false;

  CheckoutController _con;

  CheckoutController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForCreditCard();
  }

  void listenForCreditCard() async {
    creditCard = await userRepo.getCreditCard();
    setState(() {});
  }

  @override
  void onLoadingCartDone() {
    if (payment != null) addOrder(carts);
    super.onLoadingCartDone();
  }

  void addOrder(List<Cart> carts) async {
    Order _order = new Order();
    _order.foodOrders = new List<FoodOrder>();
    _order.tax = carts[0].food.restaurant.defaultTax;
    _order.deliveryFee = payment.method == 'Pay on Pickup' ? 0 : carts[0].food.restaurant.deliveryFee;
    OrderStatus _orderStatus = new OrderStatus();
    _orderStatus.id = '1'; // TODO default order status Id
    _order.orderStatus = _orderStatus;
    _order.deliveryAddress = settingRepo.deliveryAddress.value;
    carts.forEach((_cart) {
      FoodOrder _foodOrder = new FoodOrder();
      _foodOrder.quantity = _cart.quantity;
      _foodOrder.price = _cart.food.price;
      _foodOrder.food = _cart.food;
      _foodOrder.extras = _cart.extras;
      _order.foodOrders.add(_foodOrder);
    });
    orderRepo.addOrder(_order, this.payment).then((value) {
      if (value is Order) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  void updateCreditCard(CreditCard creditCard) {
    userRepo.setCreditCard(creditCard).then((value) {
      setState(() {});
      scaffoldKey?.currentState?.showSnackBar(SnackBar(content: Text(S.of(context).payment_card_updated_successfully),
      ));
    });
  }


  //get over customer api :-

   customerGetApi() {
    getCustomerId().then((value) {
      if (value != null && value.success == true) {
        print(value);
        // createCustomerApi(value.id);
        print("cardId length ${value.data.length}");
        for(int i = 0; i < value.data.length; i++) {
          getCardData(value.data[i].cardId);
        }
        setState((){});
        // int restaurantId = value.id;
        // Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantRegThirdPage(restaurantId: restaurantId)));
      } else {
        print("Some thing wrong");
      }
    });
  }

  //Stripe Payment Get Card : -
  getCardData (String cardId) {
    // imageUploadApi (Uint8List uploadedImage, {File file}) {

    // Map<String, dynamic> cardDataMap = {
    //   "card[number]": imageBase64,
    //   "card[exp_month]": imageBase64,
    //   "card[exp_year]": imageBase64,
    //   "card[cvc]": imageBase64,
    //   "card[name]": imageBase64,
    // };

    print("cardId");
    getCardApi(cardId).then((value) {
      if (value != null) {
        if(value.data.isNotEmpty) {
          rememberAllCardShow.add(value);
          print(rememberAllCardShow);
          print(value.data.length);
          setState((){});
        }
      } else {
        print("Some thing wrong");
      }
    });
  }



  //Stripe payment add card
  stripAddPaymentApi (StripeGetCardModel rememberAllCardShow) {

    // Map<String, dynamic> cardDataMap = {
    //   "card[number]": creditCard.number,
    //   "card[exp_month]": creditCard.expMonth,
    //   "card[exp_year]": creditCard.expYear,
    //   "card[cvc]": creditCard.cvc,
    //   // "card[name]": creditCard,
    // };

    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);

    Map<String, dynamic> cardDataMap = {
      "card[number]": rememberAllCardShow.data[0].cardAllNumber.toString(),
      "card[exp_month]": rememberAllCardShow.data[0].expMonth.toString(),
      "card[exp_year]": rememberAllCardShow.data[0].expYear.toString(),
      "card[cvc]": rememberAllCardShow.data[0].cvcNumber.toString(),
      // "card[name]": creditCard,
    };

    isRemember = rememberAllCardShow.data[0].isRemember;

    print(cardDataMap);
    postAddCardDetailsApi(cardDataMap).then((value) {

      Future.delayed(const Duration(seconds: 4), () => Helper.hideLoader(loader));

      if (value != null && value.id != null) {
        print(value);
        createCustomerApi(value.id);
        setState((){});
      } else {
        print("Some thing wrong");
      }
    });
  }

  //create customer Id : -

  createCustomerApi (String tokenAccess) {

    Map<String, dynamic> customerMap = {
      // "description": "any",
      "source": tokenAccess,
      // "email": "test@gmail.com",
    };

    print(customerMap);
    postCustomerIdGet(customerMap).then((value) {
      if (value != null && value.id != null) {
        print(value);
        stripePayApi(value.id, value.defaultSource, isRemember);
        if(isRemember) {
          addCustomerIdApi(value.id);
        }
        setState((){});
      } else {
        print("Some thing wrong");
      }
    });
  }

  //Stripe Payment Delete Card : -
  deleteCardData (String customerId, String cardId) {
    print(cardId);

    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);

    deleteCardApi(customerId, cardId).then((value) {
      Future.delayed(Duration(seconds: 7), () => Helper.hideLoader(loader));
      if (value != null) {
        // Fluttertoast.showToast(msg: "Card Delete Successfully");
        deleteCustomerIdApi(cardId);
        setState((){});
      } else {
        print("Some thing wrong");
      }
    });

  }



  //web api add customer/card id.
  addCustomerIdApi(String customerId) {

    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);

    postCustomerId(customerId).then((value) {
      Helper.hideLoader(loader);
      if (value != null && value.success == true) {
        print(value);
        Fluttertoast.showToast(msg: value.message);
        setState((){});
      } else {
        print("Some thing wrong");
      }
    });
  }

  //delete web api card
  deleteCustomerIdApi(String cardId) {
    deleteCustomerId(cardId).then((value) {
      if (value != null && value.success != true) {
        print(value);
        Fluttertoast.showToast(msg: value.message);
        setState((){});
      } else {
        print("Some thing wrong");
      }
    });
  }
  /*//Stripe payment add card
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
        stripePayApi(value.id);
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

  //stripe pay api

  //create customer Id : -
  stripePayApi (String customerId, String cardId, bool isDelete) {

    Map<String, dynamic> customerMap = {
      "amount":((total * 100).toInt()).toString(),
      "currency":"INR",
      "customer":customerId,
      "description":"Testing data",
      // "email": "test@gmail.com",
    };

    print(customerMap);
    postStripeApi(customerMap).then((value) {
      if (value != null && value.id != null) {
        print(value);
        // _con.payment = new Payment("Cash on Delivery");
        // _con.listenForCarts();
        successAlertShow();
        if(!isRemember && isDelete == true) {
          deleteCardData(customerId, cardId);
        }
        setState((){});
      } else {
        print("Some thing wrong");
        failAlertShow();
      }
    });
  }


  successAlertShow() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Successful!'),
          content: Text('Your transactions successfully pay'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(true);
                Navigator.of(context).pushNamedAndRemoveUntil('/Pages', (Route<dynamic> route) => false, arguments: 2);
                // /Pages// dismisses only the dialog and returns true
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  failAlertShow() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Fail!'),
          content: Text('Your transactions fail!'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(true); // dismisses only the dialog and returns true
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

}

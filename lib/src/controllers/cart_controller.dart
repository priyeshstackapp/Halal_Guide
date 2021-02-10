import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/helpers/app_config.dart';
import 'package:food_delivery_app/src/models/charity.dart';
import 'package:food_delivery_app/src/models/charity_custome_cart.dart';
import 'package:food_delivery_app/src/models/route_argument.dart';
import 'package:food_delivery_app/src/pages/delivery_pickup.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/user_repository.dart' as userRepo;
import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/cart.dart';
import '../repository/cart_repository.dart';
import '../repository/user_repository.dart';

class CartController extends ControllerMVC {
  List<Cart> carts = <Cart>[];
  double taxAmount = 0.0;
  double deliveryFee = 0.0;
  int cartCount = 0;
  double subTotal = 0.0;
  double total = 0.0;
  double withOutCharityTotal = 0.0;
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Charity> charityList;
  String selectedCharityId = "";


  CartController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void listenForCarts({String message}) async {
    final Stream<Cart> stream = await getCart();
    stream.listen((Cart _cart) {
      if (!carts.contains(_cart)) {
        setState(() {
          carts.add(_cart);
        });
      }
    }, onError: (a) {
      print(a);
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).verify_your_internet_connection),
      ));
    }, onDone: () {
      if (carts.isNotEmpty) {
        calculateSubtotal();
      }
      if (message != null) {
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
      onLoadingCartDone();
      // if (payment != null) addOrder(carts);
    });
  }

  void listenForCharity() async {
    charityList = await getCharity();
    notifyListeners();
  }

  void onLoadingCartDone() {}

  void listenForCartsCount({String message}) async {
    final Stream<int> stream = await getCartCount();
    stream.listen((int _count) {
      setState(() {
        this.cartCount = _count;
      });
    }, onError: (a) {
      print(a);
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).verify_your_internet_connection),
      ));
    });
  }

  Future<void> refreshCarts() async {
    setState(() {
      carts = [];
    });
    listenForCarts(message: S.of(context).carts_refreshed_successfuly);
  }

  void removeFromCart(Cart _cart) async {
    setState(() {
      this.carts.remove(_cart);
    });
    removeCart(_cart).then((value) {
      calculateSubtotal();
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).the_food_was_removed_from_your_cart(_cart.food.name)),
      ));
    });
  }

  void calculateSubtotal() async {
    double cartPrice = 0;
    subTotal = 0;
    carts.forEach((cart) {
      cartPrice = cart.food.price;
      cart.extras.forEach((element) {
        cartPrice += element.price;
      });
      cartPrice *= cart.quantity;
      subTotal += cartPrice;
    });
    if (Helper.canDelivery(carts[0].food.restaurant, carts: carts)) {
      deliveryFee = carts[0].food.restaurant.deliveryFee;
    }
    taxAmount = (subTotal + deliveryFee) * carts[0].food.restaurant.defaultTax / 100;
    total = subTotal + taxAmount + deliveryFee;
    // withOutCharityTotal = total;
    setState(() {});
  }

  incrementQuantity(Cart cart) {
    if (cart.quantity <= 99) {
      ++cart.quantity;
      updateCart(cart);
      calculateSubtotal();
    }
  }

  decrementQuantity(Cart cart) {
    if (cart.quantity > 1) {
      --cart.quantity;
      updateCart(cart);
      calculateSubtotal();
    }
  }

  void goCheckout(BuildContext context) {
    if (!currentUser.value.profileCompleted()) {
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).completeYourProfileDetailsToContinue),
        action: SnackBarAction(
          label: S.of(context).settings,
          textColor: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.of(context).pushNamed('/Settings');
          },
        ),
      ));
    } else {
      if (carts[0].food.restaurant.closed) {
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).this_restaurant_is_closed_),
        ));
      } else {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryPickupWidget()));

        charityCartCustomApi();

        Map<String, dynamic> mapData = {
            "subTotal":subTotal,
            "taxAmount":taxAmount,
            "deliveryFee":deliveryFee,
            "total":total,
        };
        App.cardMapData = mapData;
        setState(() {});
        Navigator.of(context).pushNamed('/DeliveryPickup', arguments: RouteArgument(param: mapData));

      }
    }
  }


  //charity cart-custom api

  charityCartCustomApi() {

    // withOutCharityTotal = total - withOutCharityTotal;

    print("withOutCharityTotal ${withOutCharityTotal}");

    Map<String, dynamic> charityMap = {
      "amount": withOutCharityTotal.toString(),
      "name": userRepo.currentUser.value.name,
      "charity_id": selectedCharityId
    };

    cartCustom(charityMap).then((value) {
      Map<String, dynamic> mapData = json.decode(value.body);
      if(value != null) {
        if(value.statusCode == 200 || value.statusCode == 201) {
          if(mapData['success'] == true) {
            CharityCustomCartModel charityCustomCartModel = CharityCustomCartModel.fromJson(json.decode(value.body));
            print(charityCustomCartModel.message);
          } else {
            print("html response");
          }
        } else {
          print("Some thing wrong");
        }
      } else {
        print("some error");
      }
    });

  }


}

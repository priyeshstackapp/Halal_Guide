import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/controllers/restaurant_user_controller.dart';
import '../../helpers/app_config.dart' as config;
import 'package:mvc_pattern/mvc_pattern.dart';

class RestaurantRegThirdPage extends StatefulWidget {

  final int restaurantId;
  const RestaurantRegThirdPage({Key key, this.restaurantId}) : super(key: key);

  @override
  _RestaurantRegThirdPageState createState() => _RestaurantRegThirdPageState();
}

class _RestaurantRegThirdPageState extends StateMVC<RestaurantRegThirdPage> {

  RestaurantRegUserController _con;

  _RestaurantRegThirdPageState() : super(RestaurantRegUserController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apply for restaurant"),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              width: config.App(context).appWidth(100),
              height: config.App(context).appHeight(29.5),
              decoration: BoxDecoration(color: Theme.of(context).accentColor),
            ),
          ),
          Positioned(
            top: config.App(context).appHeight(29.5) - 120,
            child: Container(
              width: config.App(context).appWidth(84),
              height: config.App(context).appHeight(29.5),
              child: Text(
                "Add Timer",
                // S.of(context).lets_start_with_register,
                style: Theme.of(context).textTheme.headline2.merge(TextStyle(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
          Positioned(
            top: config.App(context).appHeight(29.5) - 50,
            child: Container(
              height: MediaQuery.of(context).size.height  - config.App(context).appHeight(29.5) - 50,
              // width: MediaQuery.of(context).size.width  - 100,
              width: config.App(context).appWidth(88),

              decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(10)), boxShadow: [
                BoxShadow(
                  blurRadius: 50,
                  color: Theme.of(context).hintColor.withOpacity(0.2),
                )
              ]),
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
//              height: config.App(context).appHeight(55),

            ),
          ),
        ],
      ),
    );
  }
}

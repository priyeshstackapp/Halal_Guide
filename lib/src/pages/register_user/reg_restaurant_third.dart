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

  bool isOpen = false;

  bool textMessageShow = false;


  RestaurantRegUserController _con;

  _RestaurantRegThirdPageState() : super(RestaurantRegUserController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.restaurantId = widget.restaurantId;
    _con.displayCuisinesApi();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        // title: Text("Apply for restaurant"),
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
                "Restaurant Cuisine",
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                        itemCount: _con.cuisineData.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Checkbox(
                              // value: selections[index] == index,
                              value: _con.cuisineData[index].isSelected,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _con.cuisineData[index].isSelected = newValue;
                                  if(_con.selectionsId.contains(_con.cuisineData[index].id)){
                                    _con.selectionsId.remove(_con.cuisineData[index].id);
                                  } else {
                                    _con.selectionsId.add(_con.cuisineData[index].id);
                                  }

                                });
                                print(_con.cuisineData[index].isSelected);
                                print(_con.selectionsId);
                              },
                            ),
                            Text(_con.cuisineData[index].name, style: TextStyle(fontSize: 20))
                          ],
                        ),
                      );
                    }),

                    SizedBox(height: 25),

                    textMessageShow ? Text("Please Select One Item", style: TextStyle(fontSize: 20, color: Colors.red)) : Container() ,

                    textMessageShow ? SizedBox(height: 25) : Container(),

                    MaterialButton(
                      onPressed: () {
                        // Navigator.of(context).pushNamed('/MobileVerification');

                        if(_con.selectionsId.isEmpty) {
                          textMessageShow = true;
                          setState(() {});
                        } else {
                          textMessageShow = false;
                          setState(() {});
                          _con.cuisineUserOwnerShipApi();
                        }
                      },
                      height: 50,
                      minWidth: config.App(context).appWidth(88),
                      padding: EdgeInsets.symmetric(vertical: 14,),
                      color: Theme.of(context).accentColor.withOpacity(0.1),
                      shape: StadiumBorder(),
                      child: Text(
                        'Submit',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

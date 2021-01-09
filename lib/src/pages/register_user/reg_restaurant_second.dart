import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/controllers/restaurant_user_controller.dart';
import '../../helpers/app_config.dart' as config;
import '../../../generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class RestaurantRegSecondPage extends StatefulWidget {

  final Map<String, dynamic> firstPageData;
  const RestaurantRegSecondPage({Key key, this.firstPageData}) : super(key: key);

  @override
  _RestaurantRegSecondPageState createState() => _RestaurantRegSecondPageState();
}

class _RestaurantRegSecondPageState extends StateMVC<RestaurantRegSecondPage> {

  RestaurantRegUserController _con;

  _RestaurantRegSecondPageState() : super(RestaurantRegUserController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _con.firstPageData = widget.firstPageData;

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
              child: Form(
                // key: _con.loginFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      // singleRowData("Sunday", "1"),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Sunday"),
                            Row(
                              children: [
                                Text("open"),
                                startTimeShow("1.0"),
                                Text("Close"),
                                startTimeShow("1.1")
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 30),

                      // singleRowData("Monday", "2"),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Monday"),

                            Row(
                              children: [
                                Text("open"),
                                startTimeShow("2.0"),
                                Text("Close"),
                                startTimeShow("2.1")
                              ],
                            )

                          ],
                        ),
                      ),
                      SizedBox(height: 30),

                      // singleRowData("Tuesday", "3"),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tuesday"),

                            Row(
                              children: [
                                Text("open"),
                                startTimeShow("3.0"),
                                Text("Close"),
                                startTimeShow("3.1")
                              ],
                            )

                          ],
                        ),
                      ),
                      SizedBox(height: 30),

                      // singleRowData("Wednesday", "4"),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Wednesday"),

                            Row(
                              children: [
                                Text("open"),
                                startTimeShow("4.0"),
                                Text("Close"),
                                startTimeShow("4.1")
                              ],
                            )

                          ],
                        ),
                      ),
                      SizedBox(height: 30),

                      // singleRowData("Thursday", "5"),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Thursday"),

                            Row(
                              children: [
                                Text("open"),
                                startTimeShow("5.0"),
                                Text("Close"),
                                startTimeShow("5.1")
                              ],
                            )

                          ],
                        ),
                      ),
                      SizedBox(height: 30),

                      // singleRowData("Friday", "6"),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Friday"),

                            Row(
                              children: [
                                Text("open"),
                                startTimeShow("6.0"),
                                Text("Close"),
                                startTimeShow("6.1")
                              ],
                            )

                          ],
                        ),
                      ),
                      SizedBox(height: 30),

                      // singleRowData("Saturday", "7"),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Saturday"),

                            Row(
                              children: [
                                Text("open"),
                                startTimeShow("7.0"),
                                Text("Close"),
                                startTimeShow("7.1")
                              ],
                            )

                          ],
                        ),
                      ),
                      SizedBox(height: 30),

                     Align(
                       alignment: Alignment.centerLeft,
                       child: Row(
                         children: [
                           Checkbox(
                             value: _con.isOpen,
                             onChanged: (bool newValue) {
                               setState(() {
                                 _con.isOpen = newValue;
                               });
                             },
                           ),
                           Text("open 24x7 ", style: TextStyle(fontSize: 20))
                         ],
                       ),
                     ),

                      /*  BlockButtonWidget(
                        text: Text(
                          S.of(context).register,
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          _con.register();
                        },
                      ),*/
                      SizedBox(height: 25),
                      MaterialButton(
                        onPressed: () {
                          // Navigator.of(context).pushNamed('/MobileVerification');
                          _con.registerUserApi();
                        },
                        height: 50,
                        minWidth: 150,
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
          ),
        ],
      ),
    );
  }

  /*singleRowData(String title, String day){
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),

          Row(
            children: [
              Text("open"),
              startTimeShow(),
              Text("Close"),
              startTimeShow()
            ],
          )

        ],
      ),
    );
  }*/

  startTimeShow(String timeShow) {
    return Container(
      height: 50,
      width: 110,
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.only(left: 5, right: 5),

      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10)
      ),
      child: DropdownButtonHideUnderline(
        child: new DropdownButton<Map>(
          items: timeSlot.map((Map value) {
            return new DropdownMenuItem<Map>(
              value: valueData(value,timeShow) ,
              child: new Text(value['time']),
            );
          }).toList(),
          // value:  _con.sundayOpen,
          value:  showMenuData(timeShow),
          onChanged: (value) {

            print(value);
            if(timeShow == "1.0") {
              _con.sundayOpen = value;
              setState(() { });
            } else if(timeShow == "1.1") {
              _con.sundayClose = value;
              setState(() { });
              // sundayClose = value["index"];
            } else  if(timeShow == "2.0") {
              _con.mondayOpen = value;
              setState(() {});
            } else if(timeShow == "2.1") {
              _con.mondayClose = value;
              setState(() { });;
              // mondayClose = value["index"];
            } else  if(timeShow == "3.0") {
              _con.tuesdayOpen = value;
              setState(() { });
              // thursdayOpen = value["index"];
            } else if(timeShow == "3.1") {
              _con.tuesdayClose = value;
              setState(() { });
              // tuesdayClose = value["index"];
            } else  if(timeShow == "4.0") {
              _con.wednesdayOpen = value;
              setState(() { });
              // wednesdayOpen = value["index"];
            } else if(timeShow == "4.1") {
              _con.wednesdayClose = value;
              setState(() { });
              // wednesdayClose = value["index"];
            } else  if(timeShow == "5.0") {
              _con.thursdayOpen = value;
              setState(() { });
              // thursdayOpen = value["index"];
            } else if(timeShow == "5.1") {
              _con.thursdayClose = value;
              setState(() { });
              // tuesdayClose = value["index"];
            } else  if(timeShow == "6.0") {
              _con.fridayOpen = value;
              setState(() { });
              // fridayOpen = value["index"];
            } else if(timeShow == "6.1") {
              _con.fridayClose = value;
              setState(() { });
              // fridayClose = value["index"];
            } else  if(timeShow == "7.0") {
              _con.saturdayOpen = value;
              setState(() { });
                // saturdayOpen = value["index"];
            } else if(timeShow == "7.1") {
              _con.saturdayClose = value;
              setState(() {});
              // saturdayClose = value["index"];
            }

          },
        ),
      ),
    );
  }


  List<Map<String, String>> timeSlot = [
    {"time" : "Closed", "index":"0"} ,
    {"time" : "7:00 am", "index":"1"} ,
    {"time" : "7:30 am", "index":"2"} ,
    {"time" : "8:00 am", "index":"3"} ,
    {"time" : "8:30 am", "index":"4"} ,
    {"time" : "9:00 am", "index":"5"} ,
    {"time" : "9:30 am", "index":"6"} ,
    {"time" : "10:00 am", "index":"7"} ,
    {"time" : "10:30 am", "index":"8"} ,
    {"time" : "11:00 am", "index":"9"} ,
    {"time" : "11:30 am", "index":"10"} ,
    {"time" : "12:00 pm", "index":"11"} ,
    {"time" : "12:30 pm", "index":"12"} ,
    {"time" : "1:00 pm", "index":"13"} ,
    {"time" : "1:30 pm", "index":"14"} ,
    {"time" : "2:00 pm", "index":"15"} ,
    {"time" : "2:30 pm", "index":"16"} ,
    {"time" : "3:00 pm", "index":"17"} ,
    {"time" : "3:30 pm", "index":"18"} ,
    {"time" : "4:00 pm", "index":"19"} ,
    {"time" : "4:30 pm", "index":"20"} ,
    {"time" : "5:00 pm", "index":"21"} ,
    {"time" : "5:30 pm", "index":"22"} ,
    {"time" : "6:00 pm", "index":"23"} ,
    {"time" : "6:30 pm", "index":"24"} ,
    {"time" : "7:00 pm", "index":"25"} ,
    {"time" : "7:30 pm", "index":"26"} ,
    {"time" : "8:00 pm", "index":"27"} ,
    {"time" : "8:30 pm", "index":"28"} ,
    {"time" : "9:00 pm", "index":"29"} ,
    {"time" : "9:30 pm", "index":"30"} ,
    {"time" : "10:00 pm", "index":"31"} ,
    {"time" : "10:30 pm", "index":"32"} ,
    {"time" : "11:00 pm", "index":"33"} ,
    {"time" : "11:30 pm", "index":"34"}
  ];

  valueData(Map<String, String> data, String timeShow) {
    // print(timeShow);
    if(timeShow == "1.0") {
     // return sundayOpen ?? {};
      return data;
    } else if(timeShow == "1.1"){
    return  data;
     // return sundayClose ?? {};
    } else  if(timeShow == "2.0"){
    return  data;
     // return mondayOpen ?? {};
    } else if(timeShow == "2.1"){
    return  data;
     // return mondayClose ?? {};
    } else  if(timeShow == "3.0"){
    return  data;
     // return tuesdayOpen ?? {};
    } else if(timeShow == "3.1"){
    return  data;
     // return tuesdayClose ?? {};
    } else  if(timeShow == "4.0"){
    return  data;
     // return wednesdayOpen ?? {};
    } else if(timeShow == "4.1") {
      return  data;
     // return wednesdayClose ?? {};
    } else  if(timeShow == "5.0") {
      return  data;
     // return thursdayOpen ?? {};
    } else if(timeShow == "5.1") {
      return  data;
     // return thursdayClose ?? {};
    } else  if(timeShow == "6.0") {
      return  data;
     // return fridayOpen ?? {};
    } else if(timeShow == "6.1"){
    return  data;
     // return fridayClose ?? {};
    } else  if(timeShow == "7.0"){
    return  data;
     // return saturdayOpen ?? {};
    } else if(timeShow == "7.1") {
      return  data;
     // return saturdayClose ?? {};
    }  }


  showMenuData(String timeShow) {
    print("hello $timeShow");
    if(timeShow == "1.0") {
      return _con.sundayOpen ;
      // return data;
    } else if(timeShow == "1.1"){
      // return  data;
      return _con.sundayClose;
    } else  if(timeShow == "2.0"){
      // return  data;
      return _con.mondayOpen;
    } else if(timeShow == "2.1"){
      // return  data;
      return _con.mondayClose;
    } else  if(timeShow == "3.0"){
      // return  data;
      return _con.tuesdayOpen;
    } else if(timeShow == "3.1"){
      // return  data;
      return _con.tuesdayClose;
    } else  if(timeShow == "4.0"){
      // return  data;
      return _con.wednesdayOpen;
    } else if(timeShow == "4.1") {
      // return  data;
      return _con.wednesdayClose;
    } else  if(timeShow == "5.0") {
      // return  data;
      return _con.thursdayOpen;
    } else if(timeShow == "5.1") {
      // return  data;
      return _con.thursdayClose;
    } else  if(timeShow == "6.0") {
      // return  data;
      return _con.fridayOpen;
    } else if(timeShow == "6.1"){
      // return  data;
      return _con.fridayClose;
    } else  if(timeShow == "7.0"){
      // return  data;
      return _con.saturdayOpen;
    } else if(timeShow == "7.1") {
      // return  data;
      return _con.saturdayClose;
    }
  }
}

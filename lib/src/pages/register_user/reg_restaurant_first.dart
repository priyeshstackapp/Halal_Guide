import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/pages/register_user/reg_restaurant_second.dart';
import '../../helpers/app_config.dart' as config;
import '../../../generated/l10n.dart';

class RestaurantRegFirstPage extends StatefulWidget {
  @override
  _RestaurantRegFirstPageState createState() => _RestaurantRegFirstPageState();
}

class _RestaurantRegFirstPageState extends State<RestaurantRegFirstPage> {


  TextEditingController nameController = TextEditingController(text: "vihhh ");
  TextEditingController descriptionController = TextEditingController(text: "203 vinagar");
  TextEditingController addressController = TextEditingController(text: "20 23 sociaty 1");
  TextEditingController phoneController = TextEditingController(text: "789456");
  TextEditingController mobileController = TextEditingController(text: "1457894561");
  TextEditingController infoController = TextEditingController(text: "test data data ");
  TextEditingController deliveryFeeController = TextEditingController(text: "1");
  TextEditingController deliveryRangeController = TextEditingController(text: "1");
  TextEditingController defaultTexController = TextEditingController(text: "1");

  String availableDropText = "Yes";
  String closeDropText = "Yes";

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

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
                S.of(context).lets_start_with_register,
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
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//              height: config.App(context).appHeight(55),
              child: Form(
                key: loginFormKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      nameTextFiled(),
                      SizedBox(height: 30),
                      descriptionTextFiled(),
                      SizedBox(height: 30),
                      addressTextFiled(),
                      SizedBox(height: 30),
                      phoneTextFiled(),
                      SizedBox(height: 30),
                      mobileTextFiled(),
                      SizedBox(height: 30),
                      infoTextFiled(),
                      SizedBox(height: 30),
                      deliveryFee(),
                      SizedBox(height: 30),
                      deliveryRange(),
                      SizedBox(height: 30),
                      defaultTex(),
                      SizedBox(height: 30),
                      availableForDelivery(),
                      SizedBox(height: 30),
                      closed(),
                      SizedBox(height: 30),

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

                         // if (loginFormKey.currentState.validate()) {
                           Map<String, dynamic> sendMapData = {
                             "name": nameController.text,
                             "description": descriptionController.text,
                             "address": addressController.text,
                             "latitude":  "21.235270",
                             "longitude": "72.868731",
                             "phone": phoneController.text,
                             "mobile": mobileController.text,
                             "information": infoController.text,
                             "delivery_fee": int.parse(deliveryFeeController.text),
                             "delivery_range": int.parse(deliveryRangeController.text),
                             "default_tax": int.parse(defaultTexController.text),
                             "available_for_delivery": availableDropText == "Yes" ? 1 : 0,
                             "closed": closeDropText == "Yes" ? 1 : 0,
                           };

                           Navigator.push(context, MaterialPageRoute(
                               builder: (context) =>
                                   RestaurantRegSecondPage(firstPageData: sendMapData)));
                         // }
                         // Navigator.of(context).pushNamed('/MobileVerification');
                       },
                       height: 50,
                       minWidth: 150,
                       padding: EdgeInsets.symmetric(vertical: 14,),
                       color: Theme.of(context).accentColor.withOpacity(0.1),
                       shape: StadiumBorder(),
                       child: Text(
                         'Next',
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

  nameTextFiled() {
    return  TextFormField(
      keyboardType: TextInputType.text,
      controller: nameController,
      // onSaved: (input) => _con.user.name = input,
      validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_letters : null,
      // validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_letters : null,
      decoration: InputDecoration(
        labelText: 'Enter Name',
        // labelText: S.of(context).full_name,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        contentPadding: EdgeInsets.all(12),
        hintText: 'Enter Name',
        // hintText: S.of(context).john_doe,
        hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
        // prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
      ),
    );
  }

  descriptionTextFiled() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: descriptionController,
      // onSaved: (input) => _con.user.email = input,
      validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_letters : null,
      decoration: InputDecoration(
        labelText: 'Description',
        // labelText: S.of(context).email,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        contentPadding: EdgeInsets.all(12),
        hintText: 'Description',
        hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
        // prefixIcon: Icon(Icons.alternate_email, color: Theme.of(context).accentColor),
        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
      ),
    );
  }

  addressTextFiled() {
    return TextFormField(
      // obscureText: _con.hidePassword,
      controller: addressController,
      // onSaved: (input) => _con.user.password = input,
      validator: (input) => input.length < 7 ? S.of(context).should_be_more_than_3_letters : null,
      decoration: InputDecoration(
        labelText: 'Address',
        // labelText: S.of(context).password,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        contentPadding: EdgeInsets.all(12),
        hintText: 'Address',
        hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
        // prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
      ),
    );
  }

  phoneTextFiled() {
    return TextFormField(
      controller: phoneController,
      // obscureText: _con.hidePassword,
      // onSaved: (input) => _con.user.password = input,
      validator: (input) => input.length < 6 ? S.of(context).should_be_more_than_6_letters : null,
      decoration: InputDecoration(
        labelText: 'Phone',
        // labelText: S.of(context).password,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        contentPadding: EdgeInsets.all(12),
        hintText: '(516) 622-6669',
        hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
        // prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
      ),
    );
  }

  mobileTextFiled() {
    return TextFormField(
      controller: mobileController,
    // obscureText: _con.hidePassword,
    // onSaved: (input) => _con.user.password = input,
    validator: (input) => input.length < 9 ? "Phone should be 10 digit" : null,
    decoration: InputDecoration(
      labelText: 'Mobile',
      // labelText: S.of(context).password,
      labelStyle: TextStyle(color: Theme.of(context).accentColor),
      contentPadding: EdgeInsets.all(12),
      hintText: '7894561230',
      hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
      // prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
      border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
    ),
  );
  }

  infoTextFiled() {
    return TextFormField(
      controller: infoController,
      // obscureText: _con.hidePassword,
      // onSaved: (input) => _con.user.password = input,
      validator: (input) => input.length < 6 ? S.of(context).should_be_more_than_6_letters : null,
      decoration: InputDecoration(
        labelText: 'Information',
        // labelText: S.of(context).password,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        contentPadding: EdgeInsets.all(12),
        hintText: 'Information',
        hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
        // prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
      ),
    );
  }

  deliveryFee() {
    return TextFormField(
      controller: deliveryFeeController,
      // obscureText: _con.hidePassword,
      // onSaved: (input) => _con.user.password = input,
      validator: (input) => input.isEmpty ? "Delivery Fee Empty" : null,
      decoration: InputDecoration(
        labelText: 'Delivery Fee',
        // labelText: S.of(context).password,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        contentPadding: EdgeInsets.all(12),
        hintText: '£20',
        hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
        // prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
      ),
    );
  }

  deliveryRange() {
    return TextFormField(
      controller: deliveryRangeController,
      // obscureText: _con.hidePassword,
      // onSaved: (input) => _con.user.password = input,
      validator: (input) => input.isEmpty ? "Delivery Range Empty" : null,
      decoration: InputDecoration(
        labelText: 'Delivery Range',
        // labelText: S.of(context).password,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        contentPadding: EdgeInsets.all(12),
        hintText: '100 M',
        hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
        // prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
      ),
    );
  }

  defaultTex() {
    return TextFormField(
      controller: defaultTexController,
      // obscureText: _con.hidePassword,
      // onSaved: (input) => _con.user.password = input,
      validator: (input) => input.isEmpty ? "Default Tex Empty" : null,
      decoration: InputDecoration(
        labelText: 'Default Tax',
        // labelText: S.of(context).password,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        contentPadding: EdgeInsets.all(12),
        hintText: '£20',
        hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
        // prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
      ),
    );
  }

  availableForDelivery() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(10)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          validator: (input) => input.isEmpty ? "Select Available delivery" : null,
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent))),
          items: <String>["Yes", "No"].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          value: availableDropText,
          onChanged: (value) {
            availableDropText = value;
            setState(() {

            });
          },
        ),
      ),
    );
  }

  closed() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.2), width: 1),
          borderRadius: BorderRadius.circular(10)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          validator: (input) => input.isEmpty ? "Select Closed" : null,

          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent))),

          items: <String>["Yes", "No"].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          value: closeDropText,
          onChanged: (value) {
            closeDropText = value;
            setState(() {});
          },
        ),
      ),
    );

  }
}

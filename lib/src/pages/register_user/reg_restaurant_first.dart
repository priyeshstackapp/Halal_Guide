import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/src/controllers/restaurant_user_controller.dart';
import 'package:food_delivery_app/src/models/cuisine_model.dart';
import 'package:food_delivery_app/src/pages/register_user/reg_restaurant_second.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../elements/CircularLoadingWidget.dart';
import '../../helpers/app_config.dart' as config;
import '../../../generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class RestaurantRegFirstWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  RestaurantRegFirstWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _RestaurantRegFirstWidgetState createState() => _RestaurantRegFirstWidgetState();
}

class _RestaurantRegFirstWidgetState extends StateMVC<RestaurantRegFirstWidget> {


  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController addressController = TextEditingController(text: "");
  TextEditingController phoneController = TextEditingController(text: "");
  TextEditingController mobileController = TextEditingController(text: "");
  TextEditingController infoController = TextEditingController(text: "");
  TextEditingController deliveryFeeController = TextEditingController(text: "");
  TextEditingController deliveryRangeController = TextEditingController(text: "");
  TextEditingController defaultTexController = TextEditingController(text: "");
  double lat  = 40.707091;
  double long = -74.009900;


  String availableDropText = "Yes";
  String closeDropText = "Yes";
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  File image;

  //Maps data

  CameraPosition cameraPosition;
  Completer<GoogleMapController> mapController = Completer();
  List<Marker> allMarkers = <Marker>[];

  RestaurantRegUserController _con;
  _RestaurantRegFirstWidgetState() : super(RestaurantRegUserController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cameraPosition = CameraPosition(
        target: LatLng(40.707091,  -74.009900),
        zoom: 15
    );

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      /*appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Apply for restaurant", style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          // new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),*/
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        // title: Text("Apply for restaurant"),
      /*  leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        ),*/
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
                      Text("Available For Delivery", style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.w500)),
                      SizedBox(height: 10),
                      availableForDelivery(),
                      SizedBox(height: 30),
                      Text("closed", style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.w500)),
                      SizedBox(height: 10),
                      closed(),
                      SizedBox(height: 30),

                      InkResponse(
                        onTap: () async {
                          print("hello");
                          FocusScope.of(context).unfocus();
                          source(context);
                          // getMultipleImageInfos();
                   /*       final _image = await FlutterWebImagePicker.getImage;
                          setState(() {
                            image = _image;
                          });*/
                          // _selectImage();
                        },
                        child: image != null ? Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.width  - 100,
                            width: MediaQuery.of(context).size.width - 100,
                            // margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 1.5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).focusColor.withOpacity(0.2),
                                    width: 1
                                ),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Image(image: FileImage(image))
                            // child: Image(image: NetworkImage(_con.imageStr))
                        )  :

                        Container(
                          height: MediaQuery.of(context).size.width  - 100,
                          width: MediaQuery.of(context).size.width - 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                             border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, color: Colors.black),
                              Text("add images", style: TextStyle(color: Colors.black))
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      Container(
                          height: MediaQuery.of(context).size.width - 60,
                          width: MediaQuery.of(context).size.width,
                        child: showGoogleMaps(),
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
                           Map<String, dynamic> sendMapData ={};
                          print("hello");
                         if (loginFormKey.currentState.validate()) {
                           if (_con.uploadedImageId != null) {
                             sendMapData   = {
                               "name": nameController.text,
                               "description": descriptionController.text,
                               "address": addressController.text,
                               "latitude": lat.toString(),
                               "longitude": long.toString(),
                               "phone": phoneController.text,
                               "mobile": mobileController.text,
                               "information": infoController.text,
                               "delivery_fee": int.parse(
                                   deliveryFeeController.text),
                               "delivery_range": int.parse(
                                   deliveryRangeController.text),
                               "default_tax": int.parse(
                                   defaultTexController.text),
                               "available_for_delivery": availableDropText ==
                                   "Yes" ? 1 : 0,
                               "closed": closeDropText == "Yes" ? 1 : 0,
                               "image": _con.uploadedImageId
                             };
                             Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantRegSecondPage(firstPageData: sendMapData)));

                           } else {
                             _con.scaffoldKey?.currentState?.showSnackBar(
                                 SnackBar(
                                   content: Text("Image not selected"),
                                   // content: Text(S.of(context).wrong_email_or_password),
                                 ));
                           }
                         }

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
      maxLines: 4,
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
      validator: (input) => input.length < 10 ? S.of(context).should_be_more_than_10_letters : null,
      maxLines: 2,
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
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[0-9]")),
        FilteringTextInputFormatter.digitsOnly
      ],
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
      maxLines: 4,
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
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[0-9]"))
      ],
      decoration: InputDecoration(
        labelText: 'Delivery Fee',
        // labelText: S.of(context).password,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        contentPadding: EdgeInsets.all(12),
        hintText: '\$20',

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
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[0-9]"))
      ],
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
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[0-9]"))
      ],
      decoration: InputDecoration(
        labelText: 'Default Tax',
        // labelText: S.of(context).password,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        contentPadding: EdgeInsets.all(12),
        hintText: '\$20',
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
          borderRadius: BorderRadius.circular(5)
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
          borderRadius: BorderRadius.circular(5)
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

  
  showGoogleMaps() {
    return cameraPosition == null
        ? CircularLoadingWidget(height: 0)
        : GoogleMap(
      mapToolbarEnabled: false,
      mapType: MapType.normal,
      initialCameraPosition: cameraPosition,
      markers: {
        Marker(
         markerId: MarkerId("1"),
         position: LatLng(lat, long),
        ),
      },
      // markers: Marker(markerId: 1),
      // markers: Set.from(allMarkers),
      onMapCreated: (GoogleMapController controller) {
        mapController.complete(controller);
      },
      onCameraMove: (CameraPosition cameraPosition) {
        cameraPosition = cameraPosition;
      },
      gestureRecognizers:
      <Factory<OneSequenceGestureRecognizer>>[
        Factory<OneSequenceGestureRecognizer>(
              () => new EagerGestureRecognizer(),
        ),
      ].toSet(),
      onTap: (value){
        print(value);
        lat = value.latitude;
        long = value.longitude;
        setState(() { });
      },
      onCameraIdle: () {
        // _con.getRestaurantsOfArea();
      },
      // polylines: _con.polylines,
    );
  }


  // Future<void> _selectImage() async {
  //   final completer = Completer<List<String>>();
  //   final InputElement input = document.createElement('input');
  //   input
  //     ..type = 'file'
  //     ..multiple = false
  //     ..accept = 'image/*';
  //   input.click();
  //   // onChange doesn't work on mobile safari
  //   input.addEventListener('change', (e) async {
  //     final List<File> files = input.files;
  //
  //     Iterable<Future<String>> resultsFutures = files.map((file) {
  //       final reader = FileReader();
  //       reader.readAsDataUrl(file);
  //       reader.onError.listen((error) => completer.completeError(error));
  //       return reader.onLoad.first.then((_) => reader.result as String);
  //     });
  //     final results = await Future.wait(resultsFutures);
  //     completer.complete(results);
  //   });
  //   // need to append on mobile safari
  //   document.body.append(input);
  //   // input.click(); can be here
  //
  //   // String image = completer.
  //
  //   final List<String> images = await completer.future;
  //   String imageBase64 = images[0];
  //   // _imageBytesDecoded = base64Decode(imageBase64);
  //
  //   // uploadedImage = base64Decode(imageBase64);
  //   // _imageBytesDecoded = base64.decode(imageBase64);
  //   print(_imageBytesDecoded);
  //   setState(() {
  //     print(images);
  //     // _uploadedImages = images;
  //   });
  //   _con.imageUploadApi(imageBase64);
  //   input.remove();
  // }

  source(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              "Select source",
            ),
            insetAnimationCurve: Curves.decelerate,
            actions: <Widget>[
              GestureDetector(
                onTap: () async {
                  var _image = await ImagePicker.pickImage(
                      source: ImageSource.camera);
                  if (_image != null) {
                    image = _image;

                    List<int> imageBytes = image.readAsBytesSync();
                    String base64Image = base64Encode(imageBytes);
                    print(base64Image);
                    _con.imageUploadApi(base64Image);

                    Navigator.pop(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.photo_camera,
                        size: 28,
                      ),
                      Text(
                        " Camera",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  // loadAssets();
                  FocusScope.of(context).requestFocus(new FocusNode());
                  File _image = await ImagePicker.pickImage(source: ImageSource.gallery);
                  if (_image != null) {
                    image = _image;
                    setState(() {});

                    List<int> imageBytes = image.readAsBytesSync();
                    print(imageBytes);
                    String base64Image = base64Encode(imageBytes);
                    print(base64Image);
                    _con.imageUploadApi(base64Image);

                    Navigator.pop(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.photo_library,
                        size: 28,
                      ),
                      Text(
                        " Gallery",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

}

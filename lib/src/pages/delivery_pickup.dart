import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/controllers/cart_controller.dart';
import 'package:food_delivery_app/src/helpers/app_config.dart' as appCon;
import 'package:food_delivery_app/src/pages/payment_methods.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/delivery_pickup_controller.dart';
import '../elements/CartBottomDetailsWidget.dart';
import '../elements/DeliveryAddressDialog.dart';
import '../elements/DeliveryAddressesItemWidget.dart';
import '../elements/NotDeliverableAddressesItemWidget.dart';
import '../elements/PickUpMethodItemWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../helpers/helper.dart';
import '../models/address.dart';
import '../models/payment_method.dart';
import '../models/route_argument.dart';

class DeliveryPickupWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  DeliveryPickupWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _DeliveryPickupWidgetState createState() => _DeliveryPickupWidgetState();
}

class _DeliveryPickupWidgetState extends StateMVC<DeliveryPickupWidget> {

  DeliveryPickupController _con;
  CartController _con1;

  _DeliveryPickupWidgetState() : super(DeliveryPickupController()) {
    _con = controller;
    _con1 = controller;
  }

  @override
  Widget build(BuildContext context) {
    if (_con.list == null) {
      _con.list = new PaymentMethodList(context);
//      widget.pickup = widget.list.pickupList.elementAt(0);
//      widget.delivery = widget.list.pickupList.elementAt(1);
    }
    return Scaffold(
      key: _con.scaffoldKey,
      // bottomNavigationBar: CartBottomDetailsWidget(con: _con),

      bottomNavigationBar: Container(
        height: 160,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), offset: Offset(0, -2), blurRadius: 5.0)]),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      S.of(context).subtotal,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Helper.getPrice(appCon.App.cardMapData['subTotal'], context, style: Theme.of(context).textTheme.subtitle1)
                  // Helper.getPrice(widget.con.subTotal, context, style: Theme.of(context).textTheme.subtitle1)
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      S.of(context).delivery_fee,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Helper.getPrice(appCon.App.cardMapData['deliveryFee'], context, style: Theme.of(context).textTheme.subtitle1)

                  //     if (Helper.canDelivery(widget.con.carts[0].food.restaurant, carts: widget.con.carts))
                  //   Helper.getPrice(widget.con.carts[0].food.restaurant.deliveryFee, context, style: Theme.of(context).textTheme.subtitle1)
                  // else
                  //   Helper.getPrice(0, context, style: Theme.of(context).textTheme.subtitle1)
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '${S.of(context).tax} (10%)',
                      // '${S.of(context).tax} (${widget.con.carts[0].food.restaurant.defaultTax}%)',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Helper.getPrice(appCon.App.cardMapData['taxAmount'], context, style: Theme.of(context).textTheme.subtitle1)
                  // Helper.getPrice(widget.con.taxAmount, context, style: Theme.of(context).textTheme.subtitle1)
                ],
              ),
              SizedBox(height: 10),
              Stack(
                fit: StackFit.loose,
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: FlatButton(
                      onPressed: () {

                        _con.goCheckout(context);

                        // Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentMethodsWidget()));

                        // Navigator.of(context).pushNamed('/Settings', arguments: RouteArgument(param: widget.routeArgument.param));

                        /*  if(_data.contains(true)) {
                          widget.con.goCheckout(context);
                        } else {
                          if(charity != "Select Charity") {
                            widget.con.scaffoldKey.currentState
                                ?.showSnackBar(SnackBar(
                              content: Text(S
                                  .of(context)
                                  .please_select_meal_for_charity),
                            ));
                          } else {
                            widget.con.goCheckout(context);
                          }
                        }*/

                      },
                      disabledColor: Theme.of(context).focusColor.withOpacity(0.5),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      color: Theme.of(context).accentColor,
                      // color: !widget.con.carts[0].food.restaurant.closed ? Theme.of(context).accentColor : Theme.of(context).focusColor.withOpacity(0.5),
                      shape: StadiumBorder(),
                      child: Text(
                        S.of(context).checkout,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Theme.of(context).primaryColor)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Helper.getPrice(
                      appCon.App.cardMapData['total'],
                      context,
                      style: Theme.of(context).textTheme.headline4.merge(TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).delivery_or_pickup,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
       /* actions: <Widget>[
          new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],*/
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  Icons.domain,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  S.of(context).pickup,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline4,
                ),
                subtitle: Text(
                  S.of(context).pickup_your_food_from_the_restaurant,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
            PickUpMethodItem(
                paymentMethod: _con.getPickUpMethod(),
                onPressed: (paymentMethod) {
                  _con.togglePickUp();
                }),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    leading: Icon(
                      Icons.map,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(
                      S.of(context).delivery,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    subtitle: _con.carts.isNotEmpty && Helper.canDelivery(_con.carts[0].food.restaurant, carts: _con.carts)
                        ? Text(
                            S.of(context).click_to_confirm_your_address_and_pay_or_long_press,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption,
                          )
                        : Text(
                            S.of(context).deliveryMethodNotAllowed,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption,
                          ),
                  ),
                ),
                _con.carts.isNotEmpty
                    // && Helper.canDelivery(_con.carts[0].food.restaurant, carts: _con.carts)
                    ? DeliveryAddressesItemWidget(
                        paymentMethod: _con.getDeliveryMethod(),
                        address: _con.deliveryAddress,
                        onPressed: (Address _address) {
                          if (_con.deliveryAddress.id == null || _con.deliveryAddress.id == 'null') {
                            DeliveryAddressDialog(
                              context: context,
                              address: _address,
                              onChanged: (Address _address) {
                                _con.addAddress(_address);
                              },
                            );
                          } else {
                            _con.toggleDelivery();
                          }
                        },
                        onLongPress: (Address _address) {
                          _con.toggleDelivery();
                          // DeliveryAddressDialog(
                          //   context: context,
                          //   address: _address,
                          //   onChanged: (Address _address) {
                          //     _con.updateAddress(_address);
                          //   },
                          // );
                        },
                      )
                    : NotDeliverableAddressesItemWidget()
              ],
            )
          ],
        ),
      ),
    );
  }
}

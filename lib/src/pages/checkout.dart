import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/elements/PaymentSettingsDialog.dart';
import 'package:food_delivery_app/src/models/credit_card.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/checkout_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/CreditCardsWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';

class CheckoutWidget extends StatefulWidget {
//  RouteArgument routeArgument;
//  CheckoutWidget({Key key, this.routeArgument}) : super(key: key);
  @override
  _CheckoutWidgetState createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends StateMVC<CheckoutWidget> {

  CreditCard creditCard;
  List<CreditCard> creditCardList = List();
  CheckoutController _con;

  _CheckoutWidgetState() : super(CheckoutController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForCarts();
    _con.customerGetApi();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).checkout,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: _con.carts.isEmpty
          ? CircularLoadingWidget(height: 400)
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 255),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            leading: Icon(
                              Icons.payment,
                              color: Theme.of(context).hintColor,
                            ),
                            title: Text(
                              S.of(context).payment_mode,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            subtitle: Text(
                              S.of(context).select_your_preferred_payment_mode,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        PaymentSettingsDialog(
                          creditCard: _con.creditCard,
                          isEdit: false,
                          onChanged: () {
                            _con.updateCreditCard(_con.creditCard);
                            creditCardList.add(_con.creditCard);
                            //setState(() {});
                          },
                        ),

                        SizedBox(height: 20),
                        CreditCardsWidget(
                            creditCard: _con.creditCard,
                            creditCardList: creditCardList,
                            onChanged: (creditCard) {
                              _con.updateCreditCard(creditCard);
                            }),
                        // creditCardShow(),
                        SizedBox(height: 40),
                        setting.value.payPalEnabled
                            ? Text(
                                S.of(context).or_checkout_with,
                                style: Theme.of(context).textTheme.caption,
                              )
                            : SizedBox(
                                height: 0,
                              ),
                        SizedBox(height: 40),
                        setting.value.payPalEnabled
                            ? SizedBox(
                                width: 320,
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacementNamed('/PayPal');
                                  },
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  color: Theme.of(context).focusColor.withOpacity(0.2),
                                  shape: StadiumBorder(),
                                  child: Image.asset(
                                    'assets/img/paypal2.png',
                                    height: 28,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 0,
                              ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                //bottom view show
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 255,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                              Helper.getPrice(_con.subTotal, context, style: Theme.of(context).textTheme.subtitle1)
                            ],
                          ),
                          SizedBox(height: 3),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  S.of(context).delivery_fee,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Helper.getPrice(_con.carts[0].food.restaurant.deliveryFee, context, style: Theme.of(context).textTheme.subtitle1)
                            ],
                          ),
                          SizedBox(height: 3),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "${S.of(context).tax} (${_con.carts[0].food.restaurant.defaultTax}%)",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Helper.getPrice(_con.taxAmount, context, style: Theme.of(context).textTheme.subtitle1)
                            ],
                          ),
                          Divider(height: 30),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  S.of(context).total,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Helper.getPrice(_con.total, context, style: Theme.of(context).textTheme.headline6)
                            ],
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: FlatButton(
                              onPressed: () {

                                // _con.stripAddPaymentApi();

                            /*    if (_con.creditCard.validated()) {
                                  Navigator.of(context).pushNamed('/OrderSuccess', arguments: new RouteArgument(param: 'Credit Card (Stripe Gateway)'));
                                } else {
                                  _con.scaffoldKey?.currentState?.showSnackBar(SnackBar(
                                    content: Text(S.of(context).your_credit_card_not_valid),
                                  ));
                                }*/
                              },
                              padding: EdgeInsets.symmetric(vertical: 14),
                              color: Theme.of(context).accentColor,
                              shape: StadiumBorder(),
                              child: Text(
                                S.of(context).confirm_payment,
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }


  // creditCardShow() {
  //   return Stack(
  //     alignment: AlignmentDirectional.topCenter,
  //     children: <Widget>[
  //       Container(
  //         width: 259,
  //         height: 165,
  //         decoration: BoxDecoration(
  //           color: Theme.of(context).primaryColor.withOpacity(0.8),
  //           borderRadius: BorderRadius.circular(10),
  //           boxShadow: [
  //             BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), blurRadius: 20, offset: Offset(0, 5)),
  //           ],
  //         ),
  //       ),
  //       Container(
  //         margin: EdgeInsets.only(top: 12),
  //         width: 275,
  //         height: 177,
  //         decoration: BoxDecoration(
  //           color: Theme.of(context).primaryColor.withOpacity(0.8),
  //           borderRadius: BorderRadius.circular(10),
  //           boxShadow: [
  //             BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), blurRadius: 20, offset: Offset(0, 5)),
  //           ],
  //         ),
  //       ),
  //       Container(
  //         margin: EdgeInsets.only(top: 25),
  //         width: 300,
  //         height: 195,
  //         decoration: BoxDecoration(
  //           color: Theme.of(context).primaryColor,
  //           borderRadius: BorderRadius.circular(10),
  //           boxShadow: [
  //             BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), blurRadius: 20, offset: Offset(0, 5)),
  //           ],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 21),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Image.asset(
  //                     'assets/img/visa.png',
  //                     height: 22,
  //                     width: 70,
  //                   ),
  //                   ButtonTheme(
  //                     padding: EdgeInsets.all(0),
  //                     minWidth: 50.0,
  //                     height: 10.0,
  //                     child: PaymentSettingsDialog(
  //                       creditCard: creditCard,
  //                       onChanged: () {
  //                         _con.updateCreditCard(creditCard);
  //                         setState(() {});
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Text(
  //                 S.of(context).card_number,
  //                 style: Theme.of(context).textTheme.caption,
  //               ),
  //               Text(
  //                 Helper.getCreditCardNumber(creditCard.number),
  //                 style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(letterSpacing: 1.4)),
  //               ),
  //               SizedBox(height: 15),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Text(
  //                     S.of(context).expiry_date,
  //                     style: Theme.of(context).textTheme.caption,
  //                   ),
  //                   Text(
  //                     S.of(context).cvv,
  //                     style: Theme.of(context).textTheme.caption,
  //                   ),
  //                 ],
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Text(
  //                     '${creditCard.expMonth}/${creditCard.expYear}',
  //                     style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(letterSpacing: 1.4)),
  //                   ),
  //                   Text(
  //                     creditCard.cvc,
  //                     style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(letterSpacing: 1.4)),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

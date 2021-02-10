import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/src/elements/PaymentSettingsDialog.dart';
import 'package:food_delivery_app/src/helpers/app_config.dart' as appCon;
import 'package:food_delivery_app/src/models/credit_card.dart';
import 'package:food_delivery_app/src/models/stripe_getcard_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/checkout_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../helpers/helper.dart';
import '../repository/settings_repository.dart';

class CheckoutWidget extends StatefulWidget {
//  RouteArgument routeArgument;
//  CheckoutWidget({Key key, this.routeArgument}) : super(key: key);
  @override
  _CheckoutWidgetState createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends StateMVC<CheckoutWidget> {

  CreditCard creditCard = CreditCard();
  // TempCardData tempCardData = TempCardData();
  // List<CreditCard> creditCardList = List();

  TextEditingController crExp = TextEditingController();
  TextEditingController crNumber = TextEditingController();
  TextEditingController crCvc = TextEditingController();

  int isSelectedIndex = -1;

  GlobalKey<FormState> _paymentSettingsFormKey = new GlobalKey<FormState>();

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

                        creditCardAlertOnShow(),
                       /* PaymentSettingsDialog (
                          creditCard: _con.creditCard,
                          isEdit: false,
                          onChanged: () {
                            _con.updateCreditCard(_con.creditCard);
                            creditCardList.add(_con.creditCard);
                            //setState(() {});
                          },
                        ),*/

                        SizedBox(height: 20),
                        creditCardShow(),
                       /* CreditCardsWidget(
                            creditCard: _con.creditCard,
                            creditCardList: creditCardList,
                            onChanged: (creditCard) {
                              _con.updateCreditCard(creditCard);
                            }),*/
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
                              Text(
                                "\$ ${appCon.App?.cardMapData['subTotal'] ?? "-"}",
                                style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(fontSize: 18)),
                              ),
                              // Helper.getPrice(_con.subTotal, context, style: Theme.of(context).textTheme.subtitle1)
                            ],
                          ),
                          SizedBox(height: 3),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  // appCon.App.cardMapData['subTotal'].toString(),
                                  S.of(context).delivery_fee,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Text(
                                "\$ ${appCon.App?.cardMapData['deliveryFee'] ?? "-"}",
                                style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(fontSize: 18)),
                              ),
                              // Helper.getPrice(_con.carts[0].food.restaurant.deliveryFee, context, style: Theme.of(context).textTheme.subtitle1)
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
                              Text(
                                "\$ ${appCon.App?.cardMapData['taxAmount'] ?? "-"}",
                                style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(fontSize: 18)),
                              ),
                              // Helper.getPrice(_con.taxAmount, context, style: Theme.of(context).textTheme.subtitle1)
                            ],
                          ),
                          Divider(height: 30),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  // appCon.App.cardMapData['total'].toString(),
                                  S.of(context).total,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Text(
                                "\$ ${appCon.App?.cardMapData['total'] ?? "-"}",
                                style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(fontSize: 18, color: Theme.of(context).accentColor)),
                              ),
                              // Helper.getPrice(_con.total, context, style: Theme.of(context).textTheme.headline6)
                            ],
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: FlatButton(
                              onPressed: () {

                                // _con.stripAddPaymentApi();

                                print(((_con.total * 100).toInt()).toString());
                                if(isSelectedIndex != -1) {
                                  if(_con.rememberAllCardShow[isSelectedIndex].data[0].id != null &&
                                      _con.rememberAllCardShow[isSelectedIndex].data[0].id != "") {
                                    _con.stripePayApi(_con.rememberAllCardShow[isSelectedIndex].data[0].customer,
                                        _con.rememberAllCardShow[isSelectedIndex].data[0].id, _con.rememberAllCardShow[isSelectedIndex].data[0].isRemember);
                                  } else {
                                    _con.stripAddPaymentApi(_con.rememberAllCardShow[isSelectedIndex]);
                                  }
                                } else {
                                  Fluttertoast.showToast(msg: "Please Select Card");
                                }


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


  creditCardAlertOnShow() {
    return FlatButton(
      onPressed: () async {
        showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return  SimpleDialog(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.person),
                        SizedBox(width: 10),
                        Text(
                          S.of(context).payment_settings,
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      ],
                    ),
                    children: <Widget>[
                      Form(
                        key: _paymentSettingsFormKey,
                        child: Column(
                          children: <Widget>[
                            new TextFormField(
                              style: TextStyle(color: Theme.of(context).hintColor),
                              keyboardType: TextInputType.number,
                              controller: crNumber,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                new LengthLimitingTextInputFormatter(16),
                              ],
                              decoration: getInputDecoration(hintText: '•••• •••• •••• ••••', labelText: S.of(context).number),
                              // initialValue: creditCard.number.isNotEmpty ? creditCard.number : null,
                              validator: (input) => input.trim().length != 16 ? S.of(context).not_a_valid_number : null,
                              onSaved: (input) => creditCard.number = input,
                            ),
                            new TextFormField(
                                style: TextStyle(color: Theme.of(context).hintColor),
                                keyboardType: TextInputType.datetime,
                                controller: crExp,
                                inputFormatters: [
                                  // FilteringTextInputFormatter.digitsOnly,
                                  new LengthLimitingTextInputFormatter(5),
                                ],
                                decoration: getInputDecoration(hintText: 'mm/yy', labelText: S.of(context).exp_date),
                                // initialValue: creditCard.expMonth.isNotEmpty ? creditCard.expMonth + '/' + creditCard.expYear : null,
                                onChanged: (s) {
                                  if(s.length==2 && !s.contains('/')){
                                    crExp.text = s+'/';
                                    crExp.selection = TextSelection.fromPosition(TextPosition(offset: crExp.text.length));
                                  }
                                },
                                // TODO validate date
                                validator: (input) => input.length != 5 ? S.of(context).not_a_valid_date : null,
                                onSaved: (input) {
                                  creditCard.expMonth = input.split('/').elementAt(0);
                                  creditCard.expYear = input.split('/').elementAt(1);
                                }),
                            new TextFormField(
                              style: TextStyle(color: Theme.of(context).hintColor),
                              keyboardType: TextInputType.number,
                              controller: crCvc,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                new LengthLimitingTextInputFormatter(3),
                              ],
                              decoration: getInputDecoration(hintText: '•••', labelText: S.of(context).cvc),
                              // initialValue: creditCard.cvc.isNotEmpty ? creditCard.cvc : null,
                              validator: (input) => input.trim().length != 3 ? S.of(context).not_a_valid_cvc : null,
                              onSaved: (input) => creditCard.cvc = input,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row (
                          children: [
                            Checkbox (
                              value: _con.isRemember,
                              onChanged: (bool newValue) {
                                setState(() {
                                  // _con.rememberAllCardShow[0].data[0].isRemember = newValue;
                                  _con.isRemember = newValue;
                                });
                              },
                            ),
                            Text("Remember Card", style: TextStyle(fontSize: 15))
                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {

                              Navigator.pop(context, false);
                            },
                            child: Text(S.of(context).cancel),
                          ),
                          MaterialButton(
                            onPressed: _submit,
                            child: Text(
                              S.of(context).add,
                              style: TextStyle(color: Theme.of(context).accentColor),
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                } ,
              );
            });
      },
      child:
      /*widget.isEdit ?
      Text(
        S.of(context).edit,
        style: Theme.of(context).textTheme.bodyText2,
      ) :*/
      Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            shape: BoxShape.circle
        ),
        child: Column(
          children: [
            Icon(Icons.add, color: Theme.of(context).primaryColor, size: 30),
            Text( S.of(context).add,
                style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor)),
          ],
        ),
      ),
    );
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Theme.of(context).focusColor)),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor)),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: Theme.of(context).textTheme.bodyText2.merge(
        TextStyle(color: Theme.of(context).hintColor),
      ),
    );
  }

  void _submit() {
    // if (_paymentSettingsFormKey.currentState.validate()) {
      print("helloo");
      CreditCard creditCard1 = CreditCard();

      creditCard1.number = crNumber.text;
      creditCard1.expMonth = crExp.text.split('/').elementAt(0);
      creditCard1.expYear = crExp.text.split('/').elementAt(1);
      creditCard1.cvc = crCvc.text;

      // _con.creditCardList.add(creditCard1);

      StripeGetCardModel stripeGetCardModel = StripeGetCardModel();

      stripeGetCardModel.object = "list";
      stripeGetCardModel.hasMore =  false;
      stripeGetCardModel.data = List();

      CardData cardData = CardData();
      cardData.last4 = crNumber.text.substring(crNumber.text.length - 4, crNumber.text.length);
      cardData.cardAllNumber = crNumber.text;
      print(cardData.last4);
      cardData.cvcNumber = crCvc.text;
      cardData.expMonth = int.parse(crExp.text.split('/').elementAt(0));
      cardData.expYear = int.parse(crExp.text.split('/').elementAt(1));
      cardData.isRemember = _con.isRemember;
      stripeGetCardModel.data.insert(0, cardData);
      _con.rememberAllCardShow.insert(0, stripeGetCardModel);


      crNumber.clear();
      crExp.clear();
      crCvc.clear();

      setState((){});

      // _con.stripAddPaymentApi();

      // _paymentSettingsFormKey.currentState.save();
      // widget.onChanged();
      Navigator.pop(context, true);
    // }
  }



  creditCardShow() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 10),
      // height: MediaQuery.of(context).size.height / 2,
      child: _con.rememberAllCardShow == null && _con.rememberAllCardShow.isEmpty ? Container() : ListView.builder (
          itemCount: _con.rememberAllCardShow != null && _con.rememberAllCardShow.isNotEmpty  ? _con.rememberAllCardShow.length : 0,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {

            return Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                // Container(
                //   width: 259,
                //   height: 165,
                //   decoration: BoxDecoration(
                //     color: Theme.of(context).primaryColor.withOpacity(0.8),
                //     borderRadius: BorderRadius.circular(10),
                //     boxShadow: [
                //       BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), blurRadius: 20, offset: Offset(0, 5)),
                //     ],
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(top: 12),
                //   width: 275,
                //   height: 177,
                //   decoration: BoxDecoration(
                //     color: Theme.of(context).primaryColor.withOpacity(0.8),
                //     borderRadius: BorderRadius.circular(10),
                //     boxShadow: [
                //       BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), blurRadius: 20, offset: Offset(0, 5)),
                //     ],
                //   ),
                // ),

                InkResponse(
                  onTap: () {
                    print("hello");
                    isSelectedIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 25),
                    width: 330,
                    height: isSelectedIndex == index ? 220 : 200,
                    decoration: BoxDecoration(
                      color: isSelectedIndex == index ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 5),),
                        // isSelectedIndex == index ? Theme.of(context).accentColor.withOpacity(0.5) :
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 21),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                      /*    isSelectedIndex == index ? Align(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.check, color: Theme.of(context).accentColor),
                          ) : Container(),*/

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Image.asset(
                                'assets/img/visa.png',
                                height: 22,
                                width: 70,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  Container(
                                    margin: EdgeInsets.only(top: 50),
                                  ),
                                 /* ButtonTheme(
                                    padding: EdgeInsets.all(0),
                                    minWidth: 30.0,
                                    height: 10.0,
                                    child: PaymentSettingsDialog(
                                      creditCard: creditCard,
                                      isEdit: true,
                                      onChanged: () {
                                        // onChanged(widget.creditCard);
                                        //setState(() {});
                                      },
                                    ),
                                  ),*/
                                  InkWell(
                                      onTap: () {
                                        _con.deleteCardData(_con.rememberAllCardShow[index].data[0].customer, _con.rememberAllCardShow[index].data[0].id);
                                        _con.rememberAllCardShow.removeAt(index);
                                        setState(() { });
                                      },
                                      child: Icon(Icons.delete, color: isSelectedIndex == index ? Colors.white : Colors.black38))
                                      // child: Text('delete', style: TextStyle(color: isSelectedIndex == index ? Colors.white : Colors.black38)/*Theme.of(context).textTheme.bodyText2*/,))
                                ],
                              )
                            ],
                          ),
                          Text(
                            " ******** ${_con.rememberAllCardShow[index].data[0].last4 ?? ""} ",
                            // S.of(context).card_number,
                            style: Theme.of(context).textTheme.caption.merge(TextStyle(color: isSelectedIndex == index ? Colors.white : Colors.black38)),
                          ),
                          Text(
                            Helper.getCreditCardNumber(creditCard.number),
                            style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(letterSpacing: 1.4, color: isSelectedIndex == index ? Colors.white : Colors.black38)),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                S.of(context).expiry_date,
                                style: Theme.of(context).textTheme.caption.merge(TextStyle(color: isSelectedIndex == index ? Colors.white : Colors.black38)),
                              ),
                              Text(
                                S.of(context).cvv,
                                style: Theme.of(context).textTheme.caption.merge(TextStyle(color: isSelectedIndex == index ? Colors.white : Colors.black38)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                // '${widget.creditCard.expMonth}/${widget.creditCard.expYear}',
                                // "${_con.creditCardList[index].expMonth}/${_con.creditCardList[index].expYear}",
                                "${_con.rememberAllCardShow[index].data[0].expMonth}/${_con.rememberAllCardShow[index].data[0].expYear}",
                                style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(letterSpacing: 1.4, color: isSelectedIndex == index ? Colors.white : Colors.black)),
                              ),
                              Text(
                                // widget.creditCard.cvc,
                                // _con.creditCardList[index].cvc,
                                "***",
                                style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(letterSpacing: 1.4, color: isSelectedIndex == index ? Colors.white : Colors.black)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            );
          }),
    );
  }
}

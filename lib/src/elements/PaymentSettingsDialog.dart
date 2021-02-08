import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/src/controllers/stripe_payment_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../models/credit_card.dart';

// ignore: must_be_immutable
class PaymentSettingsDialog extends StatefulWidget {
  CreditCard creditCard;
  VoidCallback onChanged;
  bool isEdit = false;
  PaymentSettingsDialog({Key key, this.creditCard, this.onChanged, this.isEdit}) : super(key: key);

  @override
  _PaymentSettingsDialogState createState() => _PaymentSettingsDialogState();
}

class _PaymentSettingsDialogState extends StateMVC<PaymentSettingsDialog> {
  GlobalKey<FormState> _paymentSettingsFormKey = new GlobalKey<FormState>();
  // TextEditingController exp = TextEditingController();
  TextEditingController crNumber = TextEditingController();
  TextEditingController crExp = TextEditingController();
  TextEditingController crCvc = TextEditingController();

  StripePaymentController _con;
  _PaymentSettingsDialogState() : super(StripePaymentController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(!widget.isEdit) {
      widget.creditCard.number = "";
      widget.creditCard.expMonth = "";
      widget.creditCard.expYear = "";
      widget.creditCard.cvc = "";
      setState(() { });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                              // controller: crNumber,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                new LengthLimitingTextInputFormatter(16),
                              ],
                              decoration: getInputDecoration(hintText: '4242 4242 4242 4242', labelText: S.of(context).number),
                              initialValue: widget.creditCard.number.isNotEmpty ? widget.creditCard.number : null,
                              validator: (input) => input.trim().length != 16 ? S.of(context).not_a_valid_number : null,
                              onSaved: (input) => widget.creditCard.number = input,
                            ),
                            new TextFormField(
                                style: TextStyle(color: Theme.of(context).hintColor),
                                keyboardType: TextInputType.datetime,
                                // controller: crExp,
                                inputFormatters: [
                                  // FilteringTextInputFormatter.digitsOnly,
                                  new LengthLimitingTextInputFormatter(5),
                                ],
                                decoration: getInputDecoration(hintText: 'mm/yy', labelText: S.of(context).exp_date),
                                initialValue: widget.creditCard.expMonth.isNotEmpty ? widget.creditCard.expMonth + '/' + widget.creditCard.expYear : null,
                                onChanged: (s) {
                                  if(s.length==2 && !s.contains('/')){
                                    crExp.text = s+'/';
                                    crExp.selection = TextSelection.fromPosition(TextPosition(offset: crExp.text.length));
                                  }
                                },
                                // TODO validate date
                                validator: (input) => input.length != 5 ? S.of(context).not_a_valid_date : null,
                                onSaved: (input) {
                                  widget.creditCard.expMonth = input.split('/').elementAt(0);
                                  widget.creditCard.expYear = input.split('/').elementAt(1);
                                }),
                            new TextFormField(
                              style: TextStyle(color: Theme.of(context).hintColor),
                              keyboardType: TextInputType.number,
                              // controller: crCvc,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                new LengthLimitingTextInputFormatter(3),
                              ],
                              decoration: getInputDecoration(hintText: '253', labelText: S.of(context).cvc),
                              initialValue: widget.creditCard.cvc.isNotEmpty ? widget.creditCard.cvc : null,
                              validator: (input) => input.trim().length != 3 ? S.of(context).not_a_valid_cvc : null,
                              onSaved: (input) => widget.creditCard.cvc = input,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Checkbox(
                              value: _con.isRemember,
                              onChanged: (bool newValue) {
                                setState(() {
                                  // widget.creditCard.isRemember = true;
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
                              S.of(context).save,
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
      child: widget.isEdit ?
      Text(
        S.of(context).edit,
        style: Theme.of(context).textTheme.bodyText2,
      ) :
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
    return new InputDecoration(
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
    if (_paymentSettingsFormKey.currentState.validate()) {

      _con.creditCard.number = crNumber.text;
      _con.creditCard.expMonth = crExp.text.split('/').elementAt(0);
      _con.creditCard.expYear = crExp.text.split('/').elementAt(1);
      _con.creditCard.cvc = crCvc.text;
      _con.stripAddPaymentApi();

      _paymentSettingsFormKey.currentState.save();
      widget.onChanged();
      Navigator.pop(context, true);
    }
  }
}

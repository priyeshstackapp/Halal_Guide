import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../elements/PaymentSettingsDialog.dart';
import '../helpers/helper.dart';
import '../models/credit_card.dart';

// ignore: must_be_immutable
class CreditCardsWidget extends StatefulWidget {
  CreditCard creditCard;
  ValueChanged<CreditCard> onChanged;
  List creditCardList;
  CreditCardsWidget({
    this.creditCard,
    this.onChanged,
    this.creditCardList,
    Key key,
  }) : super(key: key);

  @override
  _CreditCardsWidgetState createState() => _CreditCardsWidgetState();
}

class _CreditCardsWidgetState extends State<CreditCardsWidget> {
  int isSelectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 10),
      // height: MediaQuery.of(context).size.height / 2,
      child: ListView.builder (
          itemCount: widget.creditCardList != null && widget.creditCardList.isNotEmpty  ? widget.creditCardList.length : 0,
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
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), blurRadius: 20, offset: Offset(0, 5)),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      isSelectedIndex == index ? Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.check, color: Theme.of(context).accentColor),
                      ) : Container(),

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
                           ButtonTheme(
                             padding: EdgeInsets.all(0),
                             minWidth: 30.0,
                             height: 10.0,
                             child: PaymentSettingsDialog(
                               creditCard: widget.creditCard,
                               isEdit: true,
                               onChanged: () {
                                 widget.onChanged(widget.creditCard);
                                 //setState(() {});
                               },
                             ),
                           ),
                           Text('delete', style: Theme.of(context).textTheme.bodyText2,)
                         ],
                       )
                        ],
                      ),
                      Text(
                        widget.creditCardList[index].number,
                        // S.of(context).card_number,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        Helper.getCreditCardNumber(widget.creditCard.number),
                        style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(letterSpacing: 1.4)),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            S.of(context).expiry_date,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(
                            S.of(context).cvv,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            // '${widget.creditCard.expMonth}/${widget.creditCard.expYear}',
                            "${widget.creditCardList[index].expMonth}/${widget.creditCardList[index].expYear}",
                            style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(letterSpacing: 1.4)),
                          ),
                          Text(
                            // widget.creditCard.cvc,
                            widget.creditCardList[index].cvc,
                            style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(letterSpacing: 1.4)),
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

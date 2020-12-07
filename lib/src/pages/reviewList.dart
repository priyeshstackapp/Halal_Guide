import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../controllers/reviews_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ReviewList extends StatefulWidget {
  final RouteArgument routeArgument;

  ReviewList({Key key, this.routeArgument}) : super(key: key);

  @override
  _ReviewsWidgetState createState() {
    return _ReviewsWidgetState();
  }
}

class _ReviewsWidgetState extends StateMVC<ReviewList> {
  ReviewsController _con;

  _ReviewsWidgetState() : super(ReviewsController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForRestaurant(id: widget.routeArgument.id);
    _con.listenForRestaurantReviews(id: widget.routeArgument.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        body: _con.restaurant == null
            ? CircularLoadingWidget(height: 500)
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Hero(
                                  tag: widget.routeArgument.heroTag +
                                      _con.restaurant.id,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: _con.restaurant.image.url,
                                    placeholder: (context, url) => Image.asset(
                                      'assets/img/loading.gif',
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              width: 110,
                              child: Chip(
                                padding: EdgeInsets.all(10),
                                label: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(_con.restaurant.rate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3
                                            .merge(TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor))),
                                    Icon(
                                      Icons.star_border,
                                      color: Theme.of(context).primaryColor,
                                      size: 30,
                                    ),
                                  ],
                                ),
                                backgroundColor: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.9),
                                shape: StadiumBorder(),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 30,
                          left: 15,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      _con.restaurant.name,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    _con.reviews.isEmpty ? Container() : Container(
                      width: MediaQuery.of(context).size.width,
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.15),
                                offset: Offset(0, -2),
                                blurRadius: 5.0)
                          ]),
                      child: ListView.builder(
                        itemCount: _con.reviews.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.15),
                                    offset: Offset(0, -2),
                                    blurRadius: 5.0)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Text("${_con.reviews[index].user.name}"),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Row(
                                    children: Helper.getStarsList(double.parse(_con.reviews[index].rate)),
                                  ),
                                  SizedBox(width: 20,),
                                  Text("${_con.reviews[index].review??" "}"),
                                ],
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ));
  }
}

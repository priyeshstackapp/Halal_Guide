import 'dart:convert';
import 'package:food_delivery_app/src/helpers/app_config.dart';
import 'package:food_delivery_app/src/models/review_imgupl_response_model.dart';
import 'package:food_delivery_app/src/models/stripe_addcard_model.dart';
import 'package:food_delivery_app/src/models/stripe_customerId_model.dart';
import 'package:food_delivery_app/src/models/stripe_customer_pay_model.dart';
import 'package:food_delivery_app/src/models/stripe_getcard_model.dart';
import 'package:food_delivery_app/src/models/stripe_web_customerid_get_model.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import '../helpers/custom_trace.dart';
import '../repository/user_repository.dart' as userRepo;
import '../../src/helpers/app_config.dart' as config;

Future<CustomerStripeId> getCustomerId() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}user_card?api_token=${userRepo.currentUser.value.apiToken}';
  print(url);
  http.Response response;
  try {
    print(App.publicKey());
    response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      return CustomerStripeId.fromJson(json.decode(response.body));
      // return Review.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return CustomerStripeId.fromJson({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return CustomerStripeId.fromJson({});
  }
}

Future<CustomerStripeIdAdd> postCustomerId(String cardId) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}user_card?api_token=${userRepo.currentUser.value.apiToken}';
  print(url);
  http.Response response;//cus_Ir0i2ECxFJaTHl
  try {
    print(App.publicKey());
    response = await http.post(url, body: {'card_id': cardId});
    if (response.statusCode == 200) {
      print(response.body);
      return CustomerStripeIdAdd.fromJson(json.decode(response.body));
      // return Review.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return CustomerStripeIdAdd.fromJson({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return CustomerStripeIdAdd.fromJson({});
  }
}

Future<DeleteCustomerIdModel> deleteCustomerId(String cardId) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}delete_user_card?api_token=${userRepo.currentUser.value.apiToken}';
  print(url);
  http.Response response;
  try {
    print(App.publicKey());
    response = await http.get(url, headers: {'card_id': cardId});
    if (response.statusCode == 200) {
      print(response.body);
      return DeleteCustomerIdModel.fromJson(json.decode(response.body));
      // return Review.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return DeleteCustomerIdModel.fromJson({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return DeleteCustomerIdModel.fromJson({});
  }
}


Future<StripeAddCardModel> postAddCardDetailsApi(Map<String, dynamic> finalMap) async {

  final String url = '${GlobalConfiguration().getString('stripe_payment_url')}v1/tokens';
  print(url);
  // final client = new http.Client();
  http.Response response;
  try {
    // print(App.publicKey());
    response = await http.post(url, headers: {'Authorization': "${App.publicKey()}"}, body: finalMap);
    // final response = await client.post(
    //   url,
    //   headers: {HttpHeaders.authorizationHeader: App.publicKey()},
    //   // {HttpHeaders.contentTypeHeader: 'application/json'},
    //   body: jsonEncode(finalMap,
    // );
    if (response.statusCode == 200) {
      print(response.body);
      return StripeAddCardModel.fromJson(json.decode(response.body));
      // return Review.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return StripeAddCardModel.fromJson({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: e).toString());
    return StripeAddCardModel.fromJson({});
  }
}


//customer id token
Future<CustomerIdModel> postCustomerIdGet(Map<String, dynamic> finalMap) async {

  final String url = '${GlobalConfiguration().getString('stripe_payment_url')}v1/customers';
  print(url);

  // final client = new http.Client();
  http.Response response;

  try {
    print(App.publicKey());
    response = await http.post(url, headers: {'Authorization': "${App.secretKey()}"}, body: finalMap);
    if (response.statusCode == 200) {
      print(response.body);
      return CustomerIdModel.fromJson(json.decode(response.body));
      // return Review.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return CustomerIdModel.fromJson({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return CustomerIdModel.fromJson({});
  }
}


//stripe pay api

Future<CustomerPayModel> postStripeApi(Map<String, dynamic> finalMap) async {

  final String url = '${GlobalConfiguration().getString('stripe_payment_url')}v1/charges';
  print(url);

  // ?amount=${finalMap['amount']}'
  // '&currency=${finalMap['currency']}'
  // '&customer=${finalMap['customer']}'
  // '&description=${finalMap['description']}

  http.Response response;

  try {
    print(App.publicKey());
    response = await http.post(url, headers: {'Authorization': "${App.secretKey()}",
      // 'Content-Type':'application/x-www-form-urlencoded; charset=utf-8',
      // "Accept": "application/json",
      // "Content-Type": "application/x-www-form-urlencoded"
    }, body: finalMap

    );
    if (response.statusCode == 200) {
      print(response.body);
      return CustomerPayModel.fromJson(json.decode(response.body));
      // return Review.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return CustomerPayModel.fromJson({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: e).toString());
    return CustomerPayModel.fromJson({});
  }
}


Future<StripeGetCardModel> getCardApi(String cardId) async {

  final String url = '${GlobalConfiguration().getString('stripe_payment_url')}v1/customers/$cardId/sources';
  print(url);
  // final client = new http.Client();
  http.Response response;
  try {
    response = await http.get(url, headers: {'Authorization': "${App.secretKey()}"});
    if (response.statusCode == 200) {
      print(response.body);
      return StripeGetCardModel.fromJson(json.decode(response.body));
      // return Review.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return StripeGetCardModel.fromJson({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return StripeGetCardModel.fromJson({});
  }
}


Future<StripeGetCardModel> deleteCardApi(String customerId,String cardId) async {

  final String url = '${GlobalConfiguration().getString('stripe_payment_url')}v1/customers/$customerId/sources/$cardId';

  print(url);
  // final client = new http.Client();

  http.Response response;
  try {
    response = await http.delete(url, headers: {'Authorization': "${App.secretKey()}"});
    if (response.statusCode == 200) {
      print(response.body);
      return StripeGetCardModel.fromJson(json.decode(response.body));
      // return Review.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return StripeGetCardModel.fromJson({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return StripeGetCardModel.fromJson({});
  }
}



class CustomerStripeId {
  bool success;
  List<Data> data;
  String message;

  CustomerStripeId({this.success, this.data, this.message});

  CustomerStripeId.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int userId;
  String cardId;

  Data({this.userId, this.cardId});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    cardId = json['card_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['card_id'] = this.cardId;
    return data;
  }
}



class CustomerStripeIdAdd {
  bool success;
  Data Data1;
  String message;

  CustomerStripeIdAdd({this.success, this.Data1, this.message});

  CustomerStripeIdAdd.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    Data1 = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.Data1 != null) {
      data['data'] = this.Data1.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data1 {
  int userId;
  String cardId;
  int id;

  Data1({this.userId, this.cardId, this.id});

  Data1.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    cardId = json['card_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['card_id'] = this.cardId;
    data['id'] = this.id;
    return data;
  }
}



//delete customer id

class DeleteCustomerIdModel {
  bool success;
  int data;
  String message;

  DeleteCustomerIdModel({this.success, this.data, this.message});

  DeleteCustomerIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}


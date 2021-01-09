class RegisterRestaurantsData {
  String name;
  String description;
  String address;
  String latitude;
  String longitude;
  String phone;
  String mobile;
  String information;
  int deliveryFee;
  int deliveryRange;
  int defaultTax;
  bool availableForDelivery;
  bool closed;
  String open24x7;
  String updatedAt;
  String createdAt;
  int id;
  List<dynamic> customFields;
  bool hasMedia;
  String rate;
  List<dynamic> media;

  RegisterRestaurantsData(
      {this.name,
        this.description,
        this.address,
        this.latitude,
        this.longitude,
        this.phone,
        this.mobile,
        this.information,
        this.deliveryFee,
        this.deliveryRange,
        this.defaultTax,
        this.availableForDelivery,
        this.closed,
        this.open24x7,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.customFields,
        this.hasMedia,
        this.rate,
        this.media});

  RegisterRestaurantsData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phone = json['phone'];
    mobile = json['mobile'];
    information = json['information'];
    deliveryFee = json['delivery_fee'];
    deliveryRange = json['delivery_range'];
    defaultTax = json['default_tax'];
    availableForDelivery = json['available_for_delivery'];
    closed = json['closed'];
    open24x7 = json['open_24x7'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    customFields = json['custom_fields'] != null ? json['custom_fields'].cast<String>() : null;
    hasMedia = json['has_media'];
    rate = json['rate'] != null ? json['rate'] : null;
    media = json['media'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['information'] = this.information;
    data['delivery_fee'] = this.deliveryFee;
    data['delivery_range'] = this.deliveryRange;
    data['default_tax'] = this.defaultTax;
    data['available_for_delivery'] = this.availableForDelivery;
    data['closed'] = this.closed;
    data['open_24x7'] = this.open24x7;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['custom_fields'] = this.customFields;
    data['has_media'] = this.hasMedia;
    data['rate'] = this.rate;
    data['media'] = this.media;
    return data;
  }
}
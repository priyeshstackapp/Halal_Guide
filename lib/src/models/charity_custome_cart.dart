class CharityCustomCartModel {
  bool success;
  List<Data> data;
  String message;

  CharityCustomCartModel({this.success, this.data, this.message});

  CharityCustomCartModel.fromJson(Map<String, dynamic> json) {
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
  int id;
  int foodId;
  int userId;
  int quantity;
  String createdAt;
  String updatedAt;
  List<String> customFields;
  Food food;
  List<String> extras;
  int charityId;
  String charityName;
  int amount;

  Data(
      {this.id,
        this.foodId,
        this.userId,
        this.quantity,
        this.createdAt,
        this.updatedAt,
        this.customFields,
        this.food,
        this.extras,
        this.charityId,
        this.charityName,
        this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodId = json['food_id'];
    userId = json['user_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customFields = json['custom_fields'].cast<String>();
    food = json['food'] != null ? new Food.fromJson(json['food']) : null;
    extras = json['extras'].cast<String>();
    charityId = json['charity_id'];
    charityName = json['charity_name'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['food_id'] = this.foodId;
    data['user_id'] = this.userId;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['custom_fields'] = this.customFields;
    if (this.food != null) {
      data['food'] = this.food.toJson();
    }
    data['extras'] = this.extras;
    data['charity_id'] = this.charityId;
    data['charity_name'] = this.charityName;
    data['amount'] = this.amount;
    return data;
  }
}

class Food {
  int id;
  String name;
  int price;
  Null discountPrice;
  String description;
  String ingredients;
  String packageItemsCount;
  String weight;
  String unit;
  bool featured;
  bool deliverable;
  int restaurantId;
  int categoryId;
  String createdAt;
  String updatedAt;
  List<String> customFields;
  bool hasMedia;
  Restaurant restaurant;
  List<Media> media;

  Food(
      {this.id,
        this.name,
        this.price,
        this.discountPrice,
        this.description,
        this.ingredients,
        this.packageItemsCount,
        this.weight,
        this.unit,
        this.featured,
        this.deliverable,
        this.restaurantId,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
        this.customFields,
        this.hasMedia,
        this.restaurant,
        this.media});

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discountPrice = json['discount_price'];
    description = json['description'];
    ingredients = json['ingredients'];
    packageItemsCount = json['package_items_count'];
    weight = json['weight'];
    unit = json['unit'];
    featured = json['featured'];
    deliverable = json['deliverable'];
    restaurantId = json['restaurant_id'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customFields = json['custom_fields'].cast<String>();
    hasMedia = json['has_media'];
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
    if (json['media'] != null) {
      media = new List<Media>();
      json['media'].forEach((v) {
        media.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['description'] = this.description;
    data['ingredients'] = this.ingredients;
    data['package_items_count'] = this.packageItemsCount;
    data['weight'] = this.weight;
    data['unit'] = this.unit;
    data['featured'] = this.featured;
    data['deliverable'] = this.deliverable;
    data['restaurant_id'] = this.restaurantId;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['custom_fields'] = this.customFields;
    data['has_media'] = this.hasMedia;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
    if (this.media != null) {
      data['media'] = this.media.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurant {
  int id;
  String name;
  String description;
  String address;
  String latitude;
  String longitude;
  String phone;
  String mobile;
  String information;
  int adminCommission;
  String deliveryFee;
  String deliveryRange;
  int defaultTax;
  bool closed;
  bool active;
  bool availableForDelivery;
  bool availableForPickup;
  bool verifiedHalal;
  String createdAt;
  String updatedAt;
  String sundayStartHour;
  String sundayEndHour;
  String mondayStartHour;
  String mondayEndHour;
  String tuesdayStartHour;
  String tuesdayEndHour;
  String wednesdayStartHour;
  String wednesdayEndHour;
  String thursdayStartHour;
  String thursdayEndHour;
  String fridayStartHour;
  String fridayEndHour;
  String saturdayStartHour;
  String saturdayEndHour;
  String open24x7;
  List<String> customFields;
  bool hasMedia;
  String rate;
  List<Media> media;

  Restaurant(
      {this.id,
        this.name,
        this.description,
        this.address,
        this.latitude,
        this.longitude,
        this.phone,
        this.mobile,
        this.information,
        this.adminCommission,
        this.deliveryFee,
        this.deliveryRange,
        this.defaultTax,
        this.closed,
        this.active,
        this.availableForDelivery,
        this.availableForPickup,
        this.verifiedHalal,
        this.createdAt,
        this.updatedAt,
        this.sundayStartHour,
        this.sundayEndHour,
        this.mondayStartHour,
        this.mondayEndHour,
        this.tuesdayStartHour,
        this.tuesdayEndHour,
        this.wednesdayStartHour,
        this.wednesdayEndHour,
        this.thursdayStartHour,
        this.thursdayEndHour,
        this.fridayStartHour,
        this.fridayEndHour,
        this.saturdayStartHour,
        this.saturdayEndHour,
        this.open24x7,
        this.customFields,
        this.hasMedia,
        this.rate,
        this.media});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phone = json['phone'];
    mobile = json['mobile'];
    information = json['information'];
    adminCommission = json['admin_commission'];
    deliveryFee = json['delivery_fee'];
    deliveryRange = json['delivery_range'];
    defaultTax = json['default_tax'];
    closed = json['closed'];
    active = json['active'];
    availableForDelivery = json['available_for_delivery'];
    availableForPickup = json['available_for_pickup'];
    verifiedHalal = json['verified_halal'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sundayStartHour = json['sunday_start_hour'];
    sundayEndHour = json['sunday_end_hour'];
    mondayStartHour = json['monday_start_hour'];
    mondayEndHour = json['monday_end_hour'];
    tuesdayStartHour = json['tuesday_start_hour'];
    tuesdayEndHour = json['tuesday_end_hour'];
    wednesdayStartHour = json['wednesday_start_hour'];
    wednesdayEndHour = json['wednesday_end_hour'];
    thursdayStartHour = json['thursday_start_hour'];
    thursdayEndHour = json['thursday_end_hour'];
    fridayStartHour = json['friday_start_hour'];
    fridayEndHour = json['friday_end_hour'];
    saturdayStartHour = json['saturday_start_hour'];
    saturdayEndHour = json['saturday_end_hour'];
    open24x7 = json['open_24x7'];
    customFields = json['custom_fields'].cast<String>();
    hasMedia = json['has_media'];
    rate = json['rate'];
    if (json['media'] != null) {
      media = new List<Media>();
      json['media'].forEach((v) {
        media.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['information'] = this.information;
    data['admin_commission'] = this.adminCommission;
    data['delivery_fee'] = this.deliveryFee;
    data['delivery_range'] = this.deliveryRange;
    data['default_tax'] = this.defaultTax;
    data['closed'] = this.closed;
    data['active'] = this.active;
    data['available_for_delivery'] = this.availableForDelivery;
    data['available_for_pickup'] = this.availableForPickup;
    data['verified_halal'] = this.verifiedHalal;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['sunday_start_hour'] = this.sundayStartHour;
    data['sunday_end_hour'] = this.sundayEndHour;
    data['monday_start_hour'] = this.mondayStartHour;
    data['monday_end_hour'] = this.mondayEndHour;
    data['tuesday_start_hour'] = this.tuesdayStartHour;
    data['tuesday_end_hour'] = this.tuesdayEndHour;
    data['wednesday_start_hour'] = this.wednesdayStartHour;
    data['wednesday_end_hour'] = this.wednesdayEndHour;
    data['thursday_start_hour'] = this.thursdayStartHour;
    data['thursday_end_hour'] = this.thursdayEndHour;
    data['friday_start_hour'] = this.fridayStartHour;
    data['friday_end_hour'] = this.fridayEndHour;
    data['saturday_start_hour'] = this.saturdayStartHour;
    data['saturday_end_hour'] = this.saturdayEndHour;
    data['open_24x7'] = this.open24x7;
    data['custom_fields'] = this.customFields;
    data['has_media'] = this.hasMedia;
    data['rate'] = this.rate;
    if (this.media != null) {
      data['media'] = this.media.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Media {
  int id;
  String modelType;
  int modelId;
  String collectionName;
  String name;
  String fileName;
  String mimeType;
  String disk;
  int size;
  List<String> manipulations;
  CustomProperties customProperties;
  List<String> responsiveImages;
  int orderColumn;
  String createdAt;
  String updatedAt;
  String url;
  String thumb;
  String icon;
  String formatedSize;

  Media(
      {this.id,
        this.modelType,
        this.modelId,
        this.collectionName,
        this.name,
        this.fileName,
        this.mimeType,
        this.disk,
        this.size,
        this.manipulations,
        this.customProperties,
        this.responsiveImages,
        this.orderColumn,
        this.createdAt,
        this.updatedAt,
        this.url,
        this.thumb,
        this.icon,
        this.formatedSize});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    size = json['size'];
    manipulations = json['manipulations'].cast<String>();
    customProperties = json['custom_properties'] != null
        ? new CustomProperties.fromJson(json['custom_properties'])
        : null;
    responsiveImages = json['responsive_images'].cast<String>();
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
    thumb = json['thumb'];
    icon = json['icon'];
    formatedSize = json['formated_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    data['collection_name'] = this.collectionName;
    data['name'] = this.name;
    data['file_name'] = this.fileName;
    data['mime_type'] = this.mimeType;
    data['disk'] = this.disk;
    data['size'] = this.size;
    data['manipulations'] = this.manipulations;
    if (this.customProperties != null) {
      data['custom_properties'] = this.customProperties.toJson();
    }
    data['responsive_images'] = this.responsiveImages;
    data['order_column'] = this.orderColumn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['url'] = this.url;
    data['thumb'] = this.thumb;
    data['icon'] = this.icon;
    data['formated_size'] = this.formatedSize;
    return data;
  }
}

class CustomProperties {
  String uuid;
  int userId;
  GeneratedConversions generatedConversions;

  CustomProperties({this.uuid, this.userId, this.generatedConversions});

  CustomProperties.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userId = json['user_id'];
    generatedConversions = json['generated_conversions'] != null
        ? new GeneratedConversions.fromJson(json['generated_conversions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['user_id'] = this.userId;
    if (this.generatedConversions != null) {
      data['generated_conversions'] = this.generatedConversions.toJson();
    }
    return data;
  }
}

class GeneratedConversions {
  bool thumb;
  bool icon;

  GeneratedConversions({this.thumb, this.icon});

  GeneratedConversions.fromJson(Map<String, dynamic> json) {
    thumb = json['thumb'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumb'] = this.thumb;
    data['icon'] = this.icon;
    return data;
  }
}

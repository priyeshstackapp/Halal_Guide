class CuisineModel {
  int id;
  String name;
  bool isSelected = false;
  String description;
  String createdAt;
  String updatedAt;
  List<String> customFields;
  List<Restaurants> restaurants;

  CuisineModel(
      {this.id,
        this.name,
        this.isSelected,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.customFields,
        this.restaurants});

  CuisineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customFields = json['custom_fields'].cast<String>();
    if (json['restaurants'] != null) {
      restaurants = new List<Restaurants>();
      json['restaurants'].forEach((v) {
        restaurants.add(new Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['custom_fields'] = this.customFields;
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurants {
  int id;
  String name;
  List<String> customFields;
  bool hasMedia;
  String rate;
  Pivot pivot;
  List<Media> media;

  Restaurants(
      {this.id,
        this.name,
        this.customFields,
        this.hasMedia,
        this.rate,
        this.pivot,
        this.media});

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    customFields = json['custom_fields'].cast<String>();
    hasMedia = json['has_media'];
    rate = json['rate'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    data['custom_fields'] = this.customFields;
    data['has_media'] = this.hasMedia;
    data['rate'] = this.rate;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    if (this.media != null) {
      data['media'] = this.media.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pivot {
  int cuisineId;
  int restaurantId;

  Pivot({this.cuisineId, this.restaurantId});

  Pivot.fromJson(Map<String, dynamic> json) {
    cuisineId = json['cuisine_id'];
    restaurantId = json['restaurant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cuisine_id'] = this.cuisineId;
    data['restaurant_id'] = this.restaurantId;
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

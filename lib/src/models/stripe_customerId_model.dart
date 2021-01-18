class CustomerIdModel {
  String id;
  String object;
  String address;
  int balance;
  int created;
  String currency;
  String defaultSource;
  bool delinquent;
  String description;
  String discount;
  String email;
  String invoicePrefix;
  InvoiceSettings invoiceSettings;
  bool livemode;
  Metadata metadata;
  String name;
  int nextInvoiceSequence;
  String phone;
  List<String> preferredLocales;
  String shipping;
  String taxExempt;

  CustomerIdModel(
      {this.id,
        this.object,
        this.address,
        this.balance,
        this.created,
        this.currency,
        this.defaultSource,
        this.delinquent,
        this.description,
        this.discount,
        this.email,
        this.invoicePrefix,
        this.invoiceSettings,
        this.livemode,
        this.metadata,
        this.name,
        this.nextInvoiceSequence,
        this.phone,
        this.preferredLocales,
        this.shipping,
        this.taxExempt});

  CustomerIdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    address = json['address'];
    balance = json['balance'];
    created = json['created'];
    currency = json['currency'];
    defaultSource = json['default_source'];
    delinquent = json['delinquent'];
    description = json['description'];
    discount = json['discount'];
    email = json['email'];
    invoicePrefix = json['invoice_prefix'];
    invoiceSettings = json['invoice_settings'] != null
        ? new InvoiceSettings.fromJson(json['invoice_settings'])
        : null;
    livemode = json['livemode'];
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    name = json['name'];
    nextInvoiceSequence = json['next_invoice_sequence'];
    phone = json['phone'];
    preferredLocales = json['preferred_locales'].cast<String>();
    shipping = json['shipping'];
    taxExempt = json['tax_exempt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    data['address'] = this.address;
    data['balance'] = this.balance;
    data['created'] = this.created;
    data['currency'] = this.currency;
    data['default_source'] = this.defaultSource;
    data['delinquent'] = this.delinquent;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['email'] = this.email;
    data['invoice_prefix'] = this.invoicePrefix;
    if (this.invoiceSettings != null) {
      data['invoice_settings'] = this.invoiceSettings.toJson();
    }
    data['livemode'] = this.livemode;
    if (this.metadata != null) {
      data['metadata'] = this.metadata.toJson();
    }
    data['name'] = this.name;
    data['next_invoice_sequence'] = this.nextInvoiceSequence;
    data['phone'] = this.phone;
    data['preferred_locales'] = this.preferredLocales;
    data['shipping'] = this.shipping;
    data['tax_exempt'] = this.taxExempt;
    return data;
  }
}

class InvoiceSettings {
  String customFields;
  String defaultPaymentMethod;
  String footer;

  InvoiceSettings({this.customFields, this.defaultPaymentMethod, this.footer});

  InvoiceSettings.fromJson(Map<String, dynamic> json) {
    customFields = json['custom_fields'];
    defaultPaymentMethod = json['default_payment_method'];
    footer = json['footer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custom_fields'] = this.customFields;
    data['default_payment_method'] = this.defaultPaymentMethod;
    data['footer'] = this.footer;
    return data;
  }
}

class Metadata {
  String data;

  Metadata({this.data});

  Metadata.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    return data;
  }
}

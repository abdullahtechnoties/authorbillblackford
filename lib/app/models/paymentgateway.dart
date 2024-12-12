import 'package:flutter_wp_woocommerce/models/payment_gateway.dart';

class WooPaymentGateway {
  String? id;
  String? title;
  String? description;
  int? order; // This field might be coming as a string from the API
  bool? enabled;
  String? methodTitle;
  String? methodDescription;
  List<String>? methodSupports;
  WooPaymentGatewaySettings? settings;
  WooPaymentGatewayLinks? lLinks;

  WooPaymentGateway(
      {required this.id,
      this.title,
      this.description,
      this.order,
      this.enabled,
      this.methodTitle,
      this.methodDescription,
      this.methodSupports,
      this.settings,
      this.lLinks});

  WooPaymentGateway.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    
    // Ensure the 'order' field is parsed as an integer (handle cases where it might be a string)
    order = json['order'] is String ? int.tryParse(json['order']) : json['order'];

    enabled = json['enabled'];
    methodTitle = json['method_title'];
    methodDescription = json['method_description'];
    methodSupports = json['method_supports']?.cast<String>();
    
    settings = json['settings'] != null
        ? WooPaymentGatewaySettings.fromJson(json['settings'])
        : null;

    lLinks = json['_links'] != null
        ? WooPaymentGatewayLinks.fromJson(json['_links'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['order'] = this.order;
    data['enabled'] = this.enabled;
    data['method_title'] = this.methodTitle;
    data['method_description'] = this.methodDescription;
    data['method_supports'] = this.methodSupports;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    return data;
  }
}
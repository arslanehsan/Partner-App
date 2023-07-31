class PaypalKeyObject {
  String client_id, secret_key;

  PaypalKeyObject({
    required this.client_id,
    required this.secret_key,
  });

  factory PaypalKeyObject.fromJson(Map<String, dynamic> json) {
    print('PaypalKeyObject DATA GETTING $json');
    return PaypalKeyObject(
      client_id: json['client_id'],
      secret_key: json['secret_key'] ?? '',
    );
  }
}

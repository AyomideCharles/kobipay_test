class TransactionModel {
  final String id;
  final String merchant;
  final String merchantImage;
  final double amount;
  final String currency;
  final DateTime date;
  final String method;
  final String status;
  final String category;
  final String note;

  TransactionModel({
    required this.id,
    required this.merchant,
    required this.merchantImage,
    required this.amount,
    required this.currency,
    required this.date,
    required this.method,
    required this.status,
    required this.category,
    required this.note,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        id: json['id'] as String,
        merchant: json['merchant'] as String,
        merchantImage: json['merchantImage'] as String,
        amount: (json['amount'] as num).toDouble(),
        currency: json['currency'] as String,
        date: DateTime.parse(json['date'] as String),
        method: json['method'] as String,
        status: json['status'] as String,
        category: json['category'] as String,
        note: json['note'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'merchant': merchant,
        'merchantImage': merchantImage,
        'amount': amount,
        'currency': currency,
        'date': date.toIso8601String(),
        'method': method,
        'status': status,
        'category': category,
        'note': note,
      };
}

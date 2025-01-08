class CurrencyRequest {

  CurrencyRequest({
    required this.baseCurrency,
    required this.currencies,
    required this.amount,
  });

  final double amount;
  final String currencies;
  final String baseCurrency;


   factory CurrencyRequest.fromJson(Map<String, dynamic> json) {
      return CurrencyRequest(
        baseCurrency: json['baseCurrency'],
        currencies: json['currencies'],
        amount: json['amount'],
      );
    }

    Map<String, dynamic> toJson() {
      return {
        'baseCurrency': baseCurrency,
        'currencies': currencies,
        'amount': amount,
      };
    }
}

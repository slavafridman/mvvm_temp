import 'dart:convert';
import 'models/currency_request.dart';
import 'package:http/http.dart' as http;
import 'package:arc_temp/utils/result.dart';



class CurrencyApiService {
  Future<Result<List<String>>> getCurrencies() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.freecurrencyapi.com/v1/currencies?apikey=fca_live_gaOx8X5O0sVWslzO5pGR2PTQg3QHlBpBsi24JFua'));
      if (response.statusCode == 200) {
        var currencies = <String>[];
        final stringData = response.body;
        final json = jsonDecode(stringData);
        for (var currency in json['data'].keys) {
          currencies.add(currency);
        }
        return Result.ok(currencies);
      } else {
        return Result.error(Exception('Failed to fetch currencies'));
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<double>> convertCurrency(CurrencyRequest req) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_gaOx8X5O0sVWslzO5pGR2PTQg3QHlBpBsi24JFua&from=${req.baseCurrency}&to=${req.currencies}'));
      if (response.statusCode == 200) {
        final stringData = response.body;
        final json = jsonDecode(stringData);
        final base = json['data'][req.baseCurrency];
        final target = json['data'][req.currencies];
        double convertedAmount = base / target * req.amount;

        return Result.ok(convertedAmount);
      } else {
        return Result.error(Exception('Failed to convert currency'));
      }
    } on Exception catch (e) {
      return (Result.error(e));
    }
  }
}

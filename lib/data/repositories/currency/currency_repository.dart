import '../../../utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:arc_temp/data/services/api/models/currency_request.dart';


abstract class CurrencyRepository extends ChangeNotifier {
  Future<Result<List<String>>> getCurrencies();
  Future<Result<double>> convertCurrency(CurrencyRequest req);
}

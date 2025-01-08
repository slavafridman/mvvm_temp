import '../../../utils/result.dart';
import '../../../utils/command.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/currency/currency_repository.dart';
import 'package:arc_temp/data/services/api/models/currency_request.dart';


class ConvertViewModel extends ChangeNotifier {
  ConvertViewModel({required CurrencyRepository currencyRepository})
      : _currencyRepository = currencyRepository {
    convert = Command1<void, CurrencyRequest>(_convert);
  }

  final CurrencyRepository _currencyRepository;
  double _convertedValue = 0;
  String get convertedValue => _convertedValue.toStringAsFixed(2);
  late final Command1<void, CurrencyRequest> convert;

  Future<Result<void>> _convert(CurrencyRequest req) async {
    try {
      final result = await _currencyRepository.convertCurrency(req);
      switch (result) {
        case Ok<double>():
          _convertedValue = result.value;
          break;
        case Error<double>():
          print(result.error);
          break;
      }
      return result;
    } catch (e) {
      return Result.error(Exception('Failed to convert currency'));
    } finally {
      notifyListeners();
    }
  }
}

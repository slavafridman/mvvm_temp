import '../../../utils/result.dart';
import '../../../utils/command.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/currency/currency_repository.dart';


class CurrenciesViewModel extends ChangeNotifier {
  CurrenciesViewModel({required CurrencyRepository currencyRepository})
      : _currencyRepository = currencyRepository {
    loadCurrencies = Command0(_loadCurrencies)..execute();
  }

  final CurrencyRepository _currencyRepository;
  List<String> _currencies = [];
  List<String> get currencies => _currencies;
  late final Command0 loadCurrencies;


  Future<Result<void>> _loadCurrencies() async {
    try{
    final result = await _currencyRepository.getCurrencies();
    switch (result) {
      case Ok<List<String>>():
        _currencies = result.value;
        break;
      case Error<List<String>>():
        print(result.error);
        break;
    }
    return result;
  } catch (e) {
      return Result.error(Exception('Failed to fetch currencies'));
    }finally{
      notifyListeners();
    }
  }
}

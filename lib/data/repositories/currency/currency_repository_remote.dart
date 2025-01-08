import '../../../utils/result.dart';
import '../../services/api/currency_api_service.dart';
import 'package:arc_temp/data/services/api/models/currency_request.dart';
import 'package:arc_temp/data/repositories/currency/currency_repository.dart';


class CurrencyRepositoryRemote extends CurrencyRepository {
  CurrencyRepositoryRemote({required CurrencyApiService apiService})
      : _apiClient = apiService;
  final CurrencyApiService _apiClient;

  final Map<String, List<String>> _cachedData = {};

  @override
  Future<Result<List<String>>> getCurrencies() async {
    try {
      if (_cachedData.containsKey('currencies')) {
        return Result.ok(_cachedData['currencies']!);
      } else {
        final result = await _apiClient.getCurrencies();
        if (result is Ok) {
          _cachedData['currencies'] = (result as Ok<List<String>>).value;
        }
        return result;
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<double>> convertCurrency(CurrencyRequest req) async {
    try {
      final result = await _apiClient.convertCurrency(req);
      return result;
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }
}

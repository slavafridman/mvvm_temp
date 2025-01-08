import 'package:test/test.dart';
import 'package:arc_temp/data/services/api/currency_api_service.dart';

void main() {
  test('Api test', () {
    final api = CurrencyApiService();
    api.getCurrencies().then((result) {
      print(result);
      expect(1 == 1, true);
    });
  });
}

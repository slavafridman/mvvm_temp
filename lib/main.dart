import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arc_temp/ui/currency/widgets/currency_convert.dart';
import 'data/repositories/currency/currency_repository_remote.dart';
import 'package:arc_temp/data/services/api/currency_api_service.dart';
import 'package:arc_temp/ui/currency/view_models/convert_view_model.dart';


void main() {
  runApp(MultiProvider(providers: [
    Provider(
      create: (context) => CurrencyApiService(),
    ),
    ChangeNotifierProvider(
      create: (context) => CurrencyRepositoryRemote(
        apiService: context.read(),
      ),
    )
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CurrencyConvert(
            viewModel: ConvertViewModel(
              currencyRepository: CurrencyRepositoryRemote(
                apiService: CurrencyApiService(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:arc_temp/data/services/api/currency_api_service.dart';
import 'package:arc_temp/ui/currency/view_models/currencies_view_model.dart';
import 'package:arc_temp/data/repositories/currency/currency_repository_remote.dart';

class CurrencyPopup extends StatefulWidget {
  final String initialValue;
  final Function(String) fallback;

  const CurrencyPopup({
    super.key,
    this.initialValue = 'USD',
    required this.fallback,
  });

  @override
  State<CurrencyPopup> createState() => _CurrencyPopupState();
}

class _CurrencyPopupState extends State<CurrencyPopup> {
  final TextEditingController controller = TextEditingController();

  final CurrenciesViewModel viewModel = CurrenciesViewModel(
      currencyRepository:
          CurrencyRepositoryRemote(apiService: CurrencyApiService()));

  @override
  void initState() {
    widget.fallback(widget.initialValue);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: viewModel.loadCurrencies,
        builder: (context, child) {
          if (viewModel.loadCurrencies.running) {
            return CircularProgressIndicator();
          }
          return DropdownMenu<String>(
            enableFilter: true,
            initialSelection: widget.initialValue,
            enableSearch: true,
            controller: controller,
            dropdownMenuEntries: viewModel.currencies
                .map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(
                value: value,
                label: value,
              );
            }).toList(),
            onSelected: (value) {
              controller.text = value!;
              widget.fallback(value);
            },
          );
        });
  }
}

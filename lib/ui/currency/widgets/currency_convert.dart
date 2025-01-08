import 'package:flutter/material.dart';
import '../../../data/services/api/models/currency_request.dart';
import 'package:arc_temp/ui/currency/widgets/currency_popup.dart';
import 'package:arc_temp/ui/currency/view_models/convert_view_model.dart';


class CurrencyConvert extends StatefulWidget {
  const CurrencyConvert({super.key, required this.viewModel});

  final ConvertViewModel viewModel;

  @override
  State<CurrencyConvert> createState() => _CurrencyConvertState();
}

class _CurrencyConvertState extends State<CurrencyConvert> {
  late TextEditingController _amountController;

  String _fromCurrency = 'USD';

  String _toCurrency = 'EUR';

  String _convertResult = '0';

  @override
  void initState() {
    _amountController = TextEditingController(text: '1');

    widget.viewModel.convert.addListener(() {
      setState(() {
        _convertResult = widget.viewModel.convertedValue;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        padding: EdgeInsets.all(16.0),
        //Add blue rounded border with radius 8.0
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.blue),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Currency Converter',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Amount',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                CurrencyPopup(
                  fallback: (value) {
                    _fromCurrency = value;
                  },
                ),
                Text('To'),
                CurrencyPopup(
                  initialValue: _toCurrency,
                  fallback: (value) {
                    _toCurrency = value;
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.viewModel.convert.execute(CurrencyRequest(
                  amount: double.parse(_amountController.text),
                  baseCurrency: _fromCurrency,
                  currencies: _toCurrency,
                ));
              },
              child: Text('Convert'),
            ),
            SizedBox(height: 16),
            Text(_convertResult),
          ],
        ),
      ),
    );
  }
}

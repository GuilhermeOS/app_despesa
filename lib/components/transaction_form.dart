import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime, String) onSubmit;

  TransactionForm(
    this.onSubmit,
  );

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  final _typeController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'receita',
      'label': 'Receita',
    },
    {
      'value': 'despesa',
      'label': 'Despesa',
    }
  ];

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    final type = _typeController.text;

    if (title.isEmpty || value <= 0 || _selectedDate == null || type.isEmpty) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate!, type);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              controller: _valueController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            SelectFormField(
              controller: _typeController,
              type: SelectFormFieldType.dropdown,
              initialValue: null,
              //icon: Icon(Icons.keyboard_arrow_down),
              labelText: 'Tipo de Transação',
              items: _items,
              onChanged: (val) => print(val),
              onSaved: (_) => _submitForm(),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Nenhuma data selecionada!'
                          : DateFormat('dd/MM/y').format(_selectedDate!),
                    ),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text(
                      _selectedDate == null
                          ? 'Selecionar Data'
                          : 'Alterar Data',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 170,
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Nova Transação',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

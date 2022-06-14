import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onDelete;

  TransactionList(
    this.transactions,
    this.onDelete,
  );

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Nenhuma Transação cadastrada',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView.builder(
            itemCount: transactions.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              final type = transactions[index].type;
              return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 4,
                  ),
                  child: (type == 'receita')
                      ? ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green[400],
                            radius: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: FittedBox(
                                child: Text(
                                  'R\$${tr.value.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            tr.title,
                          ),
                          subtitle: Text(
                            DateFormat('d/MM/y').format(tr.date),
                          ),
                          trailing: IconButton(
                            onPressed: () => onDelete(tr.id),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.deepOrange,
                            ),
                          ),
                        )
                      : ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.red[400],
                            radius: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: FittedBox(
                                child: Text(
                                  'R\$${tr.value.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            tr.title,
                          ),
                          subtitle: Text(
                            DateFormat('d/MM/y').format(tr.date),
                          ),
                          trailing: IconButton(
                            onPressed: () => onDelete(tr.id),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ));
            });
  }
}

import 'package:banca_app/backend/models/credit.dart';
import 'package:banca_app/constants/app_theme.dart';
import 'package:banca_app/screens/screens.dart';
import 'package:flutter/material.dart';

class CreditHistoryTable extends StatelessWidget {
  const CreditHistoryTable({super.key, required this.credits});

  final List<Credit> credits;

  void _onRowTap(BuildContext context, Credit credit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryCreditDetailScreen(credit: credit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.symmetric(
        inside: BorderSide(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      columnWidths: const {
        2: FlexColumnWidth(0.4),
        3: FlexColumnWidth(0.6),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            ...List.generate(
              tableHeader.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  tableHeader[index]['label'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
        ...List.generate(
          credits.length,
          (index) => TableRow(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
            children: List.generate(
              tableHeader.length,
              (index2) => TableRowInkWell(
                onTap: () => _onRowTap(context, credits[index]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.padding / 2,
                  ),
                  child: Text(
                    credits[index]
                        .toJson()[tableHeader[index2]['name']]
                        .toString(),
                    style: TextStyle(
                      color: tableHeader[index2]['color'] as Color,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

const tableHeader = [
  {
    'name': 'prestamoTotal',
    'label': 'Monto de crédito',
    'color': Colors.black54
  },
  {'name': 'fechaDesembolso', 'label': 'Fecha', 'color': Colors.black54},
  {'name': 'nCuota', 'label': 'No de Cuotas', 'color': Colors.black54},
  {'name': 'interes', 'label': 'Interes', 'color': Colors.black54},
];

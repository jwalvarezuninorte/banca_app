import 'package:banca_app/backend/models/credit.dart';
import 'package:banca_app/backend/models/mensual_quota.dart';
import 'package:banca_app/constants/app_theme.dart';
import 'package:flutter/material.dart';

class AmortizationTable extends StatelessWidget {
  const AmortizationTable({Key? key, required this.credit}) : super(key: key);

  final Credit credit;

  @override
  Widget build(BuildContext context) {
    final List<MensualQuota> cuotas = credit.getAmortizaationTable(
      prestamo: credit,
    );

    return Column(
      children: [
        Table(
          border: TableBorder.symmetric(
            inside: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
          columnWidths: const {
            0: FlexColumnWidth(0.5),
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
              cuotas.length,
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
                  (index2) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppTheme.padding / 2),
                    child: Text(
                      cuotas[index]
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
          ],
        ),
      ],
    );
  }
}

// A. Saldo Inicial (Inicia con el valor del préstamo y en el siguiente registro debe mostrar el saldo del periodo anterior).
// B. Número de la cuota.
// C. Cuota: valor de la cuota, precio fijo.
// D. Interés: Saldo inicial * el valor del interés.
// E. Abono a capital: Valor de la cuota - intereses.
// F. Saldo del periodo: Saldo inicial - abono a capital.
const tableHeader = [
  {'name': 'nCuota', 'label': 'No', 'color': Colors.black54},
  {'name': 'cuota', 'label': 'Cuota', 'color': Colors.black54},
  {'name': 'abonoCapital', 'label': 'Abono a capital', 'color': Colors.green},
  {'name': 'interes', 'label': 'Interes', 'color': Colors.black54},
  {
    'name': 'saldoPeriodo',
    'label': 'Saldo del periodo',
    'color': Colors.black54
  },
];

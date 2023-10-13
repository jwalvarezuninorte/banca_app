import 'dart:io';
import 'dart:math';

import 'package:banca_app/backend/models/mensual_quota.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class Credit {
  final int userId;
  final int nCuota;
  final DateTime fechaDesembolso;
  final CreditType tipoCredito;
  final double prestamoTotal;

  Credit({
    required this.userId,
    required this.nCuota,
    required this.fechaDesembolso,
    required this.tipoCredito,
    required this.prestamoTotal,
  }) : assert(
          nCuota % 12 == 0 && nCuota >= 12 && nCuota <= 84
              ? true
              : throw ('Las cuotas permitidas son 12, 24, 36, 48, 60, 72, 84'),
        );

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': DateTime.now().millisecondsSinceEpoch,
      'nQuota': nCuota,
      'simulationDate': fechaDesembolso.toString(),
      'creditTypeName': tipoCredito.name,
      'creditTypeInterest': tipoCredito.interes,
      'totalLoan': prestamoTotal,
    };
  }

  Credit.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        nCuota = map['nQuota'],
        fechaDesembolso = DateTime.parse(map['simulationDate']),
        tipoCredito = CreditType(
          name: map['creditTypeName'],
          interes: map['creditTypeInterest'],
        ),
        prestamoTotal = map['totalLoan'];

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nCuota': nCuota,
      'fechaDesembolso': fechaDesembolso.toString().split(' ')[0],
      'tipoCredito': tipoCredito.toJson(),
      'interes': '${(tipoCredito.interes)} %',
      'prestamoTotal': prestamoTotal,
    };
  }

  // (Monto del préstamo*Interés) /(1-(1+interés) ^ número de cuotas)
  List<MensualQuota> getAmortizaationTable({required Credit prestamo}) {
    final List<MensualQuota> cuotas = [];

    final double interes = prestamo.tipoCredito.interes / 100;
    final double prestamoTotal = prestamo.prestamoTotal;
    final int nCuotas = prestamo.nCuota;
    for (int i = 0; i < nCuotas; i++) {
      final double saldoInicial =
          i == 0 ? prestamoTotal : cuotas[i - 1].saldoPeriodo;
      final double cuota =
          (prestamoTotal * interes) / (1 - pow(1 + interes, nCuotas * -1));

      cuotas.add(
        MensualQuota(
          saldoInicial: saldoInicial,
          nCuota: i + 1,
          cuota: cuota,
          interes: (saldoInicial * interes),
          abonoCapital: cuota - (saldoInicial * interes),
          saldoPeriodo: saldoInicial - (cuota - (saldoInicial * interes)),
        ),
      );
    }
    return cuotas;
  }

  // this return the path of the saed excel file
  static Future<String> saveTableToExcel(List<MensualQuota> cuotas) async {
    var excel = Excel.createExcel();

    // We rename Sheet1 to 'Tabla de amortización'
    excel.rename('Sheet1', 'Tabla de amortización');

    Sheet sheetObject = excel['Tabla de amortización'];

    final headers = [
      'Saldo Inicial',
      'No',
      'Cuota',
      'Interes',
      'Abono a capital',
      'Saldo del periodo',
    ];

    // Save table headers to excel
    sheetObject.appendRow(headers);

    // (optional) Add bold style to first row
    for (var element in headers) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(
              columnIndex: headers.indexOf(element), rowIndex: 0))
          .cellStyle = CellStyle(
        bold: true,
        horizontalAlign: HorizontalAlign.Right,
      );
    }

    // Save table data
    for (var cuota in cuotas) {
      sheetObject.appendRow([
        cuota.saldoInicial.round(),
        cuota.nCuota,
        cuota.cuota.round(),
        cuota.interes.round(),
        cuota.abonoCapital.round(),
        cuota.saldoPeriodo.round(),
      ]);

      // Add bold style to 'abono a capital' and green color
      sheetObject
          .cell(CellIndex.indexByColumnRow(
              columnIndex: headers.indexOf('Abono a capital'),
              rowIndex: cuotas.indexOf(cuota) + 1))
          .cellStyle = CellStyle(
        bold: true,
        horizontalAlign: HorizontalAlign.Right,
        fontColorHex: '#2EAE44',
      );
    }

    for (var element in headers) {
      sheetObject.setColAutoFit(headers.indexOf(element));
    }

    // We save the excel and export the file to app's documents
    var fileBytes = excel.save();
    var directory = await getApplicationDocumentsDirectory();

    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    String fileName = 'Simulación de Crédito - $timeStamp.xlsx';

    await File('${directory.path}/$fileName').writeAsBytes(fileBytes!);

    return '${directory.path}/$fileName';
  }

  static Future saveAndOpenCreditSimulationExcel({
    required Credit credit,
    required BuildContext context,
  }) async {
    try {
      final cuotas = credit.getAmortizaationTable(prestamo: credit);

      final String path = await Credit.saveTableToExcel(cuotas);

      await OpenFilex.open(path);
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar
        ..showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Hubo un error al momento de descargar la cotización',
            ),
          ),
        );
    }
  }
}

class CreditType {
  final String name;
  final double interes;

  CreditType({
    required this.name,
    required this.interes,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'interes': interes,
    };
  }
}

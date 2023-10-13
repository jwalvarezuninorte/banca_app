/*
A. Saldo Inicial (Inicia con el valor del préstamo y en el siguiente registro debe mostrar el saldo del periodo anterior).
B. Número de la cuota.
C. Cuota: valor de la cuota, precio fijo.
D. Interés: Saldo inicial * el valor del interés.
E. Abono a capital: Valor de la cuota - intereses.
F. Saldo del periodo: Saldo inicial - abono a capital.
*/
class MensualQuota {
  final double saldoInicial;
  final int nCuota;
  final double cuota;
  final double interes;
  final double abonoCapital;
  final double saldoPeriodo;

  MensualQuota({
    required this.saldoInicial,
    required this.nCuota,
    required this.cuota,
    required this.interes,
    required this.abonoCapital,
    required this.saldoPeriodo,
  });

  Map<String, dynamic> toJson() {
    return {
      'saldoInicial': saldoInicial.roundToDouble(),
      'nCuota': nCuota,
      'cuota': cuota.roundToDouble(),
      'interes': interes.roundToDouble(),
      'abonoCapital': '+${abonoCapital.roundToDouble()}',
      'saldoPeriodo': saldoPeriodo.roundToDouble(),
    };
  }
}

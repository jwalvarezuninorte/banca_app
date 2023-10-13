import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';

import 'package:banca_app/backend/models/credit.dart';
import 'package:banca_app/backend/services/auth_service.dart';
import 'package:banca_app/backend/services/sqlite_service.dart';
import 'package:banca_app/constants/app_theme.dart';
import 'package:banca_app/widgets/base/base.dart';
import 'package:banca_app/widgets/commons/credit_simulation_result.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.sqliteService}) : super(key: key);

  final SqliteService sqliteService;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double maximumCredit = 0;
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _dueController = TextEditingController();

  // We can get this information from backend (e.g. GET /api/v1/credit/types/)
  final List<CreditType> creditTypeList = [
    CreditType(interes: 3.0, name: 'Crédito de vehículo'),
    CreditType(interes: 1.0, name: 'Crédito de vivienda'),
    CreditType(interes: 3.5, name: 'Crédito de libre inversión'),
    CreditType(interes: 2.36, name: 'Crédito de Jhon'),
  ];

  String dropdownValue = '';

  bool _showTable = false;
  Credit? credito;
  bool _buttonDisable = true;

  void verifyButtonDisable() {
    if (_salaryController.text.isEmpty ||
        _dueController.text.isEmpty ||
        dropdownValue.isEmpty) {
      _buttonDisable = true;
    } else {
      _buttonDisable = false;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      backgroundColor: AppTheme.base,
      appBar: _showTable
          ? null
          : CustomAppBar(userFullName: authService.currentUser!.name),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.padding,
          ),
          child: SingleChildScrollView(
            child: !_showTable
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeadlineIconBody(
                        bodyText:
                            'Ingresa los datos para tu crédito según lo que necesites.',
                        headerText: 'Simular tu crédito',
                        showIcon: true,
                      ),
                      const InputLabelText(
                          '¿Qué tipo de créditos deseas realizar?'),
                      CustomDropdownMenu(
                        creditTypeList: creditTypeList,
                        onSelected: (value) {
                          dropdownValue = value;
                          verifyButtonDisable();
                        },
                      ),
                      const InputLabelText('¿Cuántos es tu salario base?'),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 16),
                        controller: _salaryController,
                        decoration: const InputDecoration(
                          hintText: '\$ 10’000.000,00',
                        ),
                        onChanged: (value) {
                          //  TODO: Ask and verify this: Crédito -> (Salario * 7) / 15%
                          if (value.isEmpty) {
                            maximumCredit = 0;
                          }

                          if (value.isNotEmpty) {
                            double salary = double.parse(value);
                            maximumCredit = ((salary * 7) - ((salary * 0.15)))
                                .roundToDouble();
                          }

                          verifyButtonDisable();

                          // setState(() {});
                        },
                      ),
                      const SizedBox(height: AppTheme.padding),
                      TextFormField(
                        enabled: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: '\$ $maximumCredit',
                          filled: true,
                          fillColor: AppTheme.dark.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppTheme.defaultRadius),
                            borderSide: BorderSide(
                              color: AppTheme.primary.withOpacity(0.6),
                              width: 2,
                            ),
                          ),
                        ),
                        // onFieldSubmitted: (value) => _passwordFocusNode.requestFocus(),
                      ),
                      const InputLabelText('¿A cuantos meses?'),
                      TextFormField(
                        style: const TextStyle(fontSize: 16),
                        controller: _dueController,
                        decoration: const InputDecoration(
                          hintText: '48',
                        ),
                        onChanged: (value) => verifyButtonDisable(),
                      ),
                      const SizedBox(height: AppTheme.padding * 2),
                      ElevatedButton(
                        onPressed: _buttonDisable
                            ? null
                            : () async {
                                showDialog(
                                  barrierDismissible: false,
                                  barrierColor: Colors.white,
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      surfaceTintColor: Colors.white,
                                      contentPadding: EdgeInsets.all(0),
                                      content: LoadingIndicator(
                                        message: 'Simulando Crédito',
                                      ),
                                    );
                                  },
                                );
                                await Future.delayed(
                                  const Duration(seconds: 2),
                                );
                                Navigator.of(context).pop();

                                try {
                                  credito = Credit(
                                    userId: authService.currentUser!.id!,
                                    nCuota: int.parse(_dueController.text),
                                    fechaDesembolso: DateTime.now(),
                                    tipoCredito: creditTypeList.firstWhere(
                                      (element) =>
                                          element.name == dropdownValue,
                                    ),
                                    prestamoTotal: maximumCredit,
                                  );

                                  _showTable = true;
                                  setState(() {});
                                } catch (e) {
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar
                                    ..showSnackBar(
                                      SnackBar(content: Text(e.toString())),
                                    );
                                }
                              },
                        child: const Text(
                          'Simular',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : CreditSimulationResult(
                    credit: credito as Credit,
                    onPrimaryPressed: () async {
                      await Credit.saveAndOpenCreditSimulationExcel(
                        context: context,
                        credit: credito as Credit,
                      );

                      _showTable = false;
                      setState(() {});
                    },
                    onSecondaryPressed: () async {
                      await showBottomSheetOptions(
                        context,
                        credito as Credit,
                        widget.sqliteService,
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends PreferredSize {
  const CustomAppBar({
    super.key,
    required this.userFullName,
  }) : super(child: const SizedBox(), preferredSize: const Size.fromHeight(82));

  final String userFullName;

  @override
  Widget build(BuildContext context) {
    final String userShortName =
        '${userFullName.split(' ').first} ${userFullName.split(' ')[1][0]}.';
    return AppBar(
      titleSpacing: AppTheme.padding,
      title: Text(
        'Hola $userShortName 👋',
        style: AppTheme.lightTheme.textTheme.titleLarge,
      ),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/icons/notification_icon.svg'),
        ),
        Padding(
          padding: const EdgeInsets.only(right: AppTheme.padding / 2),
          child: IconButton(
            onPressed: () {
              final authService = Provider.of<AuthService>(
                context,
                listen: false,
              );
              authService.logout();

              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        )
      ],
    );
  }
}

class HeadlineIconBody extends StatelessWidget {
  const HeadlineIconBody({
    super.key,
    required this.headerText,
    required this.bodyText,
    this.headerColor = AppTheme.primary,
    required this.showIcon,
  });

  final String headerText;
  final String bodyText;

  final Color? headerColor;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              headerText,
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                color: headerColor,
                height: 0,
              ),
            ),
            showIcon
                ? const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.padding / 3,
                    ),
                    child: Icon(Icons.info_outline_rounded, size: 26),
                  )
                : const Spacer()
          ],
        ),
        const SizedBox(height: AppTheme.padding / 3),
        Text(
          bodyText,
          style: AppTheme.lightTheme.textTheme.bodyLarge,
        ),
        const SizedBox(height: AppTheme.padding / 2),
      ],
    );
  }
}

class CustomDropdownMenu extends StatelessWidget {
  const CustomDropdownMenu({
    super.key,
    required this.creditTypeList,
    required this.onSelected,
  });

  final List<CreditType> creditTypeList;
  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width - AppTheme.padding * 2,
      hintText: 'Selecciona el tipo de créditos',
      textStyle: const TextStyle(fontSize: 16, color: AppTheme.dark),
      trailingIcon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppTheme.dark.withOpacity(0.4),
      ),
      onSelected: (value) => onSelected(value as String),
      dropdownMenuEntries:
          creditTypeList.map<DropdownMenuEntry<String>>((CreditType value) {
        return DropdownMenuEntry<String>(
            value: value.name, label: '${value.name} (${value.interes}%)');
      }).toList(),
    );
  }
}

Future<void> showBottomSheetOptions(
  BuildContext context,
  Credit credito,
  SqliteService sqliteService,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        // height: 400,
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppTheme.defaultRadius * 1.5),
            topRight: Radius.circular(AppTheme.defaultRadius * 1.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xffEBEBEB),
              blurRadius: 0,
              spreadRadius: -10,
              offset: Offset(0, -24),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: AppTheme.padding * 2),
                SvgPicture.asset(
                  'assets/icons/info_icon.svg',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: AppTheme.padding / 2),
                Text(
                  '¿Está seguro que desea Guardar la cotización?',
                  style: AppTheme.lightTheme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.padding / 2),
                const Text(
                  'La cotización realizada la podrás consultar en tu historial de créditos.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.padding * 2),
                ElevatedButton(
                  onPressed: () async {
                    // final cuotas =
                    //     credito.getAmortizaationTable(prestamo: credito);

                    // final String path = await Credit.saveTableToExcel(cuotas);

                    await sqliteService.saveCredit(credito);

                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar
                      ..showSnackBar(
                        const SnackBar(
                          backgroundColor: AppTheme.green,
                          content: Text('Cotización guardada'),
                        ),
                      );

                    // open file with default app
                    // OpenFilex.open(path);
                  },
                  child: const Text('Guardar'),
                ),
                const SizedBox(height: AppTheme.padding / 2),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    backgroundColor: AppTheme.base,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppTheme.defaultRadius),
                      side: const BorderSide(
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(height: AppTheme.padding),
              ],
            ),
            const Positioned(
              right: 0,
              top: AppTheme.padding,
              child: BackIconButton(),
            ),
          ],
        ),
      );
    },
  );
}

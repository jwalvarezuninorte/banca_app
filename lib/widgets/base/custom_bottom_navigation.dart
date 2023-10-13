import 'package:banca_app/constants/app_theme.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onTap,
    super.key,
  });

  final int selectedIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final bottomNavigationItems = [
      const _BottomNavigationItem(
        icon: Icons.home_filled,
        label: 'Home',
      ),
      const _BottomNavigationItem(
        icon: Icons.wallet_sharp,
        label: 'Historial créditos',
      ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            // color: Colors.red,
            border: Border(
              top: BorderSide(color: AppTheme.dark.withOpacity(0.2)),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: onTap,
            elevation: 0,
            items: [
              ...List.generate(
                bottomNavigationItems.length,
                (index) => BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(AppTheme.padding / 2),
                    child: Icon(
                      bottomNavigationItems[index].icon,
                      size: 26,
                    ),
                  ),
                  label: bottomNavigationItems[index].label,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BottomNavigationItem {
  const _BottomNavigationItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

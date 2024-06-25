import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ActionButton(icon: Icons.send, color: Colors.orange, label: 'Send', key: Key('sendButton')),
        ActionButton(icon: Icons.payment, color: Colors.blue, label: 'Pay', key: Key('payButton')),
        ActionButton(icon: Icons.receipt_long, color: Colors.green, label: 'Bills', key: Key('billsButton')),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const ActionButton({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40, color: color), // Icon with specified size and color.
        const SizedBox(height: 8), // Spacing between the icon and the label.
        Text(label), // Text label below the icon.
      ],
    );
  }
}

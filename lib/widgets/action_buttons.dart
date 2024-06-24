import 'package:flutter/material.dart';


class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ActionButton(icon: Icons.send, color: Colors.orange, label: 'Send'),
        ActionButton(icon: Icons.payment, color: Colors.blue, label: 'Pay'),
        ActionButton(icon: Icons.receipt_long, color: Colors.green, label: 'Bills'),
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
        Icon(icon, size: 40, color: color),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}

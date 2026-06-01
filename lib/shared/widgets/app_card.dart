import 'package:flutter/material.dart';
import '../../core/theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double radius;

  const AppCard({
    super.key,
    required this.child,
    this.color,
    this.borderColor,
    this.padding,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color ?? AppColors.card,
        border: borderColor != null ? Border.all(color: borderColor!, width: 1.5) : null,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class BarRow extends StatelessWidget {
  final String label;
  final double value; // 0.0 ~ 1.0
  final Color? fillColor;

  const BarRow({super.key, required this.label, required this.value, this.fillColor});

  @override
  Widget build(BuildContext context) {
    final pct = (value * 100).round();
    final color = fillColor ?? _autoColor(value);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: AppColors.gray)),
              Text('$pct%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF333333))),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 7,
              backgroundColor: const Color(0xFFF0F3F0),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  Color _autoColor(double v) {
    if (v >= 0.7) return AppColors.accent;
    if (v >= 0.5) return AppColors.orange;
    return AppColors.red;
  }
}

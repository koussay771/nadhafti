import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

/// Reusable text field for all auth screens.
/// Fully themed: pill shape, teal focus border, NunitoSans.
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.suffixIcon,
    this.prefixText,
    this.inputFormatters,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final Widget? suffixIcon;
  final String? prefixText;
  final List<dynamic>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurface),
      inputFormatters: inputFormatters?.cast(),
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
        floatingLabelStyle:
            AppTextStyles.labelMd.copyWith(color: AppColors.primary),
        prefixText: prefixText,
        prefixStyle:
            AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
        suffixIcon: suffixIcon,
        // Borders inherited from InputDecorationTheme in app_theme.dart
      ),
    );
  }
}

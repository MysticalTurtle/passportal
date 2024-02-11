import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.nextFocus,
    this.keyboardType = TextInputType.name,
    this.textCapitalization = TextCapitalization.words,
    required this.hintText,
    this.focusNode,
    this.validator,
    this.prefixIcon,
    this.onChanged,
  });

  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType keyboardType;
  final String hintText;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final void Function(String)? onChanged;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: widget.hintText,
          prefixIcon: Icon(widget.prefixIcon),
        ),
        onFieldSubmitted: (value) {
          if (widget.nextFocus != null) {
            FocusScope.of(context).requestFocus(widget.nextFocus);
          } else {
            FocusScope.of(context).unfocus();
          }
        },
        validator: widget.validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Campo requerido';
              }
              return null;
            },
        onChanged: widget.onChanged,
      ),
    );
  }
}

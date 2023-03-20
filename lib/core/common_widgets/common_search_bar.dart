import 'package:flutter/material.dart';
import 'package:ombd/core/utils/typography.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    this.hintText = "Search by",
    required this.textEditingController,
    required this.onPressed,
    this.onClearButtonPressed,
  }) : super(key: key);
  final String hintText;
  final TextEditingController textEditingController;
  final VoidCallback onPressed;
  final VoidCallback? onClearButtonPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: textEditingController,
        onEditingComplete: onPressed,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  if (textEditingController.text.isNotEmpty) {
                    textEditingController.clear();

                    if (onClearButtonPressed != null) {
                      onClearButtonPressed!();
                    } else {
                      onPressed();
                    }
                  }
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.black38,
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.search,
                  color: Colors.blueGrey.withOpacity(0.4),
                ),
              ),
            ],
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          filled: true,
          hintStyle: CustomTypography.body2,
          hintText: hintText,
        ),
      ),
    );
  }
}

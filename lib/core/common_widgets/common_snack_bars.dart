import 'package:flutter/material.dart';
import 'package:ombd/core/utils/typography.dart';

void commonSnackBar({
  required BuildContext context,
  required String msg,
  required SnackBarStatusEnum status,
}) {
  final snackBar = customSnackBar(status, msg, context);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

SnackBar customSnackBar(
    SnackBarStatusEnum status, String msg, BuildContext context) {
  return SnackBar(
    duration: const Duration(seconds: 5),
    content: SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            status == SnackBarStatusEnum.success
                ? Icons.check_circle_outline
                : status == SnackBarStatusEnum.warning
                    ? Icons.warning
                    : Icons.error,
            color: Colors.white,
          ),
          const SizedBox(width: 15),
          Text(
            msg,
            style: CustomTypography.subtitle1White
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
    backgroundColor: status == SnackBarStatusEnum.success
        ? Colors.green
        : status == SnackBarStatusEnum.warning
            ? Colors.yellow
            : Colors.red,
  );
}

enum SnackBarStatusEnum { success, failure, warning }

import 'package:flutter/material.dart';

class SwitchPageButton extends StatelessWidget {
  final bool show;
  final void Function() onPressed;
  final Widget icon;

  const SwitchPageButton({
    super.key,
    required this.show,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: show ? false : true,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: show ? 1 : 0,
        child: IconButton.filled(
          iconSize: 26,
          onPressed: () {
            onPressed();
          },
          icon: icon,
        ),
      ),
    );
  }
}

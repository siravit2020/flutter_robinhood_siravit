import 'package:flutter/material.dart';
import 'package:flutter_robinhood_siravit/core/constants/constants.dart';
import 'package:get/route_manager.dart';

class Numpad extends StatelessWidget {
  final void Function(String) onTab;
  final void Function() onCancel;
  final void Function() onRemove;
  const Numpad({
    Key? key,
    required this.onTab,
    required this.onCancel,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Get.width * 0.8,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NumpadButton(
                  value: '1',
                  onTab: (value) => onTab(value),
                ),
                _NumpadButton(
                  value: '2',
                  onTab: (value) => onTab(value),
                ),
                _NumpadButton(
                  value: '3',
                  onTab: (value) => onTab(value),
                ),
              ],
            ),
            const SizedBox(
              height: Spacing.spacing16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NumpadButton(
                  value: '4',
                  onTab: (value) => onTab(value),
                ),
                _NumpadButton(
                  value: '5',
                  onTab: (value) => onTab(value),
                ),
                _NumpadButton(
                  value: '6',
                  onTab: (value) => onTab(value),
                ),
              ],
            ),
            const SizedBox(
              height: Spacing.spacing16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NumpadButton(
                  value: '7',
                  onTab: (value) => onTab(value),
                ),
                _NumpadButton(
                  value: '8',
                  onTab: (value) => onTab(value),
                ),
                _NumpadButton(
                  value: '9',
                  onTab: (value) => onTab(value),
                ),
              ],
            ),
            const SizedBox(
              height: Spacing.spacing16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _TransparentNumpad(
                  key: const Key('numpad_cancel'),
                  widget: Text(
                    'Cancel',
                    style: TextStyleSet.paragraph300.copyWith(
                      color: ColorPalette.darkGrey,
                    ),
                  ),
                  onTab: onCancel,
                ),
                _NumpadButton(
                  value: '0',
                  onTab: (value) => onTab(value),
                ),
                _TransparentNumpad(
                  key: const Key('numpad_remove'),
                  widget: const Icon(
                    Icons.backspace_rounded,
                    color: ColorPalette.darkGrey,
                  ),
                  onTab: onRemove,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NumpadButton extends StatelessWidget {
  final String value;
  final void Function(String) onTab;
  const _NumpadButton({
    Key? key,
    required this.value,
    required this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: Key('numpad_$value'),
      width: 80,
      height: 80,
      child: ElevatedButton(
        onPressed: () => onTab(value),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          elevation: 0,
          backgroundColor: ColorPalette.disable,
          shadowColor: Colors.transparent,
          foregroundColor: ColorPalette.darkGrey,
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyleSet.paragraph400,
          ),
        ),
      ),
    );
  }
}

class _TransparentNumpad extends StatelessWidget {
  final Widget widget;
  final void Function() onTab;
  const _TransparentNumpad({
    Key? key,
    required this.widget,
    required this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: widget,
        ),
      ),
    );
  }
}

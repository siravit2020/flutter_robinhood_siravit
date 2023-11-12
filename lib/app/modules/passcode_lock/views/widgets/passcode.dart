import 'package:flutter/widgets.dart';
import 'package:flutter_robinhood_siravit/core/constants/constants.dart';

class Passcode extends StatelessWidget {
  final String passcode;
  const Passcode({
    Key? key,
    required this.passcode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Spacing.spacing16,
      children: List.generate(
        6,
        (index) => _Dot(
          isActive: passcode.length > index,
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final bool isActive;
  const _Dot({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = isActive ? ColorPalette.darkGrey : ColorPalette.grey;
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

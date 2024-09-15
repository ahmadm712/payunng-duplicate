import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payuung_pribadi_duplicate/services/styles.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({
    super.key,
    required this.name,
    required this.image,
    this.onTap,
    this.size,
    this.isActive = false,
  });
  final String name;
  final String image;
  final Function()? onTap;
  final Size? size;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final bool isSizeNull = size == null;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: isSizeNull ? 45 : size!.width,
            height: isSizeNull ? 45 : size!.height,
            child: SvgPicture.network(
              image,
              colorFilter: isActive
                  ? ColorFilter.mode(primaryColor, BlendMode.srcIn)
                  : null,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13),
          )
        ],
      ),
    );
  }
}

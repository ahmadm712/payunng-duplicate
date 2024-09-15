import 'package:flutter/material.dart';
import 'package:payuung_pribadi_duplicate/data/models/wellness_model.dart';
import 'package:payuung_pribadi_duplicate/utils/string_util.dart';

class WellnessItem extends StatelessWidget {
  const WellnessItem({
    super.key,
    required this.wellness,
    required this.isHaveDiscount,
  });

  final WellnessModel wellness;
  final bool isHaveDiscount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            margin: const EdgeInsets.only(bottom: 12.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(wellness.image),
              ),
            ),
          ),
          Text(
            wellness.name,
          ),
          const SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                convertToIdr(wellness.price, 0),
                style: TextStyle(
                  decoration:
                      isHaveDiscount ? TextDecoration.lineThrough : null,
                ),
              ),
              const SizedBox(width: 6.0),
              Visibility(
                visible: isHaveDiscount,
                child: Text(
                  '${(wellness.discount?.toInt() ?? 0)}% OFF',
                  style: const TextStyle(
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: isHaveDiscount,
            child: Text(
              convertToIdr(wellness.discountPrice ?? 0, 0),
            ),
          ),
        ],
      ),
    );
  }
}

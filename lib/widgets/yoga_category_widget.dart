import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YogaCategoryWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const YogaCategoryWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final baseWidth = 392.72727272727275;
    final baseHeight = 850.9090909090909;

    double w(double v) => screenWidth * (v / baseWidth);
    double h(double v) => screenHeight * (v / baseHeight);

    final list = data['list'];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choose a Yoga Category',
                style: GoogleFonts.robotoSerif(
                  fontSize: w(16),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  fontSize: w(14),
                  color: Colors.grey,
                ),
              )
            ],
          ),
          SizedBox(height: h(14)),
          GridView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: w(12),
              mainAxisSpacing: h(12),
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) {
              final item = list[index];
              return CategoryCard(item: item, w: w, h: h);
            },
          )
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final double Function(double) w;
  final double Function(double) h;

  const CategoryCard({
    super.key,
    required this.item,
    required this.w,
    required this.h,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(vertical: h(12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w(18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: w(10),
            offset: Offset(0, h(4)),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item['name'],
            style: GoogleFonts.exo(
              fontSize: w(14),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: h(4)),
          Text(
            '${item['workouts']} Workouts',
            style: TextStyle(
              fontSize: w(12),
              color: Colors.grey,
            ),
          ),
          SizedBox(height: h(10)),
          Image.network(
            item['iconUrl'],
            height: h(36),
            fit: BoxFit.contain,
          )
        ],
      ),
    );
  }
}

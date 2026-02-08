import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularVideosWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const PopularVideosWidget({super.key, required this.data});

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
                'Popular Videos',
                style: GoogleFonts.robotoSerif(
                  fontSize: w(16),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'See all',
                style: TextStyle(
                  fontSize: w(14),
                  color: Colors.grey,
                ),
              )
            ],
          ),
          SizedBox(height: h(15)),
          ListView.separated(
            itemCount: list.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => SizedBox(height: h(20)),
            itemBuilder: (context, index) {
              final item = list[index];
              return VideoItem(item: item, w: w, h: h);
            },
          )
        ],
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final double Function(double) w;
  final double Function(double) h;

  const VideoItem({
    super.key,
    required this.item,
    required this.w,
    required this.h,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(w(12)),
          child: Image.network(
            item['thumbnailUrl'],
            width: w(80),
            height: h(64),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: w(23)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['title'],
                style: GoogleFonts.exo(
                  fontSize: w(16),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: h(6)),
              Row(
                children: [
                  Icon(Icons.local_fire_department,
                      size: w(14), color: Colors.blue),
                  SizedBox(width: w(4)),
                  Text(
                    '${item['stats']['kcal']} kcal',
                    style: TextStyle(fontSize: w(14), color: Colors.grey),
                  ),
                  SizedBox(width: w(12)),
                  Icon(Icons.access_time,
                      size: w(14), color: Colors.blue),
                  SizedBox(width: w(4)),
                  Text(
                    '${item['stats']['durationMin']} min',
                    style: TextStyle(fontSize: w(14), color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: h(4)),
              Text(
                item['details'],
                style: TextStyle(
                  fontSize: w(13),
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

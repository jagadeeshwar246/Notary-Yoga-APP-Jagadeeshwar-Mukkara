import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContinueWatchingWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const ContinueWatchingWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final baseWidth = 392.72727272727275;
    final baseHeight = 850.9090909090909;

    double w(double v) => screenWidth * (v / baseWidth);
    double h(double v) => screenHeight * (v / baseHeight);

    final current = data['current'];
    final next = data['next'];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text(
                'Continue Watching',
                style: GoogleFonts.robotoSerif(fontSize: w(17), fontWeight: FontWeight.w600),
              ),
              Text(
                'View all',
                style: TextStyle(color: Colors.grey, fontSize: w(14)),
              )
            ],
          ),
          SizedBox(height: h(14)),
          SizedBox(
            height: h(340),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ContinueCard(item: current),
                SizedBox(width: w(12)),
                ContinueCard(item: next),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ContinueCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const ContinueCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final baseWidth = 392.72727272727275;
    final baseHeight = 850.9090909090909;

    double w(double v) => screenWidth * (v / baseWidth);
    double h(double v) => screenHeight * (v / baseHeight);

    return Container(
      width: w(280),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w(20)),
        image: DecorationImage(
          image: NetworkImage(item['imageUrl']),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(w(14)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(w(20)),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.5),
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              item['title'],
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: w(26),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: h(10)),
            Row(
              children: item['tags']
                  .map<Widget>(
                    (tag) => Container(
                  margin: EdgeInsets.only(right: w(8)),
                  padding: EdgeInsets.symmetric(
                    horizontal: w(10),
                    vertical: h(5),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(w(10)),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w(12),
                    ),
                  ),
                ),
              )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  final Map<String, dynamic> header;

  const HeaderWidget({super.key, required this.header});

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final baseWidth = 392.72727272727275;
    final baseHeight = 850.9090909090909;

    double w(double v) => screenWidth * (v / baseWidth);
    double h(double v) => screenHeight * (v / baseHeight);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: w(12),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    header['greeting'].split(',')[0],
                    style: TextStyle(
                      fontSize: w(16),
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(height: h(2)),
                  Text(
                    header['greeting'].split(',').length > 1
                        ? 'Hello ${header['greeting'].split(',')[1].trim()}'
                        : '',
                    style: GoogleFonts.poppins(
                      fontSize: w(21),
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
              SizedBox(width: w(135),),
              Stack(
                children: [
                  CircleAvatar(
                    radius: w(22),
                    backgroundColor: Colors.white,
                    child: Icon(Icons.notifications_none, size: w(26)),
                  ),
                  if (header['notificationCount'] > 0)
                    Positioned(
                      right: w(2),
                      top: h(2),
                      child: Container(
                        width: w(9),
                        height: h(9),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
          SizedBox(height: h(16)),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: w(14)),
                  height: h(60),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(w(28)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey, size: w(24)),
                      SizedBox(width: w(10)),
                      Text(
                        header['searchPlaceholder'],
                        style: TextStyle(color: Colors.grey,fontSize: w(16)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: w(12)),
              Container(
                height: h(48),
                width: w(48),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(w(16)),
                ),
                child: Icon(Icons.tune, size: w(24)),
              ),
              SizedBox(width:w(10))
            ],
          )
        ],
      ),
    );
  }
}

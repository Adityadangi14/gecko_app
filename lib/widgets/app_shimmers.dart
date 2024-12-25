import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:shimmer/shimmer.dart';

class CategoryBlogsLoadingShimmer extends StatelessWidget {
  const CategoryBlogsLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 5,
          );
        },
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.green[100]!,
            highlightColor: Colors.green[50]!,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    width: 40.w,
                    height: 100,
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 10.w,
                        height: 20,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        width: 40.w,
                        height: 20,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        width: 45.w,
                        height: 20,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoryLoadingShimmer extends StatelessWidget {
  const CategoryLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 12),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.green[100]!,
              highlightColor: Colors.green[50]!,
              child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                  )),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 10,
            );
          },
          itemCount: 5),
    );
  }
}

class TrendingBlogsShimmer extends StatelessWidget {
  const TrendingBlogsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Shimmer.fromColors(
          baseColor: Colors.green[100]!,
          highlightColor: Colors.green[50]!,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12)),
            height: 200,
            width: 85.w,
          ),
        ),
      ],
    );
  }
}

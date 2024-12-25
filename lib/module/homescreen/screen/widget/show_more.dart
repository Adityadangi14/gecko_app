import 'package:flutter/material.dart';
import 'package:geeko_app/module/homescreen/model/blog_model.dart';
import 'package:intl/intl.dart';

class ShowMore extends StatelessWidget {
  const ShowMore({super.key, required this.blogData});
  final BlogData blogData;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blogData.title ?? "",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(blogData.thumbnailUrl ?? "")),
                SizedBox(
                  height: 10,
                ),
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundImage: NetworkImage(
                            blogData.company!.companyLogoURL!,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${blogData.company!.companyName}",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  DateFormat("dd MMMM yyyy").format(
                      DateTime.fromMillisecondsSinceEpoch(
                          int.parse(blogData.pubTime ?? ""))),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(blogData.description ?? "")
              ]),
        ),
      ),
    );
  }
}

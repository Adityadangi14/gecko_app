import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:geeko_app/module/blog-webview/blog_webview.dart';
import 'package:geeko_app/module/homescreen/model/blog_model.dart';
import 'package:geeko_app/module/homescreen/screen/widget/show_more.dart';

class BlogContainer extends StatelessWidget {
  const BlogContainer({super.key, required this.blogData});

  final BlogData blogData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return ShowMore(
              blogData: blogData,
            );
          },
        );
      },
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlogWebview(url: blogData.blogUrl ?? ""),
        ));
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: FittedBox(
          child: Stack(children: [
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return AspectRatio(
                        aspectRatio: 1080 / 650,
                        child:
                            BlurHash(hash: blogData.tThumbnailBlurhash ?? ""));
                  },
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(
                    blogData.thumbnailUrl!,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(
                    bottom: 10, left: 12, right: 12, top: 34),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[
                        Colors.black87,
                        Colors.black54,
                        Colors.black26,
                        Colors.transparent
                      ]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  blogData.title!,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
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
                        radius: 15,
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
                            .labelMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}

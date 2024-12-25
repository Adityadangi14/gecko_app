import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:geeko_app/core/shared-prefrences/shared_prefrences_singleton.dart';
import 'package:geeko_app/module/blog-webview/blog_webview.dart';
import 'package:geeko_app/module/homescreen/controller/blogsController.dart';
import 'package:geeko_app/module/homescreen/model/blog_model.dart';
import 'package:geeko_app/module/homescreen/screen/widget/blog_container.dart';
import 'package:geeko_app/module/homescreen/screen/widget/show_more.dart';
import 'package:geeko_app/widgets/app_shimmers.dart';
import 'package:geeko_app/widgets/button_loading_animation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restart_app/restart_app.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double height = 70.h;

  BlogsController blogsController = Get.find();

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    blogsController.getTrendingBlogs();
    blogsController.getBlogCategories();
    blogsController.getBlogByCategories("All");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent - 1.h <=
                scrollController.position.pixels &&
            blogsController.blogModel.value.isNextPageExist != false &&
            blogsController.isLoadingMoreBlogs.value != true) {
          blogsController.pageNo = blogsController.pageNo + 1;

          blogsController
              .getBlogByCategories(blogsController.selectedCategoryName);
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              actions: [
                Obx(() => blogsController.isThemeDark.value
                    ? IconButton(
                        onPressed: () async {
                          blogsController.isThemeDark.value =
                              !blogsController.isThemeDark.value;
                          await Prefs.setBool(
                              "appTheme", blogsController.isThemeDark.value);

                          Restart.restartApp();
                        },
                        icon: const Icon(
                          CupertinoIcons.sun_max,
                          color: Colors.yellow,
                          size: 30,
                        ))
                    : IconButton(
                        onPressed: () async {
                          blogsController.isThemeDark.value =
                              !blogsController.isThemeDark.value;

                          await Prefs.setBool(
                              "appTheme", blogsController.isThemeDark.value);

                          Restart.restartApp();
                        },
                        icon: const Icon(
                          CupertinoIcons.moon_circle_fill,
                          size: 30,
                        )))
              ],
              centerTitle: true,
              title: Text(
                "Gecko",
                style: GoogleFonts.nothingYouCouldDo(
                    fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: const EdgeInsets.all(9),
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage("${Prefs.getString("profilePicture")}"),
                ),
              )),
          body: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 2.h,
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Hot 🔥",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Obx(() => blogsController.isTrendingLoading.value ||
                        blogsController.trendingBlogs.value.data == null
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [TrendingBlogsShimmer()],
                      )
                    : CarouselSlider(
                        items: blogsController.trendingBlogs.value.data!
                            .map((e) => BlogContainer(
                                blogData: BlogData(
                                    blogUrl: e.blogUrl,
                                    company: e.company,
                                    description: e.description,
                                    iD: e.iD,
                                    pubTime: e.pubTime,
                                    tThumbnailBlurhash: e.tThumbnailBlurhash,
                                    tags: e.tags,
                                    thumbnailUrl: e.thumbnailUrl,
                                    title: e.title)))
                            .toList(),
                        options: CarouselOptions(
                            autoPlay: false,
                            padEnds: true,
                            viewportFraction: 0.85,
                            enlargeCenterPage: true,
                            onPageChanged: ((index, reason) {})),
                      )),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 2.h,
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Categories 🗂️",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: BlogsCategories(),
              ),
              SliverToBoxAdapter(child: CategoryBlogs())
            ],
          )),
    );
  }
}

class BlogList extends StatelessWidget {
  BlogList({super.key});
  final BlogsController blogsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: blogsController.blogModel.value.data!.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 1.h,
      ),
      itemBuilder: (context, index) {
        return BlogContainer(
            blogData: blogsController.blogModel.value.data![index]);
      },
    );
  }
}

class BlogsCategories extends StatefulWidget {
  BlogsCategories({super.key});

  @override
  State<BlogsCategories> createState() => _BlogsCategoriesState();
}

class _BlogsCategoriesState extends State<BlogsCategories> {
  final BlogsController blogsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return blogsController.isCategoriesLoading.value
          ? const Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                CategoryLoadingShimmer(),
                SizedBox(
                  height: 10,
                ),
              ],
            )
          : SizedBox(
              height: 80,
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                scrollDirection: Axis.horizontal,
                itemCount:
                    blogsController.blogCategoriesModel.value.data != null
                        ? blogsController.blogCategoriesModel.value.data!.length
                        : 0,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                itemBuilder: (context, index) {
                  bool isSelected =
                      blogsController.selectedCategoryIndex.value == index;
                  return Obx(() {
                    return FilterChip(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      label: Text(
                        blogsController.blogCategoriesModel.value.data![index]
                                .categoryName ??
                            "",
                        style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black),
                      ),
                      showCheckmark: false,
                      selected:
                          blogsController.selectedCategoryIndex.value == index,
                      onSelected: (value) {
                        blogsController.pageNo = 1;
                        setState(() {
                          blogsController.selectedCategoryIndex.value = index;
                        });

                        blogsController.selectedCategoryName = blogsController
                                .blogCategoriesModel
                                .value
                                .data![index]
                                .categoryName ??
                            "";

                        blogsController.getBlogByCategories(
                            blogsController.selectedCategoryName);
                      },
                    );
                  });
                },
              ),
            );
    });
  }
}

class CategoryBlogs extends StatefulWidget {
  CategoryBlogs({super.key});

  @override
  State<CategoryBlogs> createState() => _CategoryBlogsState();
}

class _CategoryBlogsState extends State<CategoryBlogs> {
  final BlogsController blogsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return blogsController.isLoading.value
          ? const CategoryBlogsLoadingShimmer()
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: blogsController.blogModel.value.data != null
                  ? blogsController.blogModel.value.data!.length
                  : 0,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 15,
                );
              },
              itemBuilder: (context, index) {
                if (blogsController.blogModel.value.data == null) {
                  return Container();
                }
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ShowMore(
                          blogData:
                              blogsController.blogModel.value.data![index],
                        );
                      },
                    );
                  },
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlogWebview(
                          url: blogsController
                                  .blogModel.value.data![index].blogUrl ??
                              ""),
                    ));
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.green.shade200)),
                        height: 100,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return AspectRatio(
                                      aspectRatio: 1080 / 650,
                                      child: BlurHash(
                                          hash: blogsController
                                                  .blogModel
                                                  .value
                                                  .data![index]
                                                  .tThumbnailBlurhash ??
                                              ""));
                                },
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(
                                  blogsController.blogModel.value.data![index]
                                      .thumbnailUrl!,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade400,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircleAvatar(
                                          radius: 6,
                                          backgroundImage: NetworkImage(
                                              blogsController
                                                      .blogModel
                                                      .value
                                                      .data![index]
                                                      .company!
                                                      .companyLogoURL ??
                                                  ""),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          blogsController
                                                  .blogModel
                                                  .value
                                                  .data![index]
                                                  .company!
                                                  .companyName ??
                                              "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      blogsController.blogModel.value
                                              .data![index].title ??
                                          "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                      overflow: TextOverflow.fade,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(() =>
                          blogsController.blogModel.value.data!.length - 1 ==
                                      index &&
                                  blogsController.isLoadingMoreBlogs.value
                              ? const ButtonLoadingAnimation()
                              : Container())
                    ],
                  ),
                );
              },
            );
    });
  }
}

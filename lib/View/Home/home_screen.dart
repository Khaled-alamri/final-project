import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Component/Custom%20Question%20card.dart';
import 'package:final_project/Component/CustomArticleCardStatic.dart';
import 'package:final_project/Component/CustomQuestionCardStatic.dart';
import 'package:final_project/Component/custom%20IconwithName.dart';
import 'package:final_project/Component/custom%20contentText.dart';
import 'package:final_project/Component/custom%20article%20card.dart';
import 'package:final_project/Controller/homepage%20Controller.dart';
import 'package:final_project/Custom/CustomAppBar.dart';
import 'package:final_project/Custom/CustomAppBarWithOutPic.dart';
import 'package:final_project/Packages/package.dart';
import 'package:final_project/Services/Storage/File.dart';
import 'package:final_project/Services/firebase/articleSystem.dart';
import 'package:final_project/View/Home/QuestionPage.dart';
import 'package:final_project/View/article/StudentsAtricleView.dart';
import 'package:final_project/View/article/atricle%20view.dart';
import 'package:final_project/View/article/problem_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  HomePageController C_HomePage = Get.put(HomePageController());

  articleSystem article = articleSystem();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: Get.height,
      width: Get.width,
      decoration: const BoxDecoration(
        gradient:
            LinearGradient(colors: [Color(0xFFD9FFF3), Color(0xFFFFE1F9)]),
      ),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: CustomAppBarWithOutPic(
            backgroundColor: primaryColor.withOpacity(0.2),
            height: 70,
            iconColor: primaryColor,
            title: "الصفحة الرئيسية",
            titleColor: primaryColor,
          ),
          backgroundColor: Colors.transparent,
          body: RefreshIndicator(
            onRefresh: () async {
              C_HomePage.onInit();
            },
            child: GetBuilder<HomePageController>(
                init: HomePageController(),
                builder: (_) {
                  return InkWell(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: C_HomePage.articleList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Get.to(ProblemScreen(),
                                  arguments: C_HomePage.articleList[index]);
                            },
                            child: CustomArticleCard(
                              cardDate: C_HomePage.articleList[index]["date"],
                              commentCont: C_HomePage.articleList[index]
                                  ["commentCount"],
                              likeCont: C_HomePage.articleList[index]
                                  ["likeCount"],
                              PostOwnrName: C_HomePage.articleList[index]
                                  ["authName"],
                              postTitle: C_HomePage.articleList[index]["title"],
                              PostBody: C_HomePage.articleList[index]["body"],
                              authImage: C_HomePage.articleList[index]
                                  ["authImage"],
                            ),
                          );
                        }),
                  );
                }),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: HexColor("#117c78"),
            onPressed: () {
              Get.to(QuestionPage());
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }

  ListView Viewbody() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: C_HomePage.articleList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return CustomArticleCard(
            onTap: () {
              Get.to(ArticleView());
              print("AAAAAAAAAA");
            },
            cardDate: C_HomePage.articleList[index]["date"],
            commentCont: C_HomePage.articleList[index]["commentCount"],
            likeCont: C_HomePage.articleList[index]["likeCount"],
            PostOwnrName: C_HomePage.articleList[index]["authName"],
            postTitle: C_HomePage.articleList[index]["title"],
            PostBody: C_HomePage.articleList[index]["body"],
            authImage: C_HomePage.articleList[index]["authImage"],
          );
        });
  }
}

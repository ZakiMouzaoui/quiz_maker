import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/controllers/quiz_controller.dart';
import 'package:quiz_maker/pages/create_quiz.dart';
import 'package:quiz_maker/pages/quiz_detail_page.dart';
import 'package:quiz_maker/widgets/app_name_widget.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppNameWidget(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(()=>CreateQuizPage());
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: GetBuilder<QuizController>(
            builder: (_) =>
                ListView.builder(
                  itemCount: _quizController.quizList.length,
                    itemBuilder: (_, index) {
                    final quizItem = _quizController.quizList.elementAt(index);
                    return GestureDetector(
                      onTap: (){
                        Get.to(()=>QuizDetailPage(), arguments: {
                          "quizId": quizItem.get("quizId")
                        });
                      },
                      child: Container(
                        height: 130,
                        margin: EdgeInsets.only(bottom: 20),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                                imageUrl: quizItem.get("imgUrl"),
                              imageBuilder: (_,provider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: provider,
                                    fit: BoxFit.cover,
                                    //colorFilter: ColorFilter.mode(Colors.black45.withOpacity(0.9), BlendMode.dstATop),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              placeholder: (_,__) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (_,__,___) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Center(
                                  child: Icon(Icons.error_outline),
                                ),
                              ),
                            ),
                            Positioned(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black26
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        quizItem.get('title'),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Text(quizItem.get('description'),style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                    );
                    }
                )
        ),
      ),
    );
  }
}

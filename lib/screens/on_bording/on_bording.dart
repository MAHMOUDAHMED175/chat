import 'package:chat/component/component.dart';
import 'package:chat/screens/login/login.dart';
import 'package:chat/screens/pageroute.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../component/cache_helper.dart';

class BoardingModel {
  String? image;
  String? title;
  String? body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var borderController=PageController();
  bool isLast=false;
  List<BoardingModel> boarding=[
    BoardingModel(
      image: 'assets/images/chat.png',
      title: 'Write',
      body: 'Write and send voice messages and pictures to your loved ones',

    ),
    BoardingModel(
      image: 'assets/images/chatt.png',
      body:"Write whatever you want at any time of the day",
      title: 'Receive messages',
    ),
    BoardingModel(
      image: 'assets/images/chattt.png',
      body: 'Connect with people from all over the world',
      title: 'Connect',
    ),

  ];
void submit(){
  CacheHelper.saveShared(key:'onBoarding', value: true).then((value){
    navigateAndFinish(context, MyLogin());

  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(80.0),
                ),
                child: TextButton(
                  onPressed:(){

                    submit();
                  },
                  child:const Text(
                    'SKIP',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),

                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
          ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              //ال pageView دي الصفحه اللى قبل تسجل الدخول اللى بتعرفك على التطبيق
              child: PageView.builder(
                reverse: false,


                onPageChanged: (int index){
                  if(index==boarding.length-1)
                    {
                      setState(() {
                        isLast=true;
                      });
                    }else
                      {

                        setState(() {
                          isLast=false;
                        });
                      }

                },
                controller:borderController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height:40.1,
            ),
            Row(
              children: [
                //دى علشان شكل التلت نقط اللى هتتحرك لما احرك الشاشات والنقط تتحرك معاها اسمها //indacator

                SmoothPageIndicator(
                  controller:borderController,
                  //علشان شكل التلت نقط
                  effect:const ExpandingDotsEffect(
                    dotColor:Colors.blueAccent,
                    activeDotColor:Colors.orange,
                    dotHeight:15,
                    expansionFactor:4,//دي اللى بتوصل بين النقطتين
                    dotWidth:15,
                    spacing:5,
                  ),
                  count:boarding.length,
                ),

                const Spacer(),//علشان يرمى اللى بعديه فى اخر الصفحه يعنى بيبعد اللى قبليه عن اللى بعديه
                FloatingActionButton(
                  onPressed: (){
                    borderController.nextPage(duration:  const Duration(
                      seconds: 4
                    ), curve: Curves.linearToEaseOut);
                    if(isLast){
                      submit();
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel boardingForModel)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:[
      Expanded(
        child: Image(
          fit: BoxFit.contain,
            image: AssetImage(boardingForModel.image!)
        ),
      ),
      const SizedBox(
        height:20.1,
      ),
      GradientText(
        boardingForModel.title!,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width/12,
        ),
        gradientType: GradientType.linear,
        radius: 8.5,
        colors: [
          Colors.blue,
          Colors.red,
          Colors.teal,
        ],
      ),

      const SizedBox(
        height:20.1,
      ),
      GradientText(
        boardingForModel.body!,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width/15,
        ),
        gradientType: GradientType.linear,
        radius: 8.5,
        colors: [
          Colors.blue,
          Colors.red,
          Colors.teal,
        ],
      ),
      const SizedBox(
        height:15.1,
      ),
    ],
  );
}
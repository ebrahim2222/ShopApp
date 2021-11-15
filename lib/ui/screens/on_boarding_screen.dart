import 'package:flutter/material.dart';
import 'package:shop_app/model/on_boarding.dart';
import 'package:shop_app/network/local/shared_helper.dart';
import 'package:shop_app/ui/screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingState();
}


class _OnBoardingState extends State<OnBoardingScreen> {
  var pageController = PageController();
  List<OnBoardingModel> onboardingList = [
    OnBoardingModel(
        image: "images/appicon.jpeg",
        title: "Title1"
    ),
    OnBoardingModel(
        image: "images/person.jpeg",
        title: "Title2"
    )
  ];
  int pageCurrentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemBuilder: (context,index){
                  return Column(
                    children: [
                      Expanded(child: Image.asset("${onboardingList[index].image}")),
                      const SizedBox(height: 20,),
                      Text("${onboardingList[index].title}")
                    ],
                  );
                },
                itemCount:onboardingList.length,
                onPageChanged: (index){
                  setState(() {
                    print(pageCurrentIndex);
                    pageCurrentIndex = index;
                  });
                  if(pageCurrentIndex ==onboardingList.length-1){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginScreen()));
                  }
                },
              ),
            ),

            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count:  onboardingList.length,
                  axisDirection: Axis.horizontal,
                  effect:  const SlideEffect(
                      spacing:  8.0,
                      radius:  4.0,
                      dotWidth:  24.0,
                      dotHeight:  16.0,
                      paintStyle:  PaintingStyle.stroke,
                      strokeWidth:  1.5,
                      dotColor:  Colors.grey,
                      activeDotColor:  Colors.indigo
                  ),
                )
                ,
                const Spacer(),
                FloatingActionButton(
                  onPressed: (){
                  if(pageCurrentIndex ==onboardingList.length-2){
                    SharedHelper.putOnBoardingValue(value: true).then((value)  {
                      print(value) ;
                      if(value){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginScreen()));
                      }
                    });
                  }else{
                    pageController.nextPage(duration: const Duration(milliseconds: 370), curve: Curves.fastLinearToSlowEaseIn);
                  }
                },child: const Icon(Icons.arrow_forward_ios))
              ],
            )

          ],
        )
      ),
    );
  }

}
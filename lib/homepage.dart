import 'package:allen/feature_list.dart';
import 'package:allen/pallete.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Allen'),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      // voice chat Image
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                        color: Pallete.assistantCircleColor,
                        shape: BoxShape.circle),
                  ),
                ),
                Center(
                  child: Container(
                    height: 123,
                    width: 123,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/virtualAssistant.png'),
                      ),
                    ),
                  ),
                )
              ],
            ),
            // chat bubble
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin:
                  const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
              decoration: BoxDecoration(
                  border: Border.all(color: Pallete.borderColor),
                  borderRadius:
                      BorderRadius.circular(20).copyWith(topLeft: Radius.zero)),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Good Morning, What task Can i do for you ?',
                  style: TextStyle(
                      color: Pallete.mainFontColor,
                      fontSize: 25,
                      fontFamily: 'Cera Pro'),
                ),
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10, left: 22),
              child: const Text(
                "Here are a new commands",
                style: TextStyle(
                  fontFamily: "Cera Pro",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Pallete.mainFontColor,
                ),
              ),
            ),
            //feature list
            const FeatureList(
              color: Pallete.firstSuggestionBoxColor,
              headerText: 'Chat GPT',
              descriptionText: 'Make  search Your searching faster and large',
            ),
            const FeatureList(
              color: Pallete.secondSuggestionBoxColor,
              headerText: 'alexa',
              descriptionText: 'Make  search Your searching faster and large',
            ),
            const FeatureList(
              color: Pallete.thirdSuggestionBoxColor,
              headerText: 'Dellby',
              descriptionText: 'Make  search Your searching faster and large',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.mic),
      ),
    );
  }
}

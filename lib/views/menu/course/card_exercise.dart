import 'package:flutter/material.dart';
import 'package:project/models/images.dart';
import 'package:project/services/database_images.dart';
import 'package:project/services/database_exercies.dart';
import 'package:project/models/exercise.dart';
import 'package:project/views/menu/course/course_card.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  ImagesDBService imagesDBService = ImagesDBService();
  ExerciseDBService exerciseDBService = ExerciseDBService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          IconButton(onPressed: addExercise, icon: Icon(Icons.add)),
      body: StreamBuilder(
          stream: exerciseDBService.getExercise(),
          builder: (context, snapshot) {
            List exercises = snapshot.data?.docs ?? [];

            if (exercises.isEmpty) {
              return const Center(
                child: Text("Please add some exercise."),
              );
            }

            return StreamBuilder(
                stream: imagesDBService.getImage(),
                builder: ((context, snapshot) {
                  List images = snapshot.data?.docs ?? [];

                  if (images.isEmpty) {
                    return const Center(
                      child: Text("Please add some images."),
                    );
                  }
                  return ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      Exercise exercise = exercises[index].data();
                      String exerciseId = exercises[index].id;

                      String url = "";
                      for (var i in images) {
                        Images images = i.data();
                        String exerciseId = i.id;
                        if (exercise.getimageKey() == exerciseId) {
                          url = images.getUrl();
                          break;
                        }
                        print("RUNING SEARCH!!");
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: CountCard(
                            exrciseName: exercise.getName(),
                            description: exercise.getDescription(),
                            restTime: exercise.getRestTime(),
                            image: url),
                      );
                    },
                  );
                }));
          }),
    );
  }

  void addExercise() {
    exerciseDBService.addExercise(Exercise.withKEY("New Data", "New Description", 50,"DeadLift"));
  }
}

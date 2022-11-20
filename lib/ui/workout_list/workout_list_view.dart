import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:magic/core/models/workout.dart';
import 'package:magic/core/utils/formatters.dart';
import 'package:magic/ui/widgets/loader.dart';
import 'package:magic/ui/workout_list/workout_list_view_model.dart';
import 'package:stacked/stacked.dart';

class WorkOutListView extends StatelessWidget {
  const WorkOutListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkOutListViewModel>.reactive(
      viewModelBuilder: () => WorkOutListViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (_, model, __) {
        return Container(
          color: Theme.of(context).colorScheme.primary,
          child: SafeArea(
            bottom: false,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Workouts',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              body: Builder(builder: (_) {
                if (model.isBusy) {
                  return Loader();
                }

                if (!model.isBusy) {
                  return ValueListenableBuilder(
                    valueListenable: model.workoutBox,
                    builder: (context, Box box, widget) {
                      if (model.box.isEmpty) {
                        return _EmptyWorkOutWidget();
                      }

                      if (model.box.isNotEmpty) {
                        return Container(
                          padding: EdgeInsets.only(top: 16),
                          child: ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (_, index) {
                              return SizedBox(
                                height: 8,
                              );
                            },
                            itemCount: box.length,
                            itemBuilder: (_, index) {
                              var item = box.getAt(index) as Workout;
                              return _WorkOutTile(
                                workout: item,
                                onTapped:()=> model.viewDetail(index),
                                onDeleteTapped: () {
                                  showDeleteDialog(
                                      context: context,
                                      index: index,
                                      model: model);
                                },
                              );
                            },
                          ),
                        );
                      }

                      return Loader();
                    },
                  );
                }

                return Loader();
              }),
              floatingActionButton: FloatingActionButton(
                onPressed: model.addWorkOut,
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.primary,
                ),
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        );
      },
    );
  }

  showDeleteDialog(
      {required BuildContext context,
      required int index,
      required WorkOutListViewModel model}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            "Delete Workout?",
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          content: Text(
            "Deleting this workout will remove it from your list of saved workouts. Press OK to proceed",
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              child:
                  Text("Cancel", style: Theme.of(context).textTheme.bodyText1),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: Text("OK",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).colorScheme.error)),
              onPressed: () async {
                await model.deleteWorkOut(index);
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }
}

class _EmptyWorkOutWidget extends StatelessWidget {
  const _EmptyWorkOutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_emotions,
              size: 48,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'No recorded workout(s)',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'Tap the + button to record a new workout',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkOutTile extends StatelessWidget {
  final Workout workout;
  final VoidCallback onDeleteTapped;
  final VoidCallback onTapped;
  const _WorkOutTile(
      {Key? key, required this.workout,required this.onTapped, required this.onDeleteTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          border: Border.all(color: Theme.of(context).colorScheme.secondary)),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                  child:  Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${workout.name}',
                          maxLines: 3,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${workout.sets.length} ${workout.sets.length > 1 ? 'sets' : 'set'} - ${Formatters.toLocalDateWithTime(workout.createdAt)}',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),

                ),


              GestureDetector(
                    onTap: onDeleteTapped,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.delete_outline_rounded,
                          color: Theme.of(context).colorScheme.error),
                    ),
                  ),
            ],
          ),
          SizedBox(height:8),
          GestureDetector(
            onTap: onTapped,
            child: Text('View detail',style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Theme.of(context).colorScheme.primary
            ),),
          ),
        ],
      ),
    );
  }
}

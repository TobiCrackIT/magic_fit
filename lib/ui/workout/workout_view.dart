import 'package:flutter/material.dart';
import 'package:magic/core/enums/workout_status.dart';
import 'package:magic/core/models/workout_set.dart';
import 'package:magic/core/utils/formatters.dart';
import 'package:magic/ui/widgets/loader.dart';
import 'package:magic/ui/workout/workout_view_model.dart';
import 'package:stacked/stacked.dart';

class WorkoutView extends StatelessWidget {
  const WorkoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkOutViewModel>.reactive(
      viewModelBuilder: () => WorkOutViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (_, model, __) {
        return Container(
          color: Theme.of(context).colorScheme.primary,
          child: SafeArea(
            bottom: false,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  '${model.screenTitle}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: model.back,
                  icon: Icon(
                    Icons.chevron_left,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              body: Builder(builder: (_) {
                if (model.isBusy) {
                  return Loader();
                }

                if (!model.isBusy &&
                    model.workoutStatus == WorkoutStatus.detail) {
                  return _WorkOutDetailView();
                }

                if (!model.isBusy && model.workoutStatus == WorkoutStatus.add) {
                  return _NewWorkOutView();
                }

                return Loader();
              }),
            ),
          ),
        );
      },
    );
  }
}

class _WorkOutDetailView extends ViewModelWidget<WorkOutViewModel> {
  const _WorkOutDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${model.currentWorkout!.name}',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 4),
          Text(
            '${Formatters.toLocalDateWithTime(model.currentWorkout!.createdAt)}',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(height: 20),
          Text(
            'Sets',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 12),
          ...model.currentWorkout!.sets
              .map((e) => _WorkOutSetTile(workoutSet: e))
              .toList(),
        ],
      ),
    );
  }
}

class _NewWorkOutView extends ViewModelWidget<WorkOutViewModel> {
  const _NewWorkOutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              maxLines: 1,
              decoration:
                  InputDecoration(hintText: 'Name your workout(Optional)'),
              keyboardType: TextInputType.name,
              onChanged: (v)=>model.setWorkOutName(v),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Workout Set'),
            TextField(
              maxLines: 1,
              decoration: InputDecoration(hintText: 'Weight used(kg)'),
              keyboardType: TextInputType.number,
              onChanged: (v)=>model.setWeight(v),
            ),
            SizedBox(
              height: 8,
            ),

            Text('Select Exercise'),
            DropdownButton(
              elevation: 2,
              value: model.selectedExercise,
              hint: Text('Select exercise'),
              borderRadius: BorderRadius.all(Radius.circular(8),),
              items: model.exerciseList
                  .map((e) => DropdownMenuItem<String>(child: Text(e),value: e,))
                  .toList(),
              onChanged: (String? v){
                model.selectExercise(v!);
              },
              iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
              isExpanded: true,
            ),
            SizedBox(
              height: 20,
            ),
            Text('Repetitions'),
            SizedBox(
              height: 12,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: model.decreaseRepetition,
                      icon: Icon(Icons.remove)),
                  Text(
                    '${model.repetitions}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  IconButton(
                      onPressed: model.increaseRepetition,
                      icon: Icon(Icons.add)),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: model.canContinue ? model.saveWorkOut : () {},
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: model.canContinue
                        ? Theme.of(context).colorScheme.onSecondary
                        : Theme.of(context)
                            .colorScheme
                            .onSecondary
                            .withOpacity(0.7)),
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    'Done',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Theme.of(context).colorScheme.surface),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkOutSetTile extends StatelessWidget {
  final WorkoutSet workoutSet;
  const _WorkOutSetTile({Key? key, required this.workoutSet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${workoutSet.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                'Repetitions : ${workoutSet.repetitions}',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          Text(
            '${workoutSet.weight}kg',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}

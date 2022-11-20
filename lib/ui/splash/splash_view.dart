import 'package:flutter/material.dart';
import 'package:magic/ui/splash/splash_view_model.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
        viewModelBuilder: ()=>SplashViewModel(),
        onModelReady: (model)=>model.initialise(),
        builder: (_,model,__){
          return Container(
            color: Theme.of(context).colorScheme.primary,
            child: Center(
              child: Text(
                'Magic',
                  textDirection: TextDirection.ltr,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          );
        },
    );
  }
}

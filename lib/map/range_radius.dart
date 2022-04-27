import 'package:covid_100kmfr/map/bloc/bloc.dart';
import 'package:covid_100kmfr/map/bloc/maps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RangeRadius extends StatefulWidget {
  final bool isRadiusFixed;
  const RangeRadius({@required this.isRadiusFixed});

  @override
  _RangeRadiusState createState() => _RangeRadiusState();
}

class _RangeRadiusState extends State<RangeRadius> {
  double _radius = 100000;
  MapsBloc _mapsBloc;
  @override
  void initState() {
    super.initState();
    _mapsBloc = BlocProvider.of<MapsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _mapsBloc,
      listener: (context, state) {
        if (state is RadiusUpdate) {
          _radius = state.radius;
        }
      },
      child: Positioned(
        bottom: 20.0,
        left: 10.0,
        right: 10.0,
        child: Card(
            child: BlocBuilder(
          bloc: _mapsBloc,
          builder: (context, state) {
            return Column(
              children: <Widget>[
                Text('#StopCovid : 100km max.', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),),
                // Text(_radius.toInt().toString() + ' Mtrs'),
                // Slider(
                //   max: 100000,
                //   min: 1000,
                //   value: _radius,
                //   activeColor: Colors.red,
                //   inactiveColor: Colors.grey,
                //   divisions: 12,
                //   onChanged: (double value) {
                //     if (!widget.isRadiusFixed) {
                //       _mapsBloc.dispatch(UpdateRangeValues(radius: value));
                //     }
                //   },
                // ),
                FlatButton(
                  child: Text(widget.isRadiusFixed != true
                      ? 'Verrouiller le lieu de résidence'
                      : 'Déverrouiller le lieu de résidence'),
                  onPressed: () => _mapsBloc.dispatch(IsRadiusFixedPressed(
                      isRadiusFixed: widget.isRadiusFixed)),
                  color:
                      widget.isRadiusFixed != true ? Colors.blue : Colors.red,
                )
              ],
            );
          },
        )),
      ),
    );
  }
}

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quran_aziz/utils/colors.dart';
import 'package:quran_aziz/utils/more_screens_appBar.dart';

import '../../../utils/apptheme.dart';

class PrayerTimingsScreen extends StatefulWidget {
  const PrayerTimingsScreen({super.key});

  @override
  State<PrayerTimingsScreen> createState() => _PrayerTimingsScreenState();
}

class _PrayerTimingsScreenState extends State<PrayerTimingsScreen> {
  List<Map<String, String>> _prayersTime = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MoreScreensAppBar(
        color: AppColors.white,
        text: "Prayer Timings",
      ),
      body: ListView.builder(
        itemCount: _prayersTime.length,
          itemBuilder: (context ,index){
            final prayer = _prayersTime[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
              tileColor: AppColors.mainAppColor ,
              shape: const StadiumBorder(),
              title: Text(prayer['name']! ,style: AppTheme.textTheme.labelSmall!
                  .copyWith(color: AppColors.white, fontSize: 17),),
              trailing: Text(prayer['time']!,style: AppTheme.textTheme.labelSmall!
                  .copyWith(color: AppColors.white, fontSize: 16)),
              ),
            );
          }
      ),
    );
  }
  _load() {

    // aisha

  final myLocation = Coordinates(31.5204, 74.3587);
    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myLocation, params);
  _prayersTime = [
    {"name": "Fajr", "time": DateFormat.jm().format(prayerTimes.fajr)},
    {"name": "Sunrise", "time": DateFormat.jm().format(prayerTimes.sunrise)},
    {"name": "Dhuhr", "time": DateFormat.jm().format(prayerTimes.dhuhr)},
    {"name": "Asr", "time": DateFormat.jm().format(prayerTimes.asr)},
    {"name": "Maghrib", "time": DateFormat.jm().format(prayerTimes.maghrib)},
    {"name": "Isha", "time": DateFormat.jm().format(prayerTimes.isha)},
  ];
  }

}

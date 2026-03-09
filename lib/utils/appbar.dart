


import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import 'apptheme.dart';
import 'colors.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final String? imagepath;
  final void Function()? onPressed;
  final GlobalKey<ScaffoldState> scaffoldKey; // Add scaffoldKey here


  const CustomAppBar({super.key, this.title, this.imagepath, required this.scaffoldKey, this.onPressed});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(250);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String? nowPrayerName;
  String? upcomingPrayerName;
  String? upcomingPrayerTime;
  String? islamicDate;
  String? currentDateTime;
  int? islamicDay;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    _load();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(

      // toolbarHeight: 150,

      backgroundColor: AppColors.mainAppColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30), // Adjust the radius as needed
        ),
      ),
      centerTitle: true,
      title: Text(
        widget.title!,
        style: AppTheme.textTheme.titleMedium,
      ),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.refresh,
            color: AppColors.white,
          ),
          tooltip: 'Refresh',
          onPressed: widget.onPressed ,
        ), //Icon
      ],
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: AppColors.white,
        ),
        tooltip: 'Menu Icon',
        onPressed: () async{
          setState(() {
          });
          widget.scaffoldKey.currentState?.openDrawer(); // Open the drawer

        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(200.0),

        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Now",
                      style: TextStyle(color: AppColors.white),
                    ),
                    Text(
                      "$nowPrayerName",
                      style: AppTheme.textTheme.labelLarge!
                          .copyWith(color: AppColors.white, fontSize: 20),
                    ),
                    const Text("Upcoming",
                        style: TextStyle(color: AppColors.white)),
                    Text(
                      "$upcomingPrayerName",
                      style: AppTheme.textTheme.labelLarge!
                          .copyWith(color: AppColors.white),
                    ),
                    Text("$upcomingPrayerTime",
                        style: const TextStyle(color: AppColors.white)),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 22),
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(widget.imagepath!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      islamicDay.toString(),
                      style: AppTheme.textTheme.labelLarge!
                          .copyWith(color: AppColors.white, fontSize: 20),
                    ),
                    Text("$islamicDate",
                        style: const TextStyle(color: AppColors.white)),
                    Text("$currentDateTime",
                        style: const TextStyle(color: AppColors.white)),
                  ],
                ),
              ],
            ),
          ),
        ), // Adjust height for the bottom content
      ),
    );
  }
   adjustIslamicDay(dynamic currentDay)  {
  var islamicDay = currentDay - 2;

  // Define the number of days in the current Islamic month (you could look this up or calculate)
  const daysInPreviousMonth = 30;  // Assuming previous month had 30 days, adjust as necessary

  // If the result is less than 1, wrap around to the previous month
  if (islamicDay < 1) {
  islamicDay = daysInPreviousMonth + islamicDay;
  }

  return islamicDay;
}

  _load() {

    var today = HijriCalendar.now();
    islamicDate = '${today.shortMonthName} ${today.hYear}';
    islamicDay = adjustIslamicDay(today.hDay);


    print("today islamic date and date: $islamicDay  and islamic date: $islamicDate");
    // Example location (latitude, longitude)
    final myLocation = Coordinates(31.471195,74.362914);
    // Calculation method (e.g., Muslim World League)
    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.hanafi; // Choose your preferred Madhab

    // Get prayer times
    final prayerTimes = PrayerTimes.today(myLocation, params);
    print(DateFormat.jm().format(prayerTimes.fajr));
    print(DateFormat.jm().format(prayerTimes.sunrise));
    print(DateFormat.jm().format(prayerTimes.dhuhr));
    print(DateFormat.jm().format(prayerTimes.asr));
    print(DateFormat.jm().format(prayerTimes.maghrib));
    print(DateFormat.jm().format(prayerTimes.isha));
    // Get current time
    final now = DateTime.now();
    currentDateTime = DateFormat('MMM d, y').format(now);
    // Determine the current or next prayer
    Prayer? nextPrayer;
    DateTime? nextPrayerTime;
    if (now.isBefore(prayerTimes.fajr)) {
      nextPrayer = Prayer.fajr;
      nextPrayerTime = prayerTimes.fajr;
    } else if (now.isBefore(prayerTimes.sunrise)) {
      nextPrayer = Prayer.sunrise;
      nextPrayerTime = prayerTimes.sunrise;
    } else if (now.isBefore(prayerTimes.dhuhr)) {
      nextPrayer = Prayer.dhuhr;
      nextPrayerTime = prayerTimes.dhuhr;
    } else if (now.isBefore(prayerTimes.asr)) {
      nextPrayer = Prayer.asr;
      nextPrayerTime = prayerTimes.asr;
    } else if (now.isBefore(prayerTimes.maghrib)) {
      nextPrayer = Prayer.maghrib;
      nextPrayerTime = prayerTimes.maghrib;
    } else if (now.isBefore(prayerTimes.isha)) {
      nextPrayer = Prayer.isha;
      nextPrayerTime = prayerTimes.isha;
    } else {
      nextPrayer =
          Prayer.fajr; // The next prayer after Isha is Fajr of the next day
      nextPrayerTime = prayerTimes.fajr.add(const Duration(days: 1));
    }
    // Format the prayer name and time
    final prayerName = getPrayerName(nextPrayer);
    final formattedTime = DateFormat.jm().format(nextPrayerTime);
    print('Next prayer: $prayerName at $formattedTime');
    upcomingPrayerName = prayerName;
    upcomingPrayerTime = formattedTime;
    // Handle current prayer status
    if (prayerName == 'Asr') {
      nowPrayerName = 'Dhuhr';
    } else if (prayerName == 'Fajr') {
      nowPrayerName = 'Isha';
    } else if (prayerName == 'Dhuhr') {
      nowPrayerName = 'Sunrise';
    } else if (prayerName == 'Maghrib') {
      nowPrayerName = 'Asr';
    } else if (prayerName == 'Isha') {
      print("Now is Maghrib time");
      nowPrayerName = 'Maghrib';
    } else if (prayerName == 'Sunrise') {
      print("Now is Fajr time");
      nowPrayerName = 'Fajr';
    } else {
      print("Next prayer is $prayerName at $formattedTime");
      upcomingPrayerName = prayerName;
      upcomingPrayerTime = formattedTime;
    }
  }

  String getPrayerName(Prayer prayer) {
    print("alla prayersname $prayer");
    switch (prayer) {
      case Prayer.fajr:
        return 'Fajr';
      case Prayer.dhuhr:
        return 'Dhuhr';
      case Prayer.asr:
        return 'Asr';
      case Prayer.maghrib:
        return 'Maghrib';
      case Prayer.isha:
        return 'Isha';
      default:
        return '';
    }
  }
}

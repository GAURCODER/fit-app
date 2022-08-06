import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class SendNot extends StatefulWidget {
  const SendNot({Key? key}) : super(key: key);

  @override
  State<SendNot> createState() => _SendNotState();
}

class _SendNotState extends State<SendNot> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  final TextEditingController _date = TextEditingController();
  final TextEditingController _time = TextEditingController();

  DateTime dateTime = DateTime.now();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
      macOS: null,
      linux: null,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (dataYouNeedToUseWhenNotificationIsClicked) {},
    );
  }

  showNotification() {
    if (_title.text.isEmpty || _desc.text.isEmpty) {
      return;
    }

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "ScheduleNotification001",
      "Notify Me",
      importance: Importance.high,
    );

    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
      macOS: null,
      linux: null,
    );

    // flutterLocalNotificationsPlugin.show(
    //     01, _title.text, _desc.text, notificationDetails);

    tz.initializeTimeZones();
    final tz.TZDateTime scheduledAt = tz.TZDateTime.from(dateTime, tz.local);

    flutterLocalNotificationsPlugin.zonedSchedule(
        01, _title.text, _desc.text, scheduledAt, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        payload: 'Ths s the data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // ignore: sized_box_for_whitespace
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                "Medicine Reminder",
                style: TextStyle(color: Colors.black, fontSize: 40),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        style: const TextStyle(color: Colors.black),
                        controller: _title,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0)),
                          label: const Text("Medicine Name",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        style: const TextStyle(color: Colors.black),
                        controller: _desc,
                        decoration: InputDecoration(
                          hoverColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0)),
                          label: const Text(
                            "Medicine Description",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        style: const TextStyle(color: Colors.black),
                        controller: _date,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0)),
                          suffixIcon: InkWell(
                            child: const Icon(
                              Icons.date_range,
                              color: Colors.blue,
                            ),
                            onTap: () async {
                              final DateTime? newlySelectedDate =
                                  await showDatePicker(
                                context: context,
                                initialDate: dateTime,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2095),
                              );

                              if (newlySelectedDate == null) {
                                return;
                              }

                              setState(() {
                                dateTime = newlySelectedDate;
                                _date.text =
                                    "${dateTime.year}/${dateTime.month}/${dateTime.day}";
                              });
                            },
                          ),
                          label: const Text("Date",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextField(
                        style: const TextStyle(color: Colors.black),
                        controller: _time,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            suffixIcon: InkWell(
                              child: const Icon(
                                Icons.timer_outlined,
                                color: Colors.blue,
                              ),
                              onTap: () async {
                                final TimeOfDay? slectedTime =
                                    await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now());

                                if (slectedTime == null) {
                                  return;
                                }

                                _time.text =
                                    "${slectedTime.hour}:${slectedTime.minute}:${slectedTime.period.toString()}";

                                DateTime newDT = DateTime(
                                  dateTime.year,
                                  dateTime.month,
                                  dateTime.day,
                                  slectedTime.hour,
                                  slectedTime.minute,
                                );
                                setState(() {
                                  dateTime = newDT;
                                });
                              },
                            ),
                            label: const Text("Time",
                                style: TextStyle(color: Colors.black))),
                      ),
                      const SizedBox(height: 60),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 55),
                          ),
                          onPressed: () {
                            showNotification();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('We will Inform You'),
                                action: SnackBarAction(
                                  label: '',
                                  onPressed: () {},
                                ),
                                duration: Duration(milliseconds: 1000),
                              ),
                            );
                            Future.delayed(const Duration(milliseconds: 700),
                                () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                          },
                          child: const Text("Hey!  Inform Me")),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

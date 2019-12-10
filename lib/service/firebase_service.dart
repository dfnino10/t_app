import 'package:calendarro/date_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static Firestore firestore = Firestore.instance;

  static Future<List> getTrips(String userId) async {
    DocumentSnapshot user =
    await firestore.collection('passengers').document(userId).get();
    List dbTrips = user['future_trips'];
    List trips = [];
    for (int i = 0; i < dbTrips.length; i++) {
      String tripId = dbTrips[i].documentID;
      DocumentSnapshot trip =
      await firestore.collection('future_trips').document(tripId).get();
      trips.add(trip);
    }
    return trips;
  }

  static Future<List> getFutureTrips(String userId) async {
    List trips = await getTrips(userId);
    List newTrips = [];
    for (int i = 0; i < trips.length; i++) {
      DateTime time = new DateTime.fromMillisecondsSinceEpoch(trips[i]['arrival_datetime'].millisecondsSinceEpoch);

      if (DateTime.now().isBefore(time)) {
        newTrips.add(trips[i]);
      }
    }
    return newTrips;
  }

  static Future<List> getPastTrips(String userId) async {
    List trips = await getTrips(userId);
    List newTrips = [];
    for (int i = 0; i < trips.length; i++) {
      DateTime time = new DateTime.fromMillisecondsSinceEpoch(trips[i]['arrival_datetime'].millisecondsSinceEpoch);

      if (DateTime.now().isAfter(time)) {
        newTrips.add(trips[i]);
      }
    }
    return newTrips;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class DemoStreamingApp extends StatefulWidget {
  const DemoStreamingApp({Key? key}) : super(key: key);

  @override
  _DemoStreamingAppState createState() => _DemoStreamingAppState();
}

class _DemoStreamingAppState extends State<DemoStreamingApp> {
  final channel = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/bnbusdt@trade');

  String livePrice = "0.0";

  @override
  initState() {
    super.initState();
    streamListener();
  }

  streamListener() {
    channel.stream.listen((message) {
      debugPrint('Received: $message');
      Map getData = jsonDecode(message);
      setState(() {
        livePrice = getData['p'];
      });
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'BTC/USDT Price',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              livePrice,
              style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            )
          ],
        ),
      ),
    );
  }
}

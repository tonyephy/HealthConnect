import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCallScreen extends StatefulWidget {
  final String therapistName;

  const VideoCallScreen({super.key, required this.therapistName});

  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  @override
  void initState() {
    super.initState();
    _initRenderers();
    _startVideoCall();
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  void _startVideoCall() async {
    // Create peer connection
    _peerConnection = await createPeerConnection({
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    });

    // Add local stream to peer connection
    _localStream = await _getUserMedia();
    _peerConnection!.addStream(_localStream!);

    // Set up event listeners for remote stream
    _peerConnection!.onAddStream = (stream) {
      _remoteRenderer.srcObject = stream;
    };

    // Implement signaling (omitted for brevity)
  }

  Future<MediaStream> _getUserMedia() async {
    final constraints = {
      'audio': true,
      'video': {
        'facingMode': 'user',
      },
    };

    return await navigator.mediaDevices.getUserMedia(constraints);
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _peerConnection?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call with ${widget.therapistName}'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: RTCVideoView(_remoteRenderer),
          ),
          Positioned(
            right: 16,
            top: 16,
            width: 120,
            height: 160,
            child: RTCVideoView(_localRenderer),
          ),
        ],
      ),
    );
  }
}

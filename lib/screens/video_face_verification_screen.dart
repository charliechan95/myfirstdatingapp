import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import '../theme.dart';
import '../data/models.dart';
import '../nav.dart';

class VideoFaceVerificationScreen extends StatefulWidget {
  const VideoFaceVerificationScreen({super.key});

  @override
  State<VideoFaceVerificationScreen> createState() => _VideoFaceVerificationScreenState();
}

class _VideoFaceVerificationScreenState extends State<VideoFaceVerificationScreen> with SingleTickerProviderStateMixin {
  bool _isRecording = false;
  bool _isProcessing = false;
  bool _verificationComplete = false;
  double _progress = 0.0;
  String _statusMessage = "Position your face in the frame";
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<String> _verificationSteps = [
    "Positioning face...",
    "Analyzing facial features...",
    "Checking for liveness...",
    "Verifying identity...",
    "Generating report..."
  ];

  int _currentStep = 0;
  
  // Camera related variables
  List<CameraDescription>? _cameras;
  CameraController? _cameraController;
  bool _cameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Request camera permission
    var status = await Permission.camera.request();
    print('Camera permission status: $status');
    
    if (status.isGranted) {
      // Get available cameras
      _cameras = await availableCameras();
      print('Available cameras: $_cameras');
      
      if (_cameras != null && _cameras!.isNotEmpty) {
        // Initialize appropriate camera - prioritize front camera, but handle web cases
        CameraDescription selectedCamera;
        
        // On mobile, use front camera. On web (Chrome), cameras might be external
        final frontCameras = _cameras!.where((camera) => 
            camera.lensDirection == CameraLensDirection.front || 
            camera.lensDirection == CameraLensDirection.external
        ).toList();
        
        if (frontCameras.isNotEmpty) {
          selectedCamera = frontCameras.first;
        } else {
          selectedCamera = _cameras!.first;
        }
        
        print('Selected camera: ${selectedCamera.name}, Lens direction: ${selectedCamera.lensDirection}');

        _cameraController = CameraController(
          selectedCamera,
          ResolutionPreset.high,
          enableAudio: false,
        );

        try {
          await _cameraController!.initialize();
          print('Camera initialized successfully');
          setState(() {
            _cameraInitialized = true;
          });
        } catch (e) {
          print('Error initializing camera: $e');
          _statusMessage = "Camera initialization failed";
        }
      } else {
        print('No cameras available');
        _statusMessage = "No cameras available";
      }
    } else {
      print('Camera permission denied');
      _statusMessage = "Camera permission denied";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  void _startVerification() {
    if (_cameraController == null || !_cameraInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Camera not available'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isRecording = true;
      _statusMessage = "Starting verification...";
    });

    // Simulate verification process with real camera
    _simulateVerificationSteps();
  }

  void _simulateVerificationSteps() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() {
        _currentStep = 1;
        _statusMessage = _verificationSteps[_currentStep];
        _progress = 0.2;
      });

      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;

        setState(() {
          _currentStep = 2;
          _statusMessage = _verificationSteps[_currentStep];
          _progress = 0.4;
        });

        Future.delayed(const Duration(seconds: 2), () {
          if (!mounted) return;

          setState(() {
            _currentStep = 3;
            _statusMessage = _verificationSteps[_currentStep];
            _progress = 0.7;
          });

          Future.delayed(const Duration(seconds: 3), () {
            if (!mounted) return;

            setState(() {
              _currentStep = 4;
              _statusMessage = _verificationSteps[_currentStep];
              _progress = 0.9;
            });

            Future.delayed(const Duration(seconds: 2), () {
              if (!mounted) return;

              setState(() {
                _isProcessing = false;
                _isRecording = false;
                _verificationComplete = true;
                _progress = 1.0;
                _statusMessage = "Verification Complete!";
              });

              _controller.forward();
            });
          });
        });
      });
    });
  }

  void _nextStep() {
    // Navigate to dating preferences screen
    context.push(AppRoutes.datingPreferences);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Verification'),
        backgroundColor: AppTheme.primary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.gradient,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                // Video Preview Container
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _verificationComplete ? Colors.green : AppTheme.primary,
                      width: 3,
                    ),
                  ),
                  child: _verificationComplete
                      ? Center(
                          child: ScaleTransition(
                            scale: _animation,
                            child: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 100,
                            ),
                          ),
                        )
                      : _cameraInitialized && _cameraController != null
                          ? Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(13),
                                  child: CameraPreview(_cameraController!),
                                ),
                                // Face detection overlay
                                Positioned(
                                  top: 50,
                                  left: MediaQuery.of(context).size.width / 2 - 75,
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.green,
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(75),
                                    ),
                                  ),
                                ),
                                if (_isRecording)
                                  const Center(
                                    child: Text(
                                      '🎥 Recording...',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ),
                              ],
                            )
                          : Center(
                              child: _statusMessage.contains('Camera')
                                  ? Text(
                                      _statusMessage,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    )
                                  : const CircularProgressIndicator(
                                      color: AppColors.primary,
                                    ),
                            ),
                ),

                const SizedBox(height: 30),

                // Progress Bar
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _verificationComplete ? Colors.green : AppTheme.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Status Message
                Text(
                  _statusMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 40),

                // Action Buttons
                if (!_isRecording && !_verificationComplete)
                  ElevatedButton(
                    onPressed: _startVerification,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Start Verification',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                if (_verificationComplete)
                  ElevatedButton(
                    onPressed: _nextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                // Tips
                if (!_verificationComplete)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Tips:',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• Ensure good lighting\n• Keep your face centered\n• Remove glasses if possible\n• Stay still during verification',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

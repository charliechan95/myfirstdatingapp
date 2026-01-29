import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import '../theme.dart';
import '../nav.dart';

class FaceAuthenticationScreen extends StatefulWidget {
  const FaceAuthenticationScreen({super.key});

  @override
  State<FaceAuthenticationScreen> createState() => _FaceAuthenticationScreenState();
}

class _FaceAuthenticationScreenState extends State<FaceAuthenticationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isScanning = false;
  bool _scanningComplete = false;
  
  // Camera related variables
  List<CameraDescription>? _cameras;
  CameraController? _cameraController;
  bool _cameraInitialized = false;
  String _statusMessage = "Position your face in the frame below";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticInOut,
    );
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Request camera permission
    var status = await Permission.camera.request();
    if (status.isGranted) {
      // Get available cameras
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        // Initialize front camera
        final frontCamera = _cameras!.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
          orElse: () => _cameras!.first,
        );

        _cameraController = CameraController(
          frontCamera,
          ResolutionPreset.high,
          enableAudio: false,
        );

        try {
          await _cameraController!.initialize();
          setState(() {
            _cameraInitialized = true;
          });
          _startScanning();
        } catch (e) {
          print('Error initializing camera: $e');
          setState(() {
            _statusMessage = "Camera initialization failed";
          });
        }
      }
    } else {
      setState(() {
        _statusMessage = "Camera permission denied";
      });
    }
  }

  Future<void> _startScanning() async {
    if (!_cameraInitialized || _cameraController == null) {
      return;
    }

    setState(() {
      _isScanning = true;
    });
    _animationController.repeat(reverse: true);

    // Simulate face scanning
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isScanning = false;
      _scanningComplete = true;
    });

    // Show success message
    await Future.delayed(const Duration(seconds: 1));

    // Navigate to login screen
    context.pushReplacement(AppRoutes.auth);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Face Authentication',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Instructions
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Face Verification',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _statusMessage,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Camera Frame
                Container(
                  width: 280,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _scanningComplete ? AppColors.primary : Colors.grey.shade300,
                      width: 3,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Camera View
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: _scanningComplete
                              ? const Icon(
                                  Icons.check_circle,
                                  size: 80,
                                  color: AppColors.primary,
                                )
                              : _cameraInitialized && _cameraController != null
                                  ? CameraPreview(_cameraController!)
                                  : _statusMessage.contains('Camera')
                                      ? Text(
                                          _statusMessage,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      : const CircularProgressIndicator(
                                          color: AppColors.primary,
                                        ),
                        ),
                      ),
                      // Scanning Animation
                      if (_isScanning)
                        Positioned.fill(
                          child: ScaleTransition(
                            scale: _scaleAnimation,
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Status Text
                Text(
                  _scanningComplete
                      ? 'Verification Successful!'
                      : _isScanning
                          ? 'Scanning face...'
                          : 'Ready to scan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _scanningComplete ? AppColors.primary : Colors.black87,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Info Text
            Text(
              'This helps us verify your identity and protect your account',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

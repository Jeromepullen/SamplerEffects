# Sampler Effects 

iOS App using Swift that allows users to record a sound using the device’s microphone. It then allows users to play the recorded sound back with six different sound modulations.

Uses code from Apple's AVFoundation API to record sounds from the microphone (AVAudioRecorder) and play recorded audio with effects (AVAudioPlayer, AVAudioEngine).

## Implementation
Sampler Effects has two Scenes: 
- **RecordSoundsViewController** : consists a record button with a microphone image.
- **PlaySoundsViewController** : contains six buttons to play the recorded sound file with different effects related to the button image and a stop button at the bottom

*The App supports all UI elements (buttons and text) are appropriately formatted for iPhone and iPad Portrait and Landscape layouts.*

*The App uses `UINavigationController` to navigate between these two scenes.*

The application uses code from `AVFoundation` to record sounds from the microphone `(AVAudioRecorder)` and play recorded audio with effects `(AVAudioPlayer, AVAudioEngine)`.

## Sound modulations
- Slow
- Fast
- High Pitch
- Low Pitch
- Echo
- Reverb


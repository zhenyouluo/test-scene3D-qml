import QtQuick 2.0
import QtQuick.Window 2.2
import QtAudioEngine 1.0

Item {
    objectName: "Scene"

    property int inPort : 9999
    property int outPort: 8888
    property string sceneName: "TopLeft"

    property point listener;

    AudioEngine {
        id: audioEngine
        listener.position : Qt.vector3d(listener.x, listener.y, 0);

        AudioCategory {
            name:"sfx"
            volume: 1
        }

        AttenuationModelInverse {
            name:"atten"
            start: 20
            end: 1000
            rolloff: 1
        }

        AudioSample {
            name:"engine"
            source: "/contents/engine-loop.wav"
            preloaded:true
        }

        AudioSample {
            name:"horn"
            source: "/contents/horn.wav"
            preloaded:true
        }
        AudioSample {
            name:"whistle"
            source: "/contents/whistle.wav"
            preloaded:true
        }

        Sound {
            name:"engine_sound"
            attenuationModel:"atten"
            category:"sfx"
            PlayVariation {
                sample:"horn"
                maxGain:0.9
                minGain:0.8
                minPitch: 0.8
                maxPitch: 1.1
            }
            PlayVariation {
                sample:"engine"
                maxGain:0.9
                minGain:0.8
                minPitch: 0.8
                maxPitch: 1.1
            }
        }

        Sound {
            name:"horn_sound"
            attenuationModel:"atten"
            category:"sfx"
            PlayVariation {
                looping:true
                sample:"horn"
                maxGain:0.9
                minGain:0.8
                minPitch: 0.8
                maxPitch: 1.1
            }
        }

        Sound {
            name:"whistle_sound"
            attenuationModel:"atten"
            category:"sfx"
            PlayVariation {
                looping:true
                sample:"whistle"
                maxGain:0.9
                minGain:0.8
                minPitch: 0.8
                maxPitch: 1.1
            }
        }

        dopplerFactor: 1
        speedOfSound: 343.33

        listener.up:"0,0,1"
        listener.velocity:"0,0,0"
        listener.direction:"0,1,0"
    }


    // x = 0 : left; x = max : right
    // y = 0 : front; y = max : back
    // listener pointe vers le bas

    SoundInstance {
        id: shipSound
        engine:audioEngine
        sound:"engine_sound"
        position: Qt.vector3d(300, 400, 0)
        Component.onCompleted: shipSound.play()
    }

    SoundInstance {
        id: hornSound
        engine:audioEngine
        sound:"horn_sound"
        position: Qt.vector3d(500, 600, 0)
        Component.onCompleted: hornSound.play()
    }

}
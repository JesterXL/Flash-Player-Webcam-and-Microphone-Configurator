package com.jxl.webcamrecord.robotlegs.events
{
    import flash.events.*;

    public class HardwareEvent extends Event
    {
        public static const LOAD_HARDWARE:String 					= "loadHardware";
        public static const CAMERAS_CHANGED:String 					= "camerasChanged";
        public static const MICROPHONES_CHANGED:String 				= "microphonesChanged";
        public static const CURRENT_CAMERA_CHANGED:String 			= "currentCameraChanged";
        public static const CURRENT_MICROPHONE_CHANGED:String 		= "currentMicrophoneChanged";

        public function HardwareEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
		}

    }
}

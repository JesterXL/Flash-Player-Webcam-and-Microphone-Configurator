package com.jxl.webcamrecord.robotlegs.models
{
    import com.jxl.webcamrecord.robotlegs.events.*;
    
    import flash.media.*;
    
    import mx.collections.*;
    
    import org.robotlegs.mvcs.*;

    public class HardwareModel extends Actor
    {
        private var _cameras:ArrayCollection;
        private var _microphones:ArrayCollection;
        private var _currentCamera:Camera;
        private var _currentMicrophone:Microphone;

        public function HardwareModel()
        {
			super();
		}

        public function get cameras() : ArrayCollection
        {
            return _cameras;
		}

        public function set cameras(value:ArrayCollection) : void
        {
            _cameras = value;
            dispatch(new HardwareEvent(HardwareEvent.CAMERAS_CHANGED));
		}

        public function get microphones() : ArrayCollection
        {
            return _microphones;
		}

        public function set microphones(value:ArrayCollection) : void
        {
            _microphones = value;
            dispatch(new HardwareEvent(HardwareEvent.MICROPHONES_CHANGED));
		}

        public function get currentCamera() : Camera
        {
            return _currentCamera;
		}

        public function set currentCamera(cam:Camera) : void
        {
            _currentCamera = cam;
            dispatch(new HardwareEvent(HardwareEvent.CURRENT_CAMERA_CHANGED));
		}
		
        public function get currentMicrophone() : Microphone
        {
            return _currentMicrophone;
		}

        public function set currentMicrophone(mic:Microphone) : void
        {
            _currentMicrophone = mic;
            dispatch(new HardwareEvent(HardwareEvent.CURRENT_MICROPHONE_CHANGED));
		}

    }
}

package com.jxl.webcamrecord.robotlegs.mediators
{
    import com.jxl.webcamrecord.controls.*;
    import com.jxl.webcamrecord.robotlegs.events.*;
    import com.jxl.webcamrecord.robotlegs.models.*;
    
    import org.robotlegs.mvcs.*;

    public class MainViewMediator extends Mediator
    {
		[Inject]
        public var mainView:MainView2;
        
		[Inject]
		public var hardwareModel:HardwareModel;

        public function MainViewMediator()
        {
			super();
		}

        override public function onRegister() : void
        {
            super.onRegister();
           
			eventMap.mapListener(eventDispatcher, HardwareEvent.CAMERAS_CHANGED, onHardwareChanged, HardwareEvent);
            eventMap.mapListener(eventDispatcher, HardwareEvent.MICROPHONES_CHANGED, onHardwareChanged, HardwareEvent);
            eventMap.mapListener(eventDispatcher, HardwareEvent.CURRENT_CAMERA_CHANGED, onCurrentCameraChanged, HardwareEvent);
            eventMap.mapListener(eventDispatcher, HardwareEvent.CURRENT_MICROPHONE_CHANGED, onCurrentMicrophoneChanged, HardwareEvent);
        
			refreshViewHardware();
		}

        private function refreshViewHardware() : void
        {
            mainView.cameras = hardwareModel.cameras;
            mainView.microphones = hardwareModel.microphones;
		}

        private function onHardwareChanged() : void
        {
            refreshViewHardware();
		}

        private function onCurrentCameraChanged(event:HardwareEvent) : void
        {
            mainView.currentCamera = hardwareModel.currentCamera;
		}

        private function onCurrentMicrophoneChanged(event:HardwareEvent) : void
        {
            mainView.currentMicrophone = hardwareModel.currentMicrophone;
		}

    }
}

package com.jxl.webcamrecord.robotlegs.commands
{
    import com.jxl.webcamrecord.events.*;
    import com.jxl.webcamrecord.robotlegs.models.*;
    import org.robotlegs.mvcs.*;

    public class UpdateCurrentMicrophoneCommand extends Command
    {
		[Inject]
        public var event:ConfigureWebCamEvent;
        
		[Inject]
		public var hardwareModel:HardwareModel;

        public function UpdateCurrentMicrophoneCommand()
        {
			super();
		}

        override public function execute() : void
        {
            hardwareModel.currentMicrophone = event.microphone;
		}
    }
}

package com.jxl.webcamrecord.robotlegs.commands
{
    import com.jxl.webcamrecord.events.*;
    import com.jxl.webcamrecord.robotlegs.models.*;
    
    import org.robotlegs.mvcs.*;

    public class UpdateCurrentCameraCommand extends Command
    {
		[Inject]
        public var event:ConfigureWebCamEvent;
        
		[Inject]
		public var hardwareModel:HardwareModel;

        public function UpdateCurrentCameraCommand()
        {
			super();
		}

        override public function execute() : void
        {
            //Debug.debug("UpdateCurrentCameraCommand::execute");
            hardwareModel.currentCamera = event.camera;
		}
    }
}

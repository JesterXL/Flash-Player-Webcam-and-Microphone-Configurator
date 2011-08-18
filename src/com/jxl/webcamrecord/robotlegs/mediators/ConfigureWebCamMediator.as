package com.jxl.webcamrecord.robotlegs.mediators
{
    import com.jxl.webcamrecord.controls.*;
    import com.jxl.webcamrecord.events.*;
    import com.jxl.webcamrecord.robotlegs.events.*;
    import com.jxl.webcamrecord.robotlegs.models.*;
    import com.jxl.webcamrecord.robotlegs.services.*;
    
    import org.robotlegs.mvcs.*;

    public class ConfigureWebCamMediator extends Mediator
    {
        [Inject]
		public var configureWebCamView:ConfigureWebCam2;
		
		[Inject]
        public var hardwareModel:HardwareModel;
		
        private var saveSettingsService:SaveSettingsService;
        private var loadSettingsService:LoadSettingsService;

        public function ConfigureWebCamMediator()
        {
			super();
		}

        override public function onRegister() : void
        {
            //Debug.debug("ConfigureWebCamMediator::onRegister");
            super.onRegister();
            
			eventMap.mapListener(eventDispatcher, HardwareEvent.CAMERAS_CHANGED, onHardwareChanged, HardwareEvent);
            eventMap.mapListener(eventDispatcher, HardwareEvent.MICROPHONES_CHANGED, onHardwareChanged, HardwareEvent);
			
            updateViewHardware();
            updateViewCamera();
            updateViewMicrophone();
            
			eventMap.mapListener(configureWebCamView, ConfigureWebCamEvent.SELECTED_CAMERA_CHANGED, onSelectedCameraChanged, ConfigureWebCamEvent);
            eventMap.mapListener(configureWebCamView, ConfigureWebCamEvent.SELECTED_MICROPHONE_CHANGED, onSelectedMicrophoneChanged, ConfigureWebCamEvent);
            eventMap.mapListener(configureWebCamView, ConfigureWebCamEvent.LOAD_SETTINGS, onLoadSettings, ConfigureWebCamEvent);
            eventMap.mapListener(configureWebCamView, ConfigureWebCamEvent.SAVE_SETTINGS, onSaveSettings, ConfigureWebCamEvent);
		}

        private function updateViewHardware() : void
        {
            configureWebCamView.cameras 		= hardwareModel.cameras;
            configureWebCamView.microphones 	= hardwareModel.microphones;
		}

        private function updateViewCamera() : void
        {
            configureWebCamView.currentCamera = hardwareModel.currentCamera;
		}

        private function updateViewMicrophone() : void
        {
            configureWebCamView.currentMicrophone = hardwareModel.currentMicrophone;
		}

        private function onHardwareChanged(event:HardwareEvent) : void
        {
            updateViewHardware();
		}

        private function onSelectedCameraChanged(event:ConfigureWebCamEvent) : void
        {
            //Debug.debug("ConfigureWebCamMediator::onSelectedCameraChanged");
            dispatch(event);
		}

        private function onSelectedMicrophoneChanged(event:ConfigureWebCamEvent) : void
        {
            dispatch(event);
		}

        private function onLoadSettings(event:ConfigureWebCamEvent) : void
        {
            if (loadSettingsService == null)
            {
                loadSettingsService = new LoadSettingsService();
                loadSettingsService.addEventListener(ServiceEvent.LOAD_SETTINGS_CANCEL, onLoadSettingsCancel);
                loadSettingsService.addEventListener(ServiceEvent.LOAD_SETTINGS_ERROR, onLoadSettingsError);
                loadSettingsService.addEventListener(ServiceEvent.LOAD_SETTINGS_SUCCESS, onLoadSettingsSuccess);
            }
            loadSettingsService.loadSettingsFile();
		}

        private function destroyLoadSettingsService() : void
        {
            if (loadSettingsService)
            {
                loadSettingsService.removeEventListener(ServiceEvent.LOAD_SETTINGS_CANCEL, onLoadSettingsCancel);
                loadSettingsService.removeEventListener(ServiceEvent.LOAD_SETTINGS_ERROR, onLoadSettingsError);
                loadSettingsService.removeEventListener(ServiceEvent.LOAD_SETTINGS_SUCCESS, onLoadSettingsSuccess);
                loadSettingsService = null;
            }
		}

        private function onLoadSettingsCancel(event:ServiceEvent) : void
        {
            destroyLoadSettingsService();
		}

        private function onLoadSettingsError(event:ServiceEvent) : void
        {
            destroyLoadSettingsService();
		}

        private function onLoadSettingsSuccess(event:ServiceEvent) : void
        {
            configureWebCamView.settings = loadSettingsService.loadedSettings;
            destroyLoadSettingsService();
		}

        private function onSaveSettings(event:ConfigureWebCamEvent) : void
        {
            if (saveSettingsService == null)
            {
                saveSettingsService = new SaveSettingsService();
                saveSettingsService.addEventListener(ServiceEvent.SAVE_SETTINGS_CANCEL, onSaveSettingsCancel);
                saveSettingsService.addEventListener(ServiceEvent.SAVE_SETTINGS_ERROR, onSaveSettingsError);
                saveSettingsService.addEventListener(ServiceEvent.SAVE_SETTINGS_SUCCESS, onSaveSettingsSuccess);
            }
            saveSettingsService.saveSettings(event.settings);
		}

        private function destroySaveSettingsService() : void
        {
            if (saveSettingsService)
            {
                saveSettingsService.removeEventListener(ServiceEvent.SAVE_SETTINGS_CANCEL, onSaveSettingsCancel);
                saveSettingsService.removeEventListener(ServiceEvent.SAVE_SETTINGS_ERROR, onSaveSettingsError);
                saveSettingsService.removeEventListener(ServiceEvent.SAVE_SETTINGS_SUCCESS, onSaveSettingsSuccess);
                saveSettingsService = null;
            }
		}

        private function onSaveSettingsCancel(event:ServiceEvent) : void
        {
            destroySaveSettingsService();
		}

        private function onSaveSettingsError(event:ServiceEvent) : void
        {
            destroySaveSettingsService();
		}

        private function onSaveSettingsSuccess(event:ServiceEvent) : void
        {
            destroySaveSettingsService();
		}

    }
}

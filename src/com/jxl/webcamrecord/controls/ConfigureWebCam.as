package com.jxl.webcamrecord.controls{
	import spark.components.Group;
	import mx.binding.IWatcherSetupUtil2;
	import spark.components.Label;
	import spark.components.HSlider;
	import spark.components.TextArea;
	import spark.components.ComboBox;
	import mx.containers.FormItem;
	import spark.components.RadioButtonGroup;
	import spark.components.CheckBox;
	import spark.components.NumericStepper;
	import mx.containers.Form;
	import mx.collections.ArrayCollection;
	import flash.media.Camera;
	import flash.utils.Timer;
	import flash.media.Microphone;
	import com.jxl.webcamrecord.vo.SettingsVO;
	import flash.utils.getDefinitionByName;
	import mx.states.State;
	import mx.binding.Binding;
	import mx.core.IFlexModuleFactory;
	import com.jxl.webcamrecord.events.ConfigureWebCamEvent;
	import com.jxl.webcamrecord.vo.CameraSettingsVO;
	import com.jxl.webcamrecord.vo.MicrophoneSettingsVO;
	import flash.events.TimerEvent;
	import flash.media.SoundCodec;
	import mx.binding.BindingManager;
	import mx.core.UIComponentDescriptor;
	import mx.containers.FormHeading;
	import spark.components.Button;
	import spark.events.IndexChangeEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import spark.components.RadioButton;
	import mx.collections.ArrayList;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	import mx.binding.*;
	import mx.core.*;
	import flash.display.*;
	import flash.media.*;
	import flash.events.*;
	import flash.system.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.geom.*;
	import flash.accessibility.*;
	import flash.debugger.*;
	import flash.errors.*;
	import flash.external.*;
	import flash.printing.*;
	import flash.profiler.*;
	import flash.text.*;
	import flash.ui.*;
	import flash.xml.*;
	import mx.filters.*;
	import mx.styles.*;
	
	use namespace mx_internal;
	
	public class ConfigureWebCam extends Group implements IBindingClient, IStateClient2 {
		
		private static var _watcherSetupUtil:IWatcherSetupUtil2;
		
		private var _292973373bandwidthLabel:Label;
		private var _281469710bandwidthSlider:HSlider;
		private var _1699156499cameraInfoTextArea:TextArea;
		private var _1132984683camerasComboBox:ComboBox;
		private var _1819674579codecFormItem:FormItem;
		private var _245092264codecRadioButtonGroup:RadioButtonGroup;
		private var _604354449echoSuppressionCheckBox:CheckBox;
		private var _1204444071enableVADCheckBox:CheckBox;
		private var _2027027117enableVADFormItem:FormItem;
		private var _1558782126favorAreaCheckBox:CheckBox;
		private var _1407984689framerateNumericStepper:NumericStepper;
		private var _1620133142framesPerPacketFormItem:FormItem;
		private var _616628160framesPerPacketSlider:HSlider;
		private var _1967539562gainFormItem:FormItem;
		private var _1636357440gainSlider:HSlider;
		private var _1012717579heightNumericStepper:NumericStepper;
		private var _1201929196keyframeIntervalSlider:HSlider;
		private var _1790368178loopbackCheckBox:CheckBox;
		private var _181177074microphoneForm:Form;
		private var _1945363570microphoneInfoTextArea:TextArea;
		private var _1246785432microphoneLoopbackCheckBox:CheckBox;
		private var _1379198714microphonesComboBox:ComboBox;
		private var _138569711motionLevelSlider:HSlider;
		private var _187647151motionTimeoutNumericStepper:NumericStepper;
		private var _2026646430noiseSuppressionLevelFormItem:FormItem;
		private var _1634345990noiseSuppressionSlider:HSlider;
		private var _1134875968qualitySlider:HSlider;
		private var _412773795rateComboBox:ComboBox;
		private var _672910071rateFormItem:FormItem;
		private var _545554980silenceLevelSlider:HSlider;
		private var _1181868196silenceTimeoutNumericStepper:NumericStepper;
		private var _1678788155speexQualityFormItem:FormItem;
		private var _706214363speexQualitySlider:HSlider;
		private var _52982378widthNumericStepper:NumericStepper;
		private var __moduleFactoryInitialized:Boolean = false;
		private var _549364206cameras:ArrayCollection;
		private var _451113847microphones:ArrayCollection;
		
		private var _currentCamera:Camera;
		private var currentCameraDirty:Boolean = false;
		private var cameraTimer:Timer;
		private var cameraInfoText:String = "";
		private var _currentMicrophone:Microphone;
		private var currentMicrophoneDirty:Boolean = false;
		private var microphoneInfoText:String = "";
		private var _settings:SettingsVO;
		private var settingsDirty:Boolean = false;
		private var bytesValue:Number;
		
		mx_internal var _bindings:Array;
		mx_internal var _watchers:Array;
		mx_internal var _bindingsByDestination:Object;
		mx_internal var _bindingsBeginWithWord:Object;
		
		public function ConfigureWebCam(){
			var target:Object;
			var watcherSetupUtilClass:Object;
			this._bindings = [];
			this._watchers = [];
			this._bindingsByDestination = {};
			this._bindingsBeginWithWord = {};
			super();
			var bindings:Array = this._ConfigureWebCam_bindingsSetup();
			var watchers:Array = [];
			target = this;
			if (_watcherSetupUtil == null)
			{
				watcherSetupUtilClass = getDefinitionByName("_com_jxl_webcamrecord_controls_ConfigureWebCamWatcherSetupUtil");
				var _local2 = watcherSetupUtilClass;
				_local2["init"](null);
			};
			_watcherSetupUtil.setup(this, function (_arg1:String){
				return (target[_arg1]);
			}, function (_arg1:String){
				return (ConfigureWebCam[_arg1]);
			}, bindings, watchers);
			mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
			mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
			this.width = 626;
			this.height = 684;
			this.mxmlContent = [this._ConfigureWebCam_Form1_c(), this._ConfigureWebCam_TextArea1_i(), this._ConfigureWebCam_Form3_i(), this._ConfigureWebCam_TextArea2_i(), this._ConfigureWebCam_Button2_c(), this._ConfigureWebCam_Button3_c()];
			this.currentState = "State1";
			this._ConfigureWebCam_RadioButtonGroup1_i();
			this.addEventListener("creationComplete", this.___ConfigureWebCam_Group1_creationComplete);
			states = [new State({
				name:"State1",
				overrides:[]
			})];
			var i:uint;
			while (i < bindings.length)
			{
				Binding(bindings[i]).execute();
				i = (i + 1);
			};
		}
		
		public static function set watcherSetupUtil(_arg1:IWatcherSetupUtil2):void{
			ConfigureWebCam._watcherSetupUtil = _arg1;
		}
		
		
		override public function set moduleFactory(_arg1:IFlexModuleFactory):void{
			super.moduleFactory = _arg1;
			if (this.__moduleFactoryInitialized)
			{
				return;
			};
			this.__moduleFactoryInitialized = true;
		}
		
		override public function initialize():void{
			super.initialize();
		}
		
		public function get currentCamera():Camera{
			return (this._currentCamera);
		}
		
		public function set currentCamera(_arg1:Camera):void{
			this._currentCamera = _arg1;
			this.currentCameraDirty = true;
			invalidateProperties();
			var _local2:ConfigureWebCamEvent = new ConfigureWebCamEvent(ConfigureWebCamEvent.SELECTED_CAMERA_CHANGED);
			_local2.camera = this._currentCamera;
			dispatchEvent(_local2);
		}
		
		public function get currentMicrophone():Microphone{
			return (this._currentMicrophone);
		}
		
		public function set currentMicrophone(_arg1:Microphone):void{
			this._currentMicrophone = _arg1;
			this.currentMicrophoneDirty = true;
			invalidateProperties();
			var _local2:ConfigureWebCamEvent = new ConfigureWebCamEvent(ConfigureWebCamEvent.SELECTED_MICROPHONE_CHANGED);
			_local2.microphone = this._currentMicrophone;
			dispatchEvent(_local2);
		}
		
		public function set settings(_arg1:SettingsVO):void{
			this._settings = _arg1;
			this.settingsDirty = true;
			invalidateProperties();
		}
		
		private function onCreationComplete():void{
			this.startCameraTimer();
		}
		
		override protected function commitProperties():void{
			var _local1:ConfigureWebCamEvent;
			var _local2:CameraSettingsVO;
			var _local3:MicrophoneSettingsVO;
			super.commitProperties();
			if (this.currentCameraDirty)
			{
				this.currentCameraDirty = false;
				this.updateControlGUIToCameraValues();
				if (this.currentCamera)
				{
					this.camerasComboBox.selectedItem = this.currentCamera.name;
				};
			};
			if (this.currentMicrophoneDirty)
			{
				this.currentMicrophoneDirty = false;
				this.onSetAudioCodec();
				this.updateControlGUIToCameraValues();
				if (this.currentMicrophone)
				{
					this.microphonesComboBox.selectedItem = this.currentMicrophone.name;
				};
			};
			if (this.settingsDirty)
			{
				this.settingsDirty = false;
				if (((((this.cameras) && ((this.cameras.length > 0)))) || (((this.microphones) && ((this.microphones.length > 0))))))
				{
					_local2 = this._settings.cameraSettings;
					if (_local2)
					{
						this.camerasComboBox.selectedItem = _local2.cameraName;
						this._currentCamera = Camera.getCamera(this.cameras.getItemIndex(_local2.cameraName).toString());
						_local1 = new ConfigureWebCamEvent(ConfigureWebCamEvent.SELECTED_CAMERA_CHANGED);
						_local1.camera = this._currentCamera;
						dispatchEvent(_local1);
						this._currentCamera.setMode(_local2.width, _local2.height, _local2.fps, _local2.favorArea);
						this._currentCamera.setKeyFrameInterval(_local2.keyframeInterval);
						this._currentCamera.setMotionLevel(_local2.motionLevel, _local2.motionTimeout);
						this._currentCamera.setQuality(_local2.bandwidth, _local2.quality);
						this.updateControlGUIToCameraValues();
					};
					_local3 = this._settings.microphoneSettings;
					if (_local3)
					{
						this.microphonesComboBox.selectedItem = _local3.microphoneName;
						this._currentMicrophone = Microphone.getMicrophone(this.microphonesComboBox.selectedIndex);
						_local1 = new ConfigureWebCamEvent(ConfigureWebCamEvent.SELECTED_MICROPHONE_CHANGED);
						_local1.microphone = this._currentMicrophone;
						dispatchEvent(_local1);
						this._currentMicrophone.setSilenceLevel(_local3.silenceLevel, _local3.silenceTimeout);
						this._currentMicrophone.setUseEchoSuppression(_local3.echoSuppression);
						this._currentMicrophone.codec = _local3.codec;
						this.codecRadioButtonGroup.selectedValue = this._currentMicrophone.codec;
						Debug.debug(("micSettings.speexQuality: " + _local3.speexQuality));
						this._currentMicrophone.encodeQuality = _local3.speexQuality;
						this._currentMicrophone.framesPerPacket = _local3.framesPerPacket;
						this._currentMicrophone.gain = _local3.gain;
						this._currentMicrophone.rate = _local3.rate;
						this.onSetAudioCodec();
						this.updateControlGUIToCameraValues();
					};
				};
				this._settings = null;
			};
		}
		
		private function startCameraTimer():void{
			if (this.cameraTimer == null)
			{
				this.cameraTimer = new Timer(1000);
				this.cameraTimer.addEventListener(TimerEvent.TIMER, this.onTick);
			};
			this.cameraTimer.reset();
			this.cameraTimer.start();
		}
		
		private function updateControlGUIToCameraValues():void{
			if (this.currentCamera)
			{
				this.bandwidthSlider.value = this.currentCamera.bandwidth;
				this.framerateNumericStepper.value = this.currentCamera.fps;
				this.heightNumericStepper.value = this.currentCamera.height;
				this.keyframeIntervalSlider.value = this.currentCamera.keyFrameInterval;
				this.loopbackCheckBox.selected = this.currentCamera.loopback;
				this.motionLevelSlider.value = this.currentCamera.motionLevel;
				this.motionTimeoutNumericStepper.value = this.currentCamera.motionTimeout;
				this.qualitySlider.value = this.currentCamera.quality;
				this.widthNumericStepper.value = this.currentCamera.width;
			};
			if (this.currentMicrophone)
			{
				this.codecRadioButtonGroup.selectedValue = this.currentMicrophone.codec;
				Debug.debug(("currentMicrophone.encodeQuality: " + this.currentMicrophone.encodeQuality));
				this.speexQualitySlider.value = this.currentMicrophone.encodeQuality;
				this.framesPerPacketSlider.value = this.currentMicrophone.framesPerPacket;
				this.gainSlider.value = this.currentMicrophone.gain;
				this.rateComboBox.selectedItem = this.currentMicrophone.rate;
				this.silenceLevelSlider.value = this.currentMicrophone.silenceLevel;
				this.silenceTimeoutNumericStepper.value = this.currentMicrophone.silenceTimeout;
				this.echoSuppressionCheckBox.selected = this.currentMicrophone.useEchoSuppression;
			};
		}
		
		private function onTick(_arg1:TimerEvent):void{
			this.cameraInfoText = "";
			this.microphoneInfoText = "";
			if (this.currentCamera)
			{
				this.cameraInfoText = (this.cameraInfoText + (("Activity Level: " + this.currentCamera.activityLevel) + "\n"));
				this.cameraInfoText = (this.cameraInfoText + (("Bandwidth: " + this.currentCamera.bandwidth) + "\n"));
				this.cameraInfoText = (this.cameraInfoText + (("Current FPS: " + this.currentCamera.currentFPS) + "\n"));
				this.cameraInfoText = (this.cameraInfoText + (("FPS: " + this.currentCamera.fps) + "\n"));
				this.cameraInfoText = (this.cameraInfoText + (("Height: " + this.currentCamera.height) + "\n"));
				this.cameraInfoText = (this.cameraInfoText + (("Index: " + this.currentCamera.index) + "\n"));
				this.cameraInfoText = (this.cameraInfoText + (("Keyframe Interval: " + this.currentCamera.keyFrameInterval) + "\n"));
				this.cameraInfoText = (this.cameraInfoText + (("Loopback: " + this.currentCamera.loopback) + "\n"));
				this.cameraInfoText = (this.cameraInfoText + (("Motion Level: " + this.currentCamera.motionLevel) + "\n"));
				this.cameraInfoText = (this.cameraInfoText + (("Motion Timeout: " + this.currentCamera.motionTimeout) + "\n"));
				this.cameraInfoText = (this.cameraInfoText + (("Muted: " + this.currentCamera.muted) + "\n"));
				this.cameraInfoText = (this.cameraInfoText + (("Name: " + this.currentCamera.name) + "\n"));
				this.cameraInfoText = (this.cameraInfoText + (("Quality: " + this.currentCamera.quality) + "\n"));
				this.cameraInfoText = (this.cameraInfoText + (("Width: " + this.currentCamera.width) + "\n"));
			};
			if (this.currentMicrophone)
			{
				this.microphoneInfoText = (this.microphoneInfoText + (("Activity Level: " + this.currentMicrophone.activityLevel) + "\n"));
				this.microphoneInfoText = (this.microphoneInfoText + (("Codec: " + this.currentMicrophone.codec) + "\n"));
				this.microphoneInfoText = (this.microphoneInfoText + (("Encode Quality: " + this.currentMicrophone.encodeQuality) + "\n"));
				this.microphoneInfoText = (this.microphoneInfoText + (("Frames Per Packet: " + this.currentMicrophone.framesPerPacket) + "\n"));
				this.microphoneInfoText = (this.microphoneInfoText + (("Gain: " + this.currentMicrophone.gain) + "\n"));
				this.microphoneInfoText = (this.microphoneInfoText + (("Index: " + this.currentMicrophone.index) + "\n"));
				this.microphoneInfoText = (this.microphoneInfoText + (("Muted: " + this.currentMicrophone.muted) + "\n"));
				this.microphoneInfoText = (this.microphoneInfoText + (("Name: " + this.currentMicrophone.name) + "\n"));
				this.microphoneInfoText = (this.microphoneInfoText + (("Rate: " + this.currentMicrophone.rate) + "\n"));
				this.microphoneInfoText = (this.microphoneInfoText + (("Silence Level: " + this.currentMicrophone.silenceLevel) + "\n"));
				this.microphoneInfoText = (this.microphoneInfoText + (("Silence Timeout: " + this.currentMicrophone.silenceTimeout) + "\n"));
				this.microphoneInfoText = (this.microphoneInfoText + (("Volume: " + this.currentMicrophone.soundTransform.volume) + "\n"));
				this.microphoneInfoText = (this.microphoneInfoText + (("Use Echo Suppression: " + this.currentMicrophone.useEchoSuppression) + "\n"));
			};
			this.cameraInfoTextArea.text = this.cameraInfoText;
			this.microphoneInfoTextArea.text = this.microphoneInfoText;
		}
		
		private function updateSelectedCamera():void{
			var _local1:Camera = Camera.getCamera(this.camerasComboBox.selectedIndex.toString());
			this.currentCamera = _local1;
		}
		
		private function updateSelectedMicrophone():void{
			var _local1:Microphone = Microphone.getMicrophone(this.microphonesComboBox.selectedIndex);
			this.currentMicrophone = _local1;
		}
		
		private function onSetLoopback():void{
			if (this.currentCamera)
			{
				this.currentCamera.setLoopback(this.loopbackCheckBox.selected);
			};
		}
		
		private function onSetMode():void{
			Debug.log(((((((("ConfigureWebCam::onSetMode, width: " + this.widthNumericStepper.value) + ", height: ") + this.heightNumericStepper.value) + ", fps: ") + this.framerateNumericStepper.value) + ", favor area: ") + this.favorAreaCheckBox.selected));
			if (this.currentCamera)
			{
				this.currentCamera.setMode(this.widthNumericStepper.value, this.heightNumericStepper.value, this.framerateNumericStepper.value, this.favorAreaCheckBox.selected);
			};
		}
		
		private function onSetMotionLevel():void{
			if (this.currentCamera)
			{
				this.currentCamera.setMotionLevel(this.motionLevelSlider.value, this.motionTimeoutNumericStepper.value);
			};
		}
		
		private function onSetQuality():void{
			Debug.log(((("ConfigureWebCam::onSetQuality, bandwidth: " + this.formatBytes(this.bandwidthSlider.value)) + ", quality: ") + this.qualitySlider.value));
			this.bandwidthLabel.text = this.formatBytes(this.bandwidthSlider.value);
			if (this.currentCamera)
			{
				this.currentCamera.setQuality(this.bandwidthSlider.value, this.qualitySlider.value);
			};
		}
		
		private function onUpdateKeyframeInterval():void{
			if (this.currentCamera)
			{
				this.currentCamera.setKeyFrameInterval(this.keyframeIntervalSlider.value);
			};
		}
		
		private function onSetMicrophoneLoopback():void{
			if (this.currentMicrophone)
			{
				this.currentMicrophone.setLoopBack(this.microphoneLoopbackCheckBox.selected);
			};
		}
		
		private function onSetSilenceLevel():void{
			if (this.currentMicrophone)
			{
				this.currentMicrophone.setSilenceLevel(this.silenceLevelSlider.value, this.silenceTimeoutNumericStepper.value);
			};
		}
		
		private function onUseEchoSuppression():void{
			if (this.currentMicrophone)
			{
				this.currentMicrophone.setUseEchoSuppression(this.echoSuppressionCheckBox.selected);
			};
		}
		
		private function formatBytes(_arg1:Number):String{
			this.bytesValue = Math.round((_arg1 / 0x0400));
			return ((this.bytesValue + " kb"));
		}
		
		private function onSetAudioCodec():void{
			if (this.currentMicrophone)
			{
				if (this.codecRadioButtonGroup.selectedValue)
				{
					this.currentMicrophone.codec = (this.codecRadioButtonGroup.selectedValue as String);
				};
				if (this.currentMicrophone.codec == SoundCodec.NELLYMOSER.toLowerCase())
				{
					if (this.enableVADFormItem.parent)
					{
						this.microphoneForm.removeChild(this.enableVADFormItem);
						this.microphoneForm.removeChild(this.speexQualityFormItem);
						this.microphoneForm.removeChild(this.framesPerPacketFormItem);
						this.microphoneForm.removeChild(this.noiseSuppressionLevelFormItem);
					};
					if (this.rateFormItem.parent == null)
					{
						this.microphoneForm.addChildAt(this.rateFormItem, (this.microphoneForm.getChildIndex(this.gainFormItem) + 1));
					};
				} else
				{
					if (this.currentMicrophone.codec == SoundCodec.SPEEX.toLowerCase())
					{
						if (this.enableVADFormItem.parent == null)
						{
							this.microphoneForm.addChildAt(this.enableVADFormItem, (this.microphoneForm.getChildIndex(this.codecFormItem) + 1));
							this.microphoneForm.addChildAt(this.speexQualityFormItem, (this.microphoneForm.getChildIndex(this.enableVADFormItem) + 1));
							this.microphoneForm.addChildAt(this.framesPerPacketFormItem, (this.microphoneForm.getChildIndex(this.speexQualityFormItem) + 1));
							this.microphoneForm.addChildAt(this.noiseSuppressionLevelFormItem, (this.microphoneForm.getChildIndex(this.framesPerPacketFormItem) + 1));
						};
						if (this.rateFormItem.parent)
						{
							this.microphoneForm.removeChild(this.rateFormItem);
						};
					};
				};
			};
		}
		
		private function onEnableVAD():void{
		}
		
		private function onChangeSpeexQuality():void{
			if (this.currentMicrophone)
			{
				this.currentMicrophone.encodeQuality = this.speexQualitySlider.value;
			};
		}
		
		private function onSetFramesPerPacket():void{
			if (this.currentMicrophone)
			{
				this.currentMicrophone.framesPerPacket = this.framesPerPacketSlider.value;
			};
		}
		
		private function onSetGain():void{
			if (this.currentMicrophone)
			{
				this.currentMicrophone.gain = this.gainSlider.value;
			};
		}
		
		private function onSetRate():void{
			if (this.currentMicrophone)
			{
				this.currentMicrophone.rate = (this.rateComboBox.selectedItem as Number);
			};
		}
		
		private function onSetNoiseSuppressionLevel():void{
		}
		
		private function onSaveSettings():void{
			var _local1:CameraSettingsVO;
			var _local2:MicrophoneSettingsVO;
			var _local3:SettingsVO;
			var _local4:ConfigureWebCamEvent;
			dispatchEvent(new ConfigureWebCamEvent(ConfigureWebCamEvent.SAVE_SETTINGS));
			if (this.currentCamera)
			{
				_local1 = new CameraSettingsVO();
				_local1.bandwidth = this.bandwidthSlider.value;
				_local1.cameraName = this.currentCamera.name;
				_local1.favorArea = this.favorAreaCheckBox.selected;
				_local1.fps = this.framerateNumericStepper.value;
				_local1.height = this.heightNumericStepper.value;
				_local1.keyframeInterval = this.keyframeIntervalSlider.value;
				_local1.motionLevel = this.motionLevelSlider.value;
				_local1.motionTimeout = this.motionTimeoutNumericStepper.value;
				_local1.quality = this.qualitySlider.value;
				_local1.width = this.widthNumericStepper.value;
			};
			if (this.currentMicrophone)
			{
				_local2 = new MicrophoneSettingsVO();
				_local2.codec = (this.codecRadioButtonGroup.selectedValue as String);
				_local2.echoSuppression = this.echoSuppressionCheckBox.selected;
				_local2.enableVAD = this.enableVADCheckBox.selected;
				_local2.framesPerPacket = this.framesPerPacketSlider.value;
				_local2.gain = this.gainSlider.value;
				_local2.microphoneName = this.currentMicrophone.name;
				_local2.noiseSuppressionLevel = this.noiseSuppressionSlider.value;
				_local2.rate = this.rateComboBox.selectedItem;
				_local2.silenceLevel = this.silenceLevelSlider.value;
				_local2.silenceTimeout = this.silenceTimeoutNumericStepper.value;
				_local2.speexQuality = this.speexQualitySlider.value;
			};
			if (((!((_local1 == null))) || (!((_local2 == null)))))
			{
				_local3 = new SettingsVO();
				_local3.cameraSettings = _local1;
				_local3.microphoneSettings = _local2;
				_local4 = new ConfigureWebCamEvent(ConfigureWebCamEvent.SAVE_SETTINGS);
				_local4.settings = _local3;
				dispatchEvent(_local4);
			};
		}
		
		private function onLoadSettings():void{
			dispatchEvent(new ConfigureWebCamEvent(ConfigureWebCamEvent.LOAD_SETTINGS));
		}
		
		private function _ConfigureWebCam_RadioButtonGroup1_i():RadioButtonGroup{
			var _local1:RadioButtonGroup = new RadioButtonGroup();
			_local1.initialized(this, "codecRadioButtonGroup");
			this.codecRadioButtonGroup = _local1;
			BindingManager.executeBindings(this, "codecRadioButtonGroup", this.codecRadioButtonGroup);
			return (_local1);
		}
		
		private function _ConfigureWebCam_Form1_c():Form{
			var temp:Form = new Form();
			temp.x = 0;
			temp.y = 25;
			if (!temp.document)
			{
				temp.document = this;
			};
			temp.mx_internal::_documentDescriptor = new UIComponentDescriptor({
				type:Form,
				propertiesFactory:function ():Object{
					return ({childDescriptors:[new UIComponentDescriptor({
						type:FormHeading,
						propertiesFactory:function ():Object{
							return ({label:"Camera Settings"});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						propertiesFactory:function ():Object{
							return ({
								label:"Cameras:",
								childDescriptors:[new UIComponentDescriptor({
									type:ComboBox,
									id:"camerasComboBox",
									events:{change:"__camerasComboBox_change"}
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						propertiesFactory:function ():Object{
							return ({
								label:"Keyframe Interval:",
								childDescriptors:[new UIComponentDescriptor({
									type:HSlider,
									id:"keyframeIntervalSlider",
									events:{change:"__keyframeIntervalSlider_change"},
									stylesFactory:function ():void{
										this.liveDragging = false;
									},
									propertiesFactory:function ():Object{
										return ({
											minimum:1,
											maximum:48,
											stepSize:1
										});
									}
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						propertiesFactory:function ():Object{
							return ({
								label:"Loopback:",
								childDescriptors:[new UIComponentDescriptor({
									type:CheckBox,
									id:"loopbackCheckBox",
									events:{click:"__loopbackCheckBox_click"}
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:Form,
						stylesFactory:function ():void{
							this.backgroundColor = 0xB8B8B8;
						},
						propertiesFactory:function ():Object{
							return ({childDescriptors:[new UIComponentDescriptor({
								type:FormItem,
								propertiesFactory:function ():Object{
									return ({
										label:"Width:",
										childDescriptors:[new UIComponentDescriptor({
											type:NumericStepper,
											id:"widthNumericStepper",
											propertiesFactory:function ():Object{
												return ({
													minimum:20,
													maximum:720,
													stepSize:1
												});
											}
										})]
									});
								}
							}), new UIComponentDescriptor({
								type:FormItem,
								propertiesFactory:function ():Object{
									return ({
										label:"Height:",
										childDescriptors:[new UIComponentDescriptor({
											type:NumericStepper,
											id:"heightNumericStepper",
											propertiesFactory:function ():Object{
												return ({
													minimum:20,
													maximum:480,
													stepSize:1
												});
											}
										})]
									});
								}
							}), new UIComponentDescriptor({
								type:FormItem,
								propertiesFactory:function ():Object{
									return ({
										label:"Framerate:",
										childDescriptors:[new UIComponentDescriptor({
											type:NumericStepper,
											id:"framerateNumericStepper",
											propertiesFactory:function ():Object{
												return ({
													minimum:1,
													maximum:120,
													stepSize:1
												});
											}
										})]
									});
								}
							}), new UIComponentDescriptor({
								type:FormItem,
								propertiesFactory:function ():Object{
									return ({
										label:"Favor Area:",
										childDescriptors:[new UIComponentDescriptor({
											type:CheckBox,
											id:"favorAreaCheckBox",
											propertiesFactory:function ():Object{
												return ({selected:false});
											}
										})]
									});
								}
							}), new UIComponentDescriptor({
								type:FormItem,
								propertiesFactory:function ():Object{
									return ({childDescriptors:[new UIComponentDescriptor({
										type:Button,
										events:{click:"___ConfigureWebCam_Button1_click"},
										propertiesFactory:function ():Object{
											return ({label:"Update"});
										}
									})]});
								}
							})]});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						propertiesFactory:function ():Object{
							return ({
								label:"Motion Level:",
								childDescriptors:[new UIComponentDescriptor({
									type:HSlider,
									id:"motionLevelSlider",
									events:{change:"__motionLevelSlider_change"},
									stylesFactory:function ():void{
										this.liveDragging = false;
									},
									propertiesFactory:function ():Object{
										return ({
											minimum:0,
											maximum:100,
											stepSize:1,
											value:50
										});
									}
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						propertiesFactory:function ():Object{
							return ({
								label:"Motion Timeout:",
								childDescriptors:[new UIComponentDescriptor({
									type:NumericStepper,
									id:"motionTimeoutNumericStepper",
									events:{change:"__motionTimeoutNumericStepper_change"},
									propertiesFactory:function ():Object{
										return ({
											stepSize:100,
											minimum:0,
											maximum:10000
										});
									}
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						propertiesFactory:function ():Object{
							return ({
								label:"Bandwidth:",
								childDescriptors:[new UIComponentDescriptor({
									type:HSlider,
									id:"bandwidthSlider",
									events:{change:"__bandwidthSlider_change"},
									propertiesFactory:function ():Object{
										return ({
											minimum:0,
											maximum:1024000,
											stepSize:0x2800,
											value:0x4000
										});
									}
								}), new UIComponentDescriptor({
									type:Label,
									id:"bandwidthLabel"
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						propertiesFactory:function ():Object{
							return ({
								label:"Quality:",
								childDescriptors:[new UIComponentDescriptor({
									type:HSlider,
									id:"qualitySlider",
									events:{change:"__qualitySlider_change"},
									stylesFactory:function ():void{
										this.liveDragging = true;
									},
									propertiesFactory:function ():Object{
										return ({
											minimum:0,
											maximum:100,
											stepSize:1,
											value:50
										});
									}
								})]
							});
						}
					})]});
				}
			});
			temp.mx_internal::_documentDescriptor.document = this;
			BindingManager.executeBindings(this, "temp", temp);
			return (temp);
		}
		
		public function __camerasComboBox_change(_arg1:IndexChangeEvent):void{
			this.updateSelectedCamera();
		}
		
		public function __keyframeIntervalSlider_change(_arg1:Event):void{
			this.onUpdateKeyframeInterval();
		}
		
		public function __loopbackCheckBox_click(_arg1:MouseEvent):void{
			this.onSetLoopback();
		}
		
		public function ___ConfigureWebCam_Button1_click(_arg1:MouseEvent):void{
			this.onSetMode();
		}
		
		public function __motionLevelSlider_change(_arg1:Event):void{
			this.onSetMotionLevel();
		}
		
		public function __motionTimeoutNumericStepper_change(_arg1:Event):void{
			this.onSetMotionLevel();
		}
		
		public function __bandwidthSlider_change(_arg1:Event):void{
			this.onSetQuality();
		}
		
		public function __qualitySlider_change(_arg1:Event):void{
			this.onSetQuality();
		}
		
		private function _ConfigureWebCam_TextArea1_i():TextArea{
			var _local1:TextArea = new TextArea();
			_local1.x = 0;
			_local1.y = 463;
			_local1.width = 294;
			_local1.height = 236;
			_local1.setStyle("fontSize", 11);
			_local1.id = "cameraInfoTextArea";
			if (!_local1.document)
			{
				_local1.document = this;
			};
			this.cameraInfoTextArea = _local1;
			BindingManager.executeBindings(this, "cameraInfoTextArea", this.cameraInfoTextArea);
			return (_local1);
		}
		
		private function _ConfigureWebCam_Form3_i():Form{
			var temp:Form = new Form();
			temp.x = 302;
			temp.y = 25;
			temp.id = "microphoneForm";
			if (!temp.document)
			{
				temp.document = this;
			};
			temp.mx_internal::_documentDescriptor = new UIComponentDescriptor({
				type:Form,
				id:"microphoneForm",
				propertiesFactory:function ():Object{
					return ({childDescriptors:[new UIComponentDescriptor({
						type:FormHeading,
						propertiesFactory:function ():Object{
							return ({label:"Microphone Settings"});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						propertiesFactory:function ():Object{
							return ({
								label:"Microphones:",
								childDescriptors:[new UIComponentDescriptor({
									type:ComboBox,
									id:"microphonesComboBox",
									events:{change:"__microphonesComboBox_change"}
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						propertiesFactory:function ():Object{
							return ({
								label:"Loopback:",
								childDescriptors:[new UIComponentDescriptor({
									type:CheckBox,
									id:"microphoneLoopbackCheckBox",
									events:{click:"__microphoneLoopbackCheckBox_click"}
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						id:"codecFormItem",
						propertiesFactory:function ():Object{
							return ({
								label:"Codec:",
								direction:"horizontal",
								childDescriptors:[new UIComponentDescriptor({
									type:RadioButton,
									events:{click:"___ConfigureWebCam_RadioButton1_click"},
									propertiesFactory:function ():Object{
										return ({
											x:48,
											y:7,
											label:"Speex",
											value:"speex",
											groupName:"codecRadioButtonGroup"
										});
									}
								}), new UIComponentDescriptor({
									type:RadioButton,
									events:{click:"___ConfigureWebCam_RadioButton2_click"},
									propertiesFactory:function ():Object{
										return ({
											x:48,
											y:33,
											label:"Nelly Moser",
											value:"nellymoser",
											groupName:"codecRadioButtonGroup"
										});
									}
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						id:"enableVADFormItem",
						propertiesFactory:function ():Object{
							return ({
								label:"Enable VAD:",
								childDescriptors:[new UIComponentDescriptor({
									type:CheckBox,
									id:"enableVADCheckBox",
									events:{click:"__enableVADCheckBox_click"}
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						id:"speexQualityFormItem",
						propertiesFactory:function ():Object{
							return ({
								label:"Speex Quality:",
								childDescriptors:[new UIComponentDescriptor({
									type:HSlider,
									id:"speexQualitySlider",
									events:{change:"__speexQualitySlider_change"},
									propertiesFactory:function ():Object{
										return ({
											minimum:0,
											maximum:10,
											stepSize:1,
											value:6
										});
									}
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						id:"framesPerPacketFormItem",
						propertiesFactory:function ():Object{
							return ({
								label:"Frames Per Packet:",
								childDescriptors:[new UIComponentDescriptor({
									type:HSlider,
									id:"framesPerPacketSlider",
									events:{change:"__framesPerPacketSlider_change"},
									propertiesFactory:function ():Object{
										return ({
											minimum:1,
											maximum:10,
											stepSize:1,
											value:2
										});
									}
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						id:"noiseSuppressionLevelFormItem",
						propertiesFactory:function ():Object{
							return ({
								label:"Noise Suppression:",
								childDescriptors:[new UIComponentDescriptor({
									type:HSlider,
									id:"noiseSuppressionSlider",
									events:{change:"__noiseSuppressionSlider_change"},
									propertiesFactory:function ():Object{
										return ({
											minimum:-30,
											maximum:0,
											stepSize:1
										});
									}
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						id:"gainFormItem",
						propertiesFactory:function ():Object{
							return ({
								label:"Gain:",
								childDescriptors:[new UIComponentDescriptor({
									type:HSlider,
									id:"gainSlider",
									events:{change:"__gainSlider_change"},
									propertiesFactory:function ():Object{
										return ({
											minimum:0,
											maximum:100,
											stepSize:1,
											value:50
										});
									}
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						id:"rateFormItem",
						propertiesFactory:function ():Object{
							return ({
								label:"Rate:",
								childDescriptors:[new UIComponentDescriptor({
									type:ComboBox,
									id:"rateComboBox",
									events:{change:"__rateComboBox_change"},
									propertiesFactory:function ():Object{
										return ({dataProvider:_ConfigureWebCam_ArrayList1_c()});
									}
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						propertiesFactory:function ():Object{
							return ({
								label:"Silence Level:",
								childDescriptors:[new UIComponentDescriptor({
									type:HSlider,
									id:"silenceLevelSlider",
									events:{change:"__silenceLevelSlider_change"},
									propertiesFactory:function ():Object{
										return ({
											minimum:0,
											maximum:100,
											stepSize:1
										});
									}
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						propertiesFactory:function ():Object{
							return ({
								label:"Timeout:",
								childDescriptors:[new UIComponentDescriptor({
									type:NumericStepper,
									id:"silenceTimeoutNumericStepper",
									events:{change:"__silenceTimeoutNumericStepper_change"},
									propertiesFactory:function ():Object{
										return ({
											minimum:-1,
											maximum:10000,
											stepSize:1000
										});
									}
								})]
							});
						}
					}), new UIComponentDescriptor({
						type:FormItem,
						propertiesFactory:function ():Object{
							return ({
								label:"Echo Suppression:",
								childDescriptors:[new UIComponentDescriptor({
									type:CheckBox,
									id:"echoSuppressionCheckBox",
									events:{click:"__echoSuppressionCheckBox_click"}
								})]
							});
						}
					})]});
				}
			});
			temp.mx_internal::_documentDescriptor.document = this;
			this.microphoneForm = temp;
			BindingManager.executeBindings(this, "microphoneForm", this.microphoneForm);
			return (temp);
		}
		
		public function __microphonesComboBox_change(_arg1:IndexChangeEvent):void{
			this.updateSelectedMicrophone();
		}
		
		public function __microphoneLoopbackCheckBox_click(_arg1:MouseEvent):void{
			this.onSetMicrophoneLoopback();
		}
		
		public function ___ConfigureWebCam_RadioButton1_click(_arg1:MouseEvent):void{
			this.onSetAudioCodec();
		}
		
		public function ___ConfigureWebCam_RadioButton2_click(_arg1:MouseEvent):void{
			this.onSetAudioCodec();
		}
		
		public function __enableVADCheckBox_click(_arg1:MouseEvent):void{
			this.onEnableVAD();
		}
		
		public function __speexQualitySlider_change(_arg1:Event):void{
			this.onChangeSpeexQuality();
		}
		
		public function __framesPerPacketSlider_change(_arg1:Event):void{
			this.onSetFramesPerPacket();
		}
		
		public function __noiseSuppressionSlider_change(_arg1:Event):void{
			this.onSetNoiseSuppressionLevel();
		}
		
		public function __gainSlider_change(_arg1:Event):void{
			this.onSetGain();
		}
		
		private function _ConfigureWebCam_ArrayList1_c():ArrayList{
			var _local1:ArrayList = new ArrayList();
			_local1.source = [44, 22, 16, 11, 8, 5];
			BindingManager.executeBindings(this, "temp", _local1);
			return (_local1);
		}
		
		public function __rateComboBox_change(_arg1:IndexChangeEvent):void{
			this.onSetRate();
		}
		
		public function __silenceLevelSlider_change(_arg1:Event):void{
			this.onSetSilenceLevel();
		}
		
		public function __silenceTimeoutNumericStepper_change(_arg1:Event):void{
			this.onSetSilenceLevel();
		}
		
		public function __echoSuppressionCheckBox_click(_arg1:MouseEvent):void{
			this.onUseEchoSuppression();
		}
		
		private function _ConfigureWebCam_TextArea2_i():TextArea{
			var _local1:TextArea = new TextArea();
			_local1.x = 302;
			_local1.y = 463;
			_local1.width = 282;
			_local1.height = 236;
			_local1.setStyle("fontSize", 11);
			_local1.id = "microphoneInfoTextArea";
			if (!_local1.document)
			{
				_local1.document = this;
			};
			this.microphoneInfoTextArea = _local1;
			BindingManager.executeBindings(this, "microphoneInfoTextArea", this.microphoneInfoTextArea);
			return (_local1);
		}
		
		private function _ConfigureWebCam_Button2_c():Button{
			var _local1:Button = new Button();
			_local1.x = 0;
			_local1.y = 0;
			_local1.label = "Load Settings";
			_local1.addEventListener("click", this.___ConfigureWebCam_Button2_click);
			if (!_local1.document)
			{
				_local1.document = this;
			};
			BindingManager.executeBindings(this, "temp", _local1);
			return (_local1);
		}
		
		public function ___ConfigureWebCam_Button2_click(_arg1:MouseEvent):void{
			this.onLoadSettings();
		}
		
		private function _ConfigureWebCam_Button3_c():Button{
			var _local1:Button = new Button();
			_local1.x = 102;
			_local1.y = 0;
			_local1.label = "Save Settings";
			_local1.addEventListener("click", this.___ConfigureWebCam_Button3_click);
			if (!_local1.document)
			{
				_local1.document = this;
			};
			BindingManager.executeBindings(this, "temp", _local1);
			return (_local1);
		}
		
		public function ___ConfigureWebCam_Button3_click(_arg1:MouseEvent):void{
			this.onSaveSettings();
		}
		
		public function ___ConfigureWebCam_Group1_creationComplete(_arg1:FlexEvent):void{
			this.onCreationComplete();
		}
		
		private function _ConfigureWebCam_bindingsSetup():Array{
			var _local1:Array = [];
			_local1[0] = new Binding(this, null, null, "camerasComboBox.dataProvider", "cameras");
			_local1[1] = new Binding(this, null, null, "microphonesComboBox.dataProvider", "microphones");
			return (_local1);
		}
		
		[Bindable(event="propertyChange")]
		public function get bandwidthLabel():Label{
			return (this._292973373bandwidthLabel);
		}
		
		public function set bandwidthLabel(_arg1:Label):void{
			var _local2:Object = this._292973373bandwidthLabel;
			if (_local2 !== _arg1)
			{
				this._292973373bandwidthLabel = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bandwidthLabel", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get bandwidthSlider():HSlider{
			return (this._281469710bandwidthSlider);
		}
		
		public function set bandwidthSlider(_arg1:HSlider):void{
			var _local2:Object = this._281469710bandwidthSlider;
			if (_local2 !== _arg1)
			{
				this._281469710bandwidthSlider = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bandwidthSlider", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get cameraInfoTextArea():TextArea{
			return (this._1699156499cameraInfoTextArea);
		}
		
		public function set cameraInfoTextArea(_arg1:TextArea):void{
			var _local2:Object = this._1699156499cameraInfoTextArea;
			if (_local2 !== _arg1)
			{
				this._1699156499cameraInfoTextArea = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cameraInfoTextArea", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get camerasComboBox():ComboBox{
			return (this._1132984683camerasComboBox);
		}
		
		public function set camerasComboBox(_arg1:ComboBox):void{
			var _local2:Object = this._1132984683camerasComboBox;
			if (_local2 !== _arg1)
			{
				this._1132984683camerasComboBox = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "camerasComboBox", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get codecFormItem():FormItem{
			return (this._1819674579codecFormItem);
		}
		
		public function set codecFormItem(_arg1:FormItem):void{
			var _local2:Object = this._1819674579codecFormItem;
			if (_local2 !== _arg1)
			{
				this._1819674579codecFormItem = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "codecFormItem", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get codecRadioButtonGroup():RadioButtonGroup{
			return (this._245092264codecRadioButtonGroup);
		}
		
		public function set codecRadioButtonGroup(_arg1:RadioButtonGroup):void{
			var _local2:Object = this._245092264codecRadioButtonGroup;
			if (_local2 !== _arg1)
			{
				this._245092264codecRadioButtonGroup = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "codecRadioButtonGroup", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get echoSuppressionCheckBox():CheckBox{
			return (this._604354449echoSuppressionCheckBox);
		}
		
		public function set echoSuppressionCheckBox(_arg1:CheckBox):void{
			var _local2:Object = this._604354449echoSuppressionCheckBox;
			if (_local2 !== _arg1)
			{
				this._604354449echoSuppressionCheckBox = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "echoSuppressionCheckBox", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get enableVADCheckBox():CheckBox{
			return (this._1204444071enableVADCheckBox);
		}
		
		public function set enableVADCheckBox(_arg1:CheckBox):void{
			var _local2:Object = this._1204444071enableVADCheckBox;
			if (_local2 !== _arg1)
			{
				this._1204444071enableVADCheckBox = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "enableVADCheckBox", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get enableVADFormItem():FormItem{
			return (this._2027027117enableVADFormItem);
		}
		
		public function set enableVADFormItem(_arg1:FormItem):void{
			var _local2:Object = this._2027027117enableVADFormItem;
			if (_local2 !== _arg1)
			{
				this._2027027117enableVADFormItem = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "enableVADFormItem", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get favorAreaCheckBox():CheckBox{
			return (this._1558782126favorAreaCheckBox);
		}
		
		public function set favorAreaCheckBox(_arg1:CheckBox):void{
			var _local2:Object = this._1558782126favorAreaCheckBox;
			if (_local2 !== _arg1)
			{
				this._1558782126favorAreaCheckBox = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "favorAreaCheckBox", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get framerateNumericStepper():NumericStepper{
			return (this._1407984689framerateNumericStepper);
		}
		
		public function set framerateNumericStepper(_arg1:NumericStepper):void{
			var _local2:Object = this._1407984689framerateNumericStepper;
			if (_local2 !== _arg1)
			{
				this._1407984689framerateNumericStepper = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "framerateNumericStepper", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get framesPerPacketFormItem():FormItem{
			return (this._1620133142framesPerPacketFormItem);
		}
		
		public function set framesPerPacketFormItem(_arg1:FormItem):void{
			var _local2:Object = this._1620133142framesPerPacketFormItem;
			if (_local2 !== _arg1)
			{
				this._1620133142framesPerPacketFormItem = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "framesPerPacketFormItem", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get framesPerPacketSlider():HSlider{
			return (this._616628160framesPerPacketSlider);
		}
		
		public function set framesPerPacketSlider(_arg1:HSlider):void{
			var _local2:Object = this._616628160framesPerPacketSlider;
			if (_local2 !== _arg1)
			{
				this._616628160framesPerPacketSlider = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "framesPerPacketSlider", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get gainFormItem():FormItem{
			return (this._1967539562gainFormItem);
		}
		
		public function set gainFormItem(_arg1:FormItem):void{
			var _local2:Object = this._1967539562gainFormItem;
			if (_local2 !== _arg1)
			{
				this._1967539562gainFormItem = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gainFormItem", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get gainSlider():HSlider{
			return (this._1636357440gainSlider);
		}
		
		public function set gainSlider(_arg1:HSlider):void{
			var _local2:Object = this._1636357440gainSlider;
			if (_local2 !== _arg1)
			{
				this._1636357440gainSlider = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gainSlider", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get heightNumericStepper():NumericStepper{
			return (this._1012717579heightNumericStepper);
		}
		
		public function set heightNumericStepper(_arg1:NumericStepper):void{
			var _local2:Object = this._1012717579heightNumericStepper;
			if (_local2 !== _arg1)
			{
				this._1012717579heightNumericStepper = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heightNumericStepper", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get keyframeIntervalSlider():HSlider{
			return (this._1201929196keyframeIntervalSlider);
		}
		
		public function set keyframeIntervalSlider(_arg1:HSlider):void{
			var _local2:Object = this._1201929196keyframeIntervalSlider;
			if (_local2 !== _arg1)
			{
				this._1201929196keyframeIntervalSlider = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "keyframeIntervalSlider", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get loopbackCheckBox():CheckBox{
			return (this._1790368178loopbackCheckBox);
		}
		
		public function set loopbackCheckBox(_arg1:CheckBox):void{
			var _local2:Object = this._1790368178loopbackCheckBox;
			if (_local2 !== _arg1)
			{
				this._1790368178loopbackCheckBox = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loopbackCheckBox", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get microphoneForm():Form{
			return (this._181177074microphoneForm);
		}
		
		public function set microphoneForm(_arg1:Form):void{
			var _local2:Object = this._181177074microphoneForm;
			if (_local2 !== _arg1)
			{
				this._181177074microphoneForm = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "microphoneForm", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get microphoneInfoTextArea():TextArea{
			return (this._1945363570microphoneInfoTextArea);
		}
		
		public function set microphoneInfoTextArea(_arg1:TextArea):void{
			var _local2:Object = this._1945363570microphoneInfoTextArea;
			if (_local2 !== _arg1)
			{
				this._1945363570microphoneInfoTextArea = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "microphoneInfoTextArea", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get microphoneLoopbackCheckBox():CheckBox{
			return (this._1246785432microphoneLoopbackCheckBox);
		}
		
		public function set microphoneLoopbackCheckBox(_arg1:CheckBox):void{
			var _local2:Object = this._1246785432microphoneLoopbackCheckBox;
			if (_local2 !== _arg1)
			{
				this._1246785432microphoneLoopbackCheckBox = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "microphoneLoopbackCheckBox", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get microphonesComboBox():ComboBox{
			return (this._1379198714microphonesComboBox);
		}
		
		public function set microphonesComboBox(_arg1:ComboBox):void{
			var _local2:Object = this._1379198714microphonesComboBox;
			if (_local2 !== _arg1)
			{
				this._1379198714microphonesComboBox = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "microphonesComboBox", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get motionLevelSlider():HSlider{
			return (this._138569711motionLevelSlider);
		}
		
		public function set motionLevelSlider(_arg1:HSlider):void{
			var _local2:Object = this._138569711motionLevelSlider;
			if (_local2 !== _arg1)
			{
				this._138569711motionLevelSlider = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "motionLevelSlider", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get motionTimeoutNumericStepper():NumericStepper{
			return (this._187647151motionTimeoutNumericStepper);
		}
		
		public function set motionTimeoutNumericStepper(_arg1:NumericStepper):void{
			var _local2:Object = this._187647151motionTimeoutNumericStepper;
			if (_local2 !== _arg1)
			{
				this._187647151motionTimeoutNumericStepper = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "motionTimeoutNumericStepper", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get noiseSuppressionLevelFormItem():FormItem{
			return (this._2026646430noiseSuppressionLevelFormItem);
		}
		
		public function set noiseSuppressionLevelFormItem(_arg1:FormItem):void{
			var _local2:Object = this._2026646430noiseSuppressionLevelFormItem;
			if (_local2 !== _arg1)
			{
				this._2026646430noiseSuppressionLevelFormItem = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "noiseSuppressionLevelFormItem", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get noiseSuppressionSlider():HSlider{
			return (this._1634345990noiseSuppressionSlider);
		}
		
		public function set noiseSuppressionSlider(_arg1:HSlider):void{
			var _local2:Object = this._1634345990noiseSuppressionSlider;
			if (_local2 !== _arg1)
			{
				this._1634345990noiseSuppressionSlider = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "noiseSuppressionSlider", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get qualitySlider():HSlider{
			return (this._1134875968qualitySlider);
		}
		
		public function set qualitySlider(_arg1:HSlider):void{
			var _local2:Object = this._1134875968qualitySlider;
			if (_local2 !== _arg1)
			{
				this._1134875968qualitySlider = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "qualitySlider", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get rateComboBox():ComboBox{
			return (this._412773795rateComboBox);
		}
		
		public function set rateComboBox(_arg1:ComboBox):void{
			var _local2:Object = this._412773795rateComboBox;
			if (_local2 !== _arg1)
			{
				this._412773795rateComboBox = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rateComboBox", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get rateFormItem():FormItem{
			return (this._672910071rateFormItem);
		}
		
		public function set rateFormItem(_arg1:FormItem):void{
			var _local2:Object = this._672910071rateFormItem;
			if (_local2 !== _arg1)
			{
				this._672910071rateFormItem = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rateFormItem", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get silenceLevelSlider():HSlider{
			return (this._545554980silenceLevelSlider);
		}
		
		public function set silenceLevelSlider(_arg1:HSlider):void{
			var _local2:Object = this._545554980silenceLevelSlider;
			if (_local2 !== _arg1)
			{
				this._545554980silenceLevelSlider = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "silenceLevelSlider", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get silenceTimeoutNumericStepper():NumericStepper{
			return (this._1181868196silenceTimeoutNumericStepper);
		}
		
		public function set silenceTimeoutNumericStepper(_arg1:NumericStepper):void{
			var _local2:Object = this._1181868196silenceTimeoutNumericStepper;
			if (_local2 !== _arg1)
			{
				this._1181868196silenceTimeoutNumericStepper = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "silenceTimeoutNumericStepper", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get speexQualityFormItem():FormItem{
			return (this._1678788155speexQualityFormItem);
		}
		
		public function set speexQualityFormItem(_arg1:FormItem):void{
			var _local2:Object = this._1678788155speexQualityFormItem;
			if (_local2 !== _arg1)
			{
				this._1678788155speexQualityFormItem = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "speexQualityFormItem", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get speexQualitySlider():HSlider{
			return (this._706214363speexQualitySlider);
		}
		
		public function set speexQualitySlider(_arg1:HSlider):void{
			var _local2:Object = this._706214363speexQualitySlider;
			if (_local2 !== _arg1)
			{
				this._706214363speexQualitySlider = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "speexQualitySlider", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get widthNumericStepper():NumericStepper{
			return (this._52982378widthNumericStepper);
		}
		
		public function set widthNumericStepper(_arg1:NumericStepper):void{
			var _local2:Object = this._52982378widthNumericStepper;
			if (_local2 !== _arg1)
			{
				this._52982378widthNumericStepper = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "widthNumericStepper", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get cameras():ArrayCollection{
			return (this._549364206cameras);
		}
		
		public function set cameras(_arg1:ArrayCollection):void{
			var _local2:Object = this._549364206cameras;
			if (_local2 !== _arg1)
			{
				this._549364206cameras = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cameras", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get microphones():ArrayCollection{
			return (this._451113847microphones);
		}
		
		public function set microphones(_arg1:ArrayCollection):void{
			var _local2:Object = this._451113847microphones;
			if (_local2 !== _arg1)
			{
				this._451113847microphones = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "microphones", _local2, _arg1));
				};
			};
		}
		
		
	}
}//package com.jxl.webcamrecord.controls
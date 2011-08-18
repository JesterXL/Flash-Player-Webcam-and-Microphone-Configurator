package com.jxl.webcamrecord.controls{
	import spark.components.Group;
	import mx.binding.IWatcherSetupUtil2;
	import com.jxl.coreplay.controls.VolumeBar;
	import com.jxl.coreplay.controls.UIWebCam;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.display.Sprite;
	import mx.collections.ArrayCollection;
	import flash.utils.getDefinitionByName;
	import mx.binding.Binding;
	import mx.core.IFlexModuleFactory;
	import flash.events.Event;
	import mx.binding.BindingManager;
	import mx.containers.TabNavigator;
	import mx.core.UIComponentDescriptor;
	import spark.components.NavigatorContent;
	import mx.core.DeferredInstanceFromFunction;
	import mx.events.PropertyChangeEvent;
	import mx.binding.*;
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
	
	public class MainView extends Group implements IBindingClient {
		
		private static var _watcherSetupUtil:IWatcherSetupUtil2;
		
		public var _MainView_RecordWebCam1:RecordWebCam;
		private var _2128310631volumeBar:VolumeBar;
		private var _791835685webCam:UIWebCam;
		private var __moduleFactoryInitialized:Boolean = false;
		
		private var _currentCamera:Camera;
		private var currentCameraDirty:Boolean = false;
		private var _currentMicrophone:Microphone;
		private var currentMicrophoneDirty:Boolean = false;
		private var micTimer:Sprite;
		
		public var cameras:ArrayCollection;
		public var microphones:ArrayCollection;
		
		mx_internal var _bindings:Array;
		mx_internal var _watchers:Array;
		mx_internal var _bindingsByDestination:Object;
		mx_internal var _bindingsBeginWithWord:Object;
		
		public function MainView(){
			var target:Object;
			var watcherSetupUtilClass:Object;
			this._bindings = [];
			this._watchers = [];
			this._bindingsByDestination = {};
			this._bindingsBeginWithWord = {};
			super();
			var bindings:Array = this._MainView_bindingsSetup();
			var watchers:Array = [];
			target = this;
			if (_watcherSetupUtil == null)
			{
				watcherSetupUtilClass = getDefinitionByName("_com_jxl_webcamrecord_controls_MainViewWatcherSetupUtil");
				var _local2 = watcherSetupUtilClass;
				_local2["init"](null);
			};
			_watcherSetupUtil.setup(this, function (_arg1:String){
				return (target[_arg1]);
			}, function (_arg1:String){
				return (MainView[_arg1]);
			}, bindings, watchers);
			mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
			mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
			this.percentWidth = 100;
			this.percentHeight = 100;
			this.mxmlContent = [this._MainView_UIWebCam1_i(), this._MainView_VolumeBar1_i(), this._MainView_TabNavigator1_c()];
			var i:uint;
			while (i < bindings.length)
			{
				Binding(bindings[i]).execute();
				i = (i + 1);
			};
		}
		
		public static function set watcherSetupUtil(_arg1:IWatcherSetupUtil2):void{
			MainView._watcherSetupUtil = _arg1;
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
		
		[Bindable(event="propertyChange")]
		public function get currentCamera():Camera{
			return (this._currentCamera);
		}
		
		private function set _1767550462currentCamera(_arg1:Camera):void{
			Debug.debug(("MainView::currentCamera: " + _arg1.name));
			this._currentCamera = _arg1;
			this.currentCameraDirty = true;
			invalidateProperties();
		}
		
		[Bindable(event="propertyChange")]
		public function get currentMicrophone():Microphone{
			return (this._currentMicrophone);
		}
		
		private function set _1979420797currentMicrophone(_arg1:Microphone):void{
			this._currentMicrophone = _arg1;
			this.currentMicrophoneDirty = true;
			invalidateProperties();
		}
		
		override protected function commitProperties():void{
			super.commitProperties();
			if (this.currentCameraDirty)
			{
				this.currentCameraDirty = false;
				this.webCam.camera = this._currentCamera;
			};
			if (this.currentMicrophoneDirty)
			{
				this.currentMicrophoneDirty = false;
				this.volumeBar.value = this.currentMicrophone.activityLevel;
				if (this.currentMicrophone)
				{
					this.startMicTimer();
				} else
				{
					this.stopMicTimer();
				};
			};
		}
		
		private function startMicTimer():void{
			if (this.micTimer == null)
			{
				this.micTimer = new Sprite();
			};
			this.micTimer.addEventListener(Event.ENTER_FRAME, this.onTick);
		}
		
		private function stopMicTimer():void{
			if (this.micTimer)
			{
				this.micTimer.removeEventListener(Event.ENTER_FRAME, this.onTick);
			};
		}
		
		private function onTick(_arg1:Event):void{
			if (this.currentMicrophone)
			{
				this.volumeBar.value = this.currentMicrophone.activityLevel;
			};
		}
		
		private function _MainView_UIWebCam1_i():UIWebCam{
			var _local1:UIWebCam = new UIWebCam();
			_local1.id = "webCam";
			if (!_local1.document)
			{
				_local1.document = this;
			};
			this.webCam = _local1;
			BindingManager.executeBindings(this, "webCam", this.webCam);
			return (_local1);
		}
		
		private function _MainView_VolumeBar1_i():VolumeBar{
			var _local1:VolumeBar = new VolumeBar();
			_local1.x = 302;
			_local1.y = 74;
			_local1.id = "volumeBar";
			if (!_local1.document)
			{
				_local1.document = this;
			};
			this.volumeBar = _local1;
			BindingManager.executeBindings(this, "volumeBar", this.volumeBar);
			return (_local1);
		}
		
		private function _MainView_TabNavigator1_c():TabNavigator{
			var temp:TabNavigator = new TabNavigator();
			temp.width = 733;
			temp.percentHeight = 100;
			temp.x = 328;
			if (!temp.document)
			{
				temp.document = this;
			};
			temp.mx_internal::_documentDescriptor = new UIComponentDescriptor({
				type:TabNavigator,
				propertiesFactory:function ():Object{
					return ({childDescriptors:[new UIComponentDescriptor({
						type:NavigatorContent,
						propertiesFactory:function ():Object{
							return ({
								label:"Record",
								percentWidth:100,
								percentHeight:100,
								mxmlContentFactory:new DeferredInstanceFromFunction(_MainView_Array2_c)
							});
						}
					}), new UIComponentDescriptor({
						type:NavigatorContent,
						propertiesFactory:function ():Object{
							return ({
								label:"Configure",
								percentWidth:100,
								percentHeight:100,
								mxmlContentFactory:new DeferredInstanceFromFunction(_MainView_Array3_c)
							});
						}
					}), new UIComponentDescriptor({
						type:NavigatorContent,
						propertiesFactory:function ():Object{
							return ({
								label:"View Videos",
								percentWidth:100,
								percentHeight:100,
								mxmlContentFactory:new DeferredInstanceFromFunction(_MainView_Array4_c)
							});
						}
					})]});
				}
			});
			temp.mx_internal::_documentDescriptor.document = this;
			BindingManager.executeBindings(this, "temp", temp);
			return (temp);
		}
		
		private function _MainView_Array2_c():Array{
			var _local1:Array = [this._MainView_RecordWebCam1_i()];
			BindingManager.executeBindings(this, "temp", _local1);
			return (_local1);
		}
		
		private function _MainView_RecordWebCam1_i():RecordWebCam{
			var _local1:RecordWebCam = new RecordWebCam();
			_local1.id = "_MainView_RecordWebCam1";
			if (!_local1.document)
			{
				_local1.document = this;
			};
			this._MainView_RecordWebCam1 = _local1;
			BindingManager.executeBindings(this, "_MainView_RecordWebCam1", this._MainView_RecordWebCam1);
			return (_local1);
		}
		
		private function _MainView_Array3_c():Array{
			var _local1:Array = [this._MainView_ConfigureWebCam1_c()];
			BindingManager.executeBindings(this, "temp", _local1);
			return (_local1);
		}
		
		private function _MainView_ConfigureWebCam1_c():ConfigureWebCam{
			var _local1:ConfigureWebCam = new ConfigureWebCam();
			if (!_local1.document)
			{
				_local1.document = this;
			};
			BindingManager.executeBindings(this, "temp", _local1);
			return (_local1);
		}
		
		private function _MainView_Array4_c():Array{
			var _local1:Array = [this._MainView_Playlist1_c()];
			BindingManager.executeBindings(this, "temp", _local1);
			return (_local1);
		}
		
		private function _MainView_Playlist1_c():Playlist{
			var _local1:Playlist = new Playlist();
			if (!_local1.document)
			{
				_local1.document = this;
			};
			BindingManager.executeBindings(this, "temp", _local1);
			return (_local1);
		}
		
		private function _MainView_bindingsSetup():Array{
			var _local1:Array = [];
			_local1[0] = new Binding(this, null, null, "_MainView_RecordWebCam1.currentCamera", "currentCamera");
			_local1[1] = new Binding(this, null, null, "_MainView_RecordWebCam1.currentMicrophone", "currentMicrophone");
			return (_local1);
		}
		
		[Bindable(event="propertyChange")]
		public function get volumeBar():VolumeBar{
			return (this._2128310631volumeBar);
		}
		
		public function set volumeBar(_arg1:VolumeBar):void{
			var _local2:Object = this._2128310631volumeBar;
			if (_local2 !== _arg1)
			{
				this._2128310631volumeBar = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "volumeBar", _local2, _arg1));
				};
			};
		}
		
		[Bindable(event="propertyChange")]
		public function get webCam():UIWebCam{
			return (this._791835685webCam);
		}
		
		public function set webCam(_arg1:UIWebCam):void{
			var _local2:Object = this._791835685webCam;
			if (_local2 !== _arg1)
			{
				this._791835685webCam = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "webCam", _local2, _arg1));
				};
			};
		}
		
		public function set currentCamera(_arg1:Camera):void{
			var _local2:Object = this.currentCamera;
			if (_local2 !== _arg1)
			{
				this._1767550462currentCamera = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentCamera", _local2, _arg1));
				};
			};
		}
		
		public function set currentMicrophone(_arg1:Microphone):void{
			var _local2:Object = this.currentMicrophone;
			if (_local2 !== _arg1)
			{
				this._1979420797currentMicrophone = _arg1;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentMicrophone", _local2, _arg1));
				};
			};
		}
		
		
	}
}//package com.jxl.webcamrecord.controls
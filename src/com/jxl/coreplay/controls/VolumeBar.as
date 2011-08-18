package com.jxl.coreplay.controls
{
    import flash.display.*;
    
    import mx.core.*;

    public class VolumeBar extends UIComponent
    {
        private var volumeBarAnime:VolumeBar_VolumeBarSymbol;
        private var _value:Number = 0;
        private var valueDirty:Boolean = false;

        public function VolumeBar()
        {
			super();
			init();
		}
		
		private function init():void
		{
			width = 18;
			height = 166;
		}

        public function get value() : Number
        {
            return _value;
		}

        public function set value(val:Number) : void
        {
            _value = val;
            valueDirty = true;
            invalidateProperties();
		}

        override protected function createChildren() : void
        {
            super.createChildren();
			
			// TODO: fix this, use t3h Flash symbol
            volumeBarAnime = new VolumeBar_VolumeBarSymbol();
            addChild(volumeBarAnime);
            volumeBarAnime.stop();
		}
		
        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (valueDirty)
            {
                valueDirty = false;
                volumeBarAnime.gotoAndStop(value);
            }
		}

    }
}

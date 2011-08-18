package com.jxl.coreplay.controls
{
    import com.jxl.coreplay.core.*;
    import flash.display.*;
    import flash.media.*;
    import mx.core.*;

    public class UIWebCam extends UIComponent
    {
        private var _cam:Camera;
        private var camDirty:Boolean = false;
        private var video:UIVideo;
        private var maskShape:Shape;

        public function UIWebCam()
        {
			super();
            init();
		}
		
		private function init():void
		{
			width = 320;
			height = 240;
		}

        public function get camera() : Camera
        {
            return _cam;
		}

        public function set camera(cam:Camera) : void
        {
            _cam = cam;
            camDirty = true;
            invalidateProperties();
		}
		
        override protected function createChildren() : void
        {
            super.createChildren();
            
			video = new UIVideo();
            addChild(video);
		}
		
        override protected function commitProperties() : void
        {
            super.commitProperties();
            if(camDirty)
            {
            	camDirty = false;
                video.attachCamera(camera);
            }
		}

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number) : void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);
            var g:* = graphics;
            g.clear();
            g.lineStyle(0, 65280);
            g.drawRect(0, 0, width, height);
            g.endFill();
		}

    }
}

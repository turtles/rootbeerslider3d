package 
{
	import away3d.core.pick.ShaderPicker;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author 
	 */
	public class Preloader extends MovieClip 
	{
		private var loadingSquare:Shape;
		private var loadingBox:Shape;
		private var doneWithLoading:Boolean = false;
		
		
		public function Preloader() 
		{
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			loadingSquare = new Shape();
			loadingSquare.graphics.beginFill(0xFFFFFF);
			loadingSquare.graphics.drawRect(0, 0, 480, 32);
			loadingSquare.graphics.endFill();
			loadingBox = new Shape();
			loadingBox.graphics.beginFill(0xFFFFFF, 0.1);
			loadingBox.graphics.drawRoundRect(0, 0, loadingSquare.width + 8, loadingSquare.height + 8, 4, 4);
			loadingBox.graphics.endFill();
			
			loadingSquare.x = 320 - loadingSquare.width / 2;
			loadingSquare.y = 240 - loadingSquare.height / 2;
			loadingSquare.scaleX = 0;
			loadingBox.x = loadingSquare.x - 4;
			loadingBox.y = loadingSquare.y - 4;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function adClosed(e:Event):void
		{
			loadingSquare.visible = true;
			loadingBox.visible = true;
			
			if (doneWithLoading) playTheGame();
		}
		
		public function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			addChild(loadingBox);
			addChild(loadingSquare);
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// update loader
			var ratio:Number = Math.min(1, e.bytesLoaded / e.bytesTotal);
			
			loadingSquare.scaleX = ratio;
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// hide loader
			removeChild(loadingBox);
			removeChild(loadingSquare);
			
			startup();
		}
		
		private function startup():void 
		{
			doneWithLoading = true;
			if (doneWithLoading) playTheGame();
		}
		
		private function playTheGame():void {
			
			var mainClass:Class = getDefinitionByName("Basic_View") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}
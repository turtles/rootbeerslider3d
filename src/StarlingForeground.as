

package
{
	import starling.display.Button;
	import Game.*;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;

	public class StarlingForeground extends Sprite
	{
		private static var _instance : StarlingForeground;
		
		private var crosshair:Crosshair;
		private var volumeButtons:VolumeButtons;
		static public var hud:HUD;
		static public var titlescreen:TitleScreen;
		static public var levelselect:LevelSelect;
		
		public static function getInstance():StarlingForeground
		{
			return _instance;
		}
		
		public function StarlingForeground()
		{
			_instance = this;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init():void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			hud = new HUD();
			addChild(hud);
			hud.visible = false;
			levelselect = new LevelSelect();
			addChild(levelselect);
			levelselect.visible = false;
			titlescreen = new TitleScreen();
			titlescreen.visible = false;
			addChild(titlescreen);
			
			volumeButtons = new VolumeButtons();
			addChild(volumeButtons);
			
			//var theme:AzureMobileTheme = new AzureMobileTheme(stage);
			
			//var button:Button = new Button();
			//
			//button.label = "Click Me";
			//addChild( button );
			//button.addEventListener( Event.TRIGGERED, button_triggeredHandler );
			//button.x = 128;
			//button.y = 128;
			//button.setSize(256, 64);
			
			//crosshair = new Crosshair();
			//addChild(crosshair);
			
			//var hudbar:Image = new Image(Assets.getAtlas().getTexture("hudbar"));
			//hudbar.x = 0;
			//hudbar.y = 0;
			//addChild(hudbar);
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		
		public function onEnterFrame( event:Event ):void {
			if (hud == null) return;
			
			if (Basic_View.room == 2) {
				if (!hud.visible) {
					hud.visible = true;
					if (volumeButtons.added) {
						volumeButtons.btn_pause.visible = true;
						volumeButtons.positionSoundButtons(1);
					}
					levelselect.visible = false;
					titlescreen.visible = false;
				}
				if (Global.pause != volumeButtons.pause) {
					volumeButtons.updateButton(3);
				}
			} else if (Basic_View.room == 1) {
				if (!levelselect.visible) {
					hud.visible = false;
					levelselect.init();
					titlescreen.visible = false;
					if (volumeButtons.added) {
						volumeButtons.btn_pause.visible = false;
						volumeButtons.positionSoundButtons(2);
					}
				}
			} else {
				if (!titlescreen.visible) {
					titlescreen.init();
					levelselect.visible = false;
					hud.visible = false;
					if (volumeButtons.added) {
						volumeButtons.btn_pause.visible = false;
						volumeButtons.positionSoundButtons(1);
					}
				}
			}
		}
	}
}
package  
{
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class VolumeButtons extends Sprite 
	{
		public var added:Boolean = false;
		public var btn_pause:Button, btn_sound:Button, btn_music:Button;
		public var pause:Boolean = false;
		
		public function VolumeButtons() 
		{
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			added = true;
			btn_sound = new Button(Assets.getAtlas().getTexture("sound_on"));
			btn_music = new Button(Assets.getAtlas().getTexture("music_on"));
			btn_pause = new Button(Assets.getAtlas().getTexture("pause"));
			positionSoundButtons();
			
			addChild(btn_sound);
			addChild(btn_music);
			addChild(btn_pause);
			
			addEventListener(Event.TRIGGERED, onTriggered);
		}
		
		public function positionSoundButtons(mode:int = 1):void {
			btn_sound.pivotX = btn_sound.upState.width / 2;
			btn_sound.pivotY = btn_sound.upState.height / 2;
			btn_sound.x = 28;
			btn_music.pivotX = btn_music.upState.width / 2;
			btn_music.pivotY = btn_music.upState.height / 2;
			btn_music.x = 68+8;
			btn_pause.pivotX = btn_pause.upState.width / 2;
			btn_pause.pivotY = btn_pause.upState.height / 2;
			btn_pause.x = 108+16;
			switch (mode) {
				case 1:
					btn_sound.y = 480 - 28;
					btn_music.y = 480 - 28;
					btn_pause.y = 480 - 28;
				break;
				case 2:
					btn_sound.y = 28;
					btn_music.y = 28;
					btn_pause.y = 28;
				break;
			}
		}
		
		private function onTriggered(e:Event):void {
			var btn:Button = (e.target as Button);
			
			if (btn == btn_sound) {
				Global.sound = !Global.sound;
				updateButton(1);
				//positionSoundButtons();
			} else if (btn == btn_music) {
				Global.music = !Global.music;
				updateButton(2);
				//positionSoundButtons();
			} else if (btn == btn_pause) {
				Global.pause = !Global.pause;
				updateButton(3);
				//positionSoundButtons();
			}
		}
		
		public function updateButton(id:int):void {
			switch (id) {
				case 1:
					if (Global.sound) {
						btn_sound.upState = Assets.getAtlas().getTexture("sound_on");
						btn_sound.downState = Assets.getAtlas().getTexture("sound_on");
					} else {
						btn_sound.upState = Assets.getAtlas().getTexture("sound_off");
						btn_sound.downState = Assets.getAtlas().getTexture("sound_off");
					}
				break;
				case 2:
					if (Global.music) {
						btn_music.upState = Assets.getAtlas().getTexture("music_on");
						btn_music.downState = Assets.getAtlas().getTexture("music_on");
					} else {
						btn_music.upState = Assets.getAtlas().getTexture("music_off");
						btn_music.downState = Assets.getAtlas().getTexture("music_off");
					}
				break;
				case 3:
					if (Basic_View.endLevel) return;
					if (Global.pause) {
						btn_pause.upState = Assets.getAtlas().getTexture("unpause");
						btn_pause.downState = Assets.getAtlas().getTexture("unpause");
						pause = true;
					} else {
						btn_pause.upState = Assets.getAtlas().getTexture("pause");
						btn_pause.downState = Assets.getAtlas().getTexture("pause");
						pause = false;
					}
				break;
			}
		}
	}

}
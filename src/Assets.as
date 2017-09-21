package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.textures.TextureAtlas;
	
	import starling.textures.Texture;
	
	public class Assets 
	{
		// levels
		[Embed(source='assets/levels/level1.xml', mimeType="application/octet-stream")] public static const Level1:Class;
		[Embed(source='assets/levels/level2.xml', mimeType="application/octet-stream")] public static const Level2:Class;
		[Embed(source='assets/levels/level3.xml', mimeType="application/octet-stream")] public static const Level3:Class;
		[Embed(source='assets/levels/level4.xml', mimeType="application/octet-stream")] public static const Level4:Class;
		[Embed(source='assets/levels/level5.xml', mimeType="application/octet-stream")] public static const Level5:Class;
		[Embed(source='assets/levels/level6.xml', mimeType="application/octet-stream")] public static const Level6:Class;
		[Embed(source='assets/levels/level7.xml', mimeType="application/octet-stream")] public static const Level7:Class;
		[Embed(source='assets/levels/level8.xml', mimeType="application/octet-stream")] public static const Level8:Class;
		[Embed(source='assets/levels/level9.xml', mimeType="application/octet-stream")] public static const Level9:Class;
		[Embed(source='assets/levels/level10.xml', mimeType="application/octet-stream")] public static const Level10:Class;
		[Embed(source='assets/levels/level11.xml', mimeType="application/octet-stream")] public static const Level11:Class;
		[Embed(source='assets/levels/level12.xml', mimeType="application/octet-stream")] public static const Level12:Class;
		[Embed(source='assets/levels/level13.xml', mimeType="application/octet-stream")] public static const Level13:Class;
		[Embed(source='assets/levels/level14.xml', mimeType="application/octet-stream")] public static const Level14:Class;
		[Embed(source='assets/levels/level15.xml', mimeType="application/octet-stream")] public static const Level15:Class;
		[Embed(source='assets/levels/level16.xml', mimeType="application/octet-stream")] public static const Level16:Class;
		[Embed(source='assets/levels/level17.xml', mimeType="application/octet-stream")] public static const Level17:Class;
		[Embed(source='assets/levels/level18.xml', mimeType="application/octet-stream")] public static const Level18:Class;
		[Embed(source='assets/levels/level19.xml', mimeType="application/octet-stream")] public static const Level19:Class;
		[Embed(source='assets/levels/level20.xml', mimeType="application/octet-stream")] public static const Level20:Class;
		[Embed(source='assets/levels/level21.xml', mimeType="application/octet-stream")] public static const Level21:Class;
		[Embed(source='assets/levels/level22.xml', mimeType="application/octet-stream")] public static const Level22:Class;
		[Embed(source='assets/levels/level23.xml', mimeType="application/octet-stream")] public static const Level23:Class;
		[Embed(source='assets/levels/level24.xml', mimeType="application/octet-stream")] public static const Level24:Class;
		
		[Embed(source = "assets/fonts/TitanOne-Regular.ttf", embedAsCFF = "false", fontFamily = "Main")] private static const Font1:Class;
		
		[Embed(source = "assets/sounds/sodagun.mp3")] public static const Sound_Sodagun:Class;
		[Embed(source = "assets/sounds/coin.mp3")] public static const Sound_Coin:Class;
		[Embed(source = "assets/sounds/thud.mp3")] public static const Sound_Thud:Class;
		[Embed(source = "assets/sounds/clink.mp3")] public static const Sound_Thud2:Class;
		[Embed(source = "assets/sounds/star.mp3")] public static const Sound_Star:Class;
		[Embed(source = "assets/sounds/countdown.mp3")] public static const Sound_Countdown:Class;
		[Embed(source = "assets/sounds/coin_drop.mp3")] public static const Sound_Coindrop:Class;
		[Embed(source = "assets/sounds/button.mp3")] public static const Sound_Button:Class;
		[Embed(source = "assets/sounds/electronicjazzloop.mp3")] public static const Music:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		//[Embed(source = "assets/sprites/back.png")] public static const BackGame:Class;
		[Embed(source = "assets/sprites/spritesheet.png")] public static const AtlasTextureGame:Class;
		[Embed(source = "assets/sprites/spritesheet.xml", mimeType = "application/octet-stream")] public static const AtlasXmlGame:Class;
		
		public static function getAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null) {
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			return gameTextureAtlas;
		}
		
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				// If texture does not yet exist, create it
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		
	}
}
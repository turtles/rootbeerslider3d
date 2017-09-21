package
{
	import away3d.containers.*;
	import away3d.core.math.MathConsts;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Contacts.b2Contact;
	import com.noteflight.standingwave3.filters.ResamplingFilter;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.SharedObject;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import com.noteflight.standingwave3.elements.*;
	import com.noteflight.standingwave3.output.*;
	import com.noteflight.standingwave3.sources.*;
	import com.noteflight.standingwave3.filters.GainFilter;
	import com.noteflight.standingwave3.filters.EchoFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import Game.GeneralObject;
	import Game.Player;
	import starling.animation.Tween;
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.entities.*;
	import away3d.events.LoaderEvent;
	import away3d.events.Stage3DEvent;
	import away3d.loaders.Loader3D;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.loaders.parsers.OBJParser;
	import away3d.materials.*;
	import away3d.primitives.*;
	import away3d.utils.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.engine.TextBlock;
	import starling.core.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Vector3D;

	[SWF(backgroundColor="#000000", frameRate="60", quality="LOW")]
	[Frame(factoryClass='Preloader')] // name of preloader class
	public class Basic_View extends Sprite
	{
		// mug
		[Embed(source="assets/models/mug/mug.obj", mimeType="application/octet-stream")]
		private var MugModel:Class;
		[Embed(source="assets/models/mug/mug.mtl", mimeType="application/octet-stream")]
		private var MugMTL:Class;
		[Embed(source="assets/models/mug/mug.jpg", mimeType="image/jpg")]
		private var MugTexture:Class;
		
		[Embed(source="assets/models/coin/coin.obj", mimeType="application/octet-stream")] private var CoinModel:Class;
		[Embed(source="assets/models/coin/coin.mtl", mimeType="application/octet-stream")] private var CoinMTL:Class;
		[Embed(source="assets/models/coin/coingold.jpg", mimeType="image/jpg")] private var CoinGoldTexture:Class;
		[Embed(source="assets/models/coin/coinsilver.jpg", mimeType="image/jpg")] private var CoinSilverTexture:Class;
		[Embed(source="assets/models/coin/coincopper.jpg", mimeType="image/jpg")] private var CoinCopperTexture:Class;
		
		[Embed(source="assets/models/star/star.obj", mimeType="application/octet-stream")] private var StarModel:Class;
		[Embed(source="assets/models/star/star.mtl", mimeType="application/octet-stream")] private var StarMTL:Class;
		[Embed(source="assets/models/star/star.png", mimeType="image/png")] private var StarTexture:Class;
		
		[Embed(source="assets/models/clock/clock.obj", mimeType="application/octet-stream")] private var ClockModel:Class;
		[Embed(source="assets/models/clock/clock.mtl", mimeType="application/octet-stream")] private var ClockMTL:Class;
		[Embed(source="assets/models/clock/clock.jpg", mimeType="image/jpg")] private var ClockTexture:Class;
		
		[Embed(source="assets/models/barstool/barstool.obj", mimeType="application/octet-stream")] private var BarStoolModel:Class;
		[Embed(source="assets/models/barstool/barstool.mtl", mimeType="application/octet-stream")] private var BarStoolMTL:Class;
		[Embed(source="assets/models/barstool/barstool_small.jpg", mimeType="image/jpg")] private var BarStoolTexture:Class;
		
		[Embed(source="assets/models/plant/plant.obj", mimeType="application/octet-stream")] private var PlantModel:Class;
		[Embed(source="assets/models/plant/plant.mtl", mimeType="application/octet-stream")] private var PlantMTL:Class;
		[Embed(source="assets/models/plant/plant.jpg", mimeType="image/jpg")] private var PlantTexture:Class;
		
		[Embed(source="assets/models/neon/neonskyline.obj", mimeType="application/octet-stream")] private var NeonSkylineModel:Class;
		[Embed(source="assets/models/neon/neonskyline.mtl", mimeType="application/octet-stream")] private var NeonSkylineMTL:Class;
		[Embed(source="assets/models/neon/neon.jpg", mimeType="image/jpg")] private var NeonSkylineTexture:Class;
		
		[Embed(source="assets/models/billards/pool.obj", mimeType="application/octet-stream")] private var BillardsModel:Class;
		[Embed(source="assets/models/billards/pool.mtl", mimeType="application/octet-stream")] private var BillardsMTL:Class;
		[Embed(source="assets/models/billards/pool.jpg", mimeType="image/jpg")] private var BillardsTexture:Class;
		
		[Embed(source="assets/models/counter/counter.obj", mimeType="application/octet-stream")] private var CounterModel:Class;
		[Embed(source="assets/models/counter/counter.mtl", mimeType="application/octet-stream")] private var CounterMTL:Class;
		[Embed(source="assets/models/counter/counter.jpg", mimeType="image/jpg")] private var CounterTexture:Class;
		
		//plane texture
		[Embed(source="assets/textures/floor_diffuse.jpg")]
		public static var FloorDiffuse:Class;
		[Embed(source="assets/textures/win.jpg")]
		public static var FloorWin:Class;
		//plane texture
		[Embed(source="assets/textures/grass_diffuse.jpg")]
		public static var GrassDiffuse:Class;
		//plane texture
		[Embed(source="assets/textures/checker.jpg")] public static var CheckerFloorDiffuse:Class;
		[Embed(source="assets/textures/bricks_small.jpg")] public static var BricksDiffuse:Class;
		
		private var mouseAccelY:int = 0, mouseAccelX:int = 0;
		private var title_pan_cam:Number = 0, enteredLevel:Boolean = false;
		
		// Stage manager and proxy instances
		private var stage3DManager:Stage3DManager;
		private var stage3DProxy:Stage3DProxy;
		
		static public var sharedOBJ:SharedObject;
		static public var globalMouseX:int=0, globalMouseY:int=0;
		static public var playerX:int=0, playerY:int=0;
		static public var restart:Boolean = false;
		static private var _setLevel:int = -1;
		
		//private var starlingBackground:Starling;
		private var starlingForeground:Starling;
		//private var hoverController:HoverController;
		
		//engine variables
		private var _view:View3D;
		
		// physics
		public var world:b2World;
		static public var worldScale:Number = 0.04;
		
		// 2d
		private var hud:HUD, setuphud:Boolean = false;
		
		// scene objects
		private var _mug:Loader3D;
		private var _turtlegun:Loader3D;
		
		private var player:Player;
		public var cameraDisplacementMag:Number, cameraDirection:Number;
		
		static public var currentLevel:int = -1;
		
		// game logic
		public var lastLevel:int = -1; // if this is the same as the current level during loading, you can just use the reset nethod to avoid recreating the level geometry
		
		private var goal:int = 0, goal_reset:int = 90, inGoal:Boolean = false;
		private var keySpace:Boolean = false;
		static public var endLevel:Boolean=false, unloaded_solidlist:Array = new Array, solidlist:Array = new Array; // contains Rectangle bounding boxes of all solid objects
		private var stars:int = 0, coins:int = 0, totalcoins:int = 0;
		public var goallist:Array = new Array, coinsCollected:Array;
		public var pickuplist:Array = new Array;
		public var animationlist:Array = new Array;
		public var boxQueue:Array = new Array, floorQueue:Array = new Array, reloadMapData:Array, pickupQueue:Array = [new Array, new Array, new Array, new Array], pickupQueueInactive:Array = [new Array, new Array, new Array, new Array]; // gold coin, silver coin, copper count, star, same as the id property on pickups
		public var boxQueueActive:Array = new Array, floorQueueActive:Array = new Array;
		private var previewCourse:Boolean = true;
		private var faraway:int = -10000; // set object coordinates to faraway to get them off the screen
		
		private var audioplayer:AudioPlayer, audioplayer2:AudioPlayer, music:Sound, musicchannel:SoundChannel, music_updated:Boolean = true;
		private var sound_soda:IAudioSource, sound_coin:IAudioSource, sound_button:IAudioSource, sound_thud:IAudioSource, sound_thud2:IAudioSource, sound_coindrop:IAudioSource, sound_star:IAudioSource, sound_countdown:IAudioSource;
		static public var play_sound_coindrop:Boolean = false, play_sound_button:Boolean = false;
		
		// Textures
		private var gameWoodFloorTexture:TextureMaterial, gameWinFloorTexture:TextureMaterial, gameBoxDiffuse:TextureMaterial;
		//private var goldCoinTexture:TextureMaterial, silverCoinTexture:TextureMaterial, copperCoinTexture:TextureMaterial, starTexture:TextureMaterial;
		
		static public var room:int = 0;
		private var contactListener:ContactListener;
		
		private var tutorialmode:int = -1;
		
		public function getMainLoaderInfo():LoaderInfo {
			var loaderInfo:LoaderInfo = root.loaderInfo;
			if (loaderInfo.loader != null) {
				loaderInfo = loaderInfo.loader.loaderInfo;
			}
			return loaderInfo;
		}
		/**
		 * Constructor
		 */
		public function Basic_View()
		{
			if (stage) init(null);
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		static public function setLevel(lvl:int):void {
			_setLevel = lvl;
		}
		
		private function SetupScene():void {
			var textureMaterialWall:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(BricksDiffuse));
			var textureMaterial:TextureMaterial =  new TextureMaterial(Cast.bitmapTexture(CheckerFloorDiffuse));
			for (var xx:int = 0; xx < 12; xx++) {
				var wall:Mesh = new Mesh(new PlaneGeometry(800, 800), textureMaterialWall);
				wall.rotationX = -90;
				wall.x = -800 * 6 + xx * 800;
				wall.y = 0;
				wall.z = 800*3;
				_view.scene.addChild(wall);
				
				for (var yy:int = 0; yy < 7; yy++) {
					var plane:Mesh = new Mesh(new PlaneGeometry(800, 800), textureMaterial);
					plane.x = -800*6 + xx*800;
					plane.z = -800*3 + yy*800;
					plane.y = -400;
					
					_view.scene.addChild(plane);
				}
			}
			
			// place clock
			
			var clockLoaderContent:AssetLoaderContext = new AssetLoaderContext();
			clockLoaderContent.mapUrlToData("clock.mtl", new ClockMTL());
			clockLoaderContent.mapUrlToData("clock.jpg", new ClockTexture());
			var _clock:Loader3D = new Loader3D();
			_clock.scale(100);
			_clock.loadData(new ClockModel(), clockLoaderContent, null, new OBJParser(1));
			_clock.y = 200;
			_clock.rotationY = 180;
			_clock.rotationX = 90;
			_clock.x = -400;
			_clock.z = 2400;
			_view.scene.addChild(_clock);
			
			var plantLoaderContent:AssetLoaderContext = new AssetLoaderContext();
			plantLoaderContent.mapUrlToData("plant.mtl", new PlantMTL());
			plantLoaderContent.mapUrlToData("plant.jpg", new PlantTexture());
			var _plant:Loader3D = new Loader3D();
			_plant.scale(250);
			_plant.loadData(new PlantModel(), plantLoaderContent, null, new OBJParser(1));
			_plant.y = -420;
			_plant.rotationY = 70;
			_plant.x = 2200;
			_plant.z = 2000;
			_view.scene.addChild(_plant);
			
			var neonskylineLoaderContent:AssetLoaderContext = new AssetLoaderContext();
			neonskylineLoaderContent.mapUrlToData("neonskyline.mtl", new NeonSkylineMTL());
			neonskylineLoaderContent.mapUrlToData("neon.jpg", new NeonSkylineTexture());
			var _neon:Loader3D = new Loader3D();
			_neon.scale(80);
			_neon.loadData(new NeonSkylineModel(), neonskylineLoaderContent, null, new OBJParser(1));
			_neon.rotationX = -90;
			_neon.y = -100;
			_neon.x = 1100;
			_neon.z = 2350;
			_view.scene.addChild(_neon);
			
			var billardsLoaderContent:AssetLoaderContext = new AssetLoaderContext();
			billardsLoaderContent.mapUrlToData("pool.mtl", new BillardsMTL());
			billardsLoaderContent.mapUrlToData("pool.jpg", new BillardsTexture());
			var _billards:Loader3D = new Loader3D();
			_billards.scale(200);
			_billards.loadData(new BillardsModel(), billardsLoaderContent, null, new OBJParser(1));
			_billards.rotationY = 180;
			_billards.y = -400;
			_billards.x = -2800;
			_billards.z = 600;
			_view.scene.addChild(_billards);
			
			// set chairs up
			for (var yy:int = 0; yy < 8; yy++) {
				var barstoolLoaderContent:AssetLoaderContext = new AssetLoaderContext();
				barstoolLoaderContent.mapUrlToData("barstool.mtl", new BarStoolMTL());
				barstoolLoaderContent.mapUrlToData("barstool.jpg", new BarStoolTexture());
				var _stool:Loader3D = new Loader3D();
				_stool.scale(140);
				_stool.loadData(new BarStoolModel(), barstoolLoaderContent, null, new OBJParser(1));
				_stool.y = -400;
				_stool.x = 2400;
				_stool.z = -(450*4) + 450 * yy;
				_view.scene.addChild(_stool);
			}
			
			// make tables
			for (var yy:int = 0; yy < 4; yy++) {
				var counterLoaderContent:AssetLoaderContext = new AssetLoaderContext();
				counterLoaderContent.mapUrlToData("counter.mtl", new CounterMTL());
				counterLoaderContent.mapUrlToData("counter.jpg", new CounterTexture());
				var _counter:Loader3D = new Loader3D();
				_counter.scale(226);
				_counter.loadData(new CounterModel(), counterLoaderContent, null, new OBJParser(1));
				_counter.rotationY = 90;
				_counter.y = -400;
				_counter.x = 2900;
				_counter.z = -(900*1.55) + 900 * yy;
				_view.scene.addChild(_counter);
			}
			
		}
		
		private function loadTextureMaterials():void {
			gameWoodFloorTexture = new TextureMaterial(Cast.bitmapTexture(GrassDiffuse));
			gameWinFloorTexture = new TextureMaterial(Cast.bitmapTexture(FloorWin));
			gameBoxDiffuse = new TextureMaterial(Cast.bitmapTexture(FloorDiffuse));
		}
		
		private function loadQueues():void {
			for (var i:int = 0; i < 200; i++) {
				var floor:Mesh = new Mesh(new PlaneGeometry(200, 200, 1, 1), null);
				floor.x = floor.y = floor.z = faraway;
				floorQueue.push(floor);
			}
			for (var i:int = 0; i < 200; i++) {
				var box:Mesh = new Mesh(new CubeGeometry(200, 200, 200, 1, 1, 1), null);
				box.x = box.y = box.z = faraway;
				boxQueue.push(box);
			}
			
			for (var ii:int = 0; ii < 12; ii++) {
			for (var i:int = 0; i < 3; i++) {
				var coinLoaderContent:AssetLoaderContext = new AssetLoaderContext();
				coinLoaderContent.mapUrlToData("coin.mtl", new CoinMTL());
				var scaleMultiplier:Number;
				switch (i) {
					case 0:
						coinLoaderContent.mapUrlToData("coingold.jpg", new CoinGoldTexture());
						scaleMultiplier = 1.0;
					break;
					case 1:
						coinLoaderContent.mapUrlToData("coingold.jpg", new CoinSilverTexture());
						scaleMultiplier = 0.9;
					break;
					case 2:
						coinLoaderContent.mapUrlToData("coingold.jpg", new CoinCopperTexture());
						scaleMultiplier = 0.6;
					break;
				}
				var _coin:Loader3D = new Loader3D();
				_coin.loadData(new CoinModel(), coinLoaderContent, null, new OBJParser(1));
				_coin.scale(45 * scaleMultiplier);
				_coin.y = 70;
				_coin.x = _coin.y = faraway;
				
				pickupQueueInactive[i].push(_coin);
			}
			}
			
			for (var i:int = 0; i < 3; i++) {
				var starLoaderContent:AssetLoaderContext = new AssetLoaderContext();
				starLoaderContent.mapUrlToData("star.mtl", new StarMTL());
				starLoaderContent.mapUrlToData("star.png", new StarTexture());
				
				var _star:Loader3D = new Loader3D();
				_star.loadData(new StarModel(), starLoaderContent, null, new OBJParser(1));
				_star.scale(60);
				_star.y = 70;
				_star.x = _star.z = faraway;
				pickupQueueInactive[3].push(_star);
			}
		}
		
		private function resetVariables():void {
			goal = goal_reset;
			endLevel = false;
			coins = 0;
			stars = 0;
			coinsCollected = [0, 0, 0];
		}
		
		private function preLevelSetup():void {
			resetVariables();
			if (hud!=null) hud.Reset();
			
			solidlist = new Array();
			goallist = new Array();
			animationlist = new Array();
			pickuplist = new Array();
			reloadMapData = new Array(); // data to be used for reloading a level, will look like: [player.x, player.y, moves, pickuip1.id, pickup1.x, pickup1.y, pickup2.id, ....]
			
			totalcoins = 0;
			
			while (floorQueueActive.length > 0) {
				var floor:Mesh = floorQueueActive.pop()
				_view.scene.removeChild(floor);
				floor.x = floor.y = floor.z = faraway;
				floorQueue.push(floor);
			}
			while (boxQueueActive.length > 0) {
				var box:Mesh = boxQueueActive.pop()
				_view.scene.removeChild(box);
				box.x = box.y = box.z = faraway;
				boxQueue.push(box);
			}
			for (var i:int = 0; i < 4; i++) {
				while (pickupQueue[i].length > 0) {
					var c:Loader3D = pickupQueue[i].pop();
					_view.scene.removeChild(c);
					pickupQueueInactive[i].push(c);
				}
			}
			
			world = new b2World(new b2Vec2(0, 0), false); /// try setting to true
			if (contactListener == null) {
				contactListener = new ContactListener();
				contactListener.eventDispatcher.addEventListener(ContactListener.MUG_HIT_BLOCK, onMugHitBlock);
			}
			
			world.SetContactListener(contactListener);
		}
		
		private function onMugHitBlock(e:Event):void {
			if (Global.sound) {
				var thud:IAudioSource;
				var velocity:Number = player.body.GetLinearVelocity().Length();
				if (velocity > 100) velocity = 100;
				if (velocity < 60) {
					//sound_thud2.resetPosition();
					var thud:IAudioSource = new GainFilter(sound_thud2, -3*(velocity / 100.0));
					//var thud_echo:IAudioSource = new EchoFilter(sound_thud2, 1.0, 0.5, 0.5);
				} else {
					//sound_thud.resetPosition();
					var thud:IAudioSource = new GainFilter(sound_thud, -3*(velocity / 100.0));
				}
				audioplayer.play(thud);
			}
		}
		
		private function loadLevel(lvl:int = 0):void {
			if (lvl == lastLevel) {
				restartLevel();
				return;
			}
			preLevelSetup();
			var levelData:XML;
			switch (lvl) {
				case 0: levelData = new XML(new Assets.Level1); break;
				case 1: levelData = new XML(new Assets.Level2); break;
				case 2: levelData = new XML(new Assets.Level3); break;
				case 3: levelData = new XML(new Assets.Level4); break;
				case 4: levelData = new XML(new Assets.Level5); break;
				case 5: levelData = new XML(new Assets.Level6); break;
				case 6: levelData = new XML(new Assets.Level7); break;
				case 7: levelData = new XML(new Assets.Level8); break;
				case 8: levelData = new XML(new Assets.Level9); break;
				case 9: levelData = new XML(new Assets.Level10); break;
				case 10: levelData = new XML(new Assets.Level11); break;
				case 11: levelData = new XML(new Assets.Level12); break;
				case 12: levelData = new XML(new Assets.Level13); break;
				case 13: levelData = new XML(new Assets.Level14); break;
				case 14: levelData = new XML(new Assets.Level15); break;
				case 15: levelData = new XML(new Assets.Level16); break;
				case 16: levelData = new XML(new Assets.Level17); break;
				case 17: levelData = new XML(new Assets.Level18); break;
				case 18: levelData = new XML(new Assets.Level19); break;
				case 19: levelData = new XML(new Assets.Level20); break;
				case 20: levelData = new XML(new Assets.Level21); break;
				case 21: levelData = new XML(new Assets.Level22); break;
				case 22: levelData = new XML(new Assets.Level23); break;
				case 23: levelData = new XML(new Assets.Level24); break;
			}
			if (lastLevel == 0 && hud != null) {
				hud.tutorial(-1);
			}
			lastLevel = currentLevel = lvl;
			
			tutorialmode = (currentLevel == 0 ? 0 : -1);
			
			// parse
			var o:XML;
			var w:int, h:int, d:int, segw:int, segh:int;
			
			
			for each (o in levelData.FLOOR[0].TILE) {
				var plane:Mesh = floorQueue.pop();
				switch (int(o.@tex)) {
					case 1: plane.material = gameWoodFloorTexture; break;
					case 2: plane.material = gameWinFloorTexture; break;
				}
				//plane.material = textureMaterial;
				plane.x = o.@x;
				plane.y = o.@y;
				plane.z = o.@z;
				floorQueueActive.push(plane);
			}
			for each (o in levelData.WALL[0].BLOCK)
			{
				//var textureMaterial:TextureMaterial;
				
				var box:Mesh = boxQueue.pop();
				switch (o.@tex) {
					case 1: box.material = gameBoxDiffuse; break;
					default: box.material = gameBoxDiffuse;
				}
				
				//box.material = textureMaterial;
				box.x = o.@x;
				box.y = o.@y;
				box.z = o.@z;
				boxQueueActive.push(box);
				
				var b2boxDef:b2BodyDef = new b2BodyDef();
				b2boxDef.type = b2Body.b2_staticBody;
				b2boxDef.position = new b2Vec2(box.x * worldScale, box.z * worldScale);
				var b2box:b2Body = world.CreateBody(b2boxDef);
				var fixtureDef:b2FixtureDef = new b2FixtureDef();
				fixtureDef.shape = b2PolygonShape.AsBox(100 * worldScale, 100 * worldScale);
				var fixture:b2Fixture = b2box.CreateFixture(fixtureDef);
				b2box.SetUserData("block");
				
				solidlist.push(new Rectangle(box.x-100, box.z-100, 200, 200));
			}
			for each (o in levelData.GOALS[0].GOAL)
			{
				var go:GeneralObject = new GeneralObject(o.@x, o.@z, o.@w, o.@h);
				goallist.push(go);
			}
			for each (o in levelData.COINS[0].COIN)
			{
				var id:int = o.@id;
				
				var _coin:Loader3D = pickupQueueInactive[id-1].pop();
				
				switch (id) {
					case 1:
						totalcoins += 25;
					break;
					case 2:
						totalcoins += 10;
					break;
					case 3:
						totalcoins++;
					break;
				}
				
				_coin.visible = true;
				_coin.y = 70;
				_coin.x = o.@x;
				_coin.z = o.@z;
				
				pickupQueue[id - 1].push(_coin);
				
				_view.scene.addChild(_coin);
				
				var _coinContainer:GeneralObject = new GeneralObject(o.@x, o.@z, 64, 64);
				_coinContainer.model = _coin;
				_coinContainer.id = id - 1;
				
				pickuplist.push(_coinContainer);
			}
			for each (o in levelData.STARS[0].STAR)
			{
				var _star:Loader3D = pickupQueueInactive[3].pop();
				_star.y = 70;
				_star.x = o.@x;
				_star.z = o.@z;
				
				_star.visible = true;
				
				pickupQueue[3].push(_star);
				_view.scene.addChild(_star);
				
				var _starContainer:GeneralObject = new GeneralObject(o.@x, o.@z, 64, 64);
				_starContainer.model = _star;
				_starContainer.id = 3;
				
				pickuplist.push(_starContainer);
			}
			
			//if (player.body==null) {
			var b2mugDef:b2BodyDef = new b2BodyDef();
			b2mugDef.type = b2Body.b2_dynamicBody;
			b2mugDef.awake = true;
			b2mugDef.inertiaScale = 0.5;
			b2mugDef.angularDamping = 2.0;
			b2mugDef.position = new b2Vec2(player.x * worldScale,player.y * worldScale);
			var b2mug:b2Body = world.CreateBody(b2mugDef);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = new b2CircleShape(player.w / 2 * worldScale);
			fixtureDef.restitution = 0.8;
			fixtureDef.density = 0.1;
			var fixture:b2Fixture = b2mug.CreateFixture(fixtureDef);
			
			b2mug.SetLinearDamping(1.1);
			b2mug.SetUserData("mug");
			player.body = b2mug;
			//}
			
			for (var i:int = 0; i < floorQueueActive.length; i++) {
				_view.scene.addChild(floorQueueActive[i]);
			}
			for (var i:int = 0; i < boxQueueActive.length; i++) {
				_view.scene.addChild(boxQueueActive[i]);
			}
			
			for each (o in levelData.PROPERTIES) {
				if (o.hasOwnProperty("@moves")) {
					player.moves = o.@moves;
				}
				if (o.hasOwnProperty("@px") && o.hasOwnProperty("@py")) {
					player.body.SetPosition(new b2Vec2(int(o.@px) * worldScale, int(o.@py)* worldScale));
				}
			}
			
			reloadMapData = [player.body.GetPosition().x, player.body.GetPosition().y, player.moves];
			
			for (var i:int = 0; i < pickuplist.length; i++) {
				reloadMapData.push(pickuplist[i].id);
				reloadMapData.push(pickuplist[i].x);
				reloadMapData.push(pickuplist[i].y);
			}
			
			cameraDisplacementMag = 0;
			previewCourse = false;
			
			setuphud = true;
			
			
			/*
			// collision debug code
			for (var i:int = 0; i < 1000; i++) {
				var box:Mesh = new Mesh(new CubeGeometry(4, 4, 4, 1, 1, 1));
				var good:Boolean = false;
				var x:int, y:int;
				do {
					x = -2000 + Math.random() * 4000;
					y = -1600 + Math.random() * 3200;
					good = collideWithSolids(new Rectangle(x, y, 4, 4));
				} while (!good);
				box.x = x;
				box.z = y;
				box.y = 24;
				_view.scene.addChild(box);
			}*/
			
		}
		
		private function restartLevel():void {
			var next:Array = [0, 0, 0, 0];
			pickuplist = new Array();
			player.body.SetPosition(new b2Vec2(reloadMapData[0], reloadMapData[1]));
			player.body.SetLinearVelocity(new b2Vec2(0, 0));
			player.moves = reloadMapData[2];
			if (hud!=null) {hud.Reset();}
			
			while (animationlist.length > 0) {
				var ani:AnimationContainer = animationlist.pop();
				if (ani.model!=null) {
					ani.model.rotationX = 0;
					ani.model.rotationZ = 0;
					ani.model = null;
				}
				//pickupQueue[ani.id].push(ani.model);
			}
			
			var id:int, size:int = 64;
			for (var i:int = 3; i < reloadMapData.length; i+=3) {
				id = int(reloadMapData[i]);
				//size = (id == 3 ? 56 : 48);
				var g:GeneralObject = new GeneralObject(reloadMapData[i+1], reloadMapData[i+2], size, size);
				g.id = id;
				g.model = pickupQueue[id][next[id]];
				next[id]++;
				g.model.visible = true;
				g.model.x = g.x;
				g.model.z = g.y;
				g.model.y = 70;
				if (hud!=null) {hud.add_coin(g.x, g.y, g.id);}
				pickuplist.push(g);
			}
			
			resetVariables();
			
			if (currentLevel == 0) {
				tutorialmode = 0;
				if (hud!=null) {hud.tutorial(0);}
			}
			
			restart = false;
		}
		
		private function init(e:Event):void {
			if (hasEventListener(Event.ADDED_TO_STAGE)) {
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
			sharedOBJ = SharedObject.getLocal("rbslider_saved");
			// Setup for handling Away3D and Starling Interoperation
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			initProxies();
			
		}
		
		private function initProxies():void {
			// Code from starling/away3d interoperability example
			// Define a new Stage3DManager for the Stage3D objects
			stage3DManager = Stage3DManager.getInstance(stage);
			
			// Create a new Stage3D proxy to contain the separate views
			stage3DProxy = stage3DManager.getFreeStage3DProxy();
			stage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_CREATED, onContextCreated);
			stage3DProxy.antiAlias = 2;
			stage3DProxy.color = 0x0;
		}
		
		private function onContextCreated(event:Stage3DEvent):void {
			//Tweener.init(); // The Tweener library is fantastic but not used in this project
			if (checkDomain("")) {
				initAway3D();
				initStarling();
				initAway3DScene();
				// Used for site locking:
				//if (stage.loaderInfo.url.indexOf("codeinferno.com")!=-1) {
					initListeners();
				//}
				onResize();
			}
		}
		
		public function checkDomain (allowed:*):Boolean
		{
			var url:String = stage.loaderInfo.url;
			var startCheck:int = url.indexOf('://' ) + 3;

			if (url.substr(0, startCheck) == 'file://') return true;

			var domainLen:int = url.indexOf('/', startCheck) - startCheck;
			var host:String = url.substr(startCheck, domainLen);

			if (allowed is String) allowed = [allowed];
			for each (var d:String in allowed)
			{
				if (host.substr(-d.length, d.length) == d) return true;
			}

			return false;
		}
		
		private function initAway3D() : void
		{
			_view = new View3D();
			_view.stage3DProxy = stage3DProxy;
			_view.shareContext = true;
			
			addChild(_view);
		}
		
		private function initAway3DScene() : void
		{
			//setup the camera
			_view.camera.x = 0;
			_view.camera.z = -400;
			_view.camera.y = 1000;
			_view.camera.lookAt(new Vector3D());
			
			//setup the scene
			var mugLoaderContent:AssetLoaderContext = new AssetLoaderContext();
			mugLoaderContent.mapUrlToData("mug.mtl", new MugMTL());
			mugLoaderContent.mapUrlToData("mug.jpg", new MugTexture());
			
			_mug = new Loader3D();
			_mug.name = "mug";
			_mug.scale(75);
			_mug.loadData(new MugModel(), mugLoaderContent, null, new OBJParser(1));
			_mug.y = 10;
			
			_view.scene.addChild(_mug);
			
			player = new Player();
			
			load();
			loadTextureMaterials();
			loadSounds();
			loadQueues();
			SetupScene();
			
			loadLevel(0);
			
			musicchannel.soundTransform = new SoundTransform(Global.music ? 1 : 0);
		}
		/**
		 * Initialise the Starling sprites
		 */
		private function initStarling() : void
		{
			// Create the Starling scenes
			//starlingBackground = new Starling(StarlingBackground, stage, stage3DProxy.viewPort, stage3DProxy.stage3D);
			Starling.handleLostContext = true;
			
			starlingForeground = new Starling(StarlingForeground, stage, stage3DProxy.viewPort, stage3DProxy.stage3D);
			starlingForeground.antiAliasing = 2;
			
			starlingForeground.start();
		}
		
		
		private function initListeners():void {
			//stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(Event.ENTER_FRAME, _onEnterFrame, false,0, true);
			//stage.addEventListener(Event.RESIZE, onResize);
			_view.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false,0, true);
			_view.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false,0, true);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown, false,0, true);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyboardUp, false,0, true);
			//stage.addEventListener(Event.ACTIVATE, onActivate);
			stage.addEventListener(Event.DEACTIVATE, onDeactivate, false,0, true);
		}
		
		
		/**
		 * Main render loop
		 */
		private function _onEnterFrame(e:Event):void
		{
			if (Global.music!=music_updated) {
				musicchannel.soundTransform = new SoundTransform(Global.music ? 1 : 0);
				music_updated = Global.music;
			}
			
			if (play_sound_button) {
				if (Global.sound) {
					sound_button.resetPosition();
					audioplayer.play(sound_button);
				}
				play_sound_button = false;
			}
			
			/// Game logic
			if (room==2) {
				updateInGame();
				
			} else if (room == 0 || !enteredLevel) {
				if (pickupQueue.length > 0) {
					if (pickupQueue[0][0].visible) {
						for (var i:int = 0; i < 4; i++) {
							for (var ii:int = 0; ii < pickupQueue[i].length; ii++) {
								pickupQueue[i][ii].visible = false;
							}
						}
					}
				}
				title_pan_cam += 0.001;
				if (title_pan_cam > 2) title_pan_cam -= 2;
				_view.camera.x = -2000 + (title_pan_cam < 1 ? title_pan_cam : (2-title_pan_cam)) * 4300;
				_view.camera.z = 1500 - ((title_pan_cam < 1 ? 0 : (title_pan_cam < 1.5? title_pan_cam-1 : 2-title_pan_cam)) * 4000);
				
			} else if (room == 1) {
				title_pan_cam = 0;
			}
			
			/// Render logic
			stage3DProxy.clear(); // Clear the Context3D object
			
			//starlingBackground.nextFrame();
			
			if (_view!=null) {_view.render();}
			
			starlingForeground.nextFrame();
			
			stage3DProxy.present(); // Present the Context3D object to Stage3D
		}
		
		private function updateHudBlocks():void {
			if (hud != null) {
				hud.clear_blocks();
				var i:int;
				for (var i = 0; i < solidlist.length; i++) {
					hud.add_block(solidlist[i].x+100, solidlist[i].y+100);
				}
				for (var i = 0; i < goallist.length; i++) {
					hud.add_floor(goallist[i].x, goallist[i].y, 1);
				}
				for (var i = 0; i < floorQueueActive.length; i++) {
					hud.add_floor(floorQueueActive[i].x, floorQueueActive[i].z, 0);
				}
			}
		}
		/**
		 * Game logic loop
		 */
		private function updateInGame():void {
			if (!enteredLevel) enteredLevel = true;
			if (hud != null) {
				hud.update();
				hud.update_player(player.x, player.y);
				hud.update_stats(player.moves);
			}
			
			if (restart) {
				restartLevel();
			}
			if (_setLevel != -1) {
				if (Global.sound) {
					sound_soda.resetPosition();
					audioplayer.play(sound_soda);
				}
				loadLevel(_setLevel);
				_setLevel = -1;
				return;
			}
			if (tutorialmode!=-1 && hud!=null) {
				switch (tutorialmode) {
					case 0:
						hud.tutorial(0);
						tutorialmode = 1;
					break;
					case 1:
						if (player.body.GetLinearVelocity().Length() > 15) {
							if (hud != null) { hud.tutorial(1); }
							tutorialmode = 2;
						}
					break;
					case 2:
						if (inGoal) {
							if (hud != null) { hud.tutorial(2); }
							tutorialmode = 3;
						}
					break;
				}
			}
			
			if (play_sound_coindrop) {
				if (Global.sound) {
					sound_coindrop.resetPosition();
					audioplayer.play(sound_coindrop);
				}
				play_sound_coindrop = false;
			}
			
			if (room != 2) return;
			
			if (endLevel) {
				if (player.drag) {
					player.drag = false;
				}
			} else if (Global.pause) {
				world.Step(0, 3, 3);
				
				return;
			}
			
			//_plane.rotationY += 1;
			player.update();
			//crosshair.update();
			world.Step(1.0/60.0, 3, 3);
			
			if (goal > 0) {
				inGoal = false;
				if (!player.drag && player.body.GetLinearVelocity().Length() < 4) {
					for (var i:int = 0; i < goallist.length; i++) {
						if ((new Rectangle(player.x - player.w / 2, player.y - player.h / 2, player.w, player.h)).intersects(new Rectangle(goallist[i].x - goallist[i].w / 2, goallist[i].y - goallist[i].h / 2, goallist[i].w, goallist[i].h))) {
							inGoal = true;
						}
					}
				}
				if (!inGoal) {
					goal = goal_reset;
					if (hud!=null) hud.HideSpinloader();
				} else {
					if (hud != null) hud.Spinloader(goal);
					if (Global.sound) {
						switch (goal) {
							case 90:
							case 60:
							case 30:
							case 1:
								sound_countdown.resetPosition();
								audioplayer2.play(sound_countdown);
							break;
						}
					}
					goal--;
					if (goal <= 0) {
						hud.endLevel(player.moves, stars, coins, totalcoins, coinsCollected[0], coinsCollected[1], coinsCollected[2]);
						hud.HideSpinloader();
						endLevel = true;
					}
				}
			}
			if (player.moves < 1 && !endLevel && goal==goal_reset && player.body.GetLinearVelocity().Length() < 1) {
				endLevel = true;
				hud.createLoseMenu();
			}
			
			for (var i:int = 0; i < pickuplist.length; i++) {
				(pickuplist[i] as GeneralObject).update();
				if (pickuplist[i].id >= 0 && pickuplist[i].id < 12) {
					if (!player.drag && (new Rectangle(player.x - player.w / 2, player.y - player.h / 2, player.w, player.h)).intersects(new Rectangle(pickuplist[i].x - pickuplist[i].w / 2, pickuplist[i].y - pickuplist[i].h / 2, pickuplist[i].w, pickuplist[i].h))) {
						removeCoin(i);
						pickuplist.splice(i, 1);
						i--;
					}
				}
			}
			for (var i:int = 0; i < animationlist.length; i++) {
				animationlist[i].update();
				if (animationlist[i].life <= 0) {
					if (animationlist[i].model!=null) {
						animationlist[i].model.rotationX = 0;
						animationlist[i].model.rotationZ = 0;
						animationlist[i].model.visible = false;
					}
					animationlist[i].model = null;
					animationlist.splice(i, 1);
					i--;
					//trace("yes");
				}
			}
			
			globalMouseX = mouseX;
			globalMouseY = mouseY;
			if (keySpace) {
				mouseAccelY = lerp(mouseAccelY, (mouseY - 240) * 4, 0.2);
				mouseAccelX = lerp(mouseAccelX, (mouseX - 320) * 4, 0.2);
			} else {
				mouseAccelX = lerp(mouseAccelX, 0, 0.4);
				mouseAccelY = lerp(mouseAccelY, 0, 0.4);
			}
			_mug.x = player.x;
			_mug.z = player.y;
			_mug.rotationY = player.rotation + 180;
			
			if (cameraDisplacementMag > 0) {
				_view.camera.z = player.y -300+ cameraDisplacementMag * cameraDirection;// - mouseAccelY;
				_view.camera.x = player.x + cameraDisplacementMag * cameraDirection;// + mouseAccelX;
			} else {
				_view.camera.z = player.y-360- mouseAccelY;
				_view.camera.x = player.x + mouseAccelX;
			}
			manageHud();
		}
		
		private function manageHud():void {
			if (hud == null) {
				if (StarlingForeground.hud != null) hud = StarlingForeground.hud;
				else return;
			}
			if (!hud.added) return;
			
			if (setuphud) {
				for (var index:int = 0; index < pickuplist.length; index++) {
					hud.add_coin(pickuplist[index].x, pickuplist[index].y, pickuplist[index].id);
					
				}
				hud.finalize_coins();
				hud.setCoins(totalcoins);
				
				updateHudBlocks();
				
				hud.update_player(player.x, player.y);
				hud.update_stats(player.moves);
				setuphud = false;
			}
		}
		
		private function removeCoin(index:int):void {
			if (hud != null) {
				if (pickuplist[index].id == 3) {
					hud.getStar();
					stars++;
				} else {
					switch (pickuplist[index].id) {
						case 0: hud.getCoin(25); break;
						case 1: hud.getCoin(10); break;
						case 2: hud.getCoin(1); break;
					}
				}
				hud.remove_coin(pickuplist[index].x, pickuplist[index].y);
			}
			
			if (pickuplist[index].id == 3) {
				if (Global.sound) {
					sound_star.resetPosition();
					var sound_star_resample:IAudioSource = new ResamplingFilter(sound_star, 1.1+(stars-1)/9);
					audioplayer2.play(sound_star_resample);
				}
			} else {
				switch (pickuplist[index].id) {
					case 0: coins += 25; coinsCollected[0]++; break;
					case 1: coins += 10; coinsCollected[1]++; break;
					case 2: coins++; coinsCollected[2]++; break;
				}
				if (Global.sound) {
					sound_coin.resetPosition();
					audioplayer.play(sound_coin);
				}
			}
			
			
			animationlist.push(new AnimationContainer((pickuplist[index].id == 3 ? 1 : 0), pickuplist[index].model));
			pickuplist[index].model = null;
		}
		
		private function collideWithSolids(collisionBox:Rectangle):Boolean {
			for (var i:int = 0; i < solidlist.length; i++) if (collisionBox.intersects(solidlist[i])) return true;
			return false;
		}
		
		
		private function lerp(val1:int, val2:int, amount:Number):int {
			return val1 + ((val2 - val1) * amount)
		}
		
		/**
		 * stage listener for resize events
		 */
		private function onResize(event:Event = null):void
		{
			_view.width = stage.stageWidth;
			_view.height = stage.stageHeight;
		}
		
		private function mouseUp():void {
			if (room == 2 && !endLevel) {
				if (player.drag) {
					player.drag = false;
				}
			}
		}
		
		
		private function onDeactivate(e:Event):void {
			if (room == 2 && !endLevel) {
				Global.pause = true;
			}
		}
		
		//private function onActivate(e:Event):void {
			//Global.pause = false;
		//}
		private function onMouseUp(e:MouseEvent):void {
			mouseUp();
		}
		
		private function onMouseUpOutside(e:MouseEvent):void {
			mouseUp();
			e.target.removeEventListener( MouseEvent.MOUSE_UP, onMouseUpOutside );
		}
		
		private function onMouseDown(e:MouseEvent):void {
			if (room == 2 && !endLevel) {
				if (player.moves>0) {
					//fireRocket(_turtlegun.rotationY);
					if (previewCourse) {
						previewCourse = false;
					}
					
					if (Global.pause) return;
					
					if (!player.drag && !keySpace && !(new Rectangle(0, 480-54, 154, 54)).containsPoint(new Point(mouseX,mouseY))) {
						player.xstart = player.x;
						player.ystart = player.y;
						player.mousexstart = mouseX;
						player.mouseystart = mouseY;
						player.drag = true;
					}
				} else {
					player.body.SetLinearVelocity(new b2Vec2(0, 0));
				}
			}
			e.target.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpOutside);
		}
		
		private function onKeyboardDown(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case 32: keySpace = true; break;
			}
		}
		
		private function onKeyboardUp(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case 32: keySpace = false; break;
			}
		}
		
		function loadSounds():void {
			audioplayer = new AudioPlayer();
			audioplayer2 = new AudioPlayer();
			sound_soda = new SoundSource(new Assets.Sound_Sodagun() as Sound);
			sound_coin = new SoundSource(new Assets.Sound_Coin() as Sound);
			sound_thud = new SoundSource(new Assets.Sound_Thud() as Sound);
			sound_thud2 = new SoundSource(new Assets.Sound_Thud2() as Sound);
			sound_coindrop = new SoundSource(new Assets.Sound_Coindrop() as Sound);
			sound_star = new SoundSource(new Assets.Sound_Star() as Sound);
			sound_countdown = new SoundSource(new Assets.Sound_Countdown() as Sound);
			sound_button = new SoundSource(new Assets.Sound_Button() as Sound);
			music = (new Assets.Music() as Sound);
			musicchannel = music.play(0, 999999);
			musicchannel.soundTransform = new SoundTransform(0);
		}
		
		static public function resetsave():void {
			var gameData:XML = <sav>
								</sav>;
			for (var i:int = 0; i < Global.stars.length; i++) {
				var recordXML:XML = <str />
				recordXML.@str = 0;
				gameData.appendChild(recordXML);
			}
			for (var i:int = 0; i < Global.coins.length; i++) {
				var recordXML:XML = <cns />
				recordXML.@cns = 0;
				gameData.appendChild(recordXML);
			}
			
			sharedOBJ.data.gameXML = gameData;
			sharedOBJ.flush();
		}
		
		static public function save():void {
			var gameData:XML = <sav>
								</sav>;
			for (var i:int = 0; i < Global.stars.length; i++) {
				var recordXML:XML = <str />
				recordXML.@str = Global.stars[i];
				gameData.appendChild(recordXML);
			}
			for (var i:int = 0; i < Global.coins.length; i++) {
				var recordXML:XML = <cns />
				recordXML.@cns = Global.coins[i];
				gameData.appendChild(recordXML);
			}
			
			sharedOBJ.data.gameXML = gameData;
			sharedOBJ.flush();
		}
		
		static public function load():void {
			var counter:int = 0;
			if (sharedOBJ.data.gameXML != undefined) {
				var xml:XML = sharedOBJ.data.gameXML;
				
				for each (var recordXML:XML in xml.str) {
					if (counter < Global.stars.length) {
						Global.stars[counter] = recordXML.@str;
						counter++;
					}
				}
				counter = 0;
				for each (var recordXML:XML in xml.cns) {
					if (counter < Global.coins.length) {
						Global.coins[counter] = recordXML.@cns;
						counter++;
					}
				}
			}
		}
	}
}

package states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.addons.effects.FlxTrail;
import flixel.effects.particles.FlxEmitter;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;
import lime.system.Display;
import objects.effects.Barrier;
import objects.hazards.Hazard;
import objects.hazards.HazardBullet;
import objects.hazards.HazardLaser;
import objects.items.Item;
import flixel.addons.effects.FlxTrailArea;
import openfl.display.BitmapData;
import openfl.filesystem.File;
import openfl.system.ApplicationDomain;
import openfl.system.System;
import openfl.utils.ByteArray;
import substates.PauseState;

import flixel.addons.transition.FlxTransitionableState;

#if desktop
import flixel.input.gamepad.FlxGamepad;
import utils.controls.Gamepad;
#end
import utils.pcg.MapChunkMerger;


import flixel.addons.display.FlxBackdrop;

import objects.enemies.EnemyBullet;
import objects.Player;
import objects.weapons.Bullet;
import objects.gamesys.Scroller;
import objects.enemies.Enemy;
import objects.items.CoinItem;
import objects.hazards.HazardBlock;
import objects.enemies.enemyobjects.EnemyExplosiveExplosion;

import flixel.FlxG;
import utils.pcg.LevelLoaderProc;
import haxe.io.Bytes;
import utils.pcg.ObjectPlacement;
import openfl.display.PNGEncoderOptions;
import flixel.math.FlxRect;

import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileCircle;
import flixel.addons.transition.TransitionData;

class PlayState extends FlxTransitionableState
{
	
	public var map:FlxTilemap;
	public var hazards:FlxTypedGroup<Hazard>;
	public var player(default, null):Player;
	public var PBullets:FlxTypedGroup<Bullet>;
	public var EBullets:FlxTypedGroup<EnemyBullet>;
	public var blocks:FlxTypedGroup<HazardBlock>;
	public var effects:FlxSpriteGroup;
	public var EExplosions:FlxTypedGroup<EnemyExplosiveExplosion>;
	public var HBullets:FlxTypedGroup<HazardBullet>;
	public var enemies(default, null):FlxTypedGroup<Enemy>;
	public var items(default, null):FlxTypedGroup<Item>;
	public var emitters:FlxTypedGroup<FlxEmitter>;
	public var coins:FlxTypedGroup <CoinItem>;
	public var sysObjects:FlxTypedGroup<FlxSprite>;
	private var _entities:FlxGroup;
	private var pauseScreen:PauseState;

	private var _scroller(default, null):Scroller;
	private var _scrollerOffset:Int = 120;
	
	public var _hud:HUD;
	private var _gameCamera:FlxCamera;
	private var _hudCamera:FlxCamera;
	
	private var trailArea:FlxTrailArea;
	
	#if desktop
	private var gamepad:FlxGamepad;
    #end
	
	private var lerpSpeed:Float = 0.1;
	
	public var canQuit = false;
	
	private var backDrop:FlxBackdrop;
	
	private var barrierLeft:Barrier;
	private var barrierRight:Barrier;
	
	private var persistentUpdateSet:Bool;
		
	override public function create():Void
	{
		super.create();

		Reg.PS = this;
		Reg.pause = false;
		Reg.CURSED = false;
		persistentUpdate = false;

		// init gameplay elements
		player = new Player(10, FlxG.height / 2);
		enemies = new FlxTypedGroup<Enemy>();
		hazards = new FlxTypedGroup<Hazard>();
		blocks = new FlxTypedGroup<HazardBlock>();
		effects = new FlxSpriteGroup();
		sysObjects = new FlxTypedGroup<FlxSprite>();
		
        Reg.score = 0;
		barrierLeft = new Barrier(0, 0);
		barrierRight = new Barrier(0, 0);

		
		coins = new FlxTypedGroup<CoinItem>();
		items = new FlxTypedGroup<Item>();
        PBullets = new FlxTypedGroup<Bullet>();
		EBullets = new FlxTypedGroup<EnemyBullet>();
		EExplosions = new FlxTypedGroup<EnemyExplosiveExplosion>();
		HBullets = new FlxTypedGroup<HazardBullet>();
		emitters = new FlxTypedGroup<FlxEmitter>();
		_entities = new FlxGroup();
		
		
		#if desktop
		FlxG.mouse.visible = false; // must always be set to false pls
		#end
		map = LevelLoaderProc.loadGeneratedLevel();
		backDrop = new FlxBackdrop(AssetPaths.background__png, 0.01, 0.01, true, true);

		cameraSetup();
		addGameplayElements();

		createTrailArea();
      //  getMiniMap();
	}
	

	override public function update(elapsed:Float):Void
	{
		if (!Reg.pause)
		super.update(elapsed);
		
		#if desktop
		controlPauseScreen();
		Gamepad.checkForGamepad();
		Gamepad.updateGameInputs();
		Gamepad.checkForExit();
		#end
		displayTracers();
		addLevelObjects();
		updateTrailArea();
		trailArea.update(elapsed);
		
		if (!persistentUpdateSet)
		{

			new FlxTimer().start(transIn.duration - 1, function(_) { 		
			 persistentUpdate = true;  persistentUpdateSet = true;
			}, 1);
			
	
		}
		
		trace(persistentUpdate);

		// PLACEHOLDER	
		barrierLeft.setPosition(FlxG.camera.scroll.x , FlxG.camera.scroll.y );
		barrierRight.setPosition(FlxG.camera.scroll.x + FlxG.width -1 , FlxG.camera.scroll.y);
		

		FlxSpriteUtil.bound(player, 
		                    FlxG.camera.scroll.x, 
							FlxG.camera.scroll.x + FlxG.camera.width,
							FlxG.camera.scroll.y,
							FlxG.camera.scroll.y + FlxG.camera.height);	
	}
	
	public function getMiniMap(wallColor:Int = 0xFFFF00FF, openColor:Int = 0xFFFFFFFF):Void
	{
		var minimap:FlxSprite = new FlxSprite();
		var bData:BitmapData;
		
		minimap.makeGraphic(map.widthInTiles, map.heightInTiles, 0xFFFF0000);
		bData = new BitmapData(map.widthInTiles, map.heightInTiles);
		for (i in 0...map.widthInTiles)
		{
			for (j in 0...map.heightInTiles)
			{
				if (map.getTile(i, j) > 0) // Is collision tile
				{
					bData.setPixel(i, j, openColor);
				}
				else bData.setPixel(i, j, wallColor); // Else
			}
		}
		
		minimap.pixels = bData;
		
		minimap.setGraphicSize(250);
		minimap.screenCenter();
		minimap.visible = true;
		minimap.scrollFactor.set(0, 0);
		
		add(minimap);
	}
	
	
	private function addLevelObjects()
	{
		for (enemy in ObjectPlacement.allLevelEnemies)
		{
		  if (FlxMath.distanceBetween(enemy, player) < ObjectPlacement.minDistanceToEnemy)
		  {
			  Reg.PS.enemies.add(enemy);
		  }
	    }
		
	    for (hazard in ObjectPlacement.allLevelHazards)
		{
		  if (FlxMath.distanceBetween(hazard, player) < ObjectPlacement.minDistanceToEnemy)
		  {
			  Reg.PS.hazards.add(hazard);
		  }
	    }
		
        for (blocks in ObjectPlacement.allLevelBlocks)
		{
		  if (FlxMath.distanceBetween(blocks, player) < ObjectPlacement.minDistanceToEnemy)
		  {
			  Reg.PS.blocks.add(blocks);
		  }
	    }
		
	}
	
	private function addGameplayElements()
	{		
		add(backDrop);
		add(map);
		

		_entities.add(EExplosions);
		_entities.add(coins);
		_entities.add(blocks);
		_entities.add(items);
		_entities.add(hazards);
		_entities.add(enemies);
		_entities.add(emitters);
		_entities.add(EBullets);
		_entities.add(HBullets);
		_entities.add(PBullets);
		_entities.add(sysObjects);

		
		add(_entities);
		add(player);	
		add(effects);
		_entities.add(barrierLeft);
		_entities.add(barrierRight);	
		effects.clear();
		
	}
	
	private function createTrailArea()
	{
	  trailArea = new FlxTrailArea(0, 0, FlxG.width, FlxG.height, 0.5,2, false, false);
	  add(trailArea);
	}
	
	private function updateTrailArea()
	{
		trailArea.setPosition(FlxG.camera.scroll.x, FlxG.camera.scroll.y);
		
		for (bullet in EBullets)
		{
		trailArea.add(bullet);
		}
		
		for (hbullet in HBullets)
		{
			trailArea.add(hbullet);
	    }
		
		for (coin in coins)
		{
			trailArea.add(coin);
		}
		
		for (hazard in hazards)
		{
			if (Type.getClassName(Type.getClass(hazard)).indexOf("HazardLaser") > -1)
			trailArea.add(hazard);
		}
		
		trailArea.add(barrierLeft);
		trailArea.add(barrierRight);
		
	}
	
	private function controlPauseScreen()
	{
		if (Reg.pause)
		{
			openSubState(new PauseState());
			_gameCamera.followLerp = 0.0;
			canQuit = true;
	
		}
		else
		{
	     	closeSubState();
			_gameCamera.followLerp = lerpSpeed;
			canQuit = false;
		}	
	}

	private function cameraSetup()
	{	
		_gameCamera = new FlxCamera();
		_hudCamera = new FlxCamera();
		_scroller = new Scroller(player.x + _scrollerOffset, player.y); 
		
		FlxG.cameras.reset(_gameCamera);
		FlxG.cameras.add(_hudCamera);
		_hudCamera.bgColor = FlxColor.TRANSPARENT;
		FlxCamera.defaultCameras = [_gameCamera];
		_hud = new HUD();
		_hud.setCamera(_hudCamera);
		
		add(_hud);
		
		_gameCamera.setScrollBoundsRect(0, 0, map.width, map.height, true);
		_gameCamera.pixelPerfectRender = false;	
		_gameCamera.follow(_scroller, FlxCameraFollowStyle.TOPDOWN_TIGHT, lerpSpeed);

		
		add(_scroller);
	}

	private function updateCam()
	{
		if (Reg.PS.player.x <_scroller.x)
		{
		_gameCamera.follow(_scroller, FlxCameraFollowStyle.TOPDOWN_TIGHT, lerpSpeed);
		}
		else
		{
		_gameCamera.follow(Reg.PS.player, FlxCameraFollowStyle.TOPDOWN, lerpSpeed);
		}
	}
	
	private function displayTracers()
	{
		#if !FLX_NO_DEBUG // && desktop
		if (FlxG.keys.justPressed.T)
		{
		trace("enemies : " + enemies.length);
		trace("SCROLLER : " + Reg.SCROLLER_ON);	
		trace("items : " + items.length);

		trace("eBullets : " +EBullets.length);
		trace("PBullets : " + PBullets.length);
	    trace("coins  " + coins.length);
		trace("blocks " + blocks.length);
		trace("_entities " + _entities.length);
		trace("effects " + effects.length);
		trace("MASTER SEED : " + Reg.CURRENT_SEED.initialSeed);
		}
	    #end
	}
	
}
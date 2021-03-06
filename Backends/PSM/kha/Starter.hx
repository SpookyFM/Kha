package kha;

import kha.graphics4.Graphics2;
import kha.psm.graphics4.Graphics;

class Starter {
	static public var game: Game;
	private static var framebuffer: Framebuffer;
	static var left: Bool;
	static var right: Bool;
	static var up: Bool;
	static var down: Bool;
	
	public static var mouseX: Int = 0;
	public static var mouseY: Int = 0;
	
	public function new() {
		left = false;
		right = false;
		up = false;
		down = false;
		
		//keyboard = new Keyboard();
		//mouse = new kha.input.Mouse();
		//gamepad = new Gamepad();
		
		Loader.init(new kha.psm.Loader());
		Scheduler.init();
	}
	
	public function start(game: Game) {
		Starter.game = game;
		Configuration.setScreen(new EmptyScreen(Color.fromBytes(0, 0, 0)));
		Loader.the.loadProject(loadFinished);
	}
	
	public function loadFinished(): Void {
		Loader.the.initProject();
		game.width = Loader.the.width;
		game.height = Loader.the.height;
		Sys.init();
		
		var graphics = new Graphics();
		framebuffer = new Framebuffer(null, graphics);
		var g2 = new Graphics2(framebuffer);
		framebuffer.init(g2, graphics);
		
		Scheduler.start();
		Configuration.setScreen(game);
		Configuration.screen().setInstance();
		game.loadFinished();
		while (true) {
			checkEvents();
			checkGamepad();
			Scheduler.executeFrame();
			game.render(framebuffer);
		}
	}
	
	@:functionCode('
		Sce.PlayStation.Core.Input.GamePadData gamePadData = Sce.PlayStation.Core.Input.GamePad.GetData(0);
		if ((gamePadData.Buttons & Sce.PlayStation.Core.Input.GamePadButtons.Left) != 0) {
			if (!left) {
				game.buttonDown(Button.LEFT);
				left = true;
			}
		}
		else {
			if (left) {
				game.buttonUp(Button.LEFT);
				left = false;
			}
		}
		if ((gamePadData.Buttons & Sce.PlayStation.Core.Input.GamePadButtons.Right) != 0) {
			if (!right) {
				game.buttonDown(Button.RIGHT);
				right = true;
			}
		}
		else {
			if (right) {
				game.buttonUp(Button.RIGHT);
				right = false;
			}
		}
		if ((gamePadData.Buttons & Sce.PlayStation.Core.Input.GamePadButtons.Up) != 0) {
			if (!up) {
				game.buttonDown(Button.UP);
				up = true;
			}
		}
		else {
			if (up) {
				game.buttonUp(Button.UP);
				up = false;
			}
		}
		if ((gamePadData.Buttons & Sce.PlayStation.Core.Input.GamePadButtons.Down) != 0) {
			if (!down) {
				game.buttonDown(Button.DOWN);
				down = true;
			}
		}
		else {
			if (down) {
				game.buttonUp(Button.DOWN);
				down = false;
			}
		}
	')
	static function checkGamepad(): Void {
		
	}
	
	@:functionCode('
		Sce.PlayStation.Core.Environment.SystemEvents.CheckEvents();
	')
	static function checkEvents(): Void {
		
	}
}

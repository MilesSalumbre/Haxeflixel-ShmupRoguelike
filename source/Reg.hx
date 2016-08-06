package;

import states.PlayState;
import states.TestState;
class Reg
{
	public static var PS:PlayState;
	public static var DEBUG = false; // set to TRUE if testing a new enemy or feature
	public static var currentLevel:Int = 0;
	
	public static var pause:Bool = false;
	public static var score:Int = 0;
	public static var availableItems:Array<Int> = [2, 3, 4, 5]; // hacky af
    public static var SCROLLER_ON = true;
	public static var mapChunkTemplates = [       
												[[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,1,1,0,0,0,0,0],
												[0,0,0,0,0,1,1,0,0,0,0,0],
												[0,0,0,0,0,3,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,3,0,0],
												[0,0,0,0,0,0,0,0,1,1,0,0],
												[0,0,0,0,0,0,0,0,1,1,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,1,1,0,0,0,0,0,0,0],
												[0,0,0,1,1,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0]],
												
												
												[[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,1,1,1,1,1,0,0,0,0],
												[0,0,0,1,1,1,1,1,0,0,0,0],
												[0,0,0,1,1,1,1,1,0,0,0,0],
												[0,0,0,1,1,1,1,1,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,3,0,0,0,0],
												[0,0,0,0,0,1,1,1,1,1,0,0],
												[0,0,0,0,0,1,1,1,1,1,0,0],
												[0,0,0,0,0,1,1,1,1,1,0,0],
												[0,0,0,0,0,1,1,1,1,1,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0]],
												
												
												
												[[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,1,1,1,1,1,0,0,0,0,0],
												[0,0,0,0,0,0,1,0,0,0,0,0],
												[0,0,0,0,0,0,1,0,0,0,0,0],
												[0,0,0,0,0,0,1,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,4,0,1,0,0,0,0,0],
												[0,0,0,0,0,0,1,0,0,0,0,0],
												[0,0,0,0,0,0,1,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,1,0,0,0,0,0],
												[0,0,0,0,0,0,1,0,0,0,0,0],
												[0,0,0,0,0,0,1,0,0,0,0,0],
												[0,0,0,3,0,0,1,0,0,0,0,0],
												[0,0,1,1,1,1,1,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0]],
												
												
												[[0,0,0,0,0,0,0,0,0,0,2,2],
												[0,0,0,0,0,0,0,0,0,0,2,2],
												[0,0,0,0,0,0,0,0,0,0,2,2],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,2,2],
												[0,0,0,0,0,0,0,0,0,0,2,2],
												[0,0,0,0,0,0,0,0,0,0,2,2],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,3,0,0,0,0],
												[0,0,0,0,0,0,2,2,2,2,0,0],
												[0,0,0,0,0,0,0,2,2,0,0,0],
												[0,0,0,0,0,0,0,0,2,2,2,2],
												[0,0,0,0,0,0,0,0,2,2,2,2],
												[0,0,0,0,0,0,0,0,0,0,2,2],
												[0,0,0,0,0,0,0,0,0,0,2,2],
												[0,0,0,0,0,0,0,0,0,0,2,2],
												[0,0,0,0,0,0,0,0,0,0,2,2]],
												
												[[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,4,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0]],
												
												[[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[5,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0]],
												
												[[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,1,1,1,1,1,1,1,0,0],
												[0,0,0,0,0,0,3,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,2,0,0,0,0,0,0,0,0,2,0],
												[0,2,0,0,0,3,3,0,0,0,2,0],
												[0,1,1,1,1,1,1,1,1,1,1,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0]],
												
												[[2,0,0,0,0,0,0,0,0,0,0,2],
												[2,0,0,0,0,0,0,0,0,0,0,2],
												[2,0,0,0,0,0,0,0,0,0,0,2],
												[2,0,0,0,0,0,0,0,0,0,0,2],
												[2,0,0,0,0,0,0,0,0,0,0,2],
												[2,0,0,0,0,0,0,0,0,0,0,2],
												[2,2,2,2,2,2,2,2,2,2,2,2],
												[2,2,2,2,2,2,2,2,2,2,2,2],
											    [6,0,0,0,6,0,0,6,0,0,0,6],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[2,2,2,2,2,2,2,2,2,2,2,2],
												[2,2,2,2,2,2,2,2,2,2,2,2],
												[2,0,0,0,0,0,0,0,0,0,0,2],
												[2,0,0,0,0,0,0,0,0,0,0,2],
												[2,0,0,0,0,0,0,0,0,0,0,2],
												[2,0,0,0,0,0,0,0,0,0,0,2],
												[2,0,0,0,0,0,0,0,0,0,0,2],
												[2,0,0,0,0,0,0,0,0,0,0,2]],
												
											   [[2,2,2,2,2,2,2,2,2,2,2,2],
												[2,2,2,2,2,2,2,2,2,2,2,2],
												[2,2,0,0,0,0,0,0,6,0,2,2],
												[2,2,0,0,0,0,0,0,0,0,2,2],
												[2,2,0,0,0,0,0,0,0,0,2,2],
												[2,2,0,0,0,2,2,0,0,0,2,2],
												[2,2,0,0,0,2,2,0,0,0,2,2],
												[2,2,0,0,0,2,2,0,0,0,2,2],
												[2,2,0,0,0,2,2,0,0,0,2,2],
												[0,0,0,0,0,2,2,0,0,0,2,2],
												[0,0,0,0,0,2,2,0,0,0,2,2],
												[0,0,0,0,0,2,2,0,0,0,0,0],
												[0,0,0,6,0,2,2,0,0,0,0,0],
												[2,2,2,2,2,2,2,0,0,0,0,0],
												[2,2,2,2,2,2,2,0,0,0,0,0],
												[2,2,2,2,2,2,2,0,0,0,0,0],
												[2,2,2,2,2,2,2,0,0,0,0,0],
												[2,2,2,2,2,2,2,2,2,2,2,2],
												[2,2,2,2,2,2,2,2,2,2,2,2],
												[2,2,2,2,2,2,2,2,2,2,2,2]],
												
												[[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,7,0,0,0,0,0],
												[0,0,0,0,2,2,2,2,0,0,0,0]],
												
										    	[[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,8,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0]],
												
												[[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,9,0,0,0,0,0]],
												
											   [[0,0,0,2,2,2,2,2,0,0,0,0],
												[0,0,0,0,0,9,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0]],
									
												[[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,2,2,2,0],
												[0,0,0,0,0,0,0,0,1,1,2,0],
												[0,0,0,0,3,0,0,0,2,2,2,0],
												[0,0,0,0,2,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[5,0,0,0,0,0,3,0,0,0,0,0],
												[0,0,0,0,0,0,2,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,3,0,0,0,0,0,0,0],
												[0,0,0,0,2,0,0,0,0,0,0,0],
												[0,0,0,0,3,0,0,0,0,3,0,0],
												[0,0,0,0,0,0,0,0,0,2,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[0,0,0,0,0,0,0,0,0,0,0,0],
												[2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2]]
												
												
												];

	
}
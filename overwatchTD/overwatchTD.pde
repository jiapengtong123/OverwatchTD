import ddf.minim.*;
import java.util.*;

PFont font; 
int font_size;
MainMenu mainMenu;
GameMenu gameMenu;
OptionsMenu options;
QuitWindow quit;
RestartWindow restart;
TextButton b1, b2, b3; // Main Menu
TextButton b4, b5, b6, b7; // Game Mode
int currentMenu; // 0: Main, 1: Play, 2: Options Popup, 3&4: Quit Pop up, 5: Restart Pop up
ProjectileSystem projSyst;
AgentSystem agentSyst;

boolean towerSelected; // If Active Buying Tower
boolean liveTowerSelected; // If Active Live Tower; cannot have buying and live tower true
boolean roundStart; //whether the round has begun
Tower activeTower;
int goldCount;
int lifeCount;
Minim minim = new Minim(this);
AudioPlayer songs[] = new AudioPlayer[3]; // 0: Main Menu; 1: Gameplay; 2: Victory
AudioPlayer voicelines[] = new AudioPlayer[18];
int currentTrack;
boolean musicMode;
float volume;
float difficulty;
int level; //round number

//road map
PRM prm;
Obstacles obstacles;

ParticleSystem ps;


float timer = 0;
int agentNum = 0;
float timeSlice = 5000;


void setup() {
  //fullScreen(P2D); // use to switch to fullscreen
  size(1280, 720, P2D); //comment out when fullscreen
  font = loadFont("SegoeUI-BoldItalic-48.vlw");
  font_size = int(0.045*height); //size for main menu

  // Initialize Menus and Popups
  mainMenu = new MainMenu();
  gameMenu = new GameMenu();
  options = new OptionsMenu();
  quit = new QuitWindow();
  restart = new RestartWindow();

  goldCount = int(1000 * difficulty); //INIT VALUE FOR NOW; TO BE CHANGED based on game difficulty
  lifeCount = int(100* difficulty);
  currentMenu = 0;
  roundStart = false;
  level =1;

  initPlaylist();
  initVoiceLines();

  projSyst = new ProjectileSystem();
  agentSyst = new AgentSystem();
  ps = new ParticleSystem();

  //road map and agents
  InitialMap_Agent();
  //createAgents();
}

void draw() {

  //println(frameRate);
  updateSoundtrack();       
  // Main Menu
  if (currentMenu == 0) { //change back to 0 after
    mainMenu.display();
  }
  // Game Mode
  if (currentMenu == 1) {
    if (agentNum < 20*level) {
      if (millis() - timer >= timeSlice) {
        createAgents();
        timer = millis();
        agentNum += 4;
      }
    }
    gameMenu.displayUI();
    modifyMusicButton();// "Cross off Sound Button
    agentSyst.displayAgentSystem();
    projSyst.displayProjectileSystem();
    if (roundStart && (agentSyst.getAgents().size() == 0)) {
      roundStart = false;
      level++;
      agentNum = 0;
      timeSlice+=1000;
      //createAgents();
    }
  }
  // Options Menu
  if (currentMenu == 2) {
    options.displayUI();
  }
  // Quit Popup in Home and Game Screens
  if ((currentMenu == 3) || (currentMenu == 4)) {
    quit.displayUI();
  }
  //Popup to leave Game Mode to Enter Main Menu
  if (currentMenu == 5) {
    restart.displayUI();
  }
}

void goldCounter() {
  textFont(font, height*0.03);
  text("Gold: " + goldCount, width*0.88, height*0.04);
}
void lifeLine() {
  textFont(font, height*0.03);
  text("Lives: " + lifeCount, width*0.88, height*0.08);
}
void currentRound() {
  textFont(font, height*0.03);
  text("Round: " + level, width*0.88, height*0.12);
}

void addObstacles() {

  float sizeObstacle = 65;

  int numEachline = int(0.88 * width / sizeObstacle);
  for (int i =0; i< numEachline; i++) {
    float x = sizeObstacle/2 + i * sizeObstacle;
    float y = sizeObstacle/2;
    obstacles.add(new Obstacle(x, y, sizeObstacle));
    y = 0.82 * height - sizeObstacle/2;
    obstacles.add(new Obstacle(x, y, sizeObstacle));
  }

  sizeObstacle = 65;
  for (int i =0; i< 13; i++) {
    float x = sizeObstacle/2 + i * sizeObstacle;
    float y = 0.8 * height /2;

    obstacles.add(new Obstacle(x, y, sizeObstacle));
  }

  sizeObstacle = 65;
  numEachline = int(0.8 * height / sizeObstacle);
  for (int i =0; i< numEachline; i++) {
    float x = 0.86 * width - sizeObstacle/2;
    float y = sizeObstacle/2 + i * sizeObstacle;

    obstacles.add(new Obstacle(x, y, sizeObstacle));
  }
}


void InitialMap_Agent() {
  //road map
  int sampleNum = 200;

  obstacles = new Obstacles();
  prm = new PRM(sampleNum);

  addObstacles();

  agentSyst.addObsatcles(obstacles);
  prm.addObstacles(obstacles);
  prm.go();
}


void createAgents() {
  int group= 4;
  int numAgents = group*level;

  for (int i = 0; i < numAgents; i++) {

    Agent agent = new Agent(new PVector(30, 0.8*height/4));
    agent.addPath(prm.finalPath);
    agentSyst.addAgent(agent);
  }
}
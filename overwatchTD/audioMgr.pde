void initPlaylist() {
  songs[0] =  minim.loadFile("Overwatch - Main Menu.mp3");
  songs[1] =  minim.loadFile("Overwatch - Gameplay.mp3");
  songs[2] =  minim.loadFile("Overwatch - Victory Theme.mp3");
  
  musicMode = true;
  currentTrack = 0;
  volume = 1.0;
  songs[currentTrack].loop();
}
void initVoiceLines() {
  voicelines[0] = minim.loadFile("Junkrat_-_Bots_into_the_light.mp3");
  voicelines[1] = minim.loadFile("Junkrat_-_come_out_and_play.mp3");
  voicelines[2] = minim.loadFile("Genji_-_Even_here_I_feel_an_outcast.mp3");
  voicelines[3] = minim.loadFile("Genji_-_Genji_is_with_you.mp3");
  voicelines[4] = minim.loadFile("Genji_-_Hah__Simple.mp3");
  voicelines[5] = minim.loadFile("Junkrat_-_Coming_up_explodey.mp3");
  voicelines[6] = minim.loadFile("Mercy_-_Back_to_square_one.mp3");
  voicelines[7] = minim.loadFile("Mercy_-_Get_them_off_me_.mp3");
  voicelines[8] = minim.loadFile("Mercy_-_I_am_touched_by_your_support.mp3");
  voicelines[9] = minim.loadFile("Mei_-_I'm_Ready_To_Start_A_Blizzard.mp3");
  voicelines[10] = minim.loadFile("Widowmaker_Pregame1.mp3");
  voicelines[11] = minim.loadFile("Mei_-_Everyone_is_counting_on_me.mp3");
  voicelines[12] = minim.loadFile("Mei_-_This_fight_is_not_over_yet.mp3");
  voicelines[13] = minim.loadFile("Widowmaker-One_after_another.mp3");
  voicelines[14] = minim.loadFile("Widowmaker_-_One_shot__one_kill.mp3");
  voicelines[15] = minim.loadFile("Winston_-_By_my_calculations__oh_forget_it__let_s_move_.mp3");
  voicelines[16] = minim.loadFile("Winston_-_There_s_no_stopping_me_.mp3");
  voicelines[17] = minim.loadFile("Winston_-_Would_you_like_to_donate_your_body_to_science.mp3");
}

void updateSoundtrack() {
  if (!musicMode) {
    songs[0].mute();
  } 
  else {
    int rand_voice = int(random(0,18)); //0-18
    songs[currentTrack].unmute();
    // If Main Menu and Not Playing Main Menu Track
    if ((currentMenu == 0) && (currentTrack!=0)) {
      songs[currentTrack].mute();
      currentTrack = 0;
      songs[currentTrack].unmute();
      songs[currentTrack].loop();
    }
    // If Game Mode and Not Playing Gameplay Track
    else if ((currentMenu == 1) && (currentTrack!=1) && roundStart) {
      voicelines[rand_voice].play();
      songs[currentTrack].mute();
      currentTrack = 1;
      songs[currentTrack].unmute();
      songs[currentTrack].loop();
    }   
    else if ((currentMenu == 1) && (currentTrack!=2) && !roundStart) {
      songs[currentTrack].mute();
      currentTrack = 2;
      songs[currentTrack].unmute();
      songs[currentTrack].loop();
    }  
  }
  //println("current track: " + currentTrack);
}
void modifyMusicButton() {
  if (musicMode == false) {
    stroke(255, 0, 0);
    strokeWeight(5);
    //crosses out Music On button in gameMenu
    line(width*0.9, height*0.78, width*0.98, height*0.74);
    line(width*0.9, height*0.74, width*0.98, height*0.78);
  }
}
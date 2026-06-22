import de.voidplus.leapmotion.*;
import java.awt.*;
import java.awt.event.*;

// ======================================================
// Table of Contents:
// ├─ 1. Callbacks
// ├─ 2. Hand
// ├─ 3. Arms
// ├─ 4. Fingers
// ├─ 5. Bones
// ├─ 6. Tools
// └─ 7. Devices
// ======================================================


LeapMotion leap;
Robot robot;
PFont pfont;
Point save_p;

void setup() {
  size(1280,720);
  //size(10,10);
  //fullScreen(P3D);
  background(255);
  // ...
  try { 
    robot = new Robot();
    robot.setAutoDelay(0);
  } 
  catch (Exception e) {
    e.printStackTrace();
  }

  leap = new LeapMotion(this);
  leap = new LeapMotion(this).allowGestures();  // All gestures
  // leap = new LeapMotion(this).allowGestures("circle, swipe, screen_tap, key_tap");
  // leap = new LeapMotion(this).allowGestures("swipe");  // Leap detects only swipe gestures
}


// ======================================================
// 1. Callbacks

void leapOnInit() {
  // println("Leap Motion Init");
}
void leapOnConnect() {
  // println("Leap Motion Connect");
}
void leapOnFrame() {
  // println("Leap Motion Frame");
}
void leapOnDisconnect() {
  // println("Leap Motion Disconnect");
}
void leapOnExit() {
  // println("Leap Motion Exit");
}


void draw() {
  background(255);
  // ...

  int fps = leap.getFrameRate();
  for (Hand hand : leap.getHands ()) {


    // ==================================================
    // 2. Hand

    int     handId             = hand.getId();
    PVector handPosition       = hand.getPosition();
    //println(handPosition);
    PVector handStabilized     = hand.getStabilizedPosition();
    PVector handDirection      = hand.getDirection();
    PVector handDynamics       = hand.getDynamics();
    float   handRoll           = hand.getRoll();
    float   handPitch          = hand.getPitch();
    float   handYaw            = hand.getYaw();
    boolean handIsLeft         = hand.isLeft();
    boolean handIsRight        = hand.isRight();
    float   handGrab           = hand.getGrabStrength();
    float   handPinch          = hand.getPinchStrength();
    float   handTime           = hand.getTimeVisible();
    PVector spherePosition     = hand.getSpherePosition();
    float   sphereRadius       = hand.getSphereRadius();

    // --------------------------------------------------
    // Drawing
    //hand.draw();
    
    // ==================================================
    // 3. Arm

    if (hand.hasArm()) {
      Arm     arm              = hand.getArm();
      float   armWidth         = arm.getWidth();
      PVector armWristPos      = arm.getWristPosition();
      PVector armElbowPos      = arm.getElbowPosition();
    }


    // ==================================================
    // 4. Finger

    Finger  fingerThumb        = hand.getThumb();
    
    // or                        hand.getFinger("thumb");
    // or                        hand.getFinger(0);

    Finger  fingerIndex        = hand.getIndexFinger();
    //println(fingerIndex);
    // or                        hand.getFinger("index");
    // or                        hand.getFinger(1);

    Finger  fingerMiddle       = hand.getMiddleFinger();
    //println(fingerMiddle);
    // or                        hand.getFinger("middle");
    // or                        hand.getFinger(2);

    Finger  fingerRing         = hand.getRingFinger();
    //println(fingerRing);
    // or                        hand.getFinger("ring");
    // or                        hand.getFinger(3);

    Finger  fingerPink         = hand.getPinkyFinger();
    //println(fingerPink);
    // or                        hand.getFinger("pinky");
    // or                        hand.getFinger(4);
    PVector fingy = fingerIndex.getPosition();
    float xPos = fingy.x;
    float yPos = fingy.y;
    //rect(xPos, yPos, 50, 50);
    int mousexPos = int(xPos);
    int mouseyPos = int(yPos);
    robot.mouseMove(mousexPos, mouseyPos);
    //println(fingy);
    
  
    for (Finger finger : hand.getFingers()) {
      // or              hand.getOutstretchedFingers();
      // or              hand.getOutstretchedFingersByAngle();

      int     fingerId         = finger.getId();
     // println(fingerId);
      PVector fingerPosition   = finger.getPosition();
      //float xPos = fingerPosition.x;
      //float yPos = fingerPosition.y;
      //rect(xPos, yPos, 30, 30);
      //println(fingerPosition);
      PVector fingerStabilized = finger.getStabilizedPosition();
      //println("finger", fingerStabilized);
      PVector fingerVelocity   = finger.getVelocity();
      PVector fingerDirection  = finger.getDirection();
      float   fingerTime       = finger.getTimeVisible();
      
      // ------------------------------------------------
      // Drawing

      // Drawing:
       //finger.draw();  // Executes drawBones() and drawJoints()
       //finger.drawBones();
       //finger.drawJoints();

      // ------------------------------------------------
      // Selection

      switch(finger.getType()) {
      case 0:
         //System.out.println("thumb");
         
        break;
      case 1:
         //System.out.println("index");
        break;
      case 2:
         //System.out.println("middle");
        break;
      case 3:
         //System.out.println("ring");
        break;
      case 4:
         //System.out.println("pinky");
        break;
      }


      // ================================================
      // 5. Bones
      // --------
      // https://developer.leapmotion.com/documentation/java/devguide/Leap_Overview.html#Layer_1

      Bone    boneDistal       = finger.getDistalBone();
      // or                      finger.get("distal");
      // or                      finger.getBone(0);

      Bone    boneIntermediate = finger.getIntermediateBone();
      // or                      finger.get("intermediate");
      // or                      finger.getBone(1);

      Bone    boneProximal     = finger.getProximalBone();
      // or                      finger.get("proximal");
      // or                      finger.getBone(2);

      Bone    boneMetacarpal   = finger.getMetacarpalBone();
      // or                      finger.get("metacarpal");
      // or                      finger.getBone(3);

      // ------------------------------------------------
      // Touch emulation

      int     touchZone        = finger.getTouchZone();
      float   touchDistance    = finger.getTouchDistance();

      switch(touchZone) {
      case -1: // None
        break;
      case 0: // Hovering
        // println("Hovering (#" + fingerId + "): " + touchDistance);
        break;
      case 1: // Touching
        // println("Touching (#" + fingerId + ")");
        break;
      }
    }


    // ==================================================
    // 6. Tools

    for (Tool tool : hand.getTools()) {
      int     toolId           = tool.getId();
      PVector toolPosition     = tool.getPosition();
      PVector toolStabilized   = tool.getStabilizedPosition();
      PVector toolVelocity     = tool.getVelocity();
      PVector toolDirection    = tool.getDirection();
      float   toolTime         = tool.getTimeVisible();

      // ------------------------------------------------
      // Drawing:
      // tool.draw();

      // ------------------------------------------------
      // Touch emulation

      int     touchZone        = tool.getTouchZone();
      float   touchDistance    = tool.getTouchDistance();

      switch(touchZone) {
      case -1: // None
        break;
      case 0: // Hovering
        // println("Hovering (#" + toolId + "): " + touchDistance);
        break;
      case 1: // Touching
        // println("Touching (#" + toolId + ")");
        break;
      }
    }
  }


  // ====================================================
  // 7. Devices

  for (Device device : leap.getDevices()) {
    float deviceHorizontalViewAngle = device.getHorizontalViewAngle();
    float deviceVericalViewAngle = device.getVerticalViewAngle();
    float deviceRange = device.getRange();
  }
}

void mouseClick(){
  robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
  println("clicked");
}

// ======================================================
// 1. Swipe Gesture

void leapOnSwipeGesture(SwipeGesture g, int state){
  int     id               = g.getId();
  Finger  finger           = g.getFinger();
  PVector position         = g.getPosition();
  PVector positionStart    = g.getStartPosition();
  PVector direction        = g.getDirection();
  float   speed            = g.getSpeed();
  long    duration         = g.getDuration();
  float   durationSeconds  = g.getDurationInSeconds();

  switch(state){
    case 1: // Start
      break;
    case 2: // Update
      break;
    case 3: // Stop
      //println("SwipeGesture: " + id);
      break;
  }
}


// ======================================================
// 2. Circle Gesture

void leapOnCircleGesture(CircleGesture g, int state){
  int     id               = g.getId();
  Finger  finger           = g.getFinger();
  PVector positionCenter   = g.getCenter();
  float   radius           = g.getRadius();
  float   progress         = g.getProgress();
  long    duration         = g.getDuration();
  float   durationSeconds  = g.getDurationInSeconds();
  int     direction        = g.getDirection();

  switch(state){
    case 1: // Start
      break;
    case 2: // Update
      break;
    case 3: // Stop
      //println("CircleGesture: " + id);
      break;
  }

  switch(direction){
    case 0: // Anticlockwise/Left gesture
      break;
    case 1: // Clockwise/Right gesture
      break;
  }
}


// ======================================================
// 3. Screen Tap Gesture

void leapOnScreenTapGesture(ScreenTapGesture g){
  int     id               = g.getId();
  Finger  finger           = g.getFinger();
  PVector position         = g.getPosition();
  PVector direction        = g.getDirection();
  long    duration         = g.getDuration();
  float   durationSeconds  = g.getDurationInSeconds();
  mouseClick();
  //println("ScreenTapGesture: " + id);
}


// ======================================================
// 4. Key Tap Gesture

void leapOnKeyTapGesture(KeyTapGesture g){
  int     id               = g.getId();
  Finger  finger           = g.getFinger();
  PVector position         = g.getPosition();
  PVector direction        = g.getDirection();
  long    duration         = g.getDuration();
  float   durationSeconds  = g.getDurationInSeconds();
  
  //println("KeyTapGesture: " + id);
}
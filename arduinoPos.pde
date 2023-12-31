void arduinoPos() { 

  print ( "compteur dans arduino  "); 
  showArray(rev);


 if (keyMode == " propagationBallRotationPASPOSSI " ) { 
    for (int i = 0; i < networkSize; i++) {

    //rev[i]=rev[0];

    //*******************************  ASSIGN MOTOR WITH POSITION
    //   pos[i]= pos[i]-numberOfStep/4; // The positions 0 of my motors in real are shifted of - half_PI  

    if (rev[i]!=0  && (net.phase[i] >  0) ) { // number of revolution is even and rotation is clock wise   
      Pos[i]= int (map (net.phase[i], 0, TWO_PI, 0, numberOfStep));
    }

    //   if (rev[i]!=0  && (net.phase[i] <  0)) { // number of revolution is even and rotation is Counter clock wise   
    if (rev[i]!=0  && (net.phase[i] <  0)) { // number of revolution is even and rotation is Counter clock wise   

      Pos[i]= int (map (net.phase[i], 0, -TWO_PI, numberOfStep, 0));
    }

    if (rev[i]==0 && (net.phase[i] < 0) ) { //  number of revolution is 0 and rotation is counter clock wise 
      Pos[i]= int (map (net.phase[i], 0, -TWO_PI, numberOfStep, 0));        
      //    print ("pos "); print (i); print (" CCW rev=0");println (pos[i]);
    }         
    if  (rev[i]==0 && (net.phase[i] > 0) ) {  //  number of revolution is 0 and rotation is clock wise     
      Pos[i]= int (map (net.phase[i], 0, TWO_PI, 0, numberOfStep));         
    }
    dataMappedForMotorisedPosition[i]=Pos[i];
   // print ( " Pos " + i + " " + Pos[i] );
   // print ( " dataMappedForMotorisedPosition " +  (int) Pos[i]+ (rev[i]*numberOfStep));
  }
  }
  
  if (formerKeyMetro == '>') {  // formerKeyMetro == '<' || 
    for (int i = 0; i < networkSize; i++) {
      // rev[i]=rev[0];

      //*******************************  ASSIGN MOTOR WITH POSITION

      if (rev[i]!=0  && (newPosF[i] >  0) ) { // number of revolution is even and rotation is clock wise   
        pos[i]= int (map (newPosF[i], 0, TWO_PI, 0, numberOfStep))+ (rev[i]*numberOfStep);
      }

      if (rev[i]!=0  && (newPosF[i] <  0)) { // number of revolution is even and rotation is Counter clock wise          // pos[i]= int (map (newPosF[i], 0, -TWO_PI, 0,  numberOfStep))+ (rev[i]*numberOfStep);

        pos[i]= int (map (newPosF[i], 0, -TWO_PI, numberOfStep, 0)) +(rev[i]*numberOfStep);       //   print ("pos "); print (i); print (" ");println (pos[i]);
      }

      if (rev[i]==0 && (newPosF[i] < 0) ) { //  number of revolution is 0 and rotation is counter clock wise 
        pos[i]= int (map (newPosF[i], 0, -TWO_PI, numberOfStep, 0));        
      }         
      if  (rev[i]==0 && (newPosF[i] > 0) ) {  //  number of revolution is 0 and rotation is clock wise     
        pos[i]= int (map (newPosF[i], 0, TWO_PI, 0, numberOfStep));                //      print ("pos "); print (i); print (" CW rev=0 ");println (pos[i]);
      }
    }
  }

  if (keyMode == " truc ") {

  for (int i = 0; i < networkSize; i++) {
    print ( " net.pase " + i + " " + net.phase[i] );

    //rev[i]=rev[0];

    //*******************************  ASSIGN MOTOR WITH POSITION
    //   pos[i]= pos[i]-numberOfStep/4; // The positions 0 of my motors in real are shifted of - half_PI  

    if (rev[i]!=0  && (net.phase[i] >  0) ) { // number of revolution is even and rotation is clock wise   
      dataMappedForMotorisedPosition[i]= int (map (net.phase[i], 0, TWO_PI, 0, numberOfStep))+rev[i]*numberOfStep ;
    }

    //   if (rev[i]!=0  && (net.phase[i] <  0)) { // number of revolution is even and rotation is Counter clock wise   
    if (rev[i]!=0  && (net.phase[i] <  0)) { // number of revolution is even and rotation is Counter clock wise   

      dataMappedForMotorisedPosition[i]= int (map (net.phase[i], 0, -TWO_PI, numberOfStep, 0))+rev[i]*numberOfStep;
    }

    if (rev[i]==0 && (net.phase[i] < 0) ) { //  number of revolution is 0 and rotation is counter clock wise 
      dataMappedForMotorisedPosition[i]= int (map (net.phase[i], 0, -TWO_PI, numberOfStep, 0));        
      //    print ("pos "); print (i); print (" CCW rev=0");println (pos[i]);
    }         
    if  (rev[i]==0 && (net.phase[i] > 0) ) {  //  number of revolution is 0 and rotation is clock wise     
      dataMappedForMotorisedPosition[i]= int (map (net.phase[i], 0, TWO_PI, 0, numberOfStep));         
    }
  }
 }  

  //=======================================================================

  // ATTENTION A ENVOYER LE MEME NOMBRE DE VAARIABLE QUE PEUT EN RECEVOIR l'ARDUINO. Here is 30 datas+1 data of COHESION 

  // TRIGGING 1 when THE COHESION is very Low   

  //  if (orderParameter>=0.999 ) {  //&& decompte[9]<=5// && revolution[9]==10 the first oscillator (in front the secreen) pass trough 0
  if (orderParameter<=0.001) { 
    cohesionCounterLow++;

    if (cohesionCounterLow==1) { 
      //   background (50);
    } 

    if ( (cohesionCounterLow>=1 && cohesionCounterLow<=1) || (!(cohesionCounterLow>=2 && cohesionCounterLow<=2))|| (!(cohesionCounterLow>=1 && cohesionCounterLow<=4)))
    {
      orderCohesionLow= 1;  // Trig sound and back ground
      //    background (255);
    }
  } else if  ( orderParameter>0.001 ) { 
    cohesionCounterLow=0 ; // Reset cohesionCounterLow at 0

    orderCohesionLow= -1;
  } 

  if (orderParameter<=0.0011 ) { // && orderParameter>=0.099
    cohesionCounterHigh=0 ;
    orderCohesion= 0;
  } 

  if (orderParameter>=0.999 ) {  //&& decompte[9]<=5// && revolution[9]==10 the first oscillator (in front the secreen) pass trough 0
    cohesionCounterHigh++;
    if (cohesionCounterHigh==1) { 
      //   background (75);
    } 

    if ( (cohesionCounterHigh>=1 && cohesionCounterHigh<=1) || (!(cohesionCounterHigh>=2 && cohesionCounterHigh<=2)) || (!(cohesionCounterHigh>=1 && cohesionCounterHigh<=4)))
    {
      orderCohesion= 1;
    }
  } else if  ( orderParameter>=0.0011  && orderParameter<=0.999) { 
    cohesionCounterHigh=0 ; // RESET COUNTER AT 0
    orderCohesion= -1;
  } 

  LevelCohesionToSend= orderParameter;

  // ATTENTION A ENVOYER LE MEME NOMBRE DE VARAIABLE 
  //***********METTRE TOUT SUR LA MEME LIGNE
  String counterNoMarked = rev[5]+","+rev[4]+","+rev[3]+","+rev[2]+","+rev[1]+","+rev[0]+","; // rev[9]+","+rev[8]+","+rev[7]+","+rev[6]+","+
  // you have the number of revolution made by each oscillator
  String revolutionNoMarked = revolution[5]+","+revolution[4]+","+revolution[3]+","+revolution[2]+","+revolution[1]+","+revolution[0]+","; //revolution[9]+","+revolution[8]+","+revolution[7]+","+revolution[6]+","+
 
   
 
  // =============== MAP ACCORDING LFO, CIRCULAR, PENDULAR PHASE To ADAPT IT TO the stepper motor
  // ===============* CIRCULAR MODE TO TRIG DATA ACCORDING POSITION *
  if (formerKeyMetro == '£'  || formerKeyMetro == '*' || formerKeyMetro == 'J' || formerKeyMetro == 's' || formerKeyMetro == '@' ) { //interPosition   || formerKeyMetro == 'c'
        if (   keyMode == " ableton " ) {
          for (int i = 0; i < networkSize; i++) { 
            net.phase[i] = newPosF[i];
       }
      }
         if (  keyMode == " addSignalOneAndTwo " ) {
          for (int i = 0; i < networkSize; i++) {  
        //    net.phase[i] = newPosF[i];
       //    net.phase[i] = newPosXaddSignal[i];
      }
     } 
    
         if (  keyMode == " null " ) {
            for (int i = 0; i < networkSize; i++) {  
        //    net.phase[i] = newPosF[i];
        //   net.phase[i] = newPosXaddSignal[i];
      }
     }

         if (  keyMode == " phasePattern " ) {
             for (int i = 0; i < networkSize; i++) {  
        //    net.phase[i] = newPosF[i];
        //   net.phase[i] = newPosXaddSignal[i];
     }
    }
   
        if (formerKeyMetro == 's' && millis()<10000 ) { //put netphase 11 to phase 
        //j  net.phase[11]= PI+0.1; // do not forget 
             }
        if (formerKeyMetro == 's' && millis()>10000 ) { //put netphase 11 to phase
  
       //   key= 'j'; keyPressed (); // to start Live 
 
             }


       if (keyMode == " phasePattern " ) {
            for (int i = 0; i < networkSize; i++) {  
        //    net.phase[i] = newPosF[i];
        //   net.phase[i] = newPosXaddSignal[i];
          }
        } 

      if (  keyMode == " phasePatternPlusTard " ) {
           for (int i = 0; i < networkSize; i++) {
     //   VirtualPosition[i]= ActualVirtualPosition[i];   // when you change mode of movement, you add last position  dataMappedForMotorisedPosition[i] +
      // =============== MAP PHASE To ADAPT IT TO the stepper motor    // =============== TRIG 0 when oscillator pass THROUG 0:  No effect on positions datas given to teensyport

      if (netPhaseBase[i] >  0 ) {  
        CircularOldVirtualPosition[i]=CircularVirtualPosition[i]; 
        CircularVirtualPosition[i]= int (map (netPhaseBase[i], -PI, PI, 0, numberOfStep));
        Pos[i]= int (map (netPhaseBase[i], 0, TWO_PI, 0, 127)); // to Oscsend
        
     if ((CircularVirtualPosition[i]>3199 && CircularOldVirtualPosition[i]<3200 && CircularOldVirtualPosition[i]>201  )
          || (CircularVirtualPosition[i]<3201 && CircularOldVirtualPosition[i]>3200 && CircularVirtualPosition[i]>201  )  ) {

       TrigmodPos[i]=0;     
       print (i);  print(" CIRCULAR PASS CLOCKWISE THROUG 0: "); println (  TrigmodPos[i]=0); print (" virt ");  println (  VirtualPosition[i]); print (" Cirvirt "); print(  CircularVirtualPosition[i]); print (" CirOldvirt "); println (  CircularOldVirtualPosition[i]);
        } else  TrigmodPos[i]=1;
      } else {
        CircularOldVirtualPosition[i]=CircularVirtualPosition[i]; 
        CircularVirtualPosition[i]= int (map (netPhaseBase[i], PI, -PI, numberOfStep, 0));  
        Pos[i]= int (map (netPhaseBase[i], 0, -TWO_PI, 127, 0));  // to Oscsend  

    if ((CircularVirtualPosition[i]<3201 && CircularOldVirtualPosition[i]>3200 )   ) {
       TrigmodPos[i]=0; print (i); print(" CIRCULAR PASS CLOCKWISE THROUG 0: ");  println (  TrigmodPos[i]=0); print (" virt ");  println (  VirtualPosition[i]); print (" Cirvirt "); print(  CircularVirtualPosition[i]); print (" CirOldvirt "); println (  CircularOldVirtualPosition[i]);

        } else  TrigmodPos[i]=1;
      } 
      dataMappedForMotorisedPosition[i]=CircularVirtualPosition[i]+ActualVirtualPosition[i];
    //  VirtualPosition[i]= CircularVirtualPosition[i]+ActualVirtualPosition[i]; 
    //  lastPositionFromCircularMode[i]=VirtualPosition[i];
      }
     }

   //****** CIRCULAR MODE

      if (  keyMode == " trigEventWithAbletonSignal " ) { // trigEventWithAbletonSignal  // phasePattern
        for (int i = 0; i < networkSize; i++) {

            
    //    VirtualPosition[i]= ActualVirtualPosition[i];   // when you change mode of movement, you add last position  dataMappedForMotorisedPosition[i] +
      // =============== MAP PHASE To ADAPT IT TO the stepper motor    // =============== TRIG 0 when oscillator pass THROUG 0:  No effect on positions datas given to teensyport

      if (net.phase[i] >  0 ) {  
        CircularOldVirtualPosition[i]=CircularVirtualPosition[i]; 
        CircularVirtualPosition[i]= int (map (net.phase[i], 0, TWO_PI, 0, numberOfStep));
        Pos[i]= int (map (net.phase[i], 0, TWO_PI, 0, 127)); // to Oscsend
        
     if ((CircularVirtualPosition[i]%numberOfStep>3199 && CircularOldVirtualPosition[i]%numberOfStep<3200 && CircularOldVirtualPosition[i]%numberOfStep>201  )
          || (CircularVirtualPosition[i]%numberOfStep<3201 && CircularOldVirtualPosition[i]%numberOfStep>3200 && CircularVirtualPosition[i]%numberOfStep>201  )  ) {
   //   background ((i+1)*10, 127/5*(i+1), 50);
       TrigmodPos[i]=0;     
       print (i);  print(" CIRCULAR PASS CLOCKWISE THROUG 0: "); println (  TrigmodPos[i]=0); print (" virt ");  println (  VirtualPosition[i]); print (" Cirvirt "); print(  CircularVirtualPosition[i]); print (" CirOldvirt "); println (  CircularOldVirtualPosition[i]);
        } else  TrigmodPos[i]=1;
      } else {
        CircularOldVirtualPosition[i]=CircularVirtualPosition[i]%numberOfStep; 
        CircularVirtualPosition[i]= int (map (net.phase[i], 0, -TWO_PI, numberOfStep, 0));  
        Pos[i]= int (map (net.phase[i], 0, -TWO_PI, 127, 0))*-1;  // to Oscsend  

    if ((CircularVirtualPosition[i]%numberOfStep<3201 && CircularOldVirtualPosition[i]%numberOfStep>3200 )   ) {
       TrigmodPos[i]=0; print (i); print(" CIRCULAR PASS CLOCKWISE THROUG 0: ");  println (  TrigmodPos[i]=0); print (" virt ");  println (  VirtualPosition[i]); print (" Cirvirt "); print(  CircularVirtualPosition[i]); print (" CirOldvirt "); println (  CircularOldVirtualPosition[i]);
     // background ((i+1)*10, 127/5*(i+1), 50);
        } else  TrigmodPos[i]=1;
      } 
       



   //    dataMappedForMotorisedPosition[i]=CircularVirtualPosition[i];//+ActualVirtualPosition[i];
       lastPositionFromCircularMode[i]=dataMappedForMotorisedPosition[i];//+positionMotorisedFromContinuesMod[i];
     //  text ( " TrigmodPos " + i + TrigmodPos[i] , 400, 400+100*i);

      }

     }
  }

  // SWITCH MODE  *************************************TRIG and  MAP PENDULAR PHASE  for TEENSY and !ç (to manage sound)

  if (formerKeyMetro == '$') {
  //  actualisePositionDataFromCircular=true;
        // ActualVirtualPosition[i]=lastPositionFromCircularMode[i];

    for (int i = 0; i < networkSize; i++) {
        // ActualVirtualPosition[i]=lastPositionFromCircularMode[i];
  
      // VirtualPosition[i]= (int) map ( VirtualPosition[i], 1600, 4800, -800, 800); // mapped at the scale in Max 4 live
      PendularOldOldOldLeftVirtualPosition[i]=PendularOldOldLeftVirtualPosition[i];  
      PendularOldOldLeftVirtualPosition[i]=PendularOldLeftVirtualPosition[i];  
      PendularOldLeftVirtualPosition[i]=PendularLeftVirtualPosition[i];  
      modOldOldPos[i]=modOldPos[i]; 
      modOldPos[i]=modPos[i];    
      PendularOldVirtualPosition[i]=PendularVirtualPosition[i];

     //   metroPhase[i] %= TWO_PI;

     PendularVirtualPosition[i]= int (map (metroPhase[i], PI, TWO_PI, 0, numberOfStep/2)); // better : Metronome pass throug position 0


    //     PendularVirtualPosition[i]= int (map (metroPhase[i], -0.5*PI, 1.5*TWO_PI, 0, numberOfStep/2)); // movement with more amplitude?
    //
      Pos[i]= int (map (PendularVirtualPosition[i], -1600, 1600, 0, 127)); // to Oscsend 

      
    


    //  dataMappedForMotorisedPosition[i]=PendularVirtualPosition[i]+  lastPositionFromCircularMode[i];
      ActualVirtualPosition[i]=dataMappedForMotorisedPosition[i];
      ActualVirtualPosition[i]%= numberOfStep;

      float rate = map(dataMappedForMotorisedPosition[i], -800, 800, 0.80f, 1.20f);
      //  rate = 1; //rateSong
      rateControl.value.setLastValue(rate);

      //SET PRECISION OF MODULO
      // PendularLeftVirtualPosition[i]=int(1*(VirtualPosition[i])+800+1)/2%80;
      //**PendularLeftVirtualPosition[i]=VirtualPosition[i];
     //** VirtualPosition[i]= (int) map (PendularLeftVirtualPosition[i], 0, numberOfStep/2, -800, 800);
      PendularVirtualPosition[i] = (int) map ( PendularVirtualPosition[i], -4800, -1600, -800, 800); // mapped at the scale in Max 4 live // GOOD to trig 0 when balls are in the middle
     //PendularPositionoMapForMotor[i
   //    PendularVirtualPosition[i] = (int) map ( PendularVirtualPosition[i], -800, 800, 800, 1600); // mapped at the scale in Max 4 live // GOOD ? NO

     //  VirtualPosition[i]= PendularVirtualPosition[i]+ActualVirtualPosition[i]; 
      VirtualPosition[i]=PendularVirtualPosition[i];



      //   modPos[i]=int((1*(VirtualPosition[i])+800+0)/2)%80; // si 0 à 80
      modPos[i]=int((1*(VirtualPosition[i])+800+0)/2)%800; // si 0 à 800


      //    print (i); print(" PENDULAR ");print (modOldOldPos[i]);  print(" PENDULAR "); print (modOldPos[i]);print(" PENDULAR "); println (  modPos[i]);
      //print (" modOldOldPos "); print ( modOldOldPos[i]); print (" modOldPos "); print ( modOldPos[i]); print (" modPos "); println( modPos[i]); 
      if   ((modOldOldPos[i]>modOldPos[i] && modOldPos[i] >modPos[i] && modOldOldPos[i]>modOldPos[i]) ) {
        trigTest=true;
        //  print ("trigTest "); print (i);  println (trigTest);
      } else {
        trigTest=false;
        // print ("trigTest "); print (i);  println (trigTest);
      }

      if (  trigTest==false //((modOldOldPos[i]>modOldPos[i] && modOldPos[i] >modPos[i] && modOldOldPos[i]>modOldPos[i]))

        && ((PendularLeftVirtualPosition[i]<PendularOldLeftVirtualPosition[i] && modOldPos[i]>720  && modPos[i]>=700  && modOldPos[i]>=modPos[i]  &&  modOldOldPos[i]<=modPos[i] &&  modOldOldPos[i]>=680 &&  modOldOldPos[i]<=800)// && PendularLeftVirtualPosition[i]< PendularOldLeftVirtualPosition[i]  && PendularLeftVirtualPosition[i]<6
        || ( PendularLeftVirtualPosition[i]<PendularOldLeftVirtualPosition[i] && modOldPos[i]>720  && modPos[i]>=700  && modOldPos[i]>=modPos[i]  &&  modOldOldPos[i]>=modPos[i] &&  modOldOldPos[i]>=680 &&  modOldOldPos[i]<=800 )
        || ( PendularLeftVirtualPosition[i]<PendularOldLeftVirtualPosition[i] && modOldPos[i]>720  && modPos[i]<=modOldPos[i] &&  modOldOldPos[i]<=modPos[i] &&  modOldOldPos[i]>=500 &&  modOldOldPos[i]<=800)  // discrimination speed 8
        || ( PendularLeftVirtualPosition[i]<PendularOldLeftVirtualPosition[i] && modOldPos[i]>720  && modPos[i]<=modOldPos[i] &&  modOldOldPos[i]>=modPos[i] &&  modOldOldPos[i]>=600 &&  modOldOldPos[i]<=800)  // discrimination speed 8
        )) {

        println ("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"); 
        print ("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"); 
        print ("VirtualPosition: ") ; 
        print (i);  
        print (" =Pendularleft: ");  
        println  (PendularLeftVirtualPosition[i]);
        //   background (int ((i+1)*22), int ((i+1)*22),int ((i+1)*22) );

        print (i); 
        print(" OLDOLD PENDULAR ");
        print (modOldOldPos[i]);  
        print("OLD PENDULAR ");  
        print (modOldPos[i]);
        print(" Actual PENDULAR "); 
        println (  modPos[i]); 
        TrigmodPos[i]=0;
                            text (modOldPos[i] + "    " +  modPos[i] + "  VirtualPosition " + i +  VirtualPosition[i] , 400, 400+400*i);

      }
      
            if   ((modOldPos[i] <= 400 && modPos[i]>= 400) ||
            (modOldPos[i] >= 400 && modPos[i]<= 400)
            
            ) {
                //  background ((i+1)*10, 127/5*(i+1), 50);
       TrigmodPos[i]=0;
              //      text (modOldPos[i] + "    " +  modPos[i] + "  VirtualPosition " + i +  VirtualPosition[i] , 400, 400+400*i);

       }
       else { 
        TrigmodPos[i]=1;
      }
   //    text ( " TrigmodPos " + i + TrigmodPos[i] , 400, 400+100*i);
     }
    }



    for (int i = 0; i < networkSize; i++) {   
      print(" Pos "); 
      print (i); 
      print(" "); 
      print (Pos[i]);
    }
     println(" "); 
  

  if (formerKeyMetro == '$' && (formerSartKey == 'X' || formerSartKey == 'x' || formerSartKey == 'W' || formerSartKey == 'w')) {

    for (int i = 0; i < networkSize; i++) {
      // VirtualPosition[i]= (int) map ( VirtualPosition[i], 1600, 4800, -800, 800); // mapped at the scale in Max 4 live
      PendularOldOldOldLeftVirtualPosition[i]=PendularOldOldLeftVirtualPosition[i];  
      PendularOldOldLeftVirtualPosition[i]=PendularOldLeftVirtualPosition[i];  
      PendularOldLeftVirtualPosition[i]=PendularLeftVirtualPosition[i];  
      modOldOldPos[i]=modOldPos[i]; 
      modOldPos[i]=modPos[i];    
      PendularOldVirtualPosition[i]=PendularVirtualPosition[i];

      PendularVirtualPosition[i]= int (map (metroPhase[i], -HALF_PI, HALF_PI, -4800, -1600)); // better : Metronome pass throug position 0


      //   PendularVirtualPosition[i]= int (map (metroPhase[i], -0.5*PI, 1.5*TWO_PI, 0, numberOfStep/2)); // movement with more amplitude?
     // PendularVirtualPosition[i]= (int) map ( PendularVirtualPosition[i], -4800, -1600, -800, 800); // mapped at the scale in Max 4 live
      Pos[i]= int (map (PendularVirtualPosition[i], -800, 800, 0, 127)); // to Oscsend 

      VirtualPosition[i]= PendularVirtualPosition[i]+ActualVirtualPosition[i]; 
      //  dataMappedForMotorisedPosition[i]=VirtualPosition[i];
      dataMappedForMotorisedPosition[i]=PendularVirtualPosition[i];
      //  dataToLive[i]=  map(dataMappedForMotorisedPosition[i], 0, 6400, 0, 1);

      float rate = map(dataMappedForMotorisedPosition[i], -800, 800, 0.80f, 1.20f);
      //  rate = 1; //rateSong
      rateControl.value.setLastValue(rate);

      //SET PRECISION OF MODULO
      // PendularLeftVirtualPosition[i]=int(1*(VirtualPosition[i])+800+1)/2%80;
      PendularLeftVirtualPosition[i]=VirtualPosition[i];

      //   modPos[i]=int((1*(VirtualPosition[i])+800+0)/2)%80; // si 0 à 80
      modPos[i]=int((1*(VirtualPosition[i])+800+0)/2)%800; // si 0 à 800
      //    print (i); print(" PENDULAR ");print (modOldOldPos[i]);  print(" PENDULAR "); print (modOldPos[i]);print(" PENDULAR "); println (  modPos[i]);
      //print (" modOldOldPos "); print ( modOldOldPos[i]); print (" modOldPos "); print ( modOldPos[i]); print (" modPos "); println( modPos[i]); 
      if   ((modOldOldPos[i]>modOldPos[i] && modOldPos[i] >modPos[i] && modOldOldPos[i]>modOldPos[i]) ) {
        trigTest=true;
        //  print ("trigTest "); print (i);  println (trigTest);
      } else {
        trigTest=false;
        // print ("trigTest "); print (i);  println (trigTest);
      }

      if (  trigTest==false //((modOldOldPos[i]>modOldPos[i] && modOldPos[i] >modPos[i] && modOldOldPos[i]>modOldPos[i]))

        && ((PendularLeftVirtualPosition[i]<PendularOldLeftVirtualPosition[i] && modOldPos[i]>720  && modPos[i]>=700  && modOldPos[i]>=modPos[i]  &&  modOldOldPos[i]<=modPos[i] &&  modOldOldPos[i]>=680 &&  modOldOldPos[i]<=800)// && PendularLeftVirtualPosition[i]< PendularOldLeftVirtualPosition[i]  && PendularLeftVirtualPosition[i]<6
        || ( PendularLeftVirtualPosition[i]<PendularOldLeftVirtualPosition[i] && modOldPos[i]>720  && modPos[i]>=700  && modOldPos[i]>=modPos[i]  &&  modOldOldPos[i]>=modPos[i] &&  modOldOldPos[i]>=680 &&  modOldOldPos[i]<=800 )
        || ( PendularLeftVirtualPosition[i]<PendularOldLeftVirtualPosition[i] && modOldPos[i]>720  && modPos[i]<=modOldPos[i] &&  modOldOldPos[i]<=modPos[i] &&  modOldOldPos[i]>=500 &&  modOldOldPos[i]<=800)  // discrimination speed 8
        || ( PendularLeftVirtualPosition[i]<PendularOldLeftVirtualPosition[i] && modOldPos[i]>720  && modPos[i]<=modOldPos[i] &&  modOldOldPos[i]>=modPos[i] &&  modOldOldPos[i]>=600 &&  modOldOldPos[i]<=800)  // discrimination speed 8
        )) {


        println ("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"); 
        print ("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"); 
        print ("VirtualPosition: ") ; 
        print (i);  
        print (" =Pendularleft: ");  
        println  (PendularLeftVirtualPosition[i]);
        //   background (int ((i+1)*22), int ((i+1)*22),int ((i+1)*22) );

        print (i); 
        print(" OLDOLD PENDULAR ");
        print (modOldOldPos[i]);  
        print("OLD PENDULAR ");  
        print (modOldPos[i]);
        print(" Actual PENDULAR "); 
        println (  modPos[i]); 
        TrigmodPos[i]=0;
      } else { 
        TrigmodPos[i]=1;
      }
    }
  }
  
    //*********** COMPUTE ACCELERATION
  
           if (  keyMode == " null " || keyMode != " null "  ) {  // keyMode == " addSignalOneAndTwo "
     for (int i = 0; i < networkSize; i++) {  
       //     net.phase[i] = newPosF[i];  // to compute acceelration
      //**     net.phase[i] = newPosXaddSignal[i];
      oldPhaseAcceleration[i] = phaseAcceleration[i];
      phaseAcceleration[i] = net.phase[i];
   
        oldVelocityBis[i] = velocityBis[i];
     //**   velocityBis[i] = (net.phase[i] - net.oldPhase[i]) / 1;
        velocityBis[i] = (phaseAcceleration[i] - oldPhaseAcceleration[i]) / 1;

        accelerationBis[i] = (velocityBis[i] - oldVelocityBis[i]) / 1;
        
        mapAcceleration[i]= constrain ((int (map (abs(accelerationBis[i] *100), -100, 100, 0, 127))), 0, 127);    
       }
        rotate (HALF_PI);
        text ( "vel[0] " + velocityBis[0] , -700, 1500 );
        text ( "Acc[0]" + mapAcceleration[0], -700, 1600 );
        rotate (-HALF_PI);
      }  
      
     //*********** END COMPUTE ACCELERATION 
  

 // countRevs();  
 // bpmAsPulsationFunction();
    printMidiNoteVelocity();
  //SUBZERO


  if (key=='l') {
    formerSartKey='l'; //trig  automatiseWithNote();
    formerKeyL();
  }
  if (key=='L') { //
    formerSartKey='L'; // trig setbpm automatically to 108
  }  

  if (formerSartKey=='l') {// || formerSartKey=='!'

  }

  String ACCELERATION = mapAcceleration[5]+","
    +mapAcceleration[4]+","+ mapAcceleration[3]+","+mapAcceleration[2]+","+ mapAcceleration[1]+","+mapAcceleration[0]+","; // mapAcceleration[9]+","+ mapAcceleration[8]+","+mapAcceleration[7]+","+ mapAcceleration[6]+","+

 // String SPEED = speedi[5]+","+speedi[4]+","+speedi[3]+","+speedi[2]+","+speedi[1]+","+speedi[0]+","; // speedi[11]+","+speedi[10]+","+speedi[9]+","+ speedi[8]+","+speedi[7]+","+ speedi[6]+","+
  // DECOMPTE: You trig a 0 when oscillator reach to the position 0, and then you have an incrementation at each frame.

  if (rev[networkSize-1]%8==0 && decompte[networkSize-1]==0 ) {// send a trig to change scene in Ableton live (if oscillator 11 makes 8 round an djust when it pass trought its position 0 -->trig next scene in Live)
    nextScene= 1;//
    println ("nextScenenextScenenextScenenextScenenextScene");
    println ("nextScenenextScenenextScenenextScenenextScene");
    println (nextScene);
  } else {
    nextScene= 0;
  }     
 

  
  //24 data Jo solution

  // OSCsend  

  /*
    if (dataToLive[10]*10>5){
   dataToLive[10]=1;
   } 
   else  if (dataToLive[10]*10<=5){
   dataToLive[10]=0;
   }
   */
 // oscSend();
 
//  printDataOnScreen();

 


  if (keyMode == " phasePattern ") {
     for (int i = 0; i < networkSize-0; i++) {
  //    dataMappedForMotorisedPosition[i]= (int) map  (netPhaseBase[i], 0, TWO_PI, 0, numberOfStep);
   //   dataMappedForMotorisedPosition[i]= dataMappedForMotorisedPosition[i]+ ActualVirtualPosition[i];
    } 
  // send24DatasToTeensy6motorsToLittleMachine(8, -3, 3,-1);
   }

  if (rev[networkSize-1]%8==0 && decompte[networkSize-1]>=-0 && decompte[networkSize-1]<1) {// send a trig to change scene in Ableton live (if oscillator 11 makes 8 round an djust when it pass trought its position 0 -->trig next scene in Live)
    nextScene= 1;//
    println ("nextScenenextScenenextScenenextScenenextScene");
    println ("nextScenenextScenenextScenenextScenenextScene");
    println (nextScene);
  } else {
    nextScene= 0;
  }     
  //*******************

 
   
 
} 
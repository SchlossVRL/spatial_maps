/**
 * jspsych-image-keyboard-response MAS-colormaps"
 * Josh de Leeuw
 *
 * plugin for displaying a stimulus and getting a keyboard response
 *
 * documentation: docs.jspsych.org
 *
 **/


jsPsych.plugins["image-keyboard-responseMAS-colormaps"] = (function() {

  var plugin = {};

  jsPsych.pluginAPI.registerPreload('image-keyboard-response', 'stimulus', 'image');

  plugin.info = {
    name: 'image-keyboard-response',
    description: '',
    parameters: {
      bg: {
        type: jsPsych.plugins.parameterType.int,
        pretty_name: 'Stimulus',
        default: 0, // if you dont give it anything it gives a white bg
        description: 'The image to be displayed'
      },
      stimulusLeft: {
        type: jsPsych.plugins.parameterType.IMAGE,
        pretty_name: 'Stimulus',
        default: undefined,
        description: 'The image to be displayed'
      },
      stimulusRight: {
        type: jsPsych.plugins.parameterType.IMAGE,
        pretty_name: 'Stimulus',
        default: undefined,
        description: 'The image to be displayed'
      },
      stimulusRightLabel: {
        type: jsPsych.plugins.parameterType.IMAGE,
        pretty_name: 'Stimulus-numbers',
        default: undefined,
        description: 'The image to be displayed'
      },
      stimulusFeedLeft: {
        type: jsPsych.plugins.parameterType.IMAGE,
        pretty_name: 'StimulusFeed',
        default: null,
        description: 'Border feedback'
      },
      /*
      stimulusFeedRight: {
        type: jsPsych.plugins.parameterType.IMAGE,
        pretty_name: 'StimulusFeed',
        default: null,
        description: 'Border feedback'
      },*/
      stimulus_height: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'Image height',
        default: null,
        description: 'Set the image height in pixels'
      },
      stimulus_width: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'Image width',
        default: null,
        description: 'Set the image width in pixels'
      },
      maintain_aspect_ratio: {
        type: jsPsych.plugins.parameterType.BOOL,
        pretty_name: 'Maintain aspect ratio',
        default: true,
        description: 'Maintain the aspect ratio after setting width or height'
      },
      choices: {
        type: jsPsych.plugins.parameterType.KEYCODE,
        array: true,
        pretty_name: 'Choices',
        default: jsPsych.ALL_KEYS,
        description: 'The keys the subject is allowed to press to respond to the stimulus.'
      },
      prompt: {
        type: jsPsych.plugins.parameterType.STRING,
        pretty_name: 'Prompt',
        default: null,
        description: 'Any content here will be displayed below the stimulus.'
      },
      legendText: {
        type: jsPsych.plugins.parameterType.STRING,
        pretty_name: 'legend Text',
        default: null,
        description: 'Labels for above & below legend.'
      },
      stimulus_duration: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'Stimulus duration',
        default: null,
        description: 'How long to hide the stimulus.'
      },
      trial_duration: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'Trial duration',
        default: null,
        description: 'How long to show trial before it ends.'
      },
      response_ends_trial: {
        type: jsPsych.plugins.parameterType.BOOL,
        pretty_name: 'Response ends trial',
        default: true,
        description: 'If true, trial will end when subject makes a response.'
      },
      trial_type: {
        type: jsPsych.plugins.parameterType.SELECT,
        pretty_name: 'Part of trial',
        options: ['Present','Feedback'],
        default: 'Present',
        description: 'Which set of features to display.'
      },
      trial_set: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'Type of trial',
        default: 'null',
        description: 'Which trials are being displayed (redundant, generalization, mismatch).'
      },
      target_side: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'Side target is on',
        default: 'null',
        description: 'Left (0) or right (1) side the target is on.'
      },
      response_sideSelected: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'sideSelected',
        default: 0,
        description: 'Left vs. right (0 vs. 1) color selected during comparison trial'
      },
      colorScale: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'colorscale',
        default: 'null',
        description: 'ColorBrewerBlue (0) or hot (1)'
      },
      darkSide: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'darkSide',
        default: 'null',
        description: 'target side (dark on left-0 or right-1)'
      },
      darkLegendOrient: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'darkLegendOrient',
        default: 'null',
        description: 'legend orientation (dark low-0 vs dark high-0)'
      },
      colormap: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'colormap',
        default: 'null',
        description: 'specific colormap (0-19)'
      },
      targetOrient: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: ' targetOrient',
        default: 'null',
        description: '  targetOrient (target high-0 vs. target low - 1)'
      },
      conditionSet:{
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'conditionSet',
        default: 'null',
        description: ' faster or longer target'
      },
      question_order:{
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'instruction trials vs experiment trials',
        default: 'null',
        description: ' instr vs exp.'
      }
    }
  }

  plugin.trial = function(display_element, trial) {

  var html = "";

  // add prompt
  // seems melissa deleted the below earlier
  if (trial.prompt !== null){
    html += '<span style="font-size: 120%;">'+trial.prompt+'</span>'
  }

  html += '<br></br>'; 

  html += '<div class = "parent">' 

  if(trial.bg == "white"){  
    html += '<div class = "backgroundBox";  style="width:550px;height:550px; position:absolute;background-color: rgb(255,255,255);"></div>'
  }else if(trial.bg == "black"){
    html += '<div class = "backgroundBox";  style="width:550px;height:550px;  position:absolute;background-color: rgb(0, 0, 0);"></div>'
  }else if(trial.bg == "red"){
    html += '<div class = "backgroundBox";  style="width:550px;height:550px;  position:absolute;background-color: rgb(255, 0, 0);"></div>'
  }else if(trial.bg == "yellow"){
    html += '<div class = "backgroundBox";  style="width:550px;height:550px;  position:absolute;background-color: rgb(255, 255, 0);"></div>'
  }else if(trial.bg == "light gray"){
    html += '<div class = "backgroundBox";  style="width:550px;height:550px;  position:absolute;background-color: rgb(246, 246, 246);"></div>'
  }else if(trial.bg == "dark gray"){
    html += '<div class = "backgroundBox";  style="width:550px;height:550px;  position:absolute;background-color: rgb(126, 126, 126);"></div>'
  }
  
  
    
/* 
    //Label for bottom of legend
    if (trial.conditionSet == 0 &  trial.targetOrient == 1){ 
      html += '<span class = "image2RLabelBelow",  style= "left:404px; font-size: 80%;">'+trial.legendText[1]+'</span>'
   }else {
    html += '<span class = "image2RLabelBelow",  style="font-size: 80%;">'+trial.legendText[1]+'</span>'
   }

    //Feedback text "WRONG"
    html += '<span class = "image3RFeedback",  style="font-size: 130%;">'+trial.prompt+'</span>'
*/
       // numbers for colorscale

       // stimulus Middle display
    html += '<img src="'+trial.stimulusRightLabel+'" class="image2RLabelSide" id="jspsych-image-keyboard-response-stimulus" style="position:relative"';
    
    html += '<br></br>'; 

    // display left stimulus
       // html += '<img src="'+trial.stimulusLeft+'" id="jspsych-image-keyboard-response-stimulus" style="height:100px;width: auto;left: -30px;position:  relative;  border:  "';
       html += '<img src="'+trial.stimulusLeft+'" class="image2L" id="jspsych-image-keyboard-response-stimulus"';

       // i think this determines stimulus dimensions
       if(trial.stimulus_height !== null){
          html += 'height:'+trial.stimulus_height+'px; '
          if(trial.stimulus_width == null && trial.maintain_aspect_ratio){
            html += 'width: auto; ';
          }
        }
        if(trial.stimulus_width !== null){
          html += 'width:'+trial.stimulus_width+'px; '
          if(trial.stimulus_height == null && trial.maintain_aspect_ratio){
            html += 'height: auto; ';
          }
        }
        html +='"></img>'; 
  

      //Horizontal lines under colormap
   //   html += '<hr class="horizon"/>' ;
     // html += '<hr class="horizon", style = "left: 250px"/>' ;

        //Label for bottom of legend
     // html += '<span class = "image2LLabelBelow",  style="font-size: 80%;"> Left Side </span>'
     // html += '<span class = "image2LLabelBelow",  style="font-size: 80%; left: 260px"> Right Side </span>'

    
    

    // display right stimulus-----------------------------------
   /*
      //top label - shift over label for word faster
     if (trial.conditionSet == 0 &  trial.targetOrient == 0){ 
        html += '<span class = "image2RLabelAbove",  style= "left:403px; font-size: 80%;">'+trial.legendText[0]+'</span>'
     }else {
        html += '<span class = "image2RLabelAbove",  style="font-size: 80%;">'+trial.legendText[0]+'</span>'
     }
    */
    // Color scale
    html += '<img src="'+trial.stimulusRight+'" class="image2R" id="jspsych-image-keyboard-response-stimulus"';
    //style = "border: 1px solid black" ';
      if(trial.stimulus_height !== null){
        html += 'height:'+trial.stimulus_height+'px; '
        if(trial.stimulus_width == null && trial.maintain_aspect_ratio){
          html += 'width: auto; ';
        }
      }
      if(trial.stimulus_width !== null){
        html += 'width:'+trial.stimulus_width+'px; '
        if(trial.stimulus_height == null && trial.maintain_aspect_ratio){
          html += 'height: auto; ';
        }
      }
      html +='"></img>';

    
 
    // end right stimulus -------------------------------
    //heres where RightLabel used to be
 


  
    html+='</div>'; 

    // render
    display_element.innerHTML = html;

    // store response
    var response = {
      rt: null,
      key: null
    };

    // function to end trial when it is time
    var end_trial = function() {

      // kill any remaining setTimeout handlers
      jsPsych.pluginAPI.clearAllTimeouts();

      // kill keyboard listeners
      if (typeof keyboardListener !== 'undefined') {
        jsPsych.pluginAPI.cancelKeyboardResponse(keyboardListener);
      }

      // gather the data to store for the trial
      var trial_data = {
        "rt": response.rt,
        "stimulus": trial.stimulusRightLabel,
        "stimLeft": trial.stimulusLeft,
        "stimRight": trial.stimulusRight,
        "key_press": response.key,
        "prompt": trial.prompt,
        "targetSide": trial.target_side,
        "colorScale" : trial.colorScale,
        "darkSide": trial.darkSide,
        "darkLegendOrient":trial.darkLegendOrient,  
        "colormap": trial.colormap,
        "targetOrient": trial.targetOrient,
        "question_order": trial.question_order
      };

      // clear the display
      display_element.innerHTML = '';

      // move on to the next trial
      jsPsych.finishTrial(trial_data);
    };

    // function to handle responses by the subject
    var after_response = function(info) {

      // after a valid response, the stimulus will have the CSS class 'responded'
      // which can be used to provide visual feedback that a response was recorded
      display_element.querySelector('#jspsych-image-keyboard-response-stimulus').className += ' responded';

      // only record the first response
      if (response.key == null) {
        response = info;
      }

      if (trial.response_ends_trial) {
        end_trial();
      }
    };

    // start the response listener
    if (trial.choices != jsPsych.NO_KEYS) {
      var keyboardListener = jsPsych.pluginAPI.getKeyboardResponse({
        callback_function: after_response,
        valid_responses: trial.choices,
        rt_method: 'performance',
        persist: false,
        allow_held_key: false
      });
    }

    // hide stimulus if stimulus_duration is set
    if (trial.stimulus_duration !== null) {
      jsPsych.pluginAPI.setTimeout(function() {
        display_element.querySelector('#jspsych-image-keyboard-response-stimulus').style.visibility = 'hidden';
      }, trial.stimulus_duration);
    }

    // end trial if trial_duration is set
    if (trial.trial_duration !== null) {
      jsPsych.pluginAPI.setTimeout(function() {
        end_trial();
      }, trial.trial_duration);
    }

  };

  return plugin;
})();

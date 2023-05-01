
function cm = mako(n, varargin)
% Colormap: mako

%-- Parse inputs ---------------------------------------------------------%
if ~exist('n', 'var'); n = []; end
if isempty(n)
   f = get(groot,'CurrentFigure');
   if isempty(f)
      n = size(get(groot,'DefaultFigureColormap'),1);
   else
      n = size(f.Colormap,1);
   end
end
%-------------------------------------------------------------------------%

% Data for colormap:
cm = [
	0.145098000	0.090196000	0.164706000
	0.160784000	0.101961000	0.192157000
	0.176471000	0.113725000	0.219608000
	0.184314000	0.121569000	0.243137000
	0.196078000	0.133333000	0.270588000
	0.207843000	0.149020000	0.301961000
	0.219608000	0.164706000	0.329412000
	0.227451000	0.176471000	0.360784000
	0.235294000	0.192157000	0.388235000
	0.243137000	0.203922000	0.419608000
	0.247059000	0.223529000	0.454902000
	0.250980000	0.231373000	0.482353000
	0.250980000	0.250980000	0.505882000
	0.250980000	0.270588000	0.537255000
	0.247059000	0.282353000	0.556863000
	0.243137000	0.305882000	0.576471000
	0.235294000	0.325490000	0.592157000
	0.227451000	0.345098000	0.600000000
	0.223529000	0.368627000	0.607843000
	0.215686000	0.384314000	0.615686000
	0.211765000	0.403922000	0.619608000
	0.207843000	0.423529000	0.623529000
	0.207843000	0.443137000	0.627451000
	0.207843000	0.462745000	0.631373000
	0.203922000	0.478431000	0.635294000
	0.203922000	0.501961000	0.639216000
	0.203922000	0.517647000	0.647059000
	0.200000000	0.537255000	0.650980000
	0.200000000	0.552941000	0.654902000
	0.200000000	0.572549000	0.658824000
	0.203922000	0.592157000	0.662745000
	0.203922000	0.615686000	0.666667000
	0.207843000	0.627451000	0.666667000
	0.211765000	0.650980000	0.670588000
	0.219608000	0.666667000	0.674510000
	0.231373000	0.686275000	0.674510000
	0.243137000	0.705882000	0.674510000
	0.254902000	0.729412000	0.678431000
	0.270588000	0.741176000	0.678431000
	0.290196000	0.764706000	0.678431000
	0.317647000	0.780392000	0.674510000
	0.352941000	0.796078000	0.674510000
	0.388235000	0.811765000	0.674510000
	0.439216000	0.831373000	0.678431000
	0.486275000	0.843137000	0.682353000
	0.537255000	0.850980000	0.698039000
	0.584314000	0.858824000	0.705882000
	0.631373000	0.874510000	0.725490000
	0.670588000	0.886275000	0.745098000
	0.709804000	0.898039000	0.772549000
	0.749020000	0.909804000	0.796078000
	0.784314000	0.921569000	0.823529000
	0.815686000	0.933333000	0.850980000
	0.854902000	0.949020000	0.882353000
];

b = [0 0 0];

%cm_short = cm(40:54,:); % take values from 30 through 256 in cm
%size(cm_short)

cm_lab = rgb2lab(cm);  % translate from rgb space to Lab

%% identify light and dark color info (LAB values)
% this is the light color we want to go to (white)
lightColor1 = [100 0 0]; 

%this is the lightest color in magma
% take the last line of the color scale, which should be the lightest color
    % if we want the first value, which would be the darkest, we can probably
    % use color_scale(1,:)
darkColor1 = cm_lab(end,:); 
steps = 10; % specify how many steps to interpolate, including lightColor and darkColor

% linspace just linearly interpolates between two values
% here i'm using it 3 times
L_light = linspace(darkColor1(1), lightColor1(1), steps);  %// Red from 1 to 0
A_light = linspace(darkColor1(2), lightColor1(2), steps); %// Green all zero
B_light = linspace(darkColor1(3), lightColor1(3), steps);  %// Blue from 0 to 1

lab_map_light = [L_light;A_light;B_light]'; 

rgb_map_light = lab2rgb(lab_map_light);
%size(rgb_map_light)

% find values larger than 1 and force them to be 1 >:)
ind1 = find(rgb_map_light > 1);
rgb_map_light(ind1) = 1;


%% append dark side
% same as light side, but this time we are adding steps to the dark side
lightColor2 = cm_lab(1,:);
darkColor2 = [0 0 0]; 
steps_dark = 10;

L_dark = linspace(darkColor2(1), lightColor2(1), steps_dark);  %// Red from 1 to 0
A_dark = linspace(darkColor2(2), lightColor2(2), steps_dark); %// Green all zero
B_dark = linspace(darkColor2(3), lightColor2(3), steps_dark);  %// Blue from 0 to 1

lab_map_dark = [L_dark;A_dark;B_dark]'; 
%size(lab_map_dark)

rgb_map_dark = lab2rgb(lab_map_dark);

% find values larger than 1 and force them to be 1 >:)
ind2 = find(rgb_map_dark < 0);
rgb_map_dark(ind2) = 0;

%% put it all together
cm_bw = [rgb_map_dark;cm;rgb_map_light];
%size(cm_bw)

% Modify the colormap by interpolation to match number of waypoints.
cm = tools.interpolate(cm_bw, n, varargin{:});

end

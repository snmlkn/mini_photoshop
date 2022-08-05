classdef homeWork2_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure        matlab.ui.Figure
        RGBButton       matlab.ui.control.Button
        HSVButton       matlab.ui.control.Button
        DNDR90Button    matlab.ui.control.Button
        DNDR180Button   matlab.ui.control.Button
        DNDR270Button   matlab.ui.control.Button
        YANSITButton    matlab.ui.control.Button
        NEGATFButton    matlab.ui.control.Button
        LOGARTMAButton  matlab.ui.control.Button
        KUVVETButton    matlab.ui.control.Button
        UIAxes          matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: RGBButton
        function RGBButtonPushed(app, event)
        cla(app.UIAxes);
        close all;
            global a;
            [filename, pathname] = uigetfile('*.*', 'Pick an Image');
            filename=strcat(pathname,filename);
            a=imread(filename);
            imshow(a,'Parent',app.UIAxes);   
         % Show image in legacy figure and turn on datacursor
            fig = figure(); 
            ax = axes(fig); 
            image(ax,a); 
            ax.Colormap = jet(100); 
            dcm = datacursormode(fig); 
            dcm.Enable = 'on'; 
            title(ax, 'RGB and pixel information')
   
            
        end

        % Button pushed function: HSVButton
        function HSVButtonPushed(app, event)
             %cla(app.UIAxes);
            close all;
            global a;
            global HSV;
            [filename, pathname] = uigetfile('*.*', 'Pick an Image');
            filename=strcat(pathname,filename);
            a=imread(filename);
            HSV = rgb2hsv(a);
            imshow(HSV,'Parent',app.UIAxes); 
            
             % Show image in legacy figure and turn on datacursor
            fig = figure(); 
            ax = axes(fig); 
            image(ax,HSV); 
            ax.Colormap = jet(100); 
            dcm = datacursormode(fig); 
            dcm.Enable = 'on'; 
            title(ax, 'HSV and pixel information')
            
        end

        % Button pushed function: DNDR90Button
        function DNDR90ButtonPushed(app, event)
            close all;
            global I;
            [filename, pathname] = uigetfile('*.*', 'Pick an Image');
            filename=strcat(pathname,filename);
            I=imread(filename);
            imshow(I,'Parent',app.UIAxes); 
            
           %figure, imshow(uint8(I));

% Initilase an image
I2 = [];

%iterate each layer
for k = 1:3
	Im = I(:, :, k);

	%Flip every layer up to down.
	Im1 = Im(end:-1:1, :);

	%Flip every layer right to left.
	Im2 = Im1(:, end:-1:1);

	%Take transpose of the image.
	Im3 = Im2';
	I2(:, :, k)=Im3;
end

% Show the image.
figure, imshow(uint8(I2));
            title('90 derece');
        end

        % Button pushed function: DNDR180Button
        function DNDR180ButtonPushed(app, event)
            close all;
            global a;
            [filename, pathname] = uigetfile('*.*', 'Pick an Image');
            filename=strcat(pathname,filename);
            a=imread(filename);
            imshow(a,'Parent',app.UIAxes); 
% Read the target image file

% Get the dimensions of the image
[x, y, z] = size(a);


% Reverse elements of each column
% in each image plane (dimension)
for plane = 1 : z
	len = x;
	for i = 1 : x
		for j = 1 : y

			% To reverse the order of the element
			% of a column we can swap the
			% topmost element of the row with
			% its bottom-most element
			
			if i < x/2
				temp =a(i, j, plane);
				a(i, j, plane) = a(len, j, plane);
				a(len, j, plane) = temp;
				
			end
		end
		len = len - 1;
	end
end


% Display the vertically flipped image
imshow(a);
title('Vertically flipped image');

            
            
            
        end

        % Button pushed function: YANSITButton
        function YANSITButtonPushed(app, event)
            cla(app.UIAxes); 
            global a;
            close all;
            [filename, pathname] = uigetfile('*.*', 'Pick an Image');
            filename=strcat(pathname,filename);
           a=imread(filename);
            imshow(a,'Parent',app.UIAxes); 
% Read the target image file

% Get the dimensions of the image
[x, y, z] =size(a);


% Reverse elements of each row
% in every image plane
for plane = 1: z
	for i = 1 : x
		len = y;
		for j = 1 : y

			% To reverse the order of the element
			% of a row we can swap the
			% leftmost element of the row with
			% its rightmost element
	
			if j < y/2
				temp = a(i, j, plane);
				a(i, j, plane) = a(i, len, plane);
				a(i, len, plane) = temp;
				len = len - 1;
			end
		end
	end
end


% Display the mirror image
imshow(a);
title('Mirror image');

        end

        % Button pushed function: NEGATFButton
        function NEGATFButtonPushed(app, event)
          cla(app.UIAxes); 
            global a;
            close all;
            [filename, pathname] = uigetfile('*.*', 'Pick an Image');
            filename=strcat(pathname,filename);
           a=imread(filename);
            imshow(a,'Parent',app.UIAxes); 
            
            L=2^8;
            neg =(L-1)-a;
            imshow(neg);
            title("Negative Image")
            
        end

        % Button pushed function: DNDR270Button
        function DNDR270ButtonPushed(app, event)
            close all;
            global a;
            [filename, pathname] = uigetfile('*.*', 'Pick an Image');
            filename=strcat(pathname,filename);
            a=imread(filename);
            imshow(a,'Parent',app.UIAxes); 
            
            R=rot90(a(:,:,1),3);
            G=rot90(a(:,:,2),3);
            B=rot90(a(:,:,3),3);

            C(:,:,1)=rot90(a(:,:,1),3);
            C(:,:,2)=rot90(a(:,:,2),3);
            C(:,:,3)=rot90(a(:,:,3),3);

            
            image(C);
            title('270 derece');
            
            
            
            
            
            
        end

        % Button pushed function: LOGARTMAButton
        function LOGARTMAButtonPushed(app, event)
            
            
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.902 0.902 0.902];
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create RGBButton
            app.RGBButton = uibutton(app.UIFigure, 'push');
            app.RGBButton.ButtonPushedFcn = createCallbackFcn(app, @RGBButtonPushed, true);
            app.RGBButton.BackgroundColor = [0.9412 0.9412 0.9412];
            app.RGBButton.Position = [24 88 100 22];
            app.RGBButton.Text = 'RGB';

            % Create HSVButton
            app.HSVButton = uibutton(app.UIFigure, 'push');
            app.HSVButton.ButtonPushedFcn = createCallbackFcn(app, @HSVButtonPushed, true);
            app.HSVButton.Position = [24 124 100 22];
            app.HSVButton.Text = 'HSV';

            % Create DNDR90Button
            app.DNDR90Button = uibutton(app.UIFigure, 'push');
            app.DNDR90Button.ButtonPushedFcn = createCallbackFcn(app, @DNDR90ButtonPushed, true);
            app.DNDR90Button.Position = [24 158 100 22];
            app.DNDR90Button.Text = 'DÖNDÜR(90)';

            % Create DNDR180Button
            app.DNDR180Button = uibutton(app.UIFigure, 'push');
            app.DNDR180Button.ButtonPushedFcn = createCallbackFcn(app, @DNDR180ButtonPushed, true);
            app.DNDR180Button.Position = [24 194 100 22];
            app.DNDR180Button.Text = 'DÖNDÜR(180)';

            % Create DNDR270Button
            app.DNDR270Button = uibutton(app.UIFigure, 'push');
            app.DNDR270Button.ButtonPushedFcn = createCallbackFcn(app, @DNDR270ButtonPushed, true);
            app.DNDR270Button.Position = [24 230 100 22];
            app.DNDR270Button.Text = 'DÖNDÜR(270)';

            % Create YANSITButton
            app.YANSITButton = uibutton(app.UIFigure, 'push');
            app.YANSITButton.ButtonPushedFcn = createCallbackFcn(app, @YANSITButtonPushed, true);
            app.YANSITButton.Position = [24 270 100 22];
            app.YANSITButton.Text = 'YANSIT';

            % Create NEGATFButton
            app.NEGATFButton = uibutton(app.UIFigure, 'push');
            app.NEGATFButton.ButtonPushedFcn = createCallbackFcn(app, @NEGATFButtonPushed, true);
            app.NEGATFButton.Position = [24 305 100 22];
            app.NEGATFButton.Text = 'NEGATİF';

            % Create LOGARTMAButton
            app.LOGARTMAButton = uibutton(app.UIFigure, 'push');
            app.LOGARTMAButton.ButtonPushedFcn = createCallbackFcn(app, @LOGARTMAButtonPushed, true);
            app.LOGARTMAButton.Position = [24 344 100 22];
            app.LOGARTMAButton.Text = 'LOGARİTMA';

            % Create KUVVETButton
            app.KUVVETButton = uibutton(app.UIFigure, 'push');
            app.KUVVETButton.Position = [24 386 100 22];
            app.KUVVETButton.Text = 'KUVVET';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Seçilen Resim')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [145 17 496 391];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = homeWork2_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
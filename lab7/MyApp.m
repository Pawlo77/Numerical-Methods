classdef MyApp < matlab.apps.AppBase
    properties (Access = public)
        UIFigure                  matlab.ui.Figure

        ChooseFuncBtn    matlab.ui.container.ButtonGroup
        SinBtn               matlab.ui.control.RadioButton
        CosBtn                matlab.ui.control.RadioButton

        RangeSlider       matlab.ui.control.RangeSlider
        RangeSliderLabel  matlab.ui.control.Label

        UITable                   matlab.ui.control.Table
        UIAxesFunction                    matlab.ui.control.UIAxes
        UIAxesFunctionDerevative                   matlab.ui.control.UIAxes
        UIAxesFunctionAproximateDerevative                   matlab.ui.control.UIAxes

        PointsNumSliderLabel  matlab.ui.control.Label
        PointsNumSlider  matlab.ui.control.Slider
    end

    properties (Access = private)
        MyFunction
        MyFunctionDerevative
        MyFunctionApproximateDerevative
    end

    methods (Access = private)
        function [out] = pochodnaP(app, x, h)
            out = (app.MyFunction(x+h) - app.MyFunction(x-h)) / (2*h);
        end

        function getMyFunction(app)
            selectedButton = app.ChooseFuncBtn.SelectedObject;

            if (selectedButton == app.SinBtn)
                app.MyFunction = @(x) sin(x);
                app.MyFunctionDerevative = @(x) cos(x);
            else 
                app.MyFunction = @(x) cos(x);
                app.MyFunctionDerevative = @(x) -sin(x);
            end
            
            app.MyFunctionApproximateDerevative = @(x) pochodnaP(app, x, 2 ^ -app.PointsNumSlider.Value);
        end

        function chooseFuncBtnSelectionChanged(app, event)
            getMyFunction(app);
            updatePlot(app);
        end

        function loadChanges(app, event)
            MyFunctionApproximateDerevative = @(x) pochodnaP(app, x, 2 ^ -app.PointsNumSlider.Value);
            updatePlot(app);
        end

        function updatePlot(app)
            xrange = app.RangeSlider.Value;
            x = linspace(xrange(1), xrange(2), 1000);
            y = app.MyFunction(x);
            
            dx = app.MyFunctionDerevative(x);
            approx = app.MyFunctionApproximateDerevative(x);

            plot(app.UIAxesFunction, x, y);
            plot(app.UIAxesFunctionDerevative, x, dx);
            plot(app.UIAxesFunctionAproximateDerevative, x, approx);

            data = [xrange(1), xrange(2), 2 ^ -app.PointsNumSlider.Value];
            app.UITable.Data = data;
        end

        function update(app, event)
            updatePlot(app)
        end
    end

    % Component initialization
    methods (Access = private)
        function createComponents(app)
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 700 600];
            app.UIFigure.Name = 'MyApp';

            app.ChooseFuncBtn = uibuttongroup(app.UIFigure);
            app.ChooseFuncBtn.SelectionChangedFcn = createCallbackFcn(app, @chooseFuncBtnSelectionChanged, true);
            app.ChooseFuncBtn.Title = 'Select Function:';
            app.ChooseFuncBtn.Position = [10 150 80 68];

            app.SinBtn = uiradiobutton(app.ChooseFuncBtn);
            app.SinBtn.Text = 'sin(x)';
            app.SinBtn.Position = [8 58 58 22];
            app.SinBtn.Value = true;
            app.CosBtn = uiradiobutton(app.ChooseFuncBtn);
            app.CosBtn.Text = 'cos(x)';
            app.CosBtn.Position = [12 31 60 60];

            app.RangeSliderLabel = uilabel(app.UIFigure);
            app.RangeSliderLabel.HorizontalAlignment = 'center';
            app.RangeSliderLabel.Position = [139 393 89 22];
            app.RangeSliderLabel.Text = 'Plot Range';
            app.RangeSlider = uislider(app.UIFigure, 'range');
            % app.RangeSlider.Limits = [- 2 * pi, 2 * pi];
            app.RangeSlider.Position = [250 200 600 3];
            app.RangeSlider.ValueChangedFcn = createCallbackFcn(app, @update, true);

            app.PointsNumSliderLabel = uilabel(app.UIFigure);
            app.PointsNumSliderLabel.HorizontalAlignment = 'center';
            app.PointsNumSliderLabel.Position = [141 158 116 30];
            app.PointsNumSliderLabel.Text = {'Derivative Accuracy'; '2^-n'};
            app.PointsNumSlider = uislider(app.UIFigure);
            app.PointsNumSlider.Limits = [0, 10];
            app.PointsNumSlider.Position = [278 182 467 3];
            app.PointsNumSlider.ValueChangedFcn = createCallbackFcn(app, @loadChanges, true);

            app.UIAxesFunction = uiaxes(app.UIFigure);
            title(app.UIAxesFunction, 'Function')
            xlabel(app.UIAxesFunction, 'x')
            ylabel(app.UIAxesFunction, 'f(x)')
            app.UIAxesFunction.Position = [1 1 800 100];

            app.UIAxesFunctionAproximateDerevative = uiaxes(app.UIFigure);
            title(app.UIAxesFunctionAproximateDerevative, 'Approximated Derivative')
            xlabel(app.UIAxesFunctionAproximateDerevative, 'x')
            ylabel(app.UIAxesFunctionAproximateDerevative, '~f''(x)')
            app.UIAxesFunctionAproximateDerevative.Position = [1 400 700 150];

            app.UIAxesFunctionDerevative = uiaxes(app.UIFigure);
            title(app.UIAxesFunctionDerevative, 'Exact Derivative')
            xlabel(app.UIAxesFunctionDerevative, 'x')
            ylabel(app.UIAxesFunctionDerevative, 'f''(x)')
            app.UIAxesFunctionDerevative.Position = [1 216 700 180];

            app.UITable = uitable(app.UIFigure);
            app.UITable.ColumnName = {'Range from', 'Range to', 'Approximation Accuracy'};
            app.UITable.RowName = {};
            app.UITable.Position = [226 241 547 135];

            chooseFuncBtnSelectionChanged(app)
            app.UIFigure.Visible = 'on';
        end
    end

    methods (Access = public)
        function app = MyApp
            createComponents(app)
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        function delete(app)
            delete(app.UIFigure)
        end
    end
end

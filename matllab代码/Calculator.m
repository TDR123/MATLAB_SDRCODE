classdef Calculator
    properties
        value
    end
    
    methods
        % 构造函数
        % function obj = Calculator(initialValue)
        %     if nargin > 0
        %         obj.value = initialValue;
        %     else
        %         obj.value = 0;
        %     end
        % end
        
        % 方法1：加法
        function obj = add(obj, x)
            obj.value = obj.value + x;
        end
        
        % 方法2：减法
        function result = subtract(~,x, y)
            result = x-y ;
        end
        
        % 方法3：获取当前值
        function result = getValue(obj)
            result = obj.value;
        end
        
        % 方法4：显示信息
        function display(obj,result)
            fprintf('Calculator value: %g\n', result);
        end
    end
end
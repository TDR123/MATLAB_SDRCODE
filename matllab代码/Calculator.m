classdef Calculator
    properties
        value
    end
    
    methods
        % ���캯��
        % function obj = Calculator(initialValue)
        %     if nargin > 0
        %         obj.value = initialValue;
        %     else
        %         obj.value = 0;
        %     end
        % end
        
        % ����1���ӷ�
        function obj = add(obj, x)
            obj.value = obj.value + x;
        end
        
        % ����2������
        function result = subtract(~,x, y)
            result = x-y ;
        end
        
        % ����3����ȡ��ǰֵ
        function result = getValue(obj)
            result = obj.value;
        end
        
        % ����4����ʾ��Ϣ
        function display(obj,result)
            fprintf('Calculator value: %g\n', result);
        end
    end
end
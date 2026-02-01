function phase_est=carrier_recovery(signal_sampled,type)
        
    if type~="QPSK"&&type~="16QAM"
        msgbox("参数'type'不是QPSK或者16QAM,请输入正确参数");
        return;
    end
    
    if length(signal_sampled)<150
        msgbox("输入数据数目小于150,请增加输入数据数量");
        return;
    end
    
    switch type
        case "QPSK"
            alpha = 0.01;  % 环路滤波器参数
            beta = 0.001;
            phase_est = 0;
            phase_history = zeros(length(signal_sampled), 1);
            signal_derotated = zeros(size(signal_sampled));
            % 对每个符号进行相位跟踪
            for n = 1:length(signal_sampled)
                % 相位旋转补偿
                signal_derotated(n) = signal_sampled(n) * exp(-1j*phase_est);
    
                % Costas环相位误差检测（QPSK）
                % 硬判决辅助的相位误差检测
                if n > 10  % 等待环路稳定
                    % 硬判决
                    symbol_hard = sign(real(signal_derotated(n))) + 1j*sign(imag(signal_derotated(n)));
                    symbol_hard = symbol_hard / sqrt(2);
    
                    % 相位误差：Im(conj(判决)*接收)
                    phase_error = imag(signal_derotated(n) * conj(symbol_hard));
    
                    % 更新相位估计
                    phase_est = phase_est + alpha * phase_error + beta * sum(phase_history(max(1,n-10):n));
                end
    
                phase_history(n) = phase_est;
    
                % 保持相位在[-pi, pi]范围内
                phase_est = mod(phase_est + pi, 2*pi) - pi;
            end
            % 补偿载波相位偏差      
            for n = 1:length(signal_sampled)
                signal_derotated(n) = signal_sampled(n) * exp(-1j*phase_est);
    
                % 相位误差检测
                symbol_hard = sign(real(signal_derotated(n))) + 1j*sign(imag(signal_derotated(n)));
                phase_error = imag(signal_derotated(n) * conj(symbol_hard));
    
                % 更新相位估计
                phase_est = phase_est + alpha * phase_error;
            end
        case "16QAM"
    
            rxSignal=signal_sampled;
            % scatterplot(rxSignal);
            M=16;
    
            % 初始化参数
            mu = 0.18;          % 环路步长
            phase_est = 0;      % 相位估计
            phase_history = zeros(length(rxSignal), 1);
            demod_symbols = zeros(length(rxSignal), 1);
    
            % Costas环处理
            for n = 1:length(rxSignal)
                % 相位补偿
                z = rxSignal(n) * exp(-1j*phase_est);
    
                % 判决（硬判决）
                demod_symbols(n) = z;
                y=z;
                % 误差检测（适用于QPSK和QAM）
                if M == 4
                    % QPSK误差检测
                    error = imag(z) * sign(real(z)) - real(z) * sign(imag(z));
                else
                    % 16QAM误差检测（简化算法）
                    s_hat = qammod(qamdemod(y, M), M, 'UnitAveragePower', true);
                    error = angle(y * conj(s_hat));   % 误差
    
                    % error = imag(z) * (abs(real(z)) - mean(abs(real(z)))) - ...
                    %         real(z) * (abs(imag(z)) - mean(abs(imag(z))));
                end
                % 相位更新
                phase_est = phase_est + mu * error;
                % 相位保持在[-pi, pi]范围内
                phase_est = mod(phase_est + pi, 2*pi) - pi;
                % 保存相位历史
                phase_history(n) = phase_est;
            end
            phase_est=mean(phase_history(end-100:end));
            % figure
            % plot(phase_history);
    end

end
sigma_x = input("Enter stress in x: ");
sigma_y = input("Enter stress in y: ");
tau_xy = input("Enter shear force: ");
theta = input("Enter angle: ");

eval(sigma_x, sigma_y, tau_xy, theta);

function sigma_x_prime = calc_sigma_x_prime(sigma_x, sigma_y, tau_xy, theta)
    sigma_x_prime = ((sigma_x + sigma_y) / 2) + (((sigma_x - sigma_y) / 2) * cosd(2 * theta)) + (tau_xy * sind(2 * theta));
end

function sigma_y_prime = calc_sigma_y_prime(sigma_x, sigma_y, tau_xy, theta)
    sigma_y_prime = ((sigma_x + sigma_y) / 2) - (((sigma_x - sigma_y) / 2) * cosd(2 * theta)) - (tau_xy * sind(2 * theta));
end

function tau_x_prime_y_prime = calc_tau_x_prime_y_prime(sigma_x, sigma_y, tau_xy, theta)
    tau_x_prime_y_prime = (tau_xy * cosd(2 * theta)) - (((sigma_x - sigma_y) / 2) * sind(2 * theta));
end

function principal_plane = calc_principal_plane(sigma_x, sigma_y, tau_xy)
    denom = (sigma_x - sigma_y) / 2;
    principal_plane = 0.5 * atand(tau_xy / denom);
end

function R = calc_r(sigma_x, sigma_y, tau_xy)
    R = sqrt((tau_xy ^ 2) + (((sigma_x - sigma_y) / 2)^2));
end

function sigma_max = calc_sigma_max(sigma_x, sigma_y, R)
    sigma_max = ((sigma_x + sigma_y) / 2) + R;
end

function sigma_min = calc_sigma_min(sigma_x, sigma_y, R)
    sigma_min = ((sigma_x + sigma_y) / 2) - R;
end

function shear_plane = calc_shear_plane(principal_plane)
    shear_plane = principal_plane;
end

function tau_max = calc_tau_max(R)
    tau_max = R;
end

function avg_sigma = calc_avg_sigma(sigma_x, sigma_y)
    avg_sigma = (sigma_x + sigma_y) / 2;
end

function overall_max_tau = calc_overall_max_tau(max_sigma, min_sigma)
    in_plane = (max_sigma - min_sigma) / 2;
    out_plane_max = max_sigma / 2;
    out_plane_min = min_sigma / 2;

    overall_max_tau = max([abs(in_plane), abs(out_plane_max), abs(out_plane_min)]);
    if(overall_max_tau == in_plane)
        disp("In-Plane");
    else
        disp("Out-Plane");
    end
end

function [max_s, min_s] = calc_abs_max_and_min(sigma_max, sigma_min)
    max_s = sigma_max;
    min_s = sigma_min;
    
    if(sigma_max < 0)
        max_s = 0;
    elseif(sigma_min > 0)
        min_s = 0; 
    end
end

function check(sigma_x, sigma_y, sigma_x_prime, sigma_y_prime)
    if (sigma_x + sigma_y) == (sigma_x_prime + sigma_y_prime)
        disp("Passed");
    else
        disp("sigma_x + sigma_y does not equal sigma_x_prime + sigma_y_prime")
    end

end

function eval(sigma_x, sigma_y, tau_xy, theta)
    sigma_x_prime = calc_sigma_x_prime(sigma_x, sigma_y, tau_xy, theta);
    sigma_y_prime = calc_sigma_y_prime(sigma_x, sigma_y, tau_xy, theta);
    tau_x_prime_y_prime = calc_tau_x_prime_y_prime(sigma_x, sigma_y, tau_xy, theta);
    
    fprintf("σₓ′: %f\nσᵧ′: %f\nτₓ′ᵧ′: %f\n", sigma_x_prime, sigma_y_prime, tau_x_prime_y_prime);
    
    check(sigma_x, sigma_y, sigma_x_prime, sigma_y_prime);
    
    disp("************");
    
    prin_plane = calc_principal_plane(sigma_x, sigma_y, tau_xy);
    R = calc_r(sigma_x, sigma_y, tau_xy);
    sigma_max = calc_sigma_max(sigma_x, sigma_y, R);
    sigma_min = calc_sigma_min(sigma_x, sigma_y, R);
    shear_plane = calc_shear_plane(prin_plane);
    tau_max = calc_tau_max(R);
    avg_sigma = calc_avg_sigma(sigma_x, sigma_y);
    overall_max_tau = calc_overall_max_tau(sigma_max, sigma_min);
    [max_s, min_s] = calc_abs_max_and_min(sigma_max, sigma_min);
    
    fprintf("θₚ: %f ± 90\nR: %f\nσ₁: %f\nσ₂: %f\nθτ: %f ± 45\nτₘₐₓ: %f\nStress on Shear Plane: %f\nOverall Max Shear: %f\nMax Stress: %f\nMin Stress: %f\n", prin_plane, R, sigma_max, sigma_min, shear_plane, tau_max, avg_sigma, overall_max_tau, max_s, min_s);
end

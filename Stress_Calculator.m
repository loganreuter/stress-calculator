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
    
    check(sigma_x, sigma_y, sigma_x_prime, sigma_y_prime)
end

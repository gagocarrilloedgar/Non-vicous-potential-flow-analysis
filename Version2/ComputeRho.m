function rho_frac = ComputeRho(d, rho, rho_, rho0)
    rho_frac = d/(0.5*d/(rho0/rho) + (0.5*d/(rho0/rho_)));
end
function sF = dthetadtheta(sF)

fhat_theta = zeros((sF.bandwidth+2)^2, 1);
for m = 0:sF.bandwidth+1
  for l = -m:m
    a = (m-1)*sqrt((m^2-l^2)/((2*m-1)*(2*m+1)));
    b = (m+2)*sqrt(((m+1)^2-l^2)/((2*m+1)*(2*m+3)));
    if ( ( m-1 == 0 ) || ( m-1 == -1 ) ) && ( l == 0 )
      a = 0;
    end
    if ( m+1 == 0 ) && ( l == 0 )
      b = 0;
    end
    fhat_theta(m*(m+1)+l+1) = a*sF.get_fhat(m, l)-b*sF.get_fhat(m, l);
  end
end

sF_theta = S2FunHarmonic(fhat_theta);


fhat_theta_theta = zeros((sF_theta.bandwidth+2)^2, 1);
for m = 0:sF_theta.bandwidth+1
  for l = -m:m
    a = (m-1)*sqrt((m^2-l^2)/((2*m-1)*(2*m+1)));
    b = (m+2)*sqrt(((m+1)^2-l^2)/((2*m+1)*(2*m+3)));
    if ( ( m-1 == 0 ) || ( m-1 == -1 ) ) && ( l == 0 )
      a = 0;
    end
    if ( m+1 == 0 ) && ( l == 0 )
      b = 0;
    end
    fhat_theta_theta(m*(m+1)+l+1) = a*sF.get_fhat(m, l)-b*sF.get_fhat(m, l);
  end
end

sF_theta_theta = S2FunHarmonic(fhat_theta_theta);

f = @(v) (sF_theta_theta.eval(v)-cos(v.theta).*sF_theta.eval(v))./max(sin(v.theta).^2, 0.1);
sF = S2FunHarmonic.quadrature(f, 'm', max(2*sF.bandwidth, 100));

end

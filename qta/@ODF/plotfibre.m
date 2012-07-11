function [x,omega] = plotfibre(odf,h,r,varargin)
% plot odf
%
% Plots the ODF as various sections which can be controled by options.
%
%% Syntax
%  plotfibre(odf,h,r);
%
%% Input
%  odf - @ODF
%    h - @Miller crystal directions
%    r - @vector3d specimen direction
%
%% Options
%  RESOLUTION - resolution of each plot
%  CENTER     - for radially symmetric plot
%
%% Example
%  plotfibre(SantaFe,Miller(1,1.2,1.6),vector3d(1.1,1.5,1.3))
%
%% See also
% S2Grid/plot savefigure Plotting Annotations_demo ColorCoding_demo PlotTypes_demo
% SphericalProjection_demo

varargin = set_default_option(varargin,...
  getpref('mtex','defaultPlotOptions'));

omega = linspace(-pi,pi,199);

center = get_option(varargin,'CENTER',hr2quat(h,r),{'quaternion','rotation','orientation'});

fibre = axis2quat(r,omega) .* center;
x = eval(odf,fibre,varargin{:});%#ok<EVLC>

optionplot(omega,x,varargin{:});
xlim([-pi pi]); xlabel('omega')

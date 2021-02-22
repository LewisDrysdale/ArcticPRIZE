%% distances between profiles


addpath C:\MATLAB\functions\m_map_2011
% West

latmor=81.034;
latrec=81.03366667;
latdep=81.03861667;
latmid=81.04181667;
latmid2=81.03951667;
lonmor=18.414;
lonrec=18.4205;
londep=18.4115;
lonmid=18.42805;
lonmid2=18.44505;

rdepw=m_lldist([latmor latdep],[lonmor londep])
rrecw=m_lldist([latmor latrec],[lonmor lonrec])
rmidw=m_lldist([latmor latmid],[lonmor lonmid])
rmid2w=m_lldist([latmor latmid2],[lonmor lonmid2])
% East

elam=81.30240333;
elom=31.34156833;
elad=81.3028;
elod=31.31536667;
elar=81.30233333;
elor=31.34066667;

rdepe=m_lldist([elam elad],[elom elod])
rrece=m_lldist([elam elar],[elom elor])
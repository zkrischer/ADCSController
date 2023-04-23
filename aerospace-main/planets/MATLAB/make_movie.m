%%Play Movie
purge

load planets.mat
load notes.mat

%%Load Sounds
strings = [64,59,56,52,47,44,40,35,32,28];
yvec = {};
Fsvec = {};
for ii =1:length(strings)
   load(['data/',num2str(strings(ii))])
   yvec = [yvec;y];
   Fsvec = [Fsvec;Fs];
end

limit = max(max(xpos_vec));
h1 = figure();
set(h1,'color','white')
%soundsc(y_sound,Fs);
tic
counter = 1;
[M,c] = size(outvec);
M
colors = {'bo','go','ro','co','yo','mo','ko','bo','go','ro'};
for ii = 1:length(tout)
  hold off
  time = toc;
  while time <= tout(ii)
     time = toc;
  end
  if counter <= M
     if tout(ii) > outvec(counter,1)
        note = outvec(counter,2);
        idx = find(note == strings);
        %soundsc(yvec{idx},Fsvec{idx})
        counter = counter + 1;
     end
  end
  for i = 1:Numparticles
     plot([xpos_vec(i,ii) xpos_vec(i,ii)],[ypos_vec(i,ii) ypos_vec(i,ii)],colors{i},'LineWidth',r(i))
     hold on
  end
  ii
  axis([-limit limit -limit limit])
  saveas(h1,['frame',num2str(ii),'.jpg'])
end




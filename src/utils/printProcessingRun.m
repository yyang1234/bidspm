function printProcessingRun(groupName, iSub, subLabel, iSes, iRun, opt)
  %
  % (C) Copyright 2019 CPP_SPM developers

  msg = sprintf([ ...
                 '  PROCESSING GROUP: %s' ...
                 'SUBJECT No.: %i ' ...
                 'SUBJECT LABEL : %s ' ...
                 'SESSION: %i ' ...
                 'RUN:  %i \n'], ...
                groupName, iSub, subLabel, iSes, iRun);

  printToScreen(msg, opt);

end

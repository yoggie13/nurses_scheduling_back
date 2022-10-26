set solvlim=%~1
cd ..\nms
glpsol --cover --clique --gomory --mir --tmlim %solvlim% -m "glpk_nms.mod" 
pause
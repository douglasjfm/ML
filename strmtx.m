function x = strmtx(fname,m)
fid = fopen(fname,"w");
for i=1:958
	for j=1:2
		fprintf(fid,"%f ",m(91,i,j));
		if(j == 2)
			fprintf(fid,"\n");
		endif
	endfor
endfor
x = fclose(fid);
endfunction

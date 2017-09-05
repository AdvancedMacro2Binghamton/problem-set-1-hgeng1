 *DATA MANAGEMENT
 
 * Most statistic values
 tabstat var6 var6_01 var12, statistics(min max mean sd variance cv p1 p5 p10 median p75 p90 p95 p99)
 * percentile 20 40 60 80
 pctile pct5=var12,nq(5) genp(percent5)
 
 *Gini index
 ginidesc var12
 * with some errors but do not know how to fixed it 
 
 * Lorenz Curve
 glcurve var12, gl(gl) p(p) lorenz nograph
 twoway line gl p , sort || line p p ,xlabel(0(.1)1) ylabel(0(.1)1) xline(0(.2)1) yline(0(.2)1) title("Lorenz curve") subtitle("Example with custom formatting") legend(label(1 "Lorenz curve") label(2 "Line of perfect equality")) plotregion(margin(zero)) aspectratio(1) scheme(economist)

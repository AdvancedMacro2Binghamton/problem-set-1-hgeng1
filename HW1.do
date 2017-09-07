 *************************Advanced Macro HW1**********************
*************************Huayan Geng************************
**Install pctile.ado, ineqdec0.ado and glcurve.ado before run this file****
 use "D:\GOOGLE DRIVE\Fall2017\Advanced Macro\hw1\rscfp2007.dta", clear
 ***Take the weight as consideration instead of delete the duplication
 ***Generate EARNINGS INCOME WEALTH
 gen INF=1.1228 
	***INF is inflation adjustment factor found in Federal Reserve Bulletin|September 2014
	***Report on SCF website
 gen EARNING= (wageinc+0.863*bussefarminc)/INF
 gen WEALTH=networth/INF
 gen INCOME=(wageinc+bussefarminc+intdivinc+kginc+ssretinc+transfothinc)/INF
 gen EARNING_LOG=log(EARNING)
 gen WEALTH_LOG=log(WEALTH)
 gen INCOME_LOG=log(INCOME)
 
 ************Table 1 percentile********
 tabstat EARNING INCOME WEALTH [aweight=wgt], statistics(min max p1 p5 p10 median p75 p90 p95 p99)
 ***plus more percentile 20 40 60 80
 pctile EARNING_PC=EARNING [aweight=wgt],nq(5) genp(earnpct)
 pctile INCOME_PC=INCOME [aweight=wgt],nq(5) genp(incpct)
 pctile WEALTH_PC=WEALTH [aweight=wgt],nq(5) genp(wlthpct)
 list EARNING_PC earnpct in 1/4
 list INCOME_PC incpct in 1/4
 list WEALTH_PC wlthpct in 1/4
 
 ***********Table 2 Concentration and Skewness**********
 *coeffient of variation, mean, media, top 1%
 tabstat EARNING INCOME WEALTH [aweight=wgt], statistics(mean cv median p99)
 
 *location of mean: by comparing mean with ._PC2 value to find corresponding .pct2
 pctile EARNING_PC2=EARNING [aweight=wgt],nq(100) genp(earnpct2)
 pctile INCOME_PC2=INCOME [aweight=wgt],nq(100) genp(incpct2)
 pctile WEALTH_PC2=WEALTH [aweight=wgt],nq(100) genp(wlthpct2)
 list EARNING_PC2 earnpct2 in 1/100
 list INCOME_PC2 incpct2 in 1/100
 list WEALTH_PC2 wlthpct2 in 1/100
 
 *Variance of the logs 
 tabstat EARNING_LOG INCOME_LOG WEALTH_LOG[aweight=wgt], statistics(variance)
 
 *mean/median calculated by calculator
 *Top 1%/ lowest 40% calculated by calculator
 
 *Gini index
 ineqdec0 EARNING [aweight=wgt]
 ineqdec0 INCOME [aweight=wgt]
 ineqdec0 WEALTH [aweight=wgt]

 *******************Lorenz Curve**************************
 glcurve EARNING [aweight=wgt] if EARNING>0, gl(gl_e) p(p_e) lorenz nograph
 twoway line gl_e p_e , sort || line p_e p_e ,xlabel(0(.1)1) ylabel(0(.1)1) xline(0(.2)1) yline(0(.2)1) title("Lorenz curve of Earning") legend(label(1 "Lorenz curve") label(2 "Line of perfect equality")) plotregion(margin(zero)) aspectratio(1) scheme(economist)

 glcurve INCOME [aweight=wgt] if INCOME>0, gl(gl_i) p(p_i) lorenz nograph
 twoway line gl_i p_i , sort || line p_i p_i ,xlabel(0(.1)1) ylabel(0(.1)1) xline(0(.2)1) yline(0(.2)1) title("Lorenz curve of Income") legend(label(1 "Lorenz curve") label(2 "Line of perfect equality")) plotregion(margin(zero)) aspectratio(1) scheme(economist)

 glcurve WEALTH [aweight=wgt] if WEALTH>0, gl(gl_w) p(p_w) lorenz nograph
 twoway line gl_w p_w , sort || line p_w p_w ,xlabel(0(.1)1) ylabel(0(.1)1) xline(0(.2)1) yline(0(.2)1) title("Lorenz curve of Wealth") legend(label(1 "Lorenz curve") label(2 "Line of perfect equality")) plotregion(margin(zero)) aspectratio(1) scheme(economist)

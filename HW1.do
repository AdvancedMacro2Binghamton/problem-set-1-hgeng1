 *DATA MANAGEMENT
 use "D:\GOOGLE DRIVE\Fall2017\Advanced Macro\hw1\rscfp2007.dta", clear
 ***Take the weight as consideration instead of delete the duplication
 ***Generate EARNINGS INCOME WEALTH
 gen EARNING= wageinc+0.863* bussefarminc
 gen WEALTH=networth
 gen INCOME=income
 gen EARNING_LOG=log(EARNING)
 gen WEALTH_LOG=log(WEALTH)
 gen INCOME_LOG=log(INCOME)
 
 ************Table 1 percentile********
 
 tabstat EARNING WEALTH INCOME [aweight=wgt], statistics(min max p1 p5 p10 median p75 p90 p95 p99)
 ***plus more percentile 20 40 60 80
 pctile EARNING_PC=EARNING [aweight=wgt],nq(5) genp(earnpct)
 pctile INCOM_PC=INCOME [aweight=wgt],nq(5) genp(incpct)
 pctile WEALTH_PC=WEALTH [aweight=wgt],nq(5) genp(wlthpct)
 
 ***********Table 2 Concentration and Skewness**********
 *coeffient of variation, mean, media, top 1%
 tabstat EARNING WEALTH INCOME [aweight=wgt], statistics(mean cv median p99)
 *location of mean: by comparing mean with ._PC2 value to find corresponding .pct2
 pctile EARNING_PC2=EARNING [aweight=wgt],nq(100) genp(earnpct2)
 pctile INCOM_PC2=INCOME [aweight=wgt],nq(100) genp(incpct2)
 pctile WEALTH_PC2=WEALTH [aweight=wgt],nq(100) genp(wlthpct2)
 *Variance of the logs 
 tabstat EARNING_LOG WEALTH_LOG INCOME_LOG [aweight=wgt], statistics(variance)
 *mean/median calculate by calculator
 *Gini index
 ginidesc EARNING WEALTH INCOME [aweight=wgt]
 **** with some errors but do not know how to fixed it 
 
 
 * Lorenz Curve
 glcurve EARNING [aweight=wgt], gl(gl_e) p(p_e) lorenz nograph
 twoway line gl_e p_e , sort || line p_e p_e ,xlabel(0(.1)1) ylabel(0(.1)1) xline(0(.2)1) yline(0(.2)1) title("Lorenz curve of Earning") legend(label(1 "Lorenz curve") label(2 "Line of perfect equality")) plotregion(margin(zero)) aspectratio(1) scheme(economist)

 glcurve INCOME [aweight=wgt], gl(gl_i) p(p_i) lorenz nograph
 twoway line gl_i p_i , sort || line p_i p_i ,xlabel(0(.1)1) ylabel(0(.1)1) xline(0(.2)1) yline(0(.2)1) title("Lorenz curve of Income") legend(label(1 "Lorenz curve") label(2 "Line of perfect equality")) plotregion(margin(zero)) aspectratio(1) scheme(economist)

 glcurve WEALTH [aweight=wgt], gl(gl_w) p(p_w) lorenz nograph
 twoway line gl_w p_w , sort || line p_w p_w ,xlabel(0(.1)1) ylabel(0(.1)1) xline(0(.2)1) yline(0(.2)1) title("Lorenz curve of Wealth") legend(label(1 "Lorenz curve") label(2 "Line of perfect equality")) plotregion(margin(zero)) aspectratio(1) scheme(economist)

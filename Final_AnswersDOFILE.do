import delimited "Dataset.csv", clear

collapse (mean) unitmonths supportunitmonths blackunitmonths lg_31_area lg_31_population  lg_31_agricultural_sector_prop lg_31_light_sector_prop lg_31_professional_sector_prop lg_31_staple_sector_prop lg_31_other_sector_prop lg_31_unempl_rate lg_31_density constituency_conservativeshare distancetocoast distancetostation distancetoaroad distancetotrunkroad distancetonearesturbanlg distancetonearestcity distancetonearestlargecity, by(postcode_district)

rename postcode_district PostDist
merge 1:1 PostDist using postcodedistricts.dta 
save merged_data.dta, replace

ssc install spmap

spmap supportunitmonths using xy.dta, id(id) fcolor(Reds) osize(medium) ocolor(black) legend(position(8) size(medsmall))

spmap blackunitmonths using xy.dta, id(id) fcolor(Blues) osize(medium) ocolor(black) legend(position(8) size(medsmall))

* Create a new variable for varconcern being either =0 or >0
gen blackunit_binary = cond(blackunitmonths==0, "=0", ">0")

* Generate summary statistics for each variable split by varconcern_cat
tabstat unitmonths supportunitmonths blackunitmonths lg_31_area lg_31_population  lg_31_agricultural_sector_prop lg_31_light_sector_prop lg_31_professional_sector_prop lg_31_staple_sector_prop lg_31_other_sector_prop lg_31_unempl_rate lg_31_density constituency_conservativeshare distancetocoast distancetostation distancetoaroad distancetotrunkroad distancetonearesturbanlg distancetonearestcity distancetonearestlargecity, by(blackunit_binary) stat(mean) nototal 

* Load data into Stata
*import delimited Dataset.csv

gen black01 = (blackunitmonths==0) + (blackunitmonths>0)*2
ttest unitmonths, by(black01)
ttest supportunitmonths, by(black01)
ttest lg_31_area, by(black01)
ttest lg_31_population, by(black01)
ttest lg_31_agricultural_sector_prop, by(black01)
ttest lg_31_light_sector_prop, by(black01)
ttest lg_31_professional_sector_prop, by(black01)
ttest lg_31_staple_sector_prop, by(black01)
ttest lg_31_other_sector_prop, by(black01)
ttest lg_31_unempl_rate, by(black01)
ttest lg_31_density, by(black01)
ttest constituency_conservativeshare, by(black01)
ttest distancetocoast, by(black01)
ttest distancetostation, by(black01)
ttest distancetoaroad, by(black01) 
ttest distancetotrunkroad, by(black01) 
ttest distancetonearesturbanlg, by(black01) 
ttest distancetonearestcity, by(black01) 
ttest distancetonearestlargecity, by(black01) 

regress blackunitmonths supportunitmonths lg_31_area lg_31_population  lg_31_agricultural_sector_prop lg_31_light_sector_prop lg_31_professional_sector_prop lg_31_staple_sector_prop lg_31_other_sector_prop lg_31_unempl_rate lg_31_density constituency_conservativeshare distancetocoast distancetostation distancetoaroad distancetotrunkroad distancetonearesturbanlg distancetonearestcity distancetonearestlargecity

outreg2 using Output, tex dec(3) replace

regress blackunitmonths unitmonths lg_31_area lg_31_population  lg_31_agricultural_sector_prop lg_31_light_sector_prop lg_31_professional_sector_prop lg_31_staple_sector_prop lg_31_other_sector_prop lg_31_unempl_rate lg_31_density constituency_conservativeshare distancetocoast distancetostation distancetoaroad distancetotrunkroad distancetonearesturbanlg distancetonearestcity distancetonearestlargecity

outreg2 using Output, tex dec(3) append

clear

import delimited "Dataset.csv" 

collapse (mean) unitmonths supportunitmonths blackunitmonths lg_31_area lg_31_population  lg_31_agricultural_sector_prop lg_31_light_sector_prop lg_31_professional_sector_prop lg_31_staple_sector_prop lg_31_other_sector_prop lg_31_unempl_rate lg_31_density constituency_conservativeshare distancetocoast distancetostation distancetoaroad distancetotrunkroad distancetonearesturbanlg distancetonearestcity distancetonearestlargecity, by(oa11cd)

regress blackunitmonths supportunitmonths lg_31_area lg_31_population  lg_31_agricultural_sector_prop lg_31_light_sector_prop lg_31_professional_sector_prop lg_31_staple_sector_prop lg_31_other_sector_prop lg_31_unempl_rate lg_31_density constituency_conservativeshare distancetocoast distancetostation distancetoaroad distancetotrunkroad distancetonearesturbanlg distancetonearestcity distancetonearestlargecity
outreg2 using Output.tex, tex dec(3) append 

regress blackunitmonths unitmonths lg_31_area lg_31_population  lg_31_agricultural_sector_prop lg_31_light_sector_prop lg_31_professional_sector_prop lg_31_staple_sector_prop lg_31_other_sector_prop lg_31_unempl_rate lg_31_density constituency_conservativeshare distancetocoast distancetostation distancetoaroad distancetotrunkroad distancetonearesturbanlg distancetonearestcity distancetonearestlargecity 
outreg2 using Output.tex, tex dec(3) append 





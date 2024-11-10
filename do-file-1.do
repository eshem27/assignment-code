clear
set more off

cd C:\Users\Shemetova_Ekaterina\Downloads\airbnb\raw

import delimited airbnb_london_listing.csv, varnames(1) bindquotes(strict) encoding("utf-8") clear


describe
summarize

* First we keep only columns that we need for the analysis
keep id host_id host_name host_response_rate city property_type room_type accommodates price cancellation_policy reviews_per_month review_scores_rating

* dropping NA values
drop if host_response_rate=="N/A"
drop if price=="NA"
drop if review_scores_rating=="NA"
drop if reviews_per_month=="NA"

* chanfing the type of data
replace host_response_rate = subinstr(host_response_rate, "%", "", .)
destring host_response_rate, replace
replace host_response_rate = host_response_rate / 100

replace price = subinstr(price, "$", "", .)
destring price, replace force
recast float price

destring reviews_per_month, replace force
recast float reviews_per_month

destring review_scores_rating, replace force

* summary tables and check for the data type 
describe
summarize 
codebook


save Data_new\airbnb_clean.dta 


codebook

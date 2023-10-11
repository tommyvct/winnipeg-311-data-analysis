
#import "template.typ": *

#show: ieee.with(
  title: "Spatiotemporal Analysis on Winnipeg 311 Service Requests",
  authors: (
    (name: "Tommy Wu", email: "wus2@myumanitoba.ca", department: "Department of Computer Science", organization: "University of Manitoba", location: "Winnipeg, Manitoba, Canada"),
  ),
  bibliography-file: ("bib.bib")
)


= Data
The dataset @data_311 has 7 columns that are used to describe each request, containing date, service area and request, electoral ward and neighbourhood. There are two other identical columns including the location regarding the request, but the location is randomized within the same neighbourhood, thus it doesn't provide much useful information as our primary care is the number of requests within a region or time period.

The 311 requests have 17 kinds of service requests:

1. Boulevard Mowing  
2. Dog Complaint
3. Frozen Catch Basin
4. Graffiti 
5. Litter Container Complaint
6. Missed Garbage Collection
7. Missed Recycling Collection
8. Mosquito Complaint
9. Neighbourhood Liveability Complaint
10. Potholes
11. Sanding 
12. Sewer Backup
13. Sidewalk Repairs 
14. Snow Removal - Roads
15. Snow Removal - Sidewalks
16. Tree Pest Caterpillar Complaint
17. Water Main Leak

The Graffiti reports were separated into 2 Service Areas, Parks and Urban Forestry and Street Maintenance. The graffiti reports which belong to the Parks and Urban Forestry area have a report number of merely 120 in the past 2 years in the dataset. We merged these reports with the one under the Street Maintenance service area.

The dataset contains only data starting from the first day of 2021, So a pre-COVID comparison is not possible. Recall that this dataset is about the city services requests received by 311, not the actual work dispatched.

In the Spatial analysis, we used 2016 Census data @census_2016 since that's the most complete and recent census data available. Even though the data is 7 years old, it still holds much useful information such as population, population density, unemployment rate, average and median family income, measurement of poverty (LIM-AT and LICO-AT), and more.

= Temporal

Overall, there was a vague trend of lower requests in the late summer and fall and an increase in the spring.

#figure(
  image("overall requests by month.png"),
  caption: "Overall 311 service requests by month"
) <overall_req>

== COVID policy related changes <covid_related_changes>
Winnipeg along with the whole province of Manitoba has seen some major differences in COVID policy between 2021 and 2022.



#figure(
  image("epi_curve-1.png"),
  caption: "Weekly Cases of COVID-19 by Season, Manitoba, 2020 – 2023 (July through June)"
) <epi_curve>

Notice that there was a substantial increase in the first 5 months of 2022 as shown in @overall_req, in which the shape matches the bump of the grey dotted line in @epi_curve @mb_resp_serv. However, the time doesn't quite match. The peak in @overall_req was in March while the peak in @epi_curve was in the first epi week, which was in January. In another word, there's a 3-month offset between the peak of the COVID wave and the peak of the request wave.

#figure(
  image("delta_jan_may_2022-2021.png"),
  caption: "Difference in request categories between 2022 and 2021 from January to May"
) <delta_2022-2021>

According to the COVID-19 pandemic in Manitoba page on Wikipedia @mbcovid_wikipedia, Since the beginning of 2022, most of the restrictions were being lifted, followed by increased civil activities; while at the same time of the year 2021, new variants of the SARS-Cov-2 virus was doing the opposite effort of limiting all non-essential businesses and services. Most people were working from home in the first half of 2021 because most of the restrictions were not lifted yet, which resulted in fewer requests asking for road-related maintenance. But 2022 was the opposite: limits were being lifted, and with more people on the road, potholes were more noticeable. People were going back to their workspace, and melting snow and potholes would be noticed by more people than in 2021, thus resulting in significant increases in snow-related requests as shown in @delta_2022-2021. Increased activities will also create more waste, hence explaining the increase in missed garbage and recycling collection service.

Recall the 3-month offset mentioned before, and the reopening process started just one-month after (Feb. 8, 2022 @mb_resp_serv) the peak of the COVID case. The overlap between the 2 distributions could mean a supply-demand imbalance of labour, especially city services. For example. people who called 311 for potholes were expecting someone from the city to fix them within a reasonable amount of time, while the people who do such kind of roadwork were still ill. COVID infection can take anywhere from 14 days to over a month to recover from @BARMAN20201205, which means there were still a substantial amount of people who were still sick at home and cannot work. Mulplicated factors resulted in such a big difference in the number of requests between 2 years.

== Seasonal changes
Most requests fluctuate with the season. For example, Boulevard Mowing, Tree Caterpillar and Mosquito complaints happen strictly in summer, Frozen Catch Basin happens strictly in early spring, while Snow Removal on sidewalks, roads, and Sanding requests happens strictly in winter. Other requests, including Dog Complaints, Litter Container Complaints, Neighbourhood Livability Complaints, Potholes, Side Walk Repair and Graffiti showed significant drops in the winter months (around and between November and February).


To quantize the seasonal change, we will make use of the meteorological data provided by Environment and Climate Change Canada @envcan_historical_weather. The following graph was the monthly average temperature, Precipitation, and Depth of snow on the ground from January 2021 to January 2023:

#figure(
  image("avg_monthly_temp.png"),
  caption: "Average Monthly Temperature in Celsius from January 2021 to January 2023"
) <avg_monthly_temp>

As @avg_monthly_temp showed, there was no significant difference in average temperatures between 2021 and 2022. 

#figure(
  image("dog graffiti noise sidewalk.png"),
  caption: "Five categories of requests which had a positive correlation with the Average Monthly Temperature"
) <temp_coor>

All of the 6 events in @temp_coor showed a positive correlation with the Average Monthly Temperature in @avg_monthly_temp. Notice All of the four categories of requests have a spike in the 2021 Q2, this matches the findings in @covid_related_changes, where the third wave is shown in @epi_curve, where the orange dotted lines hump from epi week 13 to 26 indicates Q2 2021.

Many activities and public works are hard or don't make sense to do in winter. For example, there is no grass in winter so there is nothing to mow, explaining 0 reports in the winter months. 

Sidewalk repair requests are less in winter because of the cold weather, people will walk outside less than in summer, also most of the time sidewalks will be covered with snow and ice in some areas, so even if the sidewalk is broken, people walking on it may not notice. 

Doing graffiti in winter is full of hypothermia risk, plus people will be concentrating on walking properly outside in harsh winter conditions, graffiti will be less noticeable, explaining near-zero reports in the winter months.

For Dog, Neighbourhood Liveability and Litter Container Complaints, we can still see a clear pattern that peaks in summer. In winter, the number of requests, however, instead of dropping to near-zero, still has a baseline number of reports. 

Notice there were spikes around June 2021 with Graffiti, Sidewalk Repairs, Dog Complaints and Neighbourhood Liveability Complaints. This coincides with the COVID policy @mbcovid_wikipedia of the time that proof of COVID vaccination was compulsory to use entertainment services such as dining in at a restaurant, taking a plane trip, etc. The policy was the by-product of the government's effort to control COVID infections and hospitalizations by forming community immunity using vaccines to avoid the high hospitalization rate of the time. And as with many compulsory public policies, a lot of people will be frustrated. People will make excessive noises, and paint graffiti on public properties to express and vent their frustration. People will also try to seek alternative entertainment like outdoor activities; this could explain the hike for sidewalk repair requests and dog complaints. 

// TODO: find social science references on covid boredom, behaviour, etc

== Precipitation changes
Some categories of reports not only correlate with temperature but also precipitation.  

#figure(
  image("avg_monthly_precip.png"),
  caption: "Average Monthly Precipitation in mm from January 2021 to January 2023"
) <avg_monthly_precip>

We can see that there was much more rain in 2022 than in 2021 from @avg_monthly_precip (Total of 766.4mm in 2022 vs total of 384.2mm in 2021).

#figure(
  image("mosquito sewer.png"),
  caption: "Three categories of requests which had a positive correlation with the Average Monthly Precipitation"
) <litter_mosquito_sewer>

There were increases in requests in the summer of 2022 compared to 2021 as shown in @litter_mosquito_sewer. The ample waterfall provided an excellent environment for insects, including mosquitos, to thrive. 

The excessive waterfall also stressed our sewer system, causing much higher than normal sewer backups. Observe that in the year 2021, the reports for sewer backup were stable and low (with a mean of 109.3) all year round, while in the summer of 2002, there were much more cases. This resulted in the number of reports in 2022 being 1000 more than reports in 2021.

// TODO: find civil eng references to support the relationship between excessive rain, flood and sewer backup.

#figure(
  image("avg_monthly_snow_on_ground.png"),
  caption: "Average Monthly Depth of Snow on Ground in cm from January 2021 to January 2023"
) <avg_monthly_snow_on_ground>

// TODO: description of climate in Winnipeg, not so much precipitation in terms of water, but to make a lot of snow you don't need a lot of water since snow takes much more volume for the same amount of h2o. avg_monthly_snow_on_ground is a better measurement for snowfall than avg_monthly_precip.

From @avg_monthly_snow_on_ground, we can see that there was much more snow from 2021-2022 than in 2020-2021. 

#figure(
  image("frozen_catch_basin_potholes_snow_removal.png"),
  caption: "Four categories of requests which had a positive correlation with the Average Snow on Ground"
) <frozen_catch_basin_potholes_snow_removal>

There were increases in requests in the winter of 2021-2022 as shown for every category of request in @frozen_catch_basin_potholes_snow_removal, compare to the winter of 2020-2021, which matches the increased snowfall as shown in @avg_monthly_snow_on_ground.

Road potholes, for example, one of the main causes for it is moisture @pothole_fact_sheet, which will be melting snow in the spring. Normally in the summer, rainwater will be either diverted by catch basins or simply sunk to the lower ground; but in winter the water will accumulate and stay on the ground in the form of snow and ice, keeping the ground wet for a long time until all snow has melted. Melted snow enters the pavement through cracks, and as it freezes and thaws, it causes the pavement to expand and contract, leading to further cracking and eventually the formation of a pothole. Heavy traffic and heavy loads on the pavement also contribute to the formation of potholes by weakening the pavement structure. Road potholes also need drastic temperature changes to happen, which is the reason why they are formed in the spring when everything is thawing. Fixing road potholes is laborious and time-consuming, which explains the prolonged requests all over the summer and fall; while other requests will be self-dissolved as the temperature rises.

== Steady Increase 
#figure(
  image("garbage_recycle.png"),
  caption: "Missed Garbage & Recycling Collection requests"
) <garbage_recycle>

For Missed Garbage & Recycling Collection requests, a steady increase could be observed as the COVID policy loosens. 

= Spatial
== Regression Analysis
All regression lines were drawn with the seaborn library, with the translucent blue as a 95% confidence interval.

=== Population Density
Overall, the number of 311 service requests has a positive correlation with the population density, As shown in @population_density_vs_count.

#figure(
  image("population_density_vs_count.png"),
  caption: "Correlation between the number of 311 requests and the population density of every neighbourhood"
) <population_density_vs_count>

The regression line in @population_density_vs_count has a gradient of 0.0289, which that means for each increase of 1000 in population density will very likely add about 289 more 311 service requests. However, the confidence interval indication, which is shown as the light blue around the regression line in @population_density_vs_count, is becoming wider as the population density increases. 

There were a few outliers in @population_density_vs_count. The only 2 neighbourhoods on the top half of the figure are William Whyte and St John's, which have 4100 and 2822 requests respectively from 2021 to 2022. These 2 neighbourhoods have the highest level of poverty, measured at 47.68% and 31.59% when using LIM-AT, or 38.42% and 27.15% when using LICO-AT. In other words, roughly a quarter to half of the people living in these 2 neighbourhoods are considered low-income.

The 4 neighbourhoods with the highest population density also have some of the lowest numbers of 311 service requests. 3 of them are located in the downtown area, while the other one was in St. Vital. All of the 4 neighbourhoods have mostly apartments instead of houses. Apartments usually have their own caretaking services and they don't rely on the city's services, hence explaining the less-than-expected service requests.

=== Poverty
To measure poverty, two common indicators used in Canada are LIM-AT and LICO-AT. LIM-AT stands for Low-Income Measure After Tax, and it is a measure of relatively low income, which compares the income of a household after tax and adjusted for household size to the median income of all households in the country. A household is considered to be low income if its adjusted income is less than 50% of the median income. LICO-AT stands for Low Income Cut-Off After Tax and is also a measure of relatively low income, but it uses a fixed threshold that varies by household and community size. The threshold represents the income below which a household is expected to spend a larger proportion of its income on necessities than the average household.

If we look at the lower-right side of @population_density_vs_count, 4 neighbourhoods have exceptionally high population densities, while maintaining a low number of requests. These neighbourhoods are Alpine Place, Roslyn, Central Park, and Broadway-Assiniboine. Despite the high level of poverty (32.59% LIM-AT, 27.86% LICO-AT), they only contributed 471 requests in 2021 and 2022. In these neighbourhoods, instead of detached houses, most people live in apartment buildings, hence explaining the high population density. This could be explained that most private apartments have their own caretaking services, where the requests regarding these properties are not reported and handled by the City of Winnipeg. In contrast, Most of detached houses rely on the city-provided services. For example, snow removal, garbages, etc. 

Neighbourhoods mentioned above, almost all these neighbourhoods have a high level of poverty, more than 20% of their population have a low income. This is because both LIM-AT and LICO-AT have a strong positive correction with the population density, as shown in @limat_licoat_pd:

#figure(
  grid(
    columns: 2,
    image("limat_pd.png"),
    image("licoat_pd.png")
  ),
  caption: "Correlation between the portion of low-income people in a neighbourhood measured by LIM-AT or LICO-AT (measurement of relative poverty), and the population density.
  Gradients were 84.62 and 98.94, and intercepts were 1555.93 and 1604.23 respectively."
) <limat_licoat_pd>

At the same time, the number of 311 requests also has a positive correlation with both LIM-AT and LICO-AT as shown in @limat_licoat_count:

#figure(
  grid(
    columns: 2,
    image("limat_count.png"),
    image("licoat_count.png")
  ),
  caption: "Correlation between number of requests and either LIM-AT or LICO-AT (measurement of relative poverty)
  Gradients for the regression lines were 7.58 and 9.25, and their intercepts were 370.16 and 369.57 respectively."
) <limat_licoat_count>

These 2 correlation agrees with the positive correlation we found earlier in @population_density_vs_count.

=== Infrastructure and Dwelling Conditions

#figure(
  image("bad_dwelling_count.png"),
  caption: "Correlation between the number of requests and the percentage of dwellings in the neighbourhood that need major repairs.
  Gradient and intercept of the regression line were 19.30 and -47.71 respectively."
) <bad_dwelling_count>

In the census data @census_2016, the ratio of dwellings in need of major repairs also has a very positive correlation with the number of 311 requests, as shown in @bad_dwelling_count.

A major factor in infrastructure and dwelling quality is time. @year_opened_count shows there's a negative correlation between the year of a neighbourhood shown in the past census for the first time. In this case, the said year is inferring the aging condition of both infrastructure and dwellings. This agrees with our previous findings.

#figure(
  image("year_opened_count.png"),
  caption: "Correlation between the number of requests and the first year appeared in the past census."
) <year_opened_count>

//=== Housing Types
// Most people in Winnipeg live in detached houses, while others live in apartments.
// 
// #figure(
//   grid(
//     columns: 2,
//     image("house_count.png"),
//     image("apartment_count.png")
//   ),
//   caption: "No correlation between the ratio of House or Apartment in a neighbourhood. The gradients are 79.45 and -76.36 respectively"
// )  <house_apartment_ratio_count>
// 
// As shown in @house_apartment_ratio_count, there is no correlation between the ratio of either house or apartment and the number of 311 requests.

=== Education and unemployment
TODO: no education vs income, no education vs count, unemployment vs count
The unemployment rate has a positive correlation with the number of events, as shown in @unemployment_count:

#figure(
  image("unemployment_count.png"),
  caption: "Correlation between the number of requests and the unemployment rate.
  The gradient of the regression line was 38.17."
) <unemployment_count>

The gradient means for every 1 percent increase in the unemployment rate, there's a 95% chance that the 311 service requests will also go up by 38 in 2 years. For neighbourhoods with an unemployment rate of over 10%, the education level was also underwhelming. For example, both China Town and Lord Selkirk Park have around half of the population who didn't finish a high school diploma or other higher education.

#figure(
  image("noedu_count.png"),
  caption: "Correlation between the number of requests and the proportion of people who didn't finish any education above high school.
  The gradient of the regression line was 18.16."
) <noedu_count>

As shown in @noedu_count, each 1 percent increase in the No Education population will add at least around 18.16 service requests in 2 years.

=== Immigration Status
Immigration status does not correlate with the number of 311 service requests as shown in @noncitizen_count, which features a near-flat gradient. 

#figure(
  image("noncitizen_count.png"),
  caption: "Correlation between the number of requests and the portion of non-citizen people.
  The gradient was -0.136 with an intercept of 487.85."
) <noncitizen_count>


=== Visible Minorities Related
Certain visible minorities had a positive correlation with the number of 311 service requests. For example, the number of 311 service requests was positively correlated with the number of Aboriginal people, Filipino, Southeast Asians and people who declared multiple minorities, as shown in @positive_ethic_count.

#figure(
  grid(
    columns: 2,
    rows: 2,
    image("aboriginal_count.png"),
    image("filipino_count.png"),
    image("southease_asian_count.png"),
    image("multiple_count.png")
  ),
  caption: "Positive correlation between the number of requests and the portion of a certain visible minority."
) <positive_ethic_count>

In @positive_ethic_count, the gradient of Aboriginal people's regression line was 15.07. The gradient for Filipinos was 10.21, for Southeast Asians was 49.43, and for people declared multiple minorities was 41.72.

Other minorities have either close-to-flat to negative correlation with the number of 311 service requests, as shown in @black_arab_count.

#figure(
  grid(
    columns: 2,
    image("black_count.png"),
    image("arab_count.png")
  ),
  caption: "Close-to-zero or negative correlation between the number of requests and the portion of a certain visible minority.
  The black people have a gradient of 2.89 while the Arab people have a gradient of -28.11."
) <black_arab_count>

== Map
#figure(
  image("requests.png"),
  caption: "Choropleth map of Winnipeg representing the number of requests for each neighbourhood."
) <main_requests_map>

From @main_requests_map, we can observe that there were more neighbourhoods in the north part of the city with an excessive amount of 311 service requests than in the south. These neighbourhoods were Rossmere-A, Jefferson, Daniel Mcintyre, Chalmers, St. John's, and William Whyte. All of the previously said neighbourhoods have at least 200 reports over the last 2 years on Neighbourhood Livability Complaints, and the total number of such complaints from these neighbourhoods was 5979. This coincides with the sad homelessness situation this city is suffering.

Looking south, the only 2 neighbourhoods that stood out were Fort Richmond and River Park South. Fortunately, most of the requests were garbage related.

Now, if we look west by the southeast corner of the Airport, the Kind Edward neighbourhood stood out. More specifically, it's right in from of Runway 31, which is a runway that is mainly used to land planes. This could explain why there were 219 Neighbourhood Liveability Complaints in the past 2 years, while all other neighbourhoods don't have this amount of Neighbourhood Liveability Complaints. For example, Deer Lodge has 66 while Sir John Fraklin has only 54 requests.

=== Graffiti
#figure(
  image("graffiti.png"),
  caption: "Choropleth map of Winnipeg representing the amount of graffiti reports to 311 for each neighbourhood."
) <graffiti_map>

From @graffiti_map, we can see that the number of graffiti reports tends to happen more frequently in the downtown and Osborne area. Graffiti is usually used to express frustration, such as the COVID-related lockdown, and the homelessness in William Whyte and St. Johns.

Regression analysis says the occurrence of such reports has strong correlations with lack of education, unemployment, bad dwelling conditions, and poverty, as shown in @graffiti_correlations.

#figure(
  grid(
    columns: 2,
    rows: 2,
    image("graffiti_bad_dwellings.png"),
    image("graffiti_licoat.png"),
    image("graffiti_noedu.png"),
    image("graffiti_unemployment.png")
  ),
  caption: "Positive correlation between the number of graffiti reports to 311 and different census data.
  The gradients were 2.57, 1.02, 1.42, 3.08 respectively."
) <graffiti_correlations>

=== Garbage & Recycle Related
#figure(
  image("garbage.png"),
  caption: "Choropleth map of Winnipeg representing the amount of garbage 
 & recycle related reports to 311 for each neighbourhood."
) <garbage_map>

From @garbage_map, we can conjecture that the general pattern of the north part of the city has more requests than the south part. It's also important to notice that in industrial and non-residential neighbourhoods, there weren't many requests. This was mainly due they may have their own private care-taking service instead of using the city's service.

For Litter Container Complaints, South Portage, which is the core of Downtown Winnipeg, had 120 such complaints while all other neighbourhoods either had less than 50 for those neighbourhoods Downtown, or close to 0 complaints. Being located at the core of Downtown means there will be countless people working here and making garbages every day.

It's also worth noting that newer neighbourhoods were having fewer such reports while older neighbourhoods have much more reports compared to the new ones. A pair of such distinctive differences was Bridgewater Trails, which first appeared in the census in 2016, while River Park South was present in the census since 1971. Bridgewater Trails had 29 requests while River Park South had 824.

=== Insect Control
#figure(
  image("insect.png"),
  caption: "Choropleth map of Winnipeg representing the amount of Insect Control requests to 311 for each neighbourhood."
) <insect_control_map>

Among all kinds of 311 service requests, Mosquito and Tree Pest Caterpillar Complaint are the least requested services; both services had 417 reports combined. In @insect_control_map, the colouring was modified to help distinguish neighbourhoods with less or more than 15 complaints in the years 2021 and 2022.

We can observe that neighbourhoods with more than 15 complaints, most of them have a large portion of land made of either park, water or both. For example, Fort Richmond has 3 parks, and it's built along the Red River; Deer Lodge has a golf range; Silver Heights have Golder Gate Park. Mosquito needs water to reproduce, and Caterpillars need to eat tree leaves to survive; These neighbourhoods provided a good environment for them to thrive.

//=== Dog Complaints
//TODO

=== Water-related
The water-related requests include a frozen catch basin, sewer backup, and water main leak.

#figure(
  image("water.png"),
  caption: "Choropleth map of Winnipeg representing the amount of water-related service requests to 311 for each neighbourhood."
) <water_map>

Generally, newer neighbourhoods will have fewer water-related service requests. This could be confirmed by a positive regression with the first year of first appearance in the census as shown in @water_yearopened_count.

#figure(
  image("water_yearopened_count.png"),
  caption: "Negative correlation between number water-related service requests and the first year appeared in the census."
) <water_yearopened_count>

What's more interesting, the number of water-related service requests also has a positive correlation with the proportion of houses in a neighbourhood as shown in @water_house_count:

#figure(
  image("water_house_count.png"),
  caption: "Positive correlation between number water-related service requests and the proportion of houses in a neighbourhood."
) <water_house_count>

=== Snow-related
Ice and snow, despite being the same chemical as liquid water, have drastically different physical properties. Given the same amount of H2O, its volume in liquid is usually smaller than its solid state. This characteristic is one of the main culprit of pothole formation on roads @pothole_fact_sheet. Ice and snow also do not "go away" by themselves; it has to be removed manually from the road we drive on and the sidewalk we walk on. This means all of the snow-related services, namely potholes, sanding, and snow removal on both roads and sidewalks, are spatially universal across the whole city as shown in @snow_map:

#figure(
  image("snow.png"),
  caption: "Choropleth map of Winnipeg representing the amount of snow-related service requests to 311 for each neighbourhood."
) <snow_map>

There are a few neighbourhoods that have higher-than-normal request numbers, but most of the neighbourhoods have less than 250 requests. Notice that there are quite a few neighbourhoods that are industrial parks, for example, Tuxedo Industrial, Airport and University. These industrials along with University and airport contributed only around 3%(758/24066) of the total requests because either these lands are not used, or they have their own caretaking services.

It seems that newer neighbourhoods still had fewer requests than old neighbourhoods, as shown in @snow_yearopen_count:

#figure(
  image("snow_yearopen_count.png"),
  caption: "Negative correlation between number snow-related service requests and the first year appeared in the census."
) <snow_yearopen_count>

But the correlation with population density is interesting to say at least:

#figure(
  image("snow_population_density_count.png"),
  caption: "Positive correlation between snow-related service requests and the population density.
  The default regression line here is not correct."
) <snow_population_density_count>

If we truncate the Population density from 0 to 6000 people/km^2 and from 6000 to 16000 respectively, we can have 2 regression lines:

#figure(
  grid(
    columns: 2,
    image("snow_population_density_count_1.png"),
    image("snow_population_density_count_2.png")
  ),
  caption: "Previous figure, but cut on the population density of 6000 people/km^2."
) <half_half>

In @half_half, the left half's regression line has a gradient of 0.0354, while the right half has a gradient of -0.0037. This could be explained in 2 parts:
1.  The left part is for detached houses. More house means more people, and more cars, hence more 311 service requests.
2. The right part is for neighbourhoods that mainly have apartments. These commercial apartments often have their own caretaking services. Higher population density means higher revenue, hence better service and the negative gradient of the right half.
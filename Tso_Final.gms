SETS
h 'hours in a day' /1*24/
techs /train, bus_diesel, bus_electric, bus_hydrogen, bus_hybrid, car_electric, car_petrol, car_diesel, car_hybrid, taxi_electric, taxi_petrol, taxi_diesel, taxi_hybrid, pedal_cycle /
buses(techs) /bus_diesel, bus_electric, bus_hydrogen, bus_hybrid/
cars(techs) /car_electric, car_petrol, car_diesel, car_hybrid/
taxis(techs)/taxi_electric, taxi_petrol, taxi_diesel, taxi_hybrid/
fuel ' fuels used to power each tech' /petrol, diesel, hydrogen, electricity/
petrol_techs(techs) /car_petrol, car_hybrid, taxi_petrol, taxi_hybrid/
diesel_techs(techs) /bus_diesel, bus_hybrid, car_diesel, taxi_diesel/
hydrogen_techs(techs) /bus_hydrogen/
electricity_techs(techs)/train, bus_electric, car_electric, taxi_electric/

;

PARAMETERS
km_per_day(techs)   'average travel distance of each transport tech (km/day)'
carbon_intensity(fuel) 'kgCO2 per litre of each fuel'
;

km_per_day('train')= 2.1;
km_per_day(buses)= 1.1;
km_per_day(cars)= 3.0;
km_per_day(taxis) = 0.23;
km_per_day('pedal_cycle')= 0.23;

carbon_intensity('petrol')=2.3;
carbon_intensity('diesel')=2.6;
carbon_intensity('electricity')=0.233;
carbon_intensity('hydrogen')=0.66;

;


*$call gdxxrw.exe Input_Data.xlsx index=Data_List!A1:G7 o=Input_Final.gdx

*$call gdxxrw.exe Input_Data.xlsx par=fuel_cons rng=Fuel_Cons!A1:O5
PARAMETER fuel_cons(fuel,techs)'fuel economy of tech while using a fuel (L/km)';
$gdxin Input_Final.gdx
$load fuel_cons
$gdxin
;

*$call gdxxrw.exe Input_Data.xlsx par=num_users_MTT rng=Num_Users_Hourly_MTT!A1:O25
PARAMETER num_users_MTT(h,techs) 'number of users on a typical weekday except friday';
$gdxin Input_Final.gdx
$load num_users_MTT
$gdxin
;

*$call gdxxrw.exe Input_Data.xlsx par=num_users_Fri rng=Num_Users_Hourly_Fri!A1:O25
PARAMETER num_users_Fri(h,techs)'number of users on a typical Friday';
$gdxin Input_Final.gdx
$load num_users_Fri
$gdxin
;

*$call gdxxrw.exe Input_Data.xlsx par=num_users_Sat rng=Num_Users_Hourly_Sat!A1:O25
PARAMETER num_users_Sat(h,techs) 'number of users on a typical saturday';
$gdxin Input_Final.gdx
$load num_users_Sat
$gdxin
;

*$call gdxxrw.exe Input_Data.xlsx par=num_users_Sun rng=Num_Users_Hourly_Sun!A1:O25
PARAMETER num_users_Sun(h,techs) 'number of users on a typical sunday';
$gdxin Input_Final.gdx
$load num_users_Sun
$gdxin
;

*$call gdxxrw.exe Input_Data.xlsx par=fare rng=Fare_Hourly!A1:O25
PARAMETER fare(h,techs)'fare prices of technology at hr h (£/km)';
$gdxin Input_Final.gdx
$load fare
$gdxin
;

VARIABLES
*MTT represents monday to thursday
user_demand_MTT(h,techs) 'km per hr per person'
spend_MTT(h,techs)       'spend on each technology in each hr £/hr'
total_spend_techs_MTT(techs) 'spend on each technology in a day £/day'
total_spend_MTT            'spend on all techs in a day, £/day'

user_demand_Fri(h,techs) 'km per hr per person'
spend_Fri(h,techs)
total_spend_techs_Fri(techs)
total_spend_Fri

user_demand_Sat(h,techs) 'km per hr per person'
spend_Sat(h,techs)
total_spend_techs_Sat(techs)
total_spend_Sat

user_demand_Sun(h,techs) 'km per hr per person'
spend_Sun(h,techs)
total_spend_techs_Sun(techs)
total_spend_Sun

total_spend           'spend on all techs in a week £/week'

user_demand_techs_MTT(techs)     'user demand for each tech in a typical MTT day, km/day'
user_demand_techs_Fri(techs)
user_demand_techs_Sat(techs)
user_demand_techs_Sun(techs)

fuel_usage_MTT(fuel,techs)      'amount of each fuel used by each tech on a typical MTT day, L/day'
fuel_usage_Fri(fuel,techs)
fuel_usage_Sat(fuel,techs)
fuel_usage_Sun(fuel,techs)

carbon_emissions_MTT(fuel,techs)      'carbon emissions from each fuel used in each tech on a typical MTT day, kgCO2/day'
carbon_emissions_Fri(fuel,techs)
carbon_emissions_Sat(fuel,techs)
carbon_emissions_Sun(fuel,techs)

total_carbon_emissions_techs_MTT(techs)     'carbon emissions from each tech on a typical MTT day, kgCO2/day'
total_carbon_emissions_techs_Fri(techs)
total_carbon_emissions_techs_Sat(techs)
total_carbon_emissions_techs_Sun(techs)

total_carbon_emissions_MTT               'carbon emissions accross all techs on a typical MTT day, kgCO2/day'
total_carbon_emissions_Fri
total_carbon_emissions_Sat
total_carbon_emissions_Sun

total_carbon_emissions                'carbon emissions accross all techs in a week, kgCO2/week'

total_fuel_usage_techs_MTT(techs)    'amount of fuel used by each tech on a typical MTT day, L/day'
total_fuel_usage_techs_Fri(techs)
total_fuel_usage_techs_Sat(techs)
total_fuel_usage_techs_Sun(techs)

total_fuel_usage_MTT           'amount of fuel used accross all techs on a typical MTT day, L/day'
total_fuel_usage_Fri
total_fuel_usage_Sat
total_fuel_usage_Sun

total_fuel_usage                'amount of fuel used accross all techs in a week, L/week'

total_fuel_usage_petrol_MTT      'amount of petrol used accross all techs on a typical MTT day, L/day'
total_fuel_usage_diesel_MTT        'amount of diesel used accross all techs on a typical MTT day, L/day'
total_fuel_usage_electricity_MTT          'amount of electricity used accross all techs on a typical MTT day, KWH/day'
total_fuel_usage_hydrogen_MTT             'amount of hydrogen used accross all techs on a typical MTT day, L/day'

total_fuel_usage_petrol_Fri
total_fuel_usage_diesel_Fri
total_fuel_usage_electricity_Fri
total_fuel_usage_hydrogen_Fri

total_fuel_usage_petrol_Sat
total_fuel_usage_diesel_Sat
total_fuel_usage_electricity_Sat
total_fuel_usage_hydrogen_Sat

total_fuel_usage_petrol_Sun
total_fuel_usage_diesel_Sun
total_fuel_usage_electricity_Sun
total_fuel_usage_hydrogen_Sun

total_carbon_emissions_petrol_MTT        'carbon emissions from petrol on a typical MTT day, kgCO2/day'
total_carbon_emissions_diesel_MTT       'carbon emissions from diesel on a typical MTT day, kgCO2/day'
total_carbon_emissions_electricity_MTT  'carbon emissions from electricity on a typical MTT day, kgCO2/day'
total_carbon_emissions_hydrogen_MTT     'carbon emissions from hydrogen on a typical MTT day, kgCO2/day'

total_carbon_emissions_petrol_Fri
total_carbon_emissions_diesel_Fri
total_carbon_emissions_electricity_Fri
total_carbon_emissions_hydrogen_Fri

total_carbon_emissions_petrol_Sat
total_carbon_emissions_diesel_Sat
total_carbon_emissions_electricity_Sat
total_carbon_emissions_hydrogen_Sat

total_carbon_emissions_petrol_Sun
total_carbon_emissions_diesel_Sun
total_carbon_emissions_electricity_Sun
total_carbon_emissions_hydrogen_Sun

;

EQUATIONS
calc_total_user_demand_MTT(h,techs)'calculate the demand for each tech that meets the capacity'
calc_spend_MTT(h,techs)
calc_total_spend_techs_MTT(techs) 'calculate the sum of all payments made for transport accross all techs in each hour'
calc_total_spend_MTT

calc_total_user_demand_Fri(h,techs)'calculate the demand for each tech that meets the capacity'
calc_spend_Fri(h,techs)
calc_total_spend_techs_Fri(techs) 'calculate the sum of all payments made for transport accross all techs in each hour'
calc_total_spend_Fri

calc_total_user_demand_Sat(h,techs)'calculate the demand for each tech that meets the capacity'
calc_spend_Sat(h,techs)
calc_total_spend_techs_Sat(techs) 'calculate the sum of all payments made for transport accross all techs in each hour'
calc_total_spend_Sat

calc_total_user_demand_Sun(h,techs)'calculate the demand for each tech that meets the capacity'
calc_spend_Sun(h,techs)
calc_total_spend_techs_Sun(techs) 'calculate the sum of all payments made for transport accross all techs in each hour'
calc_total_spend_Sun

calc_total_spend

calc_user_demand_techs_MTT(techs)
calc_user_demand_techs_Fri(techs)
calc_user_demand_techs_Sat(techs)
calc_user_demand_techs_Sun(techs)

calc_fuel_usage_MTT(fuel,techs)
calc_fuel_usage_Fri(fuel,techs)
calc_fuel_usage_Sat(fuel,techs)
calc_fuel_usage_Sun(fuel,techs)

calc_carbon_emissions_MTT(fuel,techs)
calc_carbon_emissions_Fri(fuel,techs)
calc_carbon_emissions_Sat(fuel,techs)
calc_carbon_emissions_Sun(fuel,techs)

calc_total_carbon_emissions_techs_MTT(techs)
calc_total_carbon_emissions_techs_Fri(techs)
calc_total_carbon_emissions_techs_Sat(techs)
calc_total_carbon_emissions_techs_Sun(techs)

calc_total_carbon_emissions_MTT
calc_total_carbon_emissions_Fri
calc_total_carbon_emissions_Sat
calc_total_carbon_emissions_Sun

calc_total_carbon_emissions

calc_total_fuel_usage_techs_MTT(techs)
calc_total_fuel_usage_techs_Fri(techs)
calc_total_fuel_usage_techs_Sat(techs)
calc_total_fuel_usage_techs_Sun(techs)

*calc_CEC_constraint_1
*calc_CEC_constraint_2

calc_total_fuel_usage_MTT
calc_total_fuel_usage_Fri
calc_total_fuel_usage_Sat
calc_total_fuel_usage_Sun

calc_total_fuel_usage

calc_total_fuel_usage_petrol_MTT
calc_total_fuel_usage_diesel_MTT
calc_total_fuel_usage_electricity_MTT
calc_total_fuel_usage_hydrogen_MTT

calc_total_fuel_usage_petrol_Fri
calc_total_fuel_usage_diesel_Fri
calc_total_fuel_usage_electricity_Fri
calc_total_fuel_usage_hydrogen_Fri

calc_total_fuel_usage_petrol_Sat
calc_total_fuel_usage_diesel_Sat
calc_total_fuel_usage_electricity_Sat
calc_total_fuel_usage_hydrogen_Sat

calc_total_fuel_usage_petrol_Sun
calc_total_fuel_usage_diesel_Sun
calc_total_fuel_usage_electricity_Sun
calc_total_fuel_usage_hydrogen_Sun

calc_total_carbon_emissions_petrol_MTT
calc_total_carbon_emissions_diesel_MTT
calc_total_carbon_emissions_electricity_MTT
calc_total_carbon_emissions_hydrogen_MTT

calc_total_carbon_emissions_petrol_Fri
calc_total_carbon_emissions_diesel_Fri
calc_total_carbon_emissions_electricity_Fri
calc_total_carbon_emissions_hydrogen_Fri

calc_total_carbon_emissions_petrol_Sat
calc_total_carbon_emissions_diesel_Sat
calc_total_carbon_emissions_electricity_Sat
calc_total_carbon_emissions_hydrogen_Sat

calc_total_carbon_emissions_petrol_Sun
calc_total_carbon_emissions_diesel_Sun
calc_total_carbon_emissions_electricity_Sun
calc_total_carbon_emissions_hydrogen_Sun


;

calc_total_user_demand_MTT(h,techs).. num_users_MTT(h, techs)*km_per_day(techs)=e= user_demand_MTT(h,techs);
calc_spend_MTT(h,techs).. spend_MTT(h,techs) =e= fare(h,techs)* user_demand_MTT(h,techs);
calc_total_spend_techs_MTT(techs).. total_spend_techs_MTT(techs) =e= sum(h,spend_MTT(h,techs));
calc_total_spend_MTT.. total_spend_MTT=e= sum(techs,total_spend_techs_MTT(techs));

calc_total_user_demand_Fri(h,techs).. num_users_Fri(h, techs)*km_per_day(techs)=e= user_demand_Fri(h,techs);
calc_spend_Fri(h,techs).. spend_Fri(h,techs) =e= fare(h,techs)* user_demand_Fri(h,techs);
calc_total_spend_techs_Fri(techs).. total_spend_techs_Fri(techs) =e= sum(h,spend_Fri(h,techs));
calc_total_spend_Fri.. total_spend_Fri=e= sum(techs,total_spend_techs_Fri(techs));

calc_total_user_demand_Sat(h,techs).. num_users_Sat(h, techs)*km_per_day(techs)=e= user_demand_Sat(h,techs);
calc_spend_Sat(h,techs).. spend_Sat(h,techs) =e= fare(h,techs)* user_demand_Sat(h,techs);
calc_total_spend_techs_Sat(techs).. total_spend_techs_Sat(techs) =e= sum(h,spend_Sat(h,techs));
calc_total_spend_Sat.. total_spend_Sat=e= sum(techs,total_spend_techs_Sat(techs));

calc_total_user_demand_Sun(h,techs).. num_users_Sun(h, techs)*km_per_day(techs)=e= user_demand_Sun(h,techs);
calc_spend_Sun(h,techs).. spend_Sun(h,techs) =e= fare(h,techs)* user_demand_Sun(h,techs);
calc_total_spend_techs_Sun(techs).. total_spend_techs_Sun(techs) =e= sum(h,spend_Sun(h,techs));
calc_total_spend_Sun.. total_spend_Sun=e= sum(techs,total_spend_techs_Sun(techs));

calc_total_spend.. total_spend =e= (4*total_spend_MTT) + total_spend_Fri + total_spend_Sat + total_spend_Sun;

calc_user_demand_techs_MTT(techs)..user_demand_techs_MTT(techs)=e= sum(h,user_demand_MTT(h,techs));
calc_user_demand_techs_Fri(techs)..user_demand_techs_Fri(techs)=e= sum(h,user_demand_Fri(h,techs));
calc_user_demand_techs_Sat(techs)..user_demand_techs_Sat(techs)=e= sum(h,user_demand_Sat(h,techs));
calc_user_demand_techs_Sun(techs)..user_demand_techs_Sun(techs)=e= sum(h,user_demand_Sun(h,techs));

calc_fuel_usage_MTT(fuel,techs).. fuel_usage_MTT(fuel,techs)=e= user_demand_techs_MTT(techs)* fuel_cons(fuel,techs);
calc_fuel_usage_Fri(fuel,techs).. fuel_usage_Fri(fuel,techs)=e= user_demand_techs_Fri(techs)* fuel_cons(fuel,techs);
calc_fuel_usage_Sat(fuel,techs).. fuel_usage_Sat(fuel,techs)=e= user_demand_techs_Sat(techs)* fuel_cons(fuel,techs);
calc_fuel_usage_Sun(fuel,techs).. fuel_usage_Sun(fuel,techs)=e= user_demand_techs_Sun(techs)* fuel_cons(fuel,techs);

calc_carbon_emissions_MTT(fuel,techs).. carbon_emissions_MTT(fuel, techs) =e= fuel_usage_MTT(fuel,techs)* carbon_intensity(fuel);
calc_carbon_emissions_Fri(fuel,techs).. carbon_emissions_Fri(fuel, techs) =e= fuel_usage_Fri(fuel,techs)* carbon_intensity(fuel);
calc_carbon_emissions_Sat(fuel,techs).. carbon_emissions_Sat(fuel, techs) =e= fuel_usage_Sat(fuel,techs)* carbon_intensity(fuel);
calc_carbon_emissions_Sun(fuel,techs).. carbon_emissions_Sun(fuel, techs) =e= fuel_usage_Sun(fuel,techs)* carbon_intensity(fuel);

calc_total_carbon_emissions_techs_MTT(techs).. total_carbon_emissions_techs_MTT(techs) =e= sum(fuel,carbon_emissions_MTT(fuel, techs));
calc_total_carbon_emissions_techs_Fri(techs).. total_carbon_emissions_techs_Fri(techs) =e= sum(fuel,carbon_emissions_Fri(fuel, techs));
calc_total_carbon_emissions_techs_Sat(techs).. total_carbon_emissions_techs_Sat(techs) =e= sum(fuel,carbon_emissions_Sat(fuel, techs));
calc_total_carbon_emissions_techs_Sun(techs).. total_carbon_emissions_techs_Sun(techs) =e= sum(fuel,carbon_emissions_Sun(fuel, techs));

calc_total_carbon_emissions_MTT.. total_carbon_emissions_MTT =e= sum(techs,total_carbon_emissions_techs_MTT(techs));
calc_total_carbon_emissions_Fri.. total_carbon_emissions_Fri =e= sum(techs,total_carbon_emissions_techs_Fri(techs));
calc_total_carbon_emissions_Sat.. total_carbon_emissions_Sat =e= sum(techs,total_carbon_emissions_techs_Sat(techs));
calc_total_carbon_emissions_Sun.. total_carbon_emissions_Sun =e= sum(techs,total_carbon_emissions_techs_Sun(techs));

calc_total_carbon_emissions.. total_carbon_emissions =e= (4*total_carbon_emissions_MTT) + total_carbon_emissions_Fri + total_carbon_emissions_Sat + total_carbon_emissions_Sun;

calc_total_fuel_usage_techs_MTT(techs).. total_fuel_usage_techs_MTT(techs) =e= sum(fuel,fuel_usage_MTT(fuel, techs));
calc_total_fuel_usage_techs_Fri(techs).. total_fuel_usage_techs_Fri(techs) =e= sum(fuel,fuel_usage_Fri(fuel, techs));
calc_total_fuel_usage_techs_Sat(techs).. total_fuel_usage_techs_Sat(techs) =e= sum(fuel,fuel_usage_Sat(fuel, techs));
calc_total_fuel_usage_techs_Sun(techs).. total_fuel_usage_techs_Sun(techs) =e= sum(fuel,fuel_usage_Sun(fuel, techs));

*calc_CEC_constraint_1.. total_carbon_emissions =g= 0;
*calc_CEC_constraint_2.. total_carbon_emissions =l= 2900000;

calc_total_fuel_usage_MTT.. total_fuel_usage_MTT =e= sum(techs,total_fuel_usage_techs_MTT(techs));
calc_total_fuel_usage_Fri.. total_fuel_usage_Fri =e= sum(techs,total_fuel_usage_techs_Fri(techs));
calc_total_fuel_usage_Sat.. total_fuel_usage_Sat =e= sum(techs,total_fuel_usage_techs_Sat(techs));
calc_total_fuel_usage_Sun.. total_fuel_usage_Sun =e= sum(techs,total_fuel_usage_techs_Sun(techs));

calc_total_fuel_usage.. total_fuel_usage =e= (4*total_fuel_usage_MTT) + total_fuel_usage_Fri + total_fuel_usage_Sat + total_fuel_usage_Sun;

calc_total_fuel_usage_petrol_MTT.. total_fuel_usage_petrol_MTT =e= sum(petrol_techs, total_fuel_usage_techs_MTT(petrol_techs));
calc_total_fuel_usage_diesel_MTT.. total_fuel_usage_diesel_MTT =e= sum(diesel_techs, total_fuel_usage_techs_MTT(diesel_techs));
calc_total_fuel_usage_electricity_MTT.. total_fuel_usage_electricity_MTT =e= sum(electricity_techs, total_fuel_usage_techs_MTT(electricity_techs));
calc_total_fuel_usage_hydrogen_MTT.. total_fuel_usage_hydrogen_MTT =e= sum(hydrogen_techs, total_fuel_usage_techs_MTT(hydrogen_techs));

calc_total_fuel_usage_petrol_Fri.. total_fuel_usage_petrol_Fri  =e= sum(petrol_techs, total_fuel_usage_techs_Fri(petrol_techs));
calc_total_fuel_usage_diesel_Fri.. total_fuel_usage_diesel_Fri =e= sum(diesel_techs, total_fuel_usage_techs_Fri(diesel_techs));
calc_total_fuel_usage_electricity_Fri.. total_fuel_usage_electricity_Fri  =e= sum(electricity_techs, total_fuel_usage_techs_Fri(electricity_techs));
calc_total_fuel_usage_hydrogen_Fri.. total_fuel_usage_hydrogen_Fri  =e= sum(hydrogen_techs, total_fuel_usage_techs_Fri(hydrogen_techs));

calc_total_fuel_usage_petrol_Sat.. total_fuel_usage_petrol_Sat =e= sum(petrol_techs, total_fuel_usage_techs_Sat(petrol_techs));
calc_total_fuel_usage_diesel_Sat.. total_fuel_usage_diesel_Sat =e= sum(diesel_techs, total_fuel_usage_techs_Sat(diesel_techs));
calc_total_fuel_usage_electricity_Sat.. total_fuel_usage_electricity_Sat =e= sum(electricity_techs, total_fuel_usage_techs_Sat(electricity_techs));
calc_total_fuel_usage_hydrogen_Sat.. total_fuel_usage_hydrogen_Sat =e= sum(hydrogen_techs, total_fuel_usage_techs_Sat(hydrogen_techs));

calc_total_fuel_usage_petrol_Sun.. total_fuel_usage_petrol_Sun =e= sum(petrol_techs, total_fuel_usage_techs_Sun(petrol_techs));
calc_total_fuel_usage_diesel_Sun.. total_fuel_usage_diesel_Sun =e= sum(diesel_techs, total_fuel_usage_techs_Sun(diesel_techs));
calc_total_fuel_usage_electricity_Sun.. total_fuel_usage_electricity_Sun =e= sum(electricity_techs, total_fuel_usage_techs_Sun(electricity_techs));
calc_total_fuel_usage_hydrogen_Sun.. total_fuel_usage_hydrogen_Sun =e= sum(hydrogen_techs, total_fuel_usage_techs_Sun(hydrogen_techs));

calc_total_carbon_emissions_petrol_MTT.. total_carbon_emissions_petrol_MTT =e= sum(petrol_techs, total_carbon_emissions_techs_MTT(petrol_techs));
calc_total_carbon_emissions_diesel_MTT.. total_carbon_emissions_diesel_MTT =e= sum(diesel_techs, total_carbon_emissions_techs_MTT(diesel_techs));
calc_total_carbon_emissions_electricity_MTT.. total_carbon_emissions_electricity_MTT =e= sum(electricity_techs, total_carbon_emissions_techs_MTT(electricity_techs));
calc_total_carbon_emissions_hydrogen_MTT.. total_carbon_emissions_hydrogen_MTT =e= sum(hydrogen_techs, total_carbon_emissions_techs_MTT(hydrogen_techs));

calc_total_carbon_emissions_petrol_Fri.. total_carbon_emissions_petrol_Fri  =e= sum(petrol_techs, total_carbon_emissions_techs_Fri(petrol_techs));
calc_total_carbon_emissions_diesel_Fri.. total_carbon_emissions_diesel_Fri =e= sum(diesel_techs, total_carbon_emissions_techs_Fri(diesel_techs));
calc_total_carbon_emissions_electricity_Fri.. total_carbon_emissions_electricity_Fri  =e= sum(electricity_techs, total_carbon_emissions_techs_Fri(electricity_techs));
calc_total_carbon_emissions_hydrogen_Fri.. total_carbon_emissions_hydrogen_Fri  =e= sum(hydrogen_techs, total_carbon_emissions_techs_Fri(hydrogen_techs));

calc_total_carbon_emissions_petrol_Sat.. total_carbon_emissions_petrol_Sat =e= sum(petrol_techs, total_carbon_emissions_techs_Sat(petrol_techs));
calc_total_carbon_emissions_diesel_Sat.. total_carbon_emissions_diesel_Sat =e= sum(diesel_techs, total_carbon_emissions_techs_Sat(diesel_techs));
calc_total_carbon_emissions_electricity_Sat.. total_carbon_emissions_electricity_Sat =e= sum(electricity_techs, total_carbon_emissions_techs_Sat(electricity_techs));
calc_total_carbon_emissions_hydrogen_Sat.. total_carbon_emissions_hydrogen_Sat =e= sum(hydrogen_techs, total_carbon_emissions_techs_Sat(hydrogen_techs));

calc_total_carbon_emissions_petrol_Sun.. total_carbon_emissions_petrol_Sun =e= sum(petrol_techs, total_carbon_emissions_techs_Sun(petrol_techs));
calc_total_carbon_emissions_diesel_Sun.. total_carbon_emissions_diesel_Sun =e= sum(diesel_techs, total_carbon_emissions_techs_Sun(diesel_techs));
calc_total_carbon_emissions_electricity_Sun.. total_carbon_emissions_electricity_Sun =e= sum(electricity_techs, total_carbon_emissions_techs_Sun(electricity_techs));
calc_total_carbon_emissions_hydrogen_Sun.. total_carbon_emissions_hydrogen_Sun =e= sum(hydrogen_techs, total_carbon_emissions_techs_Sun(hydrogen_techs));


Model Tso /all/;

solve Tso using lp minimising total_spend;
execute_unload "Tso_Output_NO_CEC.gdx";



























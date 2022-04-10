/*
 TODO: Create Testing Structure for both Control and Interference and normalize so crits do not matter (Make sure players don't use bleed as it is luck based [in an uncontrollable way] and thus interfers with testing)
 TODO: Provide Standard Deviation of Control and Test DPS, Mean DPS Diff Deviation Range, % Damage Increase Deviation Range
 If control deviation is maximum in the negative and test deviation is maximum in the positive it gives the maximum for the range detailing change in DPS between control and test within 1 standard deviation
 If control deviation is maximum in the positive and test deviation is maximum in the negative it gives the minimum for the range detailing change in DPS between control and test within 1 standard deviation
 (The above cases for control deviation describe adding or subtracting the standard deviation (not varience) to the actual means of both control and test and then running both through the equation detailed in line below)
 Where T = Test Mean, C = Control Mean, Ts = Test Standard Deviation, Cs = Control Standard Deviation
 (((T+Ts)-(C-Cs))/(C-Cs))*100 = Maximum Percent Increase Comparing Control and Test
 (((T-Ts)-(C+Cs))/(C+Cs))*100 = Minimum Percent Increase Comparing Control and Test
 (T+Ts)-(C-Cs) = Maximum Increase Comparing Control and Test
 (T-Ts)-(C+Cs) = Minimum Increase Comparing Control and Test
 https://www.mathsisfun.com/data/standard-deviation.html
 https://www.calculatorsoup.com/calculators/algebra/percentage-increase-calculator.php
 https://www.statisticshowto.com/combined-mean/
 */

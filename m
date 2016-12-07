From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 12/12] PM / OPP: Update Documentation to remove RCU specific bits
Date: Wed,  7 Dec 2016 16:07:50 +0530
Message-ID: <164ad6c0c6a5200eae99a7ac23554f33542f465b.1481106919.git.viresh.kumar@linaro.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1481106919.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1481106919.git.viresh.kumar@linaro.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Update OPP documentation to remove the RCU specific bits.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/power/opp.txt | 47 +++++++++++++--------------------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/Documentation/power/opp.txt b/Documentation/power/opp.txt
index c6279c2be47c..be895e32022d 100644
--- a/Documentation/power/opp.txt
+++ b/Documentation/power/opp.txt
@@ -79,22 +79,6 @@ dependent subsystems such as cpufreq are left to the discretion of the SoC
 specific framework which uses the OPP library. Similar care needs to be taken
 care to refresh the cpufreq table in cases of these operations.
 
-WARNING on OPP List locking mechanism:
--------------------------------------------------
-OPP library uses RCU for exclusivity. RCU allows the query functions to operate
-in multiple contexts and this synchronization mechanism is optimal for a read
-intensive operations on data structure as the OPP library caters to.
-
-To ensure that the data retrieved are sane, the users such as SoC framework
-should ensure that the section of code operating on OPP queries are locked
-using RCU read locks. The opp_find_freq_{exact,ceil,floor},
-opp_get_{voltage, freq, opp_count} fall into this category.
-
-opp_{add,enable,disable} are updaters which use mutex and implement it's own
-RCU locking mechanisms. These functions should *NOT* be called under RCU locks
-and other contexts that prevent blocking functions in RCU or mutex operations
-from working.
-
 2. Initial OPP List Registration
 ================================
 The SoC implementation calls dev_pm_opp_add function iteratively to add OPPs per
@@ -137,15 +121,18 @@ functions return the matching pointer representing the opp if a match is
 found, else returns error. These errors are expected to be handled by standard
 error checks such as IS_ERR() and appropriate actions taken by the caller.
 
+Callers of these functions shall call dev_pm_opp_put() after they have used the
+OPP. Otherwise the memory for the OPP will never get freed and result in
+memleak.
+
 dev_pm_opp_find_freq_exact - Search for an OPP based on an *exact* frequency and
 	availability. This function is especially useful to enable an OPP which
 	is not available by default.
 	Example: In a case when SoC framework detects a situation where a
 	higher frequency could be made available, it can use this function to
 	find the OPP prior to call the dev_pm_opp_enable to actually make it available.
-	 rcu_read_lock();
 	 opp = dev_pm_opp_find_freq_exact(dev, 1000000000, false);
-	 rcu_read_unlock();
+	 dev_pm_opp_put(opp);
 	 /* dont operate on the pointer.. just do a sanity check.. */
 	 if (IS_ERR(opp)) {
 		pr_err("frequency not disabled!\n");
@@ -163,9 +150,8 @@ dev_pm_opp_find_freq_floor - Search for an available OPP which is *at most* the
 	frequency.
 	Example: To find the highest opp for a device:
 	 freq = ULONG_MAX;
-	 rcu_read_lock();
 	 dev_pm_opp_find_freq_floor(dev, &freq);
-	 rcu_read_unlock();
+	 dev_pm_opp_put(opp);
 
 dev_pm_opp_find_freq_ceil - Search for an available OPP which is *at least* the
 	provided frequency. This function is useful while searching for a
@@ -173,17 +159,15 @@ dev_pm_opp_find_freq_ceil - Search for an available OPP which is *at least* the
 	frequency.
 	Example 1: To find the lowest opp for a device:
 	 freq = 0;
-	 rcu_read_lock();
 	 dev_pm_opp_find_freq_ceil(dev, &freq);
-	 rcu_read_unlock();
+	 dev_pm_opp_put(opp);
 	Example 2: A simplified implementation of a SoC cpufreq_driver->target:
 	 soc_cpufreq_target(..)
 	 {
 		/* Do stuff like policy checks etc. */
 		/* Find the best frequency match for the req */
-		rcu_read_lock();
 		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
-		rcu_read_unlock();
+		dev_pm_opp_put(opp);
 		if (!IS_ERR(opp))
 			soc_switch_to_freq_voltage(freq);
 		else
@@ -208,9 +192,8 @@ dev_pm_opp_enable - Make a OPP available for operation.
 	implementation might choose to do something as follows:
 	 if (cur_temp < temp_low_thresh) {
 		/* Enable 1GHz if it was disabled */
-		rcu_read_lock();
 		opp = dev_pm_opp_find_freq_exact(dev, 1000000000, false);
-		rcu_read_unlock();
+		dev_pm_opp_put(opp);
 		/* just error check */
 		if (!IS_ERR(opp))
 			ret = dev_pm_opp_enable(dev, 1000000000);
@@ -224,9 +207,8 @@ dev_pm_opp_disable - Make an OPP to be not available for operation
 	choose to do something as follows:
 	 if (cur_temp > temp_high_thresh) {
 		/* Disable 1GHz if it was enabled */
-		rcu_read_lock();
 		opp = dev_pm_opp_find_freq_exact(dev, 1000000000, true);
-		rcu_read_unlock();
+		dev_pm_opp_put(opp);
 		/* just error check */
 		if (!IS_ERR(opp))
 			ret = dev_pm_opp_disable(dev, 1000000000);
@@ -249,10 +231,9 @@ dev_pm_opp_get_voltage - Retrieve the voltage represented by the opp pointer.
 	 soc_switch_to_freq_voltage(freq)
 	 {
 		/* do things */
-		rcu_read_lock();
 		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
 		v = dev_pm_opp_get_voltage(opp);
-		rcu_read_unlock();
+		dev_pm_opp_put(opp);
 		if (v)
 			regulator_set_voltage(.., v);
 		/* do other things */
@@ -266,12 +247,11 @@ dev_pm_opp_get_freq - Retrieve the freq represented by the opp pointer.
 	 {
 		/* do things.. */
 		 max_freq = ULONG_MAX;
-		 rcu_read_lock();
 		 max_opp = dev_pm_opp_find_freq_floor(dev,&max_freq);
 		 requested_opp = dev_pm_opp_find_freq_ceil(dev,&freq);
 		 if (!IS_ERR(max_opp) && !IS_ERR(requested_opp))
 			r = soc_test_validity(max_opp, requested_opp);
-		 rcu_read_unlock();
+		 dev_pm_opp_put(max_opp);
 		/* do other things */
 	 }
 	 soc_test_validity(..)
@@ -289,7 +269,6 @@ dev_pm_opp_get_opp_count - Retrieve the number of available opps for a device
 	 soc_notify_coproc_available_frequencies()
 	 {
 		/* Do things */
-		rcu_read_lock();
 		num_available = dev_pm_opp_get_opp_count(dev);
 		speeds = kzalloc(sizeof(u32) * num_available, GFP_KERNEL);
 		/* populate the table in increasing order */
@@ -298,8 +277,8 @@ dev_pm_opp_get_opp_count - Retrieve the number of available opps for a device
 			speeds[i] = freq;
 			freq++;
 			i++;
+			dev_pm_opp_put(opp);
 		}
-		rcu_read_unlock();
 
 		soc_notify_coproc(AVAILABLE_FREQs, speeds, num_available);
 		/* Do other things */
-- 
2.7.1.410.g6faf27b

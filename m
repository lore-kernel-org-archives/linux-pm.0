From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] cpufreq: Documentation: Updates based on current code
Date: Fri,  6 Jan 2017 11:08:05 +0530
Message-ID: <907fbfb3970b8eaa1320d2d0e416d83bdceb1fbb.1483681020.git.viresh.kumar@linaro.org>
References: <f3a8d4fd3c5a632c6e118a471d44a8fd5af390c8.1483681020.git.viresh.kumar@linaro.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <f3a8d4fd3c5a632c6e118a471d44a8fd5af390c8.1483681020.git.viresh.kumar@linaro.org>
In-Reply-To: <f3a8d4fd3c5a632c6e118a471d44a8fd5af390c8.1483681020.git.viresh.kumar@linaro.org>
References: <f3a8d4fd3c5a632c6e118a471d44a8fd5af390c8.1483681020.git.viresh.kumar@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Claudio Scordino <claudio@evidence.eu.com>, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpufreq core has gone though lots of updates in recent times, but on
many occasions the documentation wasn't updated along with the code.
This patch tries to catchup the documentation with the code.

Also add Rafael and Viresh as the contributors to the documentation.

Based on a patch from Claudio Scordino.

Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/core.txt          |  24 +++--
 Documentation/cpu-freq/cpu-drivers.txt   | 177 +++++++++++++++++--------------
 Documentation/cpu-freq/cpufreq-stats.txt |  24 ++---
 Documentation/cpu-freq/governors.txt     | 117 +++++++++++---------
 Documentation/cpu-freq/index.txt         |  23 ++--
 Documentation/cpu-freq/user-guide.txt    |  60 ++++++-----
 6 files changed, 232 insertions(+), 193 deletions(-)

diff --git a/Documentation/cpu-freq/core.txt b/Documentation/cpu-freq/core.txt
index 4bc7287806de..978463a7c81e 100644
--- a/Documentation/cpu-freq/core.txt
+++ b/Documentation/cpu-freq/core.txt
@@ -8,6 +8,8 @@
 
 		    Dominik Brodowski  <linux@brodo.de>
 		     David Kimdon <dwhedon@debian.org>
+		Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+		   Viresh Kumar <viresh.kumar@linaro.org>
 
 
 
@@ -36,10 +38,11 @@ speed limits (like LCD drivers on ARM architecture). Additionally, the
 kernel "constant" loops_per_jiffy is updated on frequency changes
 here.
 
-Reference counting is done by cpufreq_get_cpu and cpufreq_put_cpu,
-which make sure that the cpufreq processor driver is correctly
-registered with the core, and will not be unloaded until
-cpufreq_put_cpu is called.
+Reference counting of the cpufreq policies is done by cpufreq_cpu_get
+and cpufreq_cpu_put, which make sure that the cpufreq driver is
+correctly registered with the core, and will not be unloaded until
+cpufreq_put_cpu is called. That also ensures that the respective cpufreq
+policy doesn't get freed while being used.
 
 2. CPUFreq notifiers
 ====================
@@ -69,18 +72,16 @@ These are notified when a new policy is intended to be set. Each
 The phase is specified in the second argument to the notifier.
 
 The third argument, a void *pointer, points to a struct cpufreq_policy
-consisting of five values: cpu, min, max, policy and max_cpu_freq. min 
-and max are the lower and upper frequencies (in kHz) of the new
-policy, policy the new policy, cpu the number of the affected CPU; and 
-max_cpu_freq the maximum supported CPU frequency. This value is given 
-for informational purposes only.
+consisting of several values, including min, max (the lower and upper
+frequencies (in kHz) of the new policy).
 
 
 2.2 CPUFreq transition notifiers
 --------------------------------
 
-These are notified twice when the CPUfreq driver switches the CPU core
-frequency and this change has any external implications.
+These are notified twice for each online CPU in the policy, when the
+CPUfreq driver switches the CPU core frequency and this change has no
+any external implications.
 
 The second argument specifies the phase - CPUFREQ_PRECHANGE or
 CPUFREQ_POSTCHANGE.
@@ -90,6 +91,7 @@ The third argument is a struct cpufreq_freqs with the following
 cpu	- number of the affected CPU
 old	- old frequency
 new	- new frequency
+flags	- flags of the cpufreq driver
 
 3. CPUFreq Table Generation with Operating Performance Point (OPP)
 ==================================================================
diff --git a/Documentation/cpu-freq/cpu-drivers.txt b/Documentation/cpu-freq/cpu-drivers.txt
index 772b94fde264..f71e6be26b83 100644
--- a/Documentation/cpu-freq/cpu-drivers.txt
+++ b/Documentation/cpu-freq/cpu-drivers.txt
@@ -9,6 +9,8 @@
 
 
 		    Dominik Brodowski  <linux@brodo.de>
+		Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+		   Viresh Kumar <viresh.kumar@linaro.org>
 
 
 
@@ -49,49 +51,65 @@ using cpufreq_register_driver()
 
 What shall this struct cpufreq_driver contain? 
 
-cpufreq_driver.name -		The name of this driver.
+ .name - The name of this driver.
 
-cpufreq_driver.init -		A pointer to the per-CPU initialization 
-				function.
+ .init - A pointer to the per-policy initialization function.
 
-cpufreq_driver.verify -		A pointer to a "verification" function.
+ .verify - A pointer to a "verification" function.
 
-cpufreq_driver.setpolicy _or_ 
-cpufreq_driver.target/
-target_index		-	See below on the differences.
+ .setpolicy _or_ .fast_switch _or_ .target _or_ .target_index - See
+ below on the differences.
 
 And optionally
 
-cpufreq_driver.exit -		A pointer to a per-CPU cleanup
-				function called during CPU_POST_DEAD
-				phase of cpu hotplug process.
+ .flags - Hints for the cpufreq core.
 
-cpufreq_driver.stop_cpu -	A pointer to a per-CPU stop function
-				called during CPU_DOWN_PREPARE phase of
-				cpu hotplug process.
+ .driver_data - cpufreq driver specific data.
 
-cpufreq_driver.resume -		A pointer to a per-CPU resume function
-				which is called with interrupts disabled
-				and _before_ the pre-suspend frequency
-				and/or policy is restored by a call to
-				->target/target_index or ->setpolicy.
+ .resolve_freq - Returns the most appropriate frequency for a target
+ frequency. Doesn't change the frequency though.
 
-cpufreq_driver.attr -		A pointer to a NULL-terminated list of
-				"struct freq_attr" which allow to
-				export values to sysfs.
+ .get_intermediate and target_intermediate - Used to switch to stable
+ frequency while changing CPU frequency.
 
-cpufreq_driver.get_intermediate
-and target_intermediate		Used to switch to stable frequency while
-				changing CPU frequency.
+ .get - Returns current frequency of the CPU.
+
+ .bios_limit - Returns HW/BIOS max frequency limitations for the CPU.
+
+ .exit - A pointer to a per-policy cleanup function called during
+ CPU_POST_DEAD phase of cpu hotplug process.
+
+ .stop_cpu - A pointer to a per-policy stop function called during
+ CPU_DOWN_PREPARE phase of cpu hotplug process.
+
+ .suspend - A pointer to a per-policy suspend function which is called
+ with interrupts disabled and _after_ the governor is stopped for the
+ policy.
+
+ .resume - A pointer to a per-policy resume function which is called
+ with interrupts disabled and _before_ the governor is started again.
+
+ .ready - A pointer to a per-policy ready function which is called after
+ the policy is fully initialized.
+
+ .attr - A pointer to a NULL-terminated list of "struct freq_attr" which
+ allow to export values to sysfs.
+
+ .boost_enabled - If set, boost frequencies are enabled.
+
+ .set_boost - A pointer to a per-policy function to enable/disable boost
+ frequencies.
 
 
 1.2 Per-CPU Initialization
 --------------------------
 
 Whenever a new CPU is registered with the device model, or after the
-cpufreq driver registers itself, the per-CPU initialization function 
-cpufreq_driver.init is called. It takes a struct cpufreq_policy
-*policy as argument. What to do now?
+cpufreq driver registers itself, the per-policy initialization function
+cpufreq_driver.init is called if no cpufreq policy existed for the CPU.
+Note that the .init() and .exit() routines are called only once for the
+policy and not for each CPU managed by the policy. It takes a struct
+cpufreq_policy *policy as argument. What to do now?
 
 If necessary, activate the CPUfreq support on your CPU.
 
@@ -117,47 +135,45 @@ policy->governor		must contain the "default policy" for
 				cpufreq_driver.setpolicy or
 				cpufreq_driver.target/target_index is called
 				with these values.
+policy->cpus			Update this with the masks of the
+				(online + offline) CPUs that do DVFS
+				along with this CPU (i.e.  that share
+				clock/voltage rails with it).
 
 For setting some of these values (cpuinfo.min[max]_freq, policy->min[max]), the
 frequency table helpers might be helpful. See the section 2 for more information
 on them.
 
-SMP systems normally have same clock source for a group of cpus. For these the
-.init() would be called only once for the first online cpu. Here the .init()
-routine must initialize policy->cpus with mask of all possible cpus (Online +
-Offline) that share the clock. Then the core would copy this mask onto
-policy->related_cpus and will reset policy->cpus to carry only online cpus.
-
 
 1.3 verify
-------------
+----------
 
 When the user decides a new policy (consisting of
 "policy,governor,min,max") shall be set, this policy must be validated
 so that incompatible values can be corrected. For verifying these
-values, a frequency table helper and/or the
-cpufreq_verify_within_limits(struct cpufreq_policy *policy, unsigned
-int min_freq, unsigned int max_freq) function might be helpful. See
-section 2 for details on frequency table helpers.
+values cpufreq_verify_within_limits(struct cpufreq_policy *policy,
+unsigned int min_freq, unsigned int max_freq) function might be helpful.
+See section 2 for details on frequency table helpers.
 
 You need to make sure that at least one valid frequency (or operating
 range) is within policy->min and policy->max. If necessary, increase
 policy->max first, and only if this is no solution, decrease policy->min.
 
 
-1.4 target/target_index or setpolicy?
-----------------------------
+1.4 target or target_index or setpolicy or fast_switch?
+-------------------------------------------------------
 
 Most cpufreq drivers or even most cpu frequency scaling algorithms 
-only allow the CPU to be set to one frequency. For these, you use the
-->target/target_index call.
+only allow the CPU frequency to be set to predefined fixed values. For
+these, you use the ->target(), ->target_index() or ->fast_switch()
+callbacks.
 
-Some cpufreq-capable processors switch the frequency between certain
-limits on their own. These shall use the ->setpolicy call
+Some cpufreq capable processors switch the frequency between certain
+limits on their own. These shall use the ->setpolicy() callback.
 
 
 1.5. target/target_index
--------------
+------------------------
 
 The target_index call has two arguments: struct cpufreq_policy *policy,
 and unsigned int index (into the exposed frequency table).
@@ -186,9 +202,20 @@ The CPUfreq driver must set the new frequency when called here. The
 Here again the frequency table helper might assist you - see section 2
 for details.
 
+1.6. fast_switch
+----------------
 
-1.6 setpolicy
----------------
+This function is used for frequency switching from scheduler's context.
+Not all drivers are expected to implement it, as sleeping from within
+this callback isn't allowed. This callback must be highly optimized to
+do switching as fast as possible.
+
+This function has two arguments: struct cpufreq_policy *policy and
+unsigned int target_frequency.
+
+
+1.7 setpolicy
+-------------
 
 The setpolicy call only takes a struct cpufreq_policy *policy as
 argument. You need to set the lower limit of the in-processor or
@@ -198,7 +225,7 @@ setting when policy->policy is CPUFREQ_POLICY_PERFORMANCE, and a
 powersaving-oriented setting when CPUFREQ_POLICY_POWERSAVE. Also check
 the reference implementation in drivers/cpufreq/longrun.c
 
-1.7 get_intermediate and target_intermediate
+1.8 get_intermediate and target_intermediate
 --------------------------------------------
 
 Only for drivers with target_index() and CPUFREQ_ASYNC_NOTIFICATION unset.
@@ -222,42 +249,36 @@ failures as core would send notifications for that.
 
 As most cpufreq processors only allow for being set to a few specific
 frequencies, a "frequency table" with some functions might assist in
-some work of the processor driver. Such a "frequency table" consists
-of an array of struct cpufreq_frequency_table entries, with any value in
-"driver_data" you want to use, and the corresponding frequency in
-"frequency". At the end of the table, you need to add a
-cpufreq_frequency_table entry with frequency set to CPUFREQ_TABLE_END. And
-if you want to skip one entry in the table, set the frequency to 
-CPUFREQ_ENTRY_INVALID. The entries don't need to be in ascending
-order.
-
-By calling cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
-					struct cpufreq_frequency_table *table);
-the cpuinfo.min_freq and cpuinfo.max_freq values are detected, and
-policy->min and policy->max are set to the same values. This is
-helpful for the per-CPU initialization stage.
-
-int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
-                                   struct cpufreq_frequency_table *table);
-assures that at least one valid frequency is within policy->min and
-policy->max, and all other criteria are met. This is helpful for the
-->verify call.
-
-int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
-                                   unsigned int target_freq,
-                                   unsigned int relation);
-
-is the corresponding frequency table helper for the ->target
-stage. Just pass the values to this function, and this function
-returns the number of the frequency table entry which contains
-the frequency the CPU shall be set to.
+some work of the processor driver. Such a "frequency table" consists of
+an array of struct cpufreq_frequency_table entries, with driver specific
+values in "driver_data", the corresponding frequency in "frequency" and
+flags set. At the end of the table, you need to add a
+cpufreq_frequency_table entry with frequency set to CPUFREQ_TABLE_END.
+And if you want to skip one entry in the table, set the frequency to
+CPUFREQ_ENTRY_INVALID. The entries don't need to be in sorted in any
+particular order, but if they are cpufreq core will do DVFS a bit
+quickly for them as search for best match is faster.
+
+By calling cpufreq_table_validate_and_show(), the cpuinfo.min_freq and
+cpuinfo.max_freq values are detected, and policy->min and policy->max
+are set to the same values. This is helpful for the per-CPU
+initialization stage.
+
+cpufreq_frequency_table_verify() assures that at least one valid
+frequency is within policy->min and policy->max, and all other criteria
+are met. This is helpful for the ->verify call.
+
+cpufreq_frequency_table_target() is the corresponding frequency table
+helper for the ->target stage. Just pass the values to this function,
+and this function returns the of the frequency table entry which
+contains the frequency the CPU shall be set to.
 
 The following macros can be used as iterators over cpufreq_frequency_table:
 
 cpufreq_for_each_entry(pos, table) - iterates over all entries of frequency
 table.
 
-cpufreq-for_each_valid_entry(pos, table) - iterates over all entries,
+cpufreq_for_each_valid_entry(pos, table) - iterates over all entries,
 excluding CPUFREQ_ENTRY_INVALID frequencies.
 Use arguments "pos" - a cpufreq_frequency_table * as a loop cursor and
 "table" - the cpufreq_frequency_table * you want to iterate over.
diff --git a/Documentation/cpu-freq/cpufreq-stats.txt b/Documentation/cpu-freq/cpufreq-stats.txt
index 3c355f6ad834..2bbe207354ed 100644
--- a/Documentation/cpu-freq/cpufreq-stats.txt
+++ b/Documentation/cpu-freq/cpufreq-stats.txt
@@ -34,10 +34,10 @@ cpufreq stats provides following statistics (explained in detail below).
 -  total_trans
 -  trans_table
 
-All the statistics will be from the time the stats driver has been inserted 
-to the time when a read of a particular statistic is done. Obviously, stats 
-driver will not have any information about the frequency transitions before
-the stats driver insertion.
+All the statistics will be from the time the stats driver has been inserted
+(or the time the stats were reset) to the time when a read of a particular
+statistic is done. Obviously, stats driver will not have any information
+about the frequency transitions before the stats driver insertion.
 
 --------------------------------------------------------------------------------
 <mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # ls -l
@@ -110,25 +110,13 @@ Config Main Menu
 		CPU Frequency scaling  --->
 			[*] CPU Frequency scaling
 			[*]   CPU frequency translation statistics
-			[*]     CPU frequency translation statistics details
 
 
 "CPU Frequency scaling" (CONFIG_CPU_FREQ) should be enabled to configure
 cpufreq-stats.
 
 "CPU frequency translation statistics" (CONFIG_CPU_FREQ_STAT) provides the
-basic statistics which includes time_in_state and total_trans.
+statistics which includes time_in_state, total_trans and trans_table.
 
-"CPU frequency translation statistics details" (CONFIG_CPU_FREQ_STAT_DETAILS)
-provides fine grained cpufreq stats by trans_table. The reason for having a
-separate config option for trans_table is:
-- trans_table goes against the traditional /sysfs rule of one value per
-  interface. It provides a whole bunch of value in a 2 dimensional matrix
-  form.
-
-Once these two options are enabled and your CPU supports cpufrequency, you
+Once this option is enabled and your CPU supports cpufrequency, you
 will be able to see the CPU frequency statistics in /sysfs.
-
-
-
-
diff --git a/Documentation/cpu-freq/governors.txt b/Documentation/cpu-freq/governors.txt
index 63eef4cca1b7..61b3184b6c24 100644
--- a/Documentation/cpu-freq/governors.txt
+++ b/Documentation/cpu-freq/governors.txt
@@ -10,6 +10,8 @@
 
 		    Dominik Brodowski  <linux@brodo.de>
             some additions and corrections by Nico Golde <nico@ngolde.de>
+		Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+		   Viresh Kumar <viresh.kumar@linaro.org>
 
 
 
@@ -28,32 +30,27 @@
 2.3  Userspace
 2.4  Ondemand
 2.5  Conservative
+2.6  Schedutil
 
 3.   The Governor Interface in the CPUfreq Core
 
+4.   References
 
 
 1. What Is A CPUFreq Governor?
 ==============================
 
 Most cpufreq drivers (except the intel_pstate and longrun) or even most
-cpu frequency scaling algorithms only offer the CPU to be set to one
-frequency. In order to offer dynamic frequency scaling, the cpufreq
-core must be able to tell these drivers of a "target frequency". So
-these specific drivers will be transformed to offer a "->target/target_index"
-call instead of the existing "->setpolicy" call. For "longrun", all
-stays the same, though.
+cpu frequency scaling algorithms only allow the CPU frequency to be set
+to predefined fixed values.  In order to offer dynamic frequency
+scaling, the cpufreq core must be able to tell these drivers of a
+"target frequency". So these specific drivers will be transformed to
+offer a "->target/target_index/fast_switch()" call instead of the
+"->setpolicy()" call. For set_policy drivers, all stays the same,
+though.
 
 How to decide what frequency within the CPUfreq policy should be used?
-That's done using "cpufreq governors". Two are already in this patch
--- they're the already existing "powersave" and "performance" which
-set the frequency statically to the lowest or highest frequency,
-respectively. At least two more such governors will be ready for
-addition in the near future, but likely many more as there are various
-different theories and models about dynamic frequency scaling
-around. Using such a generic interface as cpufreq offers to scaling
-governors, these can be tested extensively, and the best one can be
-selected for each specific use.
+That's done using "cpufreq governors".
 
 Basically, it's the following flow graph:
 
@@ -71,7 +68,7 @@ CPU can be set to switch independently	 |	   CPU can only be set
 		    /			       the limits of policy->{min,max}
 		   /			            \
 		  /				     \
-	Using the ->setpolicy call,		 Using the ->target/target_index call,
+	Using the ->setpolicy call,		 Using the ->target/target_index/fast_switch call,
 	    the limits and the			  the frequency closest
 	     "policy" is set.			  to target_freq is set.
 						  It is assured that it
@@ -109,9 +106,12 @@ directory.
 2.4 Ondemand
 ------------
 
-The CPUfreq governor "ondemand" sets the CPU depending on the
-current usage. To do this the CPU must have the capability to
-switch the frequency very quickly.
+The CPUfreq governor "ondemand" sets the CPU frequency depending on the
+current system load. Load estimation is triggered by the scheduler
+through the update_util_data->func hook; when triggered, cpufreq checks
+the CPU-usage statistics over the last period and the governor sets the
+CPU accordingly.  The CPU must have the capability to switch the
+frequency very quickly.
 
 Sysfs files:
 
@@ -207,12 +207,12 @@ switch the frequency very quickly.
 ----------------
 
 The CPUfreq governor "conservative", much like the "ondemand"
-governor, sets the CPU depending on the current usage.  It differs in
-behaviour in that it gracefully increases and decreases the CPU speed
-rather than jumping to max speed the moment there is any load on the
-CPU.  This behaviour more suitable in a battery powered environment.
-The governor is tweaked in the same manner as the "ondemand" governor
-through sysfs with the addition of:
+governor, sets the CPU frequency depending on the current usage.  It
+differs in behaviour in that it gracefully increases and decreases the
+CPU speed rather than jumping to max speed the moment there is any load
+on the CPU. This behaviour is more suitable in a battery powered
+environment.  The governor is tweaked in the same manner as the
+"ondemand" governor through sysfs with the addition of:
 
 * freq_step:
 
@@ -237,6 +237,29 @@ The governor is tweaked in the same manner as the "ondemand" governor
   decision on when to decrease the frequency while running in any speed.
   Load for frequency increase is still evaluated every sampling rate.
 
+
+2.6 Schedutil
+-------------
+
+The "schedutil" governor aims at better integration with the Linux
+kernel scheduler.  Load estimation is achieved through the scheduler's
+Per-Entity Load Tracking (PELT) mechanism, which also provides
+information about the recent load [1].  This governor currently does
+load based DVFS only for tasks managed by CFS. RT and DL scheduler tasks
+are always run at the highest frequency.  Unlike all the other
+governors, the code is located under the kernel/sched/ directory.
+
+Sysfs files:
+
+* rate_limit_us:
+
+  This contains a value in microseconds. The governor waits for
+  rate_limit_us time before reevaluating the load again, after it has
+  evaluated the load once.
+
+For an in-depth comparison with the other governors refer to [2].
+
+
 3. The Governor Interface in the CPUfreq Core
 =============================================
 
@@ -244,26 +267,10 @@ A new governor must register itself with the CPUfreq core using
 "cpufreq_register_governor". The struct cpufreq_governor, which has to
 be passed to that function, must contain the following values:
 
-governor->name -	    A unique name for this governor
-governor->governor -	    The governor callback function
-governor->owner	-	    .THIS_MODULE for the governor module (if 
-			    appropriate)
-
-The governor->governor callback is called with the current (or to-be-set)
-cpufreq_policy struct for that CPU, and an unsigned int event. The
-following events are currently defined:
-
-CPUFREQ_GOV_START:   This governor shall start its duty for the CPU
-		     policy->cpu
-CPUFREQ_GOV_STOP:    This governor shall end its duty for the CPU
-		     policy->cpu
-CPUFREQ_GOV_LIMITS:  The limits for CPU policy->cpu have changed to
-		     policy->min and policy->max.
-
-If you need other "events" externally of your driver, _only_ use the
-cpufreq_governor_l(unsigned int cpu, unsigned int event) call to the
-CPUfreq core to ensure proper locking.
+governor->name - A unique name for this governor.
+governor->owner - .THIS_MODULE for the governor module (if appropriate).
 
+plus a set of hooks to the functions implementing the governor's logic.
 
 The CPUfreq governor may call the CPU processor driver using one of
 these two functions:
@@ -277,12 +284,18 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
                                    unsigned int relation);
 
 target_freq must be within policy->min and policy->max, of course.
-What's the difference between these two functions? When your governor
-still is in a direct code path of a call to governor->governor, the
-per-CPU cpufreq lock is still held in the cpufreq core, and there's
-no need to lock it again (in fact, this would cause a deadlock). So
-use __cpufreq_driver_target only in these cases. In all other cases 
-(for example, when there's a "daemonized" function that wakes up 
-every second), use cpufreq_driver_target to lock the cpufreq per-CPU
-lock before the command is passed to the cpufreq processor driver.
+What's the difference between these two functions? When your governor is
+in a direct code path of a call to governor callbacks, like
+governor->start(), the policy->rwsem is still held in the cpufreq core,
+and there's no need to lock it again (in fact, this would cause a
+deadlock). So use __cpufreq_driver_target only in these cases. In all
+other cases (for example, when there's a "daemonized" function that
+wakes up every second), use cpufreq_driver_target to take policy->rwsem
+before the command is passed to the cpufreq driver.
+
+4. References
+=============
+
+[1] Per-entity load tracking: https://lwn.net/Articles/531853/
+[2] Improvements in CPU frequency management: https://lwn.net/Articles/682391/
 
diff --git a/Documentation/cpu-freq/index.txt b/Documentation/cpu-freq/index.txt
index dc024ab4054f..ef1d39247b05 100644
--- a/Documentation/cpu-freq/index.txt
+++ b/Documentation/cpu-freq/index.txt
@@ -18,16 +18,29 @@
 
 Documents in this directory:
 ----------------------------
+
+amd-powernow.txt -	AMD powernow driver specific file.
+
+boost.txt -		Frequency boosting support.
+
 core.txt	-	General description of the CPUFreq core and
-			of CPUFreq notifiers
+			of CPUFreq notifiers.
+
+cpu-drivers.txt -	How to implement a new cpufreq processor driver.
 
-cpu-drivers.txt -	How to implement a new cpufreq processor driver
+cpufreq-nforce2.txt -	nVidia nForce2 platform specific file.
+
+cpufreq-stats.txt -	General description of sysfs cpufreq stats.
 
 governors.txt	-	What are cpufreq governors and how to
 			implement them?
 
 index.txt	-	File index, Mailing list and Links (this document)
 
+intel-pstate.txt -	Intel pstate cpufreq driver specific file.
+
+pcc-cpufreq.txt -	PCC cpufreq driver specific file.
+
 user-guide.txt	-	User Guide to CPUFreq
 
 
@@ -35,9 +48,7 @@ Mailing List
 ------------
 There is a CPU frequency changing CVS commit and general list where
 you can report bugs, problems or submit patches. To post a message,
-send an email to linux-pm@vger.kernel.org, to subscribe go to
-http://vger.kernel.org/vger-lists.html#linux-pm and follow the
-instructions there.
+send an email to linux-pm@vger.kernel.org.
 
 Links
 -----
@@ -48,7 +59,7 @@ Links
 * http://cvs.arm.linux.org.uk/
 
 the CPUFreq Mailing list:
-* http://vger.kernel.org/vger-lists.html#cpufreq
+* http://vger.kernel.org/vger-lists.html#linux-pm
 
 Clock and voltage scaling for the SA-1100:
 * http://www.lartmaker.nl/projects/scaling
diff --git a/Documentation/cpu-freq/user-guide.txt b/Documentation/cpu-freq/user-guide.txt
index 109e97bbab77..107f6fdd7d14 100644
--- a/Documentation/cpu-freq/user-guide.txt
+++ b/Documentation/cpu-freq/user-guide.txt
@@ -18,7 +18,7 @@
 Contents:
 ---------
 1. Supported Architectures and Processors
-1.1 ARM
+1.1 ARM and ARM64
 1.2 x86
 1.3 sparc64
 1.4 ppc
@@ -37,16 +37,10 @@
 1. Supported Architectures and Processors
 =========================================
 
-1.1 ARM
--------
-
-The following ARM processors are supported by cpufreq:
-
-ARM Integrator
-ARM-SA1100
-ARM-SA1110
-Intel PXA
+1.1 ARM and ARM64
+-----------------
 
+Almost all ARM and ARM64 platforms support CPU frequency scaling.
 
 1.2 x86
 -------
@@ -69,6 +63,7 @@ Transmeta Crusoe
 Transmeta Efficeon
 VIA Cyrix 3 / C3
 various processors on some ACPI 2.0-compatible systems [*]
+And many more
 
 [*] Only if "ACPI Processor Performance States" are available
 to the ACPI<->BIOS interface.
@@ -147,10 +142,19 @@ mounted it at /sys, the cpufreq interface is located in a subdirectory
 "cpufreq" within the cpu-device directory
 (e.g. /sys/devices/system/cpu/cpu0/cpufreq/ for the first CPU).
 
+affected_cpus :			List of Online CPUs that require software
+				coordination of frequency.
+
+cpuinfo_cur_freq :		Current frequency of the CPU as obtained from
+				the hardware, in KHz. This is the frequency
+				the CPU actually runs at.
+
 cpuinfo_min_freq :		this file shows the minimum operating
 				frequency the processor can run at(in kHz) 
+
 cpuinfo_max_freq :		this file shows the maximum operating
 				frequency the processor can run at(in kHz) 
+
 cpuinfo_transition_latency	The time it takes on this CPU to
 				switch between two frequencies in nano
 				seconds. If unknown or known to be
@@ -163,25 +167,30 @@ cpuinfo_transition_latency	The time it takes on this CPU to
 				userspace daemon. Make sure to not
 				switch the frequency too often
 				resulting in performance loss.
-scaling_driver :		this file shows what cpufreq driver is
-				used to set the frequency on this CPU
+
+related_cpus :			List of Online + Offline CPUs that need software
+				coordination of frequency.
+
+scaling_available_frequencies : List of available frequencies, in KHz.
 
 scaling_available_governors :	this file shows the CPUfreq governors
 				available in this kernel. You can see the
 				currently activated governor in
 
+scaling_cur_freq :		Current frequency of the CPU as determined by
+				the governor and cpufreq core, in KHz. This is
+				the frequency the kernel thinks the CPU runs
+				at.
+
+scaling_driver :		this file shows what cpufreq driver is
+				used to set the frequency on this CPU
+
 scaling_governor,		and by "echoing" the name of another
 				governor you can change it. Please note
 				that some governors won't load - they only
 				work on some specific architectures or
 				processors.
 
-cpuinfo_cur_freq :		Current frequency of the CPU as obtained from
-				the hardware, in KHz. This is the frequency
-				the CPU actually runs at.
-
-scaling_available_frequencies : List of available frequencies, in KHz.
-
 scaling_min_freq and
 scaling_max_freq		show the current "policy limits" (in
 				kHz). By echoing new values into these
@@ -190,16 +199,11 @@ scaling_max_freq		show the current "policy limits" (in
 				first set scaling_max_freq, then
 				scaling_min_freq.
 
-affected_cpus :			List of Online CPUs that require software
-				coordination of frequency.
-
-related_cpus :			List of Online + Offline CPUs that need software
-				coordination of frequency.
-
-scaling_cur_freq :		Current frequency of the CPU as determined by
-				the governor and cpufreq core, in KHz. This is
-				the frequency the kernel thinks the CPU runs
-				at.
+scaling_setspeed		This can be read to get the currently programmed
+				value by the governor. This can be written to
+				change the current frequency for a group of
+				CPUs, represented by a policy. This is supported
+				currently only by the userspace governor.
 
 bios_limit :			If the BIOS tells the OS to limit a CPU to
 				lower frequencies, the user can read out the
-- 
2.7.1.410.g6faf27b


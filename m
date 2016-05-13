From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/5] cpufreq: Split cpufreq_governor() into simpler functions
Date: Sat, 14 May 2016 01:01:46 +0200
Message-ID: <1955096.uEWMPOTP2H@vostro.rjw.lan>
References: <10707470.yIcqGAzuFY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <10707470.yIcqGAzuFY@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The cpufreq_governor() routine is used by the cpufreq core to invoke
the current governor's ->governor() callback with appropriate arguments
and do some housekeeping related to that.  Unfortunately, the way it
mixes different governor events in one code path makes it rather hard
to follow the code.

For this reason, split cpufreq_governor() into five simpler functions
that each will handle just one specific governor event and put all of
the code related to the given event into its own function.

This change is a prerequisite for a redesign of the cpufreq governor
API that will be done subsequently.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |  115 ++++++++++++++++++++++++++++------------------
 1 file changed, 71 insertions(+), 44 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -74,19 +74,12 @@ static inline bool has_target(void)
 }
 
 /* internal prototypes */
-static int cpufreq_governor(struct cpufreq_policy *policy, unsigned int event);
 static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
+static int cpufreq_init_governor(struct cpufreq_policy *policy);
+static void cpufreq_exit_governor(struct cpufreq_policy *policy);
 static int cpufreq_start_governor(struct cpufreq_policy *policy);
-
-static inline void cpufreq_exit_governor(struct cpufreq_policy *policy)
-{
-	(void)cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
-}
-
-static inline void cpufreq_stop_governor(struct cpufreq_policy *policy)
-{
-	(void)cpufreq_governor(policy, CPUFREQ_GOV_STOP);
-}
+static void cpufreq_stop_governor(struct cpufreq_policy *policy);
+static void cpufreq_governor_limits(struct cpufreq_policy *policy);
 
 /**
  * Two notifier lists: the "policy" list is involved in the
@@ -1997,7 +1990,7 @@ __weak struct cpufreq_governor *cpufreq_
 	return NULL;
 }
 
-static int cpufreq_governor(struct cpufreq_policy *policy, unsigned int event)
+static int cpufreq_init_governor(struct cpufreq_policy *policy)
 {
 	int ret;
 
@@ -2011,57 +2004,91 @@ static int cpufreq_governor(struct cpufr
 	if (!policy->governor)
 		return -EINVAL;
 
-	if (event == CPUFREQ_GOV_POLICY_INIT) {
-		if (policy->governor->max_transition_latency &&
-		    policy->cpuinfo.transition_latency >
-		    policy->governor->max_transition_latency) {
-			struct cpufreq_governor *gov = cpufreq_fallback_governor();
-
-			if (gov) {
-				pr_warn("%s governor failed, too long transition latency of HW, fallback to %s governor\n",
-					policy->governor->name, gov->name);
-				policy->governor = gov;
-			} else {
-				return -EINVAL;
-			}
-		}
-
-		if (!try_module_get(policy->governor->owner))
+	if (policy->governor->max_transition_latency &&
+	    policy->cpuinfo.transition_latency >
+	    policy->governor->max_transition_latency) {
+		struct cpufreq_governor *gov = cpufreq_fallback_governor();
+
+		if (gov) {
+			pr_warn("%s governor failed, too long transition latency of HW, fallback to %s governor\n",
+				policy->governor->name, gov->name);
+			policy->governor = gov;
+		} else {
 			return -EINVAL;
+		}
 	}
 
-	pr_debug("%s: for CPU %u, event %u\n", __func__, policy->cpu, event);
+	if (!try_module_get(policy->governor->owner))
+		return -EINVAL;
 
-	ret = policy->governor->governor(policy, event);
+	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
 
-	if (event == CPUFREQ_GOV_POLICY_INIT) {
-		if (ret)
-			module_put(policy->governor->owner);
-		else
-			policy->governor->initialized++;
-	} else if (event == CPUFREQ_GOV_POLICY_EXIT) {
-		policy->governor->initialized--;
+	ret = policy->governor->governor(policy, CPUFREQ_GOV_POLICY_INIT);
+	if (ret) {
 		module_put(policy->governor->owner);
+		return ret;
 	}
 
-	return ret;
+	policy->governor->initialized++;
+	return 0;
+}
+
+static void cpufreq_exit_governor(struct cpufreq_policy *policy)
+{
+	if (cpufreq_suspended || !policy->governor)
+		return;
+
+	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
+
+	policy->governor->governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+
+	policy->governor->initialized--;
+	module_put(policy->governor->owner);
 }
 
 static int cpufreq_start_governor(struct cpufreq_policy *policy)
 {
 	int ret;
 
+	if (cpufreq_suspended)
+		return 0;
+
+	if (!policy->governor)
+		return -EINVAL;
+
+	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
+
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy)
 		cpufreq_update_current_freq(policy);
 
-	ret = cpufreq_governor(policy, CPUFREQ_GOV_START);
+	ret = policy->governor->governor(policy, CPUFREQ_GOV_START);
 	if (ret)
 		return ret;
 
-	cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+	policy->governor->governor(policy, CPUFREQ_GOV_LIMITS);
 	return 0;
 }
 
+static void cpufreq_stop_governor(struct cpufreq_policy *policy)
+{
+	if (cpufreq_suspended || !policy->governor)
+		return;
+
+	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
+
+	policy->governor->governor(policy, CPUFREQ_GOV_STOP);
+}
+
+static void cpufreq_governor_limits(struct cpufreq_policy *policy)
+{
+	if (cpufreq_suspended || !policy->governor)
+		return;
+
+	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
+
+	policy->governor->governor(policy, CPUFREQ_GOV_LIMITS);
+}
+
 int cpufreq_register_governor(struct cpufreq_governor *governor)
 {
 	int err;
@@ -2200,7 +2227,7 @@ static int cpufreq_set_policy(struct cpu
 
 	if (new_policy->governor == policy->governor) {
 		pr_debug("cpufreq: governor limits update\n");
-		cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+		cpufreq_governor_limits(policy);
 		return 0;
 	}
 
@@ -2216,7 +2243,7 @@ static int cpufreq_set_policy(struct cpu
 
 	/* start new governor */
 	policy->governor = new_policy->governor;
-	ret = cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT);
+	ret = cpufreq_init_governor(policy);
 	if (!ret) {
 		ret = cpufreq_start_governor(policy);
 		if (!ret) {
@@ -2230,7 +2257,7 @@ static int cpufreq_set_policy(struct cpu
 	pr_debug("starting governor %s failed\n", policy->governor->name);
 	if (old_gov) {
 		policy->governor = old_gov;
-		if (cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))
+		if (cpufreq_init_governor(policy))
 			policy->governor = NULL;
 		else
 			cpufreq_start_governor(policy);
@@ -2328,7 +2355,7 @@ static int cpufreq_boost_set_sw(int stat
 
 			down_write(&policy->rwsem);
 			policy->user_policy.max = policy->max;
-			cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+			cpufreq_governor_limits(policy);
 			up_write(&policy->rwsem);
 		}
 	}

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Call cpufreq_disable_fast_switch() in sugov_exit()
Date: Thu, 07 Apr 2016 23:38:46 +0200
Message-ID: <2791888.n2Juh7mFmz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61730 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752883AbcDGVgP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 17:36:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Due to differences in the cpufreq core's handling of runtime CPU
offline and nonboot CPUs disabling during system suspend-to-RAM,
fast frequency switching gets disabled after a suspend-to-RAM and
resume cycle on all of the nonboot CPUs.

To prevent that from happening, move the invocation of
cpufreq_disable_fast_switch() from cpufreq_exit_governor() to
sugov_exit(), as the schedutil governor is the only user of fast
frequency switching today anyway.

That simply prevents cpufreq_disable_fast_switch() from being called
without invoking the ->governor callback for the CPUFREQ_GOV_POLICY_EXIT
event (which happens during system suspend now).

Fixes: b7898fda5bc7 (cpufreq: Support for fast frequency switching)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of linux-next.

---
 drivers/cpufreq/cpufreq.c        |   19 +++++++++++--------
 include/linux/cpufreq.h          |    1 +
 kernel/sched/cpufreq_schedutil.c |    2 ++
 3 files changed, 14 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -77,7 +77,11 @@ static inline bool has_target(void)
 static int cpufreq_governor(struct cpufreq_policy *policy, unsigned int event);
 static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
 static int cpufreq_start_governor(struct cpufreq_policy *policy);
-static int cpufreq_exit_governor(struct cpufreq_policy *policy);
+
+static inline int cpufreq_exit_governor(struct cpufreq_policy *policy)
+{
+	return cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+}
 
 /**
  * Two notifier lists: the "policy" list is involved in the
@@ -482,7 +486,11 @@ void cpufreq_enable_fast_switch(struct c
 }
 EXPORT_SYMBOL_GPL(cpufreq_enable_fast_switch);
 
-static void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
+/**
+ * cpufreq_disable_fast_switch - Disable fast frequency switching for policy.
+ * @policy: cpufreq policy to disable fast frequency switching for.
+ */
+void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
 {
 	mutex_lock(&cpufreq_fast_switch_lock);
 	if (policy->fast_switch_enabled) {
@@ -492,6 +500,7 @@ static void cpufreq_disable_fast_switch(
 	}
 	mutex_unlock(&cpufreq_fast_switch_lock);
 }
+EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 
 /*********************************************************************
  *                          SYSFS INTERFACE                          *
@@ -2060,12 +2069,6 @@ static int cpufreq_start_governor(struct
 	return ret ? ret : cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 }
 
-static int cpufreq_exit_governor(struct cpufreq_policy *policy)
-{
-	cpufreq_disable_fast_switch(policy);
-	return cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
-}
-
 int cpufreq_register_governor(struct cpufreq_governor *governor)
 {
 	int err;
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -168,6 +168,7 @@ int cpufreq_update_policy(unsigned int c
 bool have_governor_per_policy(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
+void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
 #else
 static inline unsigned int cpufreq_get(unsigned int cpu)
 {
Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -398,6 +398,8 @@ static int sugov_exit(struct cpufreq_pol
 	struct sugov_tunables *tunables = sg_policy->tunables;
 	unsigned int count;
 
+	cpufreq_disable_fast_switch(policy);
+
 	mutex_lock(&global_tunables_lock);
 
 	count = gov_attr_set_put(&tunables->attr_set, &sg_policy->tunables_hook);


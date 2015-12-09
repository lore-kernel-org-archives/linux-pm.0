From: Thomas Renninger <trenn@suse.de>
Subject: cpufreq: [RFC] Create intel_pstate specific governors template
Date: Wed, 09 Dec 2015 19:41:03 +0100
Message-ID: <1602202.sddj3DAuML@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35919 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786AbbLISlH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Dec 2015 13:41:07 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, Philippe Longepe <philippe.longepe@linux.intel.com>

This is about recently posted:

[PATCH v2 0/4] cpufreq governors and Intel P state driver compatibility
and
[PATCH V6 0/3] cpufreq: intel_pstate: account non C0 time

Below patch tries to bring above needs together.

We have different algorithms to find the target frequency depending on
user needs and workload with the latter patchset.

These are called governors or policies in the kernel cpufreq subsystem.

Below patch is a quick write-down and compile tested only.
It still has to be filled with the different new algorithms introduced via:
[PATCH V6 0/3] cpufreq: intel_pstate: account non C0 time

and then still be enhanced with ACPI pm_profile default settings
(but this is easy, simply chose the right governor for each platform).

No idea whether this works at all, but it should?
What do you think?

--------------------------------
cpufreq: [RFC] Create intel_pstate specific governors template

intel_pstate driver chose the way to implement it's own policy.
It came out that one algorithm doesn't fit all platform requirements.
Users have different needs depending on their workload, etc.

To be at least somewhat compatible with other cpufreq drivers and the whole
cpufreq subsystem, make use of self defined cpufreq governors.

Intel pstate driver will define its own governors (and some default ones like
performance and powersave) for laptop, tablet or whatever specific platform
and workload needs.

By switching governors, also tuning knobs (params) which have been CPU model
specific will be set. Like this there will not be any CPU id specific defaults
or optimizations anymore, only workload (platform policy, governor) specific
settings and algorithms.

Signed-off-by: Thomas Renninger <trenn@suse.com>


diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3af9dd7..5a1e5fe 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -169,6 +169,37 @@ static struct perf_limits limits = {
 	.min_sysfs_pct = 0,
 };
 
+static void (*intel_pstate_governor_func) (struct cpudata *cpu);
+
+static void intel_pstate_server_func(struct cpudata *cpu);
+
+/* Governor templates */
+#define create_governor(__GOV)						\
+static int cpufreq_governor_laptop(struct cpufreq_policy *policy,	\
+					unsigned int event)		\
+{									\
+	switch (event) {						\
+	case CPUFREQ_GOV_START:						\
+		pr_debug("Switching to ##__GOV pstate governor");	\
+		add_timer_on(&all_cpu_data[policy->cpu]->timer, policy->cpu); \
+	break;								\
+	case CPUFREQ_GOV_STOP:						\
+		del_timer_sync(&all_cpu_data[policy->cpu]->timer);	\
+		break;							\
+	default:							\
+		break;							\
+	}								\
+	return 0;							\
+}									\
+									\
+static struct cpufreq_governor cpufreq_gov_##__GOV = {			\
+	.name		= "##__GOV",					\
+	.governor	= cpufreq_governor_##__GOV,			\
+	.owner		= THIS_MODULE,					\
+};
+
+create_governor(laptop)
+
 static inline void pid_reset(struct _pid *pid, int setpoint, int busy,
 			     int deadband, int integral) {
 	pid->setpoint = setpoint;
@@ -852,7 +883,7 @@ static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
 	return core_busy;
 }
 
-static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
+static void intel_pstate_server_func(struct cpudata *cpu)
 {
 	int32_t busy_scaled;
 	struct _pid *pid;
@@ -895,7 +926,8 @@ static void intel_pstate_timer_func(unsigned long __data)
 
 	intel_pstate_sample(cpu);
 
-	intel_pstate_adjust_busy_pstate(cpu);
+	intel_pstate_governor_func(cpu);
+	//	intel_pstate_adjust_busy_pstate(cpu);
 
 	intel_pstate_set_sample_time(cpu);
 }
@@ -1265,6 +1297,12 @@ static int __init intel_pstate_init(void)
 	if (intel_pstate_msrs_not_valid())
 		return -ENODEV;
 
+	pr_info("Initializing intel pstate specific governors.\n");
+
+	intel_pstate_governor_func = intel_pstate_server_func;
+
+	cpufreq_register_governor(&cpufreq_gov_laptop);
+
 	pr_info("Intel P-state driver initializing.\n");
 
 	all_cpu_data = vzalloc(sizeof(void *) * num_possible_cpus());


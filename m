From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/11] cpufreq: Clean up default and fallback governor setup
Date: Thu, 04 Feb 2016 00:14:34 +0100
Message-ID: <8241294.RLKfcoktTC@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3705929.bslqXH980s@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The preprocessor magic used for setting the default cpufreq governor
(and for using the performance governor as a fallback one for that
matter) is really nasty, so replace it with __weak functions and
overrides.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c              |   37 ++++++++++++++++++---------------
 drivers/cpufreq/cpufreq_conservative.c |   10 +++++---
 drivers/cpufreq/cpufreq_ondemand.c     |   34 ++++++++++++++++--------------
 drivers/cpufreq/cpufreq_performance.c  |   18 ++++++++++++----
 drivers/cpufreq/cpufreq_powersave.c    |   10 +++++---
 drivers/cpufreq/cpufreq_userspace.c    |   10 +++++---
 include/linux/cpufreq.h                |   25 +---------------------
 7 files changed, 73 insertions(+), 71 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1003,6 +1003,11 @@ static int cpufreq_add_dev_interface(str
 	return cpufreq_add_dev_symlink(policy);
 }
 
+__weak struct cpufreq_governor *cpufreq_default_governor(void)
+{
+	return NULL;
+}
+
 static int cpufreq_init_policy(struct cpufreq_policy *policy)
 {
 	struct cpufreq_governor *gov = NULL;
@@ -1012,11 +1017,14 @@ static int cpufreq_init_policy(struct cp
 
 	/* Update governor of new_policy to the governor used before hotplug */
 	gov = find_governor(policy->last_governor);
-	if (gov)
+	if (gov) {
 		pr_debug("Restoring governor %s for cpu %d\n",
 				policy->governor->name, policy->cpu);
-	else
-		gov = CPUFREQ_DEFAULT_GOVERNOR;
+	} else {
+		gov = cpufreq_default_governor();
+		if (!gov)
+			return -ENODATA;
+	}
 
 	new_policy.governor = gov;
 
@@ -1964,21 +1972,16 @@ int cpufreq_driver_target(struct cpufreq
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_target);
 
+__weak struct cpufreq_governor *cpufreq_fallback_governor(void)
+{
+	return NULL;
+}
+
 static int __cpufreq_governor(struct cpufreq_policy *policy,
 					unsigned int event)
 {
 	int ret;
 
-	/* Only must be defined when default governor is known to have latency
-	   restrictions, like e.g. conservative or ondemand.
-	   That this is the case is already ensured in Kconfig
-	*/
-#ifdef CONFIG_CPU_FREQ_GOV_PERFORMANCE
-	struct cpufreq_governor *gov = &cpufreq_gov_performance;
-#else
-	struct cpufreq_governor *gov = NULL;
-#endif
-
 	/* Don't start any governor operations if we are entering suspend */
 	if (cpufreq_suspended)
 		return 0;
@@ -1992,12 +1995,14 @@ static int __cpufreq_governor(struct cpu
 	if (policy->governor->max_transition_latency &&
 	    policy->cpuinfo.transition_latency >
 	    policy->governor->max_transition_latency) {
-		if (!gov)
-			return -EINVAL;
-		else {
+		struct cpufreq_governor *gov = cpufreq_fallback_governor();
+
+		if (gov) {
 			pr_warn("%s governor failed, too long transition latency of HW, fallback to %s governor\n",
 				policy->governor->name, gov->name);
 			policy->governor = gov;
+		} else {
+			return -EINVAL;
 		}
 	}
 
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -26,10 +26,7 @@ static DEFINE_PER_CPU(struct cs_cpu_dbs_
 static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
 				   unsigned int event);
 
-#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
-static
-#endif
-struct cpufreq_governor cpufreq_gov_conservative = {
+static struct cpufreq_governor cpufreq_gov_conservative = {
 	.name			= "conservative",
 	.governor		= cs_cpufreq_governor_dbs,
 	.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
@@ -397,6 +394,11 @@ MODULE_DESCRIPTION("'cpufreq_conservativ
 MODULE_LICENSE("GPL");
 
 #ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
+struct cpufreq_governor *cpufreq_default_governor(void)
+{
+	return &cpufreq_gov_conservative;
+}
+
 fs_initcall(cpufreq_gov_dbs_init);
 #else
 module_init(cpufreq_gov_dbs_init);
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -471,29 +471,8 @@ int __cpufreq_driver_target(struct cpufr
 int cpufreq_register_governor(struct cpufreq_governor *governor);
 void cpufreq_unregister_governor(struct cpufreq_governor *governor);
 
-/* CPUFREQ DEFAULT GOVERNOR */
-/*
- * Performance governor is fallback governor if any other gov failed to auto
- * load due latency restrictions
- */
-#ifdef CONFIG_CPU_FREQ_GOV_PERFORMANCE
-extern struct cpufreq_governor cpufreq_gov_performance;
-#endif
-#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
-#define CPUFREQ_DEFAULT_GOVERNOR	(&cpufreq_gov_performance)
-#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE)
-extern struct cpufreq_governor cpufreq_gov_powersave;
-#define CPUFREQ_DEFAULT_GOVERNOR	(&cpufreq_gov_powersave)
-#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE)
-extern struct cpufreq_governor cpufreq_gov_userspace;
-#define CPUFREQ_DEFAULT_GOVERNOR	(&cpufreq_gov_userspace)
-#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND)
-extern struct cpufreq_governor cpufreq_gov_ondemand;
-#define CPUFREQ_DEFAULT_GOVERNOR	(&cpufreq_gov_ondemand)
-#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE)
-extern struct cpufreq_governor cpufreq_gov_conservative;
-#define CPUFREQ_DEFAULT_GOVERNOR	(&cpufreq_gov_conservative)
-#endif
+struct cpufreq_governor *cpufreq_default_governor(void);
+struct cpufreq_governor *cpufreq_fallback_governor(void);
 
 /*********************************************************************
  *                     FREQUENCY TABLE HELPERS                       *
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -553,6 +553,19 @@ static struct common_dbs_data od_dbs_cda
 	.mutex = __MUTEX_INITIALIZER(od_dbs_cdata.mutex),
 };
 
+static int od_cpufreq_governor_dbs(struct cpufreq_policy *policy,
+		unsigned int event)
+{
+	return cpufreq_governor_dbs(policy, &od_dbs_cdata, event);
+}
+
+static struct cpufreq_governor cpufreq_gov_ondemand = {
+	.name			= "ondemand",
+	.governor		= od_cpufreq_governor_dbs,
+	.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
+	.owner			= THIS_MODULE,
+};
+
 static void od_set_powersave_bias(unsigned int powersave_bias)
 {
 	struct cpufreq_policy *policy;
@@ -604,22 +617,6 @@ void od_unregister_powersave_bias_handle
 }
 EXPORT_SYMBOL_GPL(od_unregister_powersave_bias_handler);
 
-static int od_cpufreq_governor_dbs(struct cpufreq_policy *policy,
-		unsigned int event)
-{
-	return cpufreq_governor_dbs(policy, &od_dbs_cdata, event);
-}
-
-#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
-static
-#endif
-struct cpufreq_governor cpufreq_gov_ondemand = {
-	.name			= "ondemand",
-	.governor		= od_cpufreq_governor_dbs,
-	.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
-	.owner			= THIS_MODULE,
-};
-
 static int __init cpufreq_gov_dbs_init(void)
 {
 	return cpufreq_register_governor(&cpufreq_gov_ondemand);
@@ -637,6 +634,11 @@ MODULE_DESCRIPTION("'cpufreq_ondemand' -
 MODULE_LICENSE("GPL");
 
 #ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
+struct cpufreq_governor *cpufreq_default_governor(void)
+{
+	return &cpufreq_gov_ondemand;
+}
+
 fs_initcall(cpufreq_gov_dbs_init);
 #else
 module_init(cpufreq_gov_dbs_init);
Index: linux-pm/drivers/cpufreq/cpufreq_performance.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_performance.c
+++ linux-pm/drivers/cpufreq/cpufreq_performance.c
@@ -33,10 +33,7 @@ static int cpufreq_governor_performance(
 	return 0;
 }
 
-#ifdef CONFIG_CPU_FREQ_GOV_PERFORMANCE_MODULE
-static
-#endif
-struct cpufreq_governor cpufreq_gov_performance = {
+static struct cpufreq_governor cpufreq_gov_performance = {
 	.name		= "performance",
 	.governor	= cpufreq_governor_performance,
 	.owner		= THIS_MODULE,
@@ -52,6 +49,19 @@ static void __exit cpufreq_gov_performan
 	cpufreq_unregister_governor(&cpufreq_gov_performance);
 }
 
+#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
+struct cpufreq_governor *cpufreq_default_governor(void)
+{
+	return &cpufreq_gov_performance;
+}
+#endif
+#ifndef CONFIG_CPU_FREQ_GOV_PERFORMANCE_MODULE
+struct cpufreq_governor *cpufreq_fallback_governor(void)
+{
+	return &cpufreq_gov_performance;
+}
+#endif
+
 MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("CPUfreq policy governor 'performance'");
 MODULE_LICENSE("GPL");
Index: linux-pm/drivers/cpufreq/cpufreq_powersave.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_powersave.c
+++ linux-pm/drivers/cpufreq/cpufreq_powersave.c
@@ -33,10 +33,7 @@ static int cpufreq_governor_powersave(st
 	return 0;
 }
 
-#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE
-static
-#endif
-struct cpufreq_governor cpufreq_gov_powersave = {
+static struct cpufreq_governor cpufreq_gov_powersave = {
 	.name		= "powersave",
 	.governor	= cpufreq_governor_powersave,
 	.owner		= THIS_MODULE,
@@ -57,6 +54,11 @@ MODULE_DESCRIPTION("CPUfreq policy gover
 MODULE_LICENSE("GPL");
 
 #ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE
+struct cpufreq_governor *cpufreq_default_governor(void)
+{
+	return &cpufreq_gov_powersave;
+}
+
 fs_initcall(cpufreq_gov_powersave_init);
 #else
 module_init(cpufreq_gov_powersave_init);
Index: linux-pm/drivers/cpufreq/cpufreq_userspace.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_userspace.c
+++ linux-pm/drivers/cpufreq/cpufreq_userspace.c
@@ -89,10 +89,7 @@ static int cpufreq_governor_userspace(st
 	return rc;
 }
 
-#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE
-static
-#endif
-struct cpufreq_governor cpufreq_gov_userspace = {
+static struct cpufreq_governor cpufreq_gov_userspace = {
 	.name		= "userspace",
 	.governor	= cpufreq_governor_userspace,
 	.store_setspeed	= cpufreq_set,
@@ -116,6 +113,11 @@ MODULE_DESCRIPTION("CPUfreq policy gover
 MODULE_LICENSE("GPL");
 
 #ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE
+struct cpufreq_governor *cpufreq_default_governor(void)
+{
+	return &cpufreq_gov_userspace;
+}
+
 fs_initcall(cpufreq_gov_userspace_init);
 #else
 module_init(cpufreq_gov_userspace_init);

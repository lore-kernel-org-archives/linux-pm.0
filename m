From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/6] cpufreq: Remove (now) unused code related to max_transition_latency
Date: Thu, 29 Jun 2017 16:29:05 +0530
Message-ID: <85a18d35c119cf444aeec43a828efddb2ce0e4e1.1498733506.git.viresh.kumar@linaro.org>
References: <cover.1498733506.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1498733506.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1498733506.git.viresh.kumar@linaro.org>
References: <cover.1498733506.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Get rid of the now unused code after the only user of
max_transition_latency is gone.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c             | 5 -----
 drivers/cpufreq/cpufreq_governor.h    | 1 -
 drivers/cpufreq/cpufreq_performance.c | 6 ------
 include/linux/cpufreq.h               | 5 -----
 4 files changed, 17 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 34dbbf3122c8..0508b62c6f9b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1969,11 +1969,6 @@ int cpufreq_driver_target(struct cpufreq_policy *policy,
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_target);
 
-__weak struct cpufreq_governor *cpufreq_fallback_governor(void)
-{
-	return NULL;
-}
-
 static int cpufreq_init_governor(struct cpufreq_policy *policy)
 {
 	int ret;
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 0236ec2cd654..7cbb07512e4c 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -160,7 +160,6 @@ void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy);
 #define CPUFREQ_DBS_GOVERNOR_INITIALIZER(_name_)			\
 	{								\
 		.name = _name_,						\
-		.max_transition_latency	= TRANSITION_LATENCY_LIMIT,	\
 		.owner = THIS_MODULE,					\
 		.init = cpufreq_dbs_governor_init,			\
 		.exit = cpufreq_dbs_governor_exit,			\
diff --git a/drivers/cpufreq/cpufreq_performance.c b/drivers/cpufreq/cpufreq_performance.c
index dafb679adc58..73bc6c28b956 100644
--- a/drivers/cpufreq/cpufreq_performance.c
+++ b/drivers/cpufreq/cpufreq_performance.c
@@ -44,12 +44,6 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return &cpufreq_gov_performance;
 }
 #endif
-#ifndef CONFIG_CPU_FREQ_GOV_PERFORMANCE_MODULE
-struct cpufreq_governor *cpufreq_fallback_governor(void)
-{
-	return &cpufreq_gov_performance;
-}
-#endif
 
 MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("CPUfreq policy governor 'performance'");
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 0818bdc3ebf2..54dfa1bdf138 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -491,7 +491,6 @@ static inline unsigned long cpufreq_scale(unsigned long old, u_int div,
 #define MIN_SAMPLING_RATE_RATIO		(2)
 #define LATENCY_MULTIPLIER		(1000)
 #define MIN_LATENCY_MULTIPLIER		(20)
-#define TRANSITION_LATENCY_LIMIT	(10 * 1000 * 1000)
 
 struct cpufreq_governor {
 	char	name[CPUFREQ_NAME_LEN];
@@ -504,9 +503,6 @@ struct cpufreq_governor {
 					 char *buf);
 	int	(*store_setspeed)	(struct cpufreq_policy *policy,
 					 unsigned int freq);
-	unsigned int max_transition_latency; /* HW must be able to switch to
-			next freq faster than this value in nano secs or we
-			will fallback to performance governor */
 	struct list_head	governor_list;
 	struct module		*owner;
 };
@@ -526,7 +522,6 @@ int cpufreq_register_governor(struct cpufreq_governor *governor);
 void cpufreq_unregister_governor(struct cpufreq_governor *governor);
 
 struct cpufreq_governor *cpufreq_default_governor(void);
-struct cpufreq_governor *cpufreq_fallback_governor(void);
 
 static inline void cpufreq_policy_apply_limits(struct cpufreq_policy *policy)
 {
-- 
2.13.0.71.gd7076ec9c9cb

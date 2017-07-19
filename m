From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 6/9] cpufreq: Replace "max_transition_latency" with "dynamic_switching"
Date: Wed, 19 Jul 2017 15:42:46 +0530
Message-ID: <bfc8e65169905be7218a26ace5623c5789755dea.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There is no limitation in the ondemand or conservative governors which
disallow the transition_latency to be greater than 10 ms.

The max_transition_latency field is rather used to disallow automatic
dynamic frequency switching for platforms which didn't wanted these
governors to run.

Replace max_transition_latency with a boolean (dynamic_switching) and
check for transition_latency == CPUFREQ_ETERNAL along with that. This
makes it pretty straight forward to read/understand now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c          | 8 ++++----
 drivers/cpufreq/cpufreq_governor.h | 2 +-
 include/linux/cpufreq.h            | 9 ++-------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d00cde871c15..2debfb5f9126 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2014,13 +2014,13 @@ static int cpufreq_init_governor(struct cpufreq_policy *policy)
 	if (!policy->governor)
 		return -EINVAL;
 
-	if (policy->governor->max_transition_latency &&
-	    policy->cpuinfo.transition_latency >
-	    policy->governor->max_transition_latency) {
+	/* Platform doesn't want dynamic frequency switching ? */
+	if (policy->governor->dynamic_switching &&
+	    policy->cpuinfo.transition_latency == CPUFREQ_ETERNAL) {
 		struct cpufreq_governor *gov = cpufreq_fallback_governor();
 
 		if (gov) {
-			pr_warn("%s governor failed, too long transition latency of HW, fallback to %s governor\n",
+			pr_warn("Transition latency set to CPUFREQ_ETERNAL, can't use %s governor. Fallback to %s governor\n",
 				policy->governor->name, gov->name);
 			policy->governor = gov;
 		} else {
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 95f207eb820e..8463f5def0f5 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -159,7 +159,7 @@ void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy);
 #define CPUFREQ_DBS_GOVERNOR_INITIALIZER(_name_)			\
 	{								\
 		.name = _name_,						\
-		.max_transition_latency	= TRANSITION_LATENCY_LIMIT,	\
+		.dynamic_switching = true,				\
 		.owner = THIS_MODULE,					\
 		.init = cpufreq_dbs_governor_init,			\
 		.exit = cpufreq_dbs_governor_exit,			\
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index aaadfc543f63..e141dbbb9d1c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -487,12 +487,8 @@ static inline unsigned long cpufreq_scale(unsigned long old, u_int div,
  * polling frequency is 1000 times the transition latency of the processor. The
  * ondemand governor will work on any processor with transition latency <= 10ms,
  * using appropriate sampling rate.
- *
- * For CPUs with transition latency > 10ms (mostly drivers with CPUFREQ_ETERNAL)
- * the ondemand governor will not work. All times here are in us (microseconds).
  */
 #define LATENCY_MULTIPLIER		(1000)
-#define TRANSITION_LATENCY_LIMIT	(10 * 1000 * 1000)
 
 struct cpufreq_governor {
 	char	name[CPUFREQ_NAME_LEN];
@@ -505,9 +501,8 @@ struct cpufreq_governor {
 					 char *buf);
 	int	(*store_setspeed)	(struct cpufreq_policy *policy,
 					 unsigned int freq);
-	unsigned int max_transition_latency; /* HW must be able to switch to
-			next freq faster than this value in nano secs or we
-			will fallback to performance governor */
+	/* For governors which change frequency dynamically by themselves */
+	bool			dynamic_switching;
 	struct list_head	governor_list;
 	struct module		*owner;
 };
-- 
2.13.0.71.gd7076ec9c9cb

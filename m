From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 5/9] cpufreq: governor: Get rid of the ->gov_check_cpu callback
Date: Mon, 15 Feb 2016 02:19:31 +0100
Message-ID: <9111131.hox2j3ReJb@vostro.rjw.lan>
References: <3329748.lhJgppdTt9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54972 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751551AbcBOBVN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Feb 2016 20:21:13 -0500
In-Reply-To: <3329748.lhJgppdTt9@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The way the ->gov_check_cpu governor callback is used by the ondemand
and conservative governors is not really straightforward.  Namely, the
governor calls dbs_check_cpu() that updates the load information for
the policy and the invokes ->gov_check_cpu() for the governor.

To get rid of that entanglement, notice that cpufreq_governor_limits()
doesn't need to call dbs_check_cpu() directly.  Instead, it can simply
reset the sample delay to 0 which will cause a sample to be taken
immediately.  The result of that is practically equivalent to calling
dbs_check_cpu() except that it will trigger a full update of governor
internal state and not just the ->gov_check_cpu() part.

Following that observation, make cpufreq_governor_limits() reset
the sample delay and turn dbs_check_cpu() into a function that will
simply evaluate the load and return the result called dbs_update().

That function can now be called by governors from the routines that
previously were pointed to by ->gov_check_cpu and those routines
can be called directly by each governor instead of dbs_check_cpu().
This way ->gov_check_cpu becomes unnecessary, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_conservative.c |   26 +++++++++-----------------
 drivers/cpufreq/cpufreq_governor.c     |   15 ++++++++-------
 drivers/cpufreq/cpufreq_governor.h     |    3 +--
 drivers/cpufreq/cpufreq_ondemand.c     |   15 +++++++++------
 4 files changed, 27 insertions(+), 32 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -140,9 +140,8 @@ static const struct sysfs_ops governor_s
 	.store	= governor_store,
 };
 
-void dbs_check_cpu(struct cpufreq_policy *policy)
+unsigned int dbs_update(struct cpufreq_policy *policy)
 {
-	int cpu = policy->cpu;
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
@@ -154,7 +153,7 @@ void dbs_check_cpu(struct cpufreq_policy
 
 	if (gov->governor == GOV_ONDEMAND) {
 		struct od_cpu_dbs_info_s *od_dbs_info =
-				gov->get_cpu_dbs_info_s(cpu);
+				gov->get_cpu_dbs_info_s(policy->cpu);
 
 		/*
 		 * Sometimes, the ondemand governor uses an additional
@@ -250,10 +249,9 @@ void dbs_check_cpu(struct cpufreq_policy
 		if (load > max_load)
 			max_load = load;
 	}
-
-	gov->gov_check_cpu(cpu, max_load);
+	return max_load;
 }
-EXPORT_SYMBOL_GPL(dbs_check_cpu);
+EXPORT_SYMBOL_GPL(dbs_update);
 
 void gov_set_update_util(struct policy_dbs_info *policy_dbs,
 			 unsigned int delay_us)
@@ -610,11 +608,14 @@ static int cpufreq_governor_limits(struc
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 
 	mutex_lock(&policy_dbs->timer_mutex);
+
 	if (policy->max < policy->cur)
 		__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
 	else if (policy->min > policy->cur)
 		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
-	dbs_check_cpu(policy);
+
+	gov_update_sample_delay(policy_dbs, 0);
+
 	mutex_unlock(&policy_dbs->timer_mutex);
 
 	return 0;
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -202,7 +202,6 @@ struct dbs_governor {
 	struct cpu_dbs_info *(*get_cpu_cdbs)(int cpu);
 	void *(*get_cpu_dbs_info_s)(int cpu);
 	unsigned int (*gov_dbs_timer)(struct cpufreq_policy *policy);
-	void (*gov_check_cpu)(int cpu, unsigned int load);
 	int (*init)(struct dbs_data *dbs_data, bool notify);
 	void (*exit)(struct dbs_data *dbs_data, bool notify);
 
@@ -235,7 +234,7 @@ static inline int delay_for_sampling_rat
 }
 
 extern struct mutex dbs_data_mutex;
-void dbs_check_cpu(struct cpufreq_policy *policy);
+unsigned int dbs_update(struct cpufreq_policy *policy);
 int cpufreq_governor_dbs(struct cpufreq_policy *policy, unsigned int event);
 void od_register_powersave_bias_handler(unsigned int (*f)
 		(struct cpufreq_policy *, unsigned int, unsigned int),
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -44,20 +44,20 @@ static inline unsigned int get_freq_targ
  * Any frequency increase takes it to the maximum frequency. Frequency reduction
  * happens at minimum steps of 5% (default) of maximum frequency
  */
-static void cs_check_cpu(int cpu, unsigned int load)
+static unsigned int cs_dbs_timer(struct cpufreq_policy *policy)
 {
-	struct cs_cpu_dbs_info_s *dbs_info = &per_cpu(cs_cpu_dbs_info, cpu);
-	struct cpufreq_policy *policy = dbs_info->cdbs.policy_dbs->policy;
+	struct cs_cpu_dbs_info_s *dbs_info = &per_cpu(cs_cpu_dbs_info, policy->cpu);
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
+	unsigned int load = dbs_update(policy);
 
 	/*
 	 * break out if we 'cannot' reduce the speed as the user might
 	 * want freq_step to be zero
 	 */
 	if (cs_tuners->freq_step == 0)
-		return;
+		goto out;
 
 	/* Check for frequency increase */
 	if (load > dbs_data->up_threshold) {
@@ -65,7 +65,7 @@ static void cs_check_cpu(int cpu, unsign
 
 		/* if we are already at full speed then break out early */
 		if (dbs_info->requested_freq == policy->max)
-			return;
+			goto out;
 
 		dbs_info->requested_freq += get_freq_target(cs_tuners, policy);
 
@@ -74,12 +74,12 @@ static void cs_check_cpu(int cpu, unsign
 
 		__cpufreq_driver_target(policy, dbs_info->requested_freq,
 			CPUFREQ_RELATION_H);
-		return;
+		goto out;
 	}
 
 	/* if sampling_down_factor is active break out early */
 	if (++dbs_info->down_skip < dbs_data->sampling_down_factor)
-		return;
+		goto out;
 	dbs_info->down_skip = 0;
 
 	/* Check for frequency decrease */
@@ -89,7 +89,7 @@ static void cs_check_cpu(int cpu, unsign
 		 * if we cannot reduce the frequency anymore, break out early
 		 */
 		if (policy->cur == policy->min)
-			return;
+			goto out;
 
 		freq_target = get_freq_target(cs_tuners, policy);
 		if (dbs_info->requested_freq > freq_target)
@@ -99,16 +99,9 @@ static void cs_check_cpu(int cpu, unsign
 
 		__cpufreq_driver_target(policy, dbs_info->requested_freq,
 				CPUFREQ_RELATION_L);
-		return;
 	}
-}
-
-static unsigned int cs_dbs_timer(struct cpufreq_policy *policy)
-{
-	struct policy_dbs_info *policy_dbs = policy->governor_data;
-	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 
-	dbs_check_cpu(policy);
+ out:
 	return delay_for_sampling_rate(dbs_data->sampling_rate);
 }
 
@@ -300,7 +293,6 @@ static struct dbs_governor cs_dbs_gov =
 	.get_cpu_cdbs = get_cpu_cdbs,
 	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
 	.gov_dbs_timer = cs_dbs_timer,
-	.gov_check_cpu = cs_check_cpu,
 	.init = cs_init,
 	.exit = cs_exit,
 };
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -150,13 +150,13 @@ static void dbs_freq_increase(struct cpu
  * (default), then we try to increase frequency. Else, we adjust the frequency
  * proportional to load.
  */
-static void od_check_cpu(int cpu, unsigned int load)
+static void od_update(struct cpufreq_policy *policy)
 {
-	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
+	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, policy->cpu);
 	struct policy_dbs_info *policy_dbs = dbs_info->cdbs.policy_dbs;
-	struct cpufreq_policy *policy = policy_dbs->policy;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
+	unsigned int load = dbs_update(policy);
 
 	dbs_info->freq_lo = 0;
 
@@ -198,12 +198,16 @@ static unsigned int od_dbs_timer(struct
 
 	/* Common NORMAL_SAMPLE setup */
 	dbs_info->sample_type = OD_NORMAL_SAMPLE;
-	if (sample_type == OD_SUB_SAMPLE) {
+	/*
+	 * OD_SUB_SAMPLE doesn't make sense if sample_delay_ns is 0, so ignore
+	 * it then.
+	 */
+	if (sample_type == OD_SUB_SAMPLE && policy_dbs->sample_delay_ns > 0) {
 		delay = dbs_info->freq_lo_jiffies;
 		__cpufreq_driver_target(policy, dbs_info->freq_lo,
 					CPUFREQ_RELATION_H);
 	} else {
-		dbs_check_cpu(policy);
+		od_update(policy);
 		if (dbs_info->freq_lo) {
 			/* Setup timer for SUB_SAMPLE */
 			dbs_info->sample_type = OD_SUB_SAMPLE;
@@ -428,7 +432,6 @@ static struct dbs_governor od_dbs_gov =
 	.get_cpu_cdbs = get_cpu_cdbs,
 	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
 	.gov_dbs_timer = od_dbs_timer,
-	.gov_check_cpu = od_check_cpu,
 	.gov_ops = &od_ops,
 	.init = od_init,
 	.exit = od_exit,


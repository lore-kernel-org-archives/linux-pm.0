From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 8/9] cpufreq: ondemand: Simplify conditionals in od_dbs_timer()
Date: Mon, 15 Feb 2016 02:21:35 +0100
Message-ID: <19952608.TanrAGEnqx@vostro.rjw.lan>
References: <3329748.lhJgppdTt9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3329748.lhJgppdTt9@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reduce the indentation level in the conditionals in od_dbs_timer()
and drop the delay variable from it.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_ondemand.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -194,7 +194,7 @@ static unsigned int od_dbs_timer(struct
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, policy->cpu);
-	int delay, sample_type = dbs_info->sample_type;
+	int sample_type = dbs_info->sample_type;
 
 	/* Common NORMAL_SAMPLE setup */
 	dbs_info->sample_type = OD_NORMAL_SAMPLE;
@@ -203,22 +203,20 @@ static unsigned int od_dbs_timer(struct
 	 * it then.
 	 */
 	if (sample_type == OD_SUB_SAMPLE && policy_dbs->sample_delay_ns > 0) {
-		delay = dbs_info->freq_lo_jiffies;
 		__cpufreq_driver_target(policy, dbs_info->freq_lo,
 					CPUFREQ_RELATION_H);
-	} else {
-		od_update(policy);
-		if (dbs_info->freq_lo) {
-			/* Setup timer for SUB_SAMPLE */
-			dbs_info->sample_type = OD_SUB_SAMPLE;
-			delay = dbs_info->freq_hi_jiffies;
-		} else {
-			delay = delay_for_sampling_rate(dbs_data->sampling_rate
-							* policy_dbs->rate_mult);
-		}
+		return dbs_info->freq_lo_jiffies;
 	}
 
-	return delay;
+	od_update(policy);
+
+	if (dbs_info->freq_lo) {
+		/* Setup timer for SUB_SAMPLE */
+		dbs_info->sample_type = OD_SUB_SAMPLE;
+		return dbs_info->freq_hi_jiffies;
+	}
+
+	return delay_for_sampling_rate(dbs_data->sampling_rate * policy_dbs->rate_mult);
 }
 
 /************************** sysfs interface ************************/

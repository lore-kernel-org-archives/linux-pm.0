From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 7/12] cpufreq: ondemand: Rework the handling of powersave bias updates
Date: Thu, 18 Feb 2016 02:28:24 +0100
Message-ID: <2373952.xlh20cNGZI@vostro.rjw.lan>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2938006.67J0esUvOA@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ondemand_powersave_bias_init() function used for resetting data
fields related to the powersave bias tunable of the ondemand governor
works by walking all of the online CPUs in the system and updating the
od_cpu_dbs_info_s structures for all of them.

However, if governor tunables are per policy, the update should not
touch the CPUs that are not associated with the given dbs_data.

Moreover, since the data fields in question are only ever used for
policy->cpu in each policy governed by ondemand, the update can be
limited to those specific CPUs.

Rework the code to take the above observations into account.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_ondemand.c |   30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -34,14 +34,6 @@ static struct od_ops od_ops;
 
 static unsigned int default_powersave_bias;
 
-static void ondemand_powersave_bias_init_cpu(int cpu)
-{
-	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
-
-	dbs_info->freq_table = cpufreq_frequency_get_table(cpu);
-	dbs_info->freq_lo = 0;
-}
-
 /*
  * Not all CPUs want IO time to be accounted as busy; this depends on how
  * efficient idling at a higher frequency/voltage is.
@@ -120,12 +112,13 @@ static unsigned int generic_powersave_bi
 	return freq_hi;
 }
 
-static void ondemand_powersave_bias_init(void)
+static void ondemand_powersave_bias_init(struct cpufreq_policy *policy)
 {
-	int i;
-	for_each_online_cpu(i) {
-		ondemand_powersave_bias_init_cpu(i);
-	}
+	unsigned int cpu = policy->cpu;
+	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
+
+	dbs_info->freq_table = cpufreq_frequency_get_table(cpu);
+	dbs_info->freq_lo = 0;
 }
 
 static void dbs_freq_increase(struct cpufreq_policy *policy, unsigned int freq)
@@ -306,6 +299,7 @@ static ssize_t store_powersave_bias(stru
 		size_t count)
 {
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
+	struct policy_dbs_info *policy_dbs;
 	unsigned int input;
 	int ret;
 	ret = sscanf(buf, "%u", &input);
@@ -317,7 +311,10 @@ static ssize_t store_powersave_bias(stru
 		input = 1000;
 
 	od_tuners->powersave_bias = input;
-	ondemand_powersave_bias_init();
+
+	list_for_each_entry(policy_dbs, &dbs_data->policy_dbs_list, list)
+		ondemand_powersave_bias_init(policy_dbs->policy);
+
 	return count;
 }
 
@@ -398,11 +395,10 @@ static void od_exit(struct dbs_data *dbs
 
 static void od_start(struct cpufreq_policy *policy)
 {
-	unsigned int cpu = policy->cpu;
-	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
+	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, policy->cpu);
 
 	dbs_info->sample_type = OD_NORMAL_SAMPLE;
-	ondemand_powersave_bias_init_cpu(cpu);
+	ondemand_powersave_bias_init(policy);
 }
 
 define_get_cpu_dbs_routines(od_cpu_dbs_info);

From: Andreas Herrmann <aherrmann@suse.com>
Subject: [PATCH v2 1/2] cpufreq/ondemand: Introduce op to customize mapping
 of load to frequency
Date: Fri, 23 Sep 2016 19:02:56 +0200
Message-ID: <20160923170256.GB9786@suselix.suse.de>
References: <20160819121814.GA17296@suselix.suse.de>
 <20160923165632.GA9786@suselix.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160923165632.GA9786@suselix.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stratos Karafotis <stratosk@semaphore.gr>, Thomas Renninger <trenn@suse.com>
List-Id: linux-pm@vger.kernel.org

Introduce op for ondemand governor that is used to map load to
frequency. It allows a cpufreq driver to provide a specific mapping
function if the generic function is not optimal for the driver.

Performance results (kernel compile with different number of jobs)
based on 4.8.0-rc7 (with and w/o my patches on top) from
an HP ProLiant DL580 Gen8 system using pcc-cpufreq:
 - Intel(R) Xeon(R) CPU E7-4890 v2 @ 2.80GHz
 - 60 CPUs, 128GB RAM
 
                    vanilla                  generic_map_load_to_freq function
 # of jobs  user    sys   elapsed   % CPU      user    sys   elapsed   % CPU
    2      445.44  110.51  272.99   203.00    445.56  111.22  273.35   203.00
    4      444.41  126.20  142.81   399.00    445.61  126.10  143.12   399.00
    8      483.04  150.58   82.19   770.40    483.51  150.84   82.17   771.40
   16      626.81  185.01   55.00  1475.40    628.01  185.54   55.02  1477.80
   32      816.72  204.39   37.26  2740.00    818.58  205.51   37.02  2765.40
   64      406.59   51.12   14.04  3257.80    406.22   51.84   13.84  3308.80
  120      413.00   48.39   14.36  3211.20    413.61   49.06   14.54  3181.00

Similar tests on another system using acpi_cpufreq didn't show
significant performance differences between these two kernel versions.

Link: https://marc.info/?i=20160819121814.GA17296%40suselix.suse.de
Signed-off-by: Andreas Herrmann <aherrmann@suse.com>
---
 drivers/cpufreq/cpufreq_governor.h |  5 +++++
 drivers/cpufreq/cpufreq_ondemand.c | 35 ++++++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index ef1037e..9fef947 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -171,6 +171,8 @@ void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy);
 struct od_ops {
 	unsigned int (*powersave_bias_target)(struct cpufreq_policy *policy,
 			unsigned int freq_next, unsigned int relation);
+	unsigned int (*map_load_to_freq)(struct cpufreq_policy *policy,
+			unsigned int load);
 };
 
 unsigned int dbs_update(struct cpufreq_policy *policy);
@@ -178,6 +180,9 @@ void od_register_powersave_bias_handler(unsigned int (*f)
 		(struct cpufreq_policy *, unsigned int, unsigned int),
 		unsigned int powersave_bias);
 void od_unregister_powersave_bias_handler(void);
+void od_register_map_load_to_freq_handler(unsigned int (*f)
+		(struct cpufreq_policy *, unsigned int));
+void od_unregister_map_load_to_freq_handler(void);
 ssize_t store_sampling_rate(struct gov_attr_set *attr_set, const char *buf,
 			    size_t count);
 void gov_update_cpu_data(struct dbs_data *dbs_data);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 3a1f49f..d245f1c 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -112,6 +112,20 @@ static void ondemand_powersave_bias_init(struct cpufreq_policy *policy)
 	dbs_info->freq_lo = 0;
 }
 
+/*
+ * Calculate the next frequency proportional to load
+ */
+static unsigned int generic_map_load_to_freq(struct cpufreq_policy *policy,
+					unsigned int load)
+{
+	unsigned int min_f, max_f;
+
+	min_f = policy->cpuinfo.min_freq;
+	max_f = policy->cpuinfo.max_freq;
+
+	return (min_f + load * (max_f - min_f) / 100);
+}
+
 static void dbs_freq_increase(struct cpufreq_policy *policy, unsigned int freq)
 {
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
@@ -150,12 +164,9 @@ static void od_update(struct cpufreq_policy *policy)
 			policy_dbs->rate_mult = dbs_data->sampling_down_factor;
 		dbs_freq_increase(policy, policy->max);
 	} else {
-		/* Calculate the next frequency proportional to load */
-		unsigned int freq_next, min_f, max_f;
+		unsigned int freq_next;
 
-		min_f = policy->cpuinfo.min_freq;
-		max_f = policy->cpuinfo.max_freq;
-		freq_next = min_f + load * (max_f - min_f) / 100;
+		freq_next = od_ops.map_load_to_freq(policy, load);
 
 		/* No longer fully busy, reset rate_mult */
 		policy_dbs->rate_mult = 1;
@@ -410,6 +421,7 @@ static void od_start(struct cpufreq_policy *policy)
 
 static struct od_ops od_ops = {
 	.powersave_bias_target = generic_powersave_bias_target,
+	.map_load_to_freq = generic_map_load_to_freq,
 };
 
 static struct dbs_governor od_dbs_gov = {
@@ -476,6 +488,19 @@ void od_unregister_powersave_bias_handler(void)
 }
 EXPORT_SYMBOL_GPL(od_unregister_powersave_bias_handler);
 
+void od_register_map_load_to_freq_handler(unsigned int (*f)
+					(struct cpufreq_policy *, unsigned int))
+{
+	od_ops.map_load_to_freq = f;
+}
+EXPORT_SYMBOL_GPL(od_register_map_load_to_freq_handler);
+
+void od_unregister_map_load_to_freq_handler(void)
+{
+	od_ops.map_load_to_freq = generic_map_load_to_freq;
+}
+EXPORT_SYMBOL_GPL(od_unregister_map_load_to_freq_handler);
+
 static int __init cpufreq_gov_dbs_init(void)
 {
 	return cpufreq_register_governor(CPU_FREQ_GOV_ONDEMAND);
-- 
1.9.1

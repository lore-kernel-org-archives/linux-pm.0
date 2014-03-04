From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [RFC v3 1/5] cpufreq:LAB:ondemand Adjust ondemand to be able to reuse
 its methods
Date: Tue, 04 Mar 2014 11:27:28 +0100
Message-ID: <1393928852-22725-2-git-send-email-l.majewski@samsung.com>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
 <1393928852-22725-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1393928852-22725-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Thomas Abraham <ta.omasab@gmail.com>, thomas.ab@samsung.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Ondemand code needed to be slightly adjusted to allow its reusage.
Mostly one needed to remove static qualifiers and provide some hacks to
allow its working with LAB.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/cpufreq/cpufreq_governor.h |   10 ++++++++++
 drivers/cpufreq/cpufreq_ondemand.c |   24 ++++++++++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index bfb9ae1..34b1cf2 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -270,4 +270,14 @@ void od_register_powersave_bias_handler(unsigned int (*f)
 		(struct cpufreq_policy *, unsigned int, unsigned int),
 		unsigned int powersave_bias);
 void od_unregister_powersave_bias_handler(void);
+
+/* COMMON CODE FOR DEMAND BASED SWITCHING */
+void od_dbs_timer(struct work_struct *work);
+int od_init(struct dbs_data *dbs_data);
+void od_exit(struct dbs_data *dbs_data);
+void od_check_cpu(int cpu, unsigned int load_freq);
+void update_sampling_rate(struct dbs_data *dbs_data,
+			  unsigned int new_rate);
+
+extern struct od_ops od_ops;
 #endif /* _CPUFREQ_GOVERNOR_H */
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 18d4091..a27326d 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -27,9 +27,9 @@
 #define MIN_FREQUENCY_UP_THRESHOLD		(11)
 #define MAX_FREQUENCY_UP_THRESHOLD		(100)
 
-static DEFINE_PER_CPU(struct od_cpu_dbs_info_s, od_cpu_dbs_info);
+DEFINE_PER_CPU(struct od_cpu_dbs_info_s, od_cpu_dbs_info);
 
-static struct od_ops od_ops;
+struct od_ops od_ops;
 
 #ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
 static struct cpufreq_governor cpufreq_gov_ondemand;
@@ -152,7 +152,7 @@ static void dbs_freq_increase(struct cpufreq_policy *policy, unsigned int freq)
  * (default), then we try to increase frequency. Else, we adjust the frequency
  * proportional to load.
  */
-static void od_check_cpu(int cpu, unsigned int load)
+void od_check_cpu(int cpu, unsigned int load)
 {
 	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
 	struct cpufreq_policy *policy = dbs_info->cdbs.cur_policy;
@@ -188,7 +188,7 @@ static void od_check_cpu(int cpu, unsigned int load)
 	}
 }
 
-static void od_dbs_timer(struct work_struct *work)
+void od_dbs_timer(struct work_struct *work)
 {
 	struct od_cpu_dbs_info_s *dbs_info =
 		container_of(work, struct od_cpu_dbs_info_s, cdbs.work.work);
@@ -233,6 +233,9 @@ max_delay:
 /************************** sysfs interface ************************/
 static struct common_dbs_data od_dbs_cdata;
 
+#ifdef CONFIG_CPU_FREQ_GOV_LAB
+extern struct cpufreq_governor cpufreq_gov_lab;
+#endif
 /**
  * update_sampling_rate - update sampling rate effective immediately if needed.
  * @new_rate: new sampling rate
@@ -246,7 +249,7 @@ static struct common_dbs_data od_dbs_cdata;
  * reducing the sampling rate, we need to make the new value effective
  * immediately.
  */
-static void update_sampling_rate(struct dbs_data *dbs_data,
+void update_sampling_rate(struct dbs_data *dbs_data,
 		unsigned int new_rate)
 {
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
@@ -263,7 +266,12 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
 			continue;
+#ifdef CONFIG_CPU_FREQ_GOV_LAB
+		if (policy->governor != &cpufreq_gov_ondemand &&
+		    policy->governor != &cpufreq_gov_lab) {
+#else
 		if (policy->governor != &cpufreq_gov_ondemand) {
+#endif
 			cpufreq_cpu_put(policy);
 			continue;
 		}
@@ -472,7 +480,7 @@ static struct attribute_group od_attr_group_gov_pol = {
 
 /************************** sysfs end ************************/
 
-static int od_init(struct dbs_data *dbs_data)
+int od_init(struct dbs_data *dbs_data)
 {
 	struct od_dbs_tuners *tuners;
 	u64 idle_time;
@@ -514,14 +522,14 @@ static int od_init(struct dbs_data *dbs_data)
 	return 0;
 }
 
-static void od_exit(struct dbs_data *dbs_data)
+void od_exit(struct dbs_data *dbs_data)
 {
 	kfree(dbs_data->tuners);
 }
 
 define_get_cpu_dbs_routines(od_cpu_dbs_info);
 
-static struct od_ops od_ops = {
+struct od_ops od_ops = {
 	.powersave_bias_init_cpu = ondemand_powersave_bias_init_cpu,
 	.powersave_bias_target = generic_powersave_bias_target,
 	.freq_increase = dbs_freq_increase,
-- 
1.7.10.4

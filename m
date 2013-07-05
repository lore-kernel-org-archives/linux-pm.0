From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 5/6] cpufreq: powersave: Add support to collect CPUs load
 periodically
Date: Fri, 05 Jul 2013 17:46:40 +0900
Message-ID: <1373014001-17746-6-git-send-email-cw00.choi@samsung.com>
References: <1373014001-17746-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1373014001-17746-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, rjw@sisk.pl, linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com
List-Id: linux-pm@vger.kernel.org

This patch collect CPUs load and create create basic sysfs file as below:
- /sys/devices/system/cpu/cpufreq/powersave/ignore_nice (rw)
- /sys/devices/system/cpu/cpufreq/powersave/sampling_rate (rw)
- /sys/devices/system/cpu/cpufreq/powersave/sampling_rate_min (r)

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
---
 drivers/cpufreq/cpufreq_governor.h  |   1 +
 drivers/cpufreq/cpufreq_powersave.c | 158 +++++++++++++++++++++++++++++++++++-
 2 files changed, 156 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 7ad4d3b..a926c74 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -199,6 +199,7 @@ struct common_dbs_data {
 	#define GOV_ONDEMAND		0
 	#define GOV_CONSERVATIVE	1
 	#define GOV_PERFORMANCE		2
+	#define GOV_POWERSAVE		3
 	int governor;
 	struct attribute_group *attr_group_gov_sys; /* one governor - system */
 	struct attribute_group *attr_group_gov_pol; /* one governor - policy */
diff --git a/drivers/cpufreq/cpufreq_powersave.c b/drivers/cpufreq/cpufreq_powersave.c
index 2d948a1..39c7857 100644
--- a/drivers/cpufreq/cpufreq_powersave.c
+++ b/drivers/cpufreq/cpufreq_powersave.c
@@ -17,9 +17,159 @@
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 
+#ifdef CONFIG_CPU_FREQ_STAT
+
+#include <linux/kernel_stat.h>
+#include <linux/slab.h>
+
+#include "cpufreq_governor.h"
+
+#define ps_cpu_dbs_info_s	cpu_dbs_info_s
+#define ps_dbs_tuners		dbs_tuners
+
+static DEFINE_PER_CPU(struct cpu_dbs_info_s, ps_cpu_dbs_info);
+static struct common_dbs_data ps_dbs_cdata;
+
+static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
+		size_t count)
+{
+	struct dbs_tuners *tuners = dbs_data->tuners;
+	unsigned int input;
+	int ret;
+	ret = sscanf(buf, "%u", &input);
+
+	if (ret != 1)
+		return -EINVAL;
+
+	tuners->sampling_rate = max(input, dbs_data->min_sampling_rate);
+	return count;
+}
+
+static ssize_t store_ignore_nice(struct dbs_data *dbs_data, const char *buf,
+		size_t count)
+{
+	struct dbs_tuners *tuners = dbs_data->tuners;
+	unsigned int input, j;
+	int ret;
+
+	ret = sscanf(buf, "%u", &input);
+	if (ret != 1)
+		return -EINVAL;
+
+	if (input > 1)
+		input = 1;
+
+	if (input == tuners->ignore_nice) /* nothing to do */
+		return count;
+
+	tuners->ignore_nice = input;
+
+	/* we need to re-evaluate prev_cpu_idle */
+	for_each_online_cpu(j) {
+		struct ps_cpu_dbs_info_s *dbs_info;
+		dbs_info = &per_cpu(ps_cpu_dbs_info, j);
+		dbs_info->cdbs.prev_cpu_idle = get_cpu_idle_time(j,
+					&dbs_info->cdbs.prev_cpu_wall, 0);
+		if (tuners->ignore_nice)
+			dbs_info->cdbs.prev_cpu_nice =
+				kcpustat_cpu(j).cpustat[CPUTIME_NICE];
+	}
+	return count;
+}
+
+show_store_one(ps, sampling_rate);
+show_store_one(ps, ignore_nice);
+declare_show_sampling_rate_min(ps);
+
+gov_sys_pol_attr_rw(sampling_rate);
+gov_sys_pol_attr_rw(ignore_nice);
+gov_sys_pol_attr_ro(sampling_rate_min);
+
+static struct attribute *dbs_attributes_gov_sys[] = {
+	&sampling_rate_min_gov_sys.attr,
+	&sampling_rate_gov_sys.attr,
+	&ignore_nice_gov_sys.attr,
+	NULL
+};
+
+static struct attribute_group ps_attr_group_gov_sys = {
+	.attrs = dbs_attributes_gov_sys,
+	.name = "powersave",
+};
+
+static struct attribute *dbs_attributes_gov_pol[] = {
+	&sampling_rate_min_gov_pol.attr,
+	&sampling_rate_gov_pol.attr,
+	&ignore_nice_gov_pol.attr,
+	NULL
+};
+
+static struct attribute_group ps_attr_group_gov_pol = {
+	.attrs = dbs_attributes_gov_pol,
+	.name = "powersave",
+};
+
+static void ps_dbs_timer(struct work_struct *work)
+{
+	struct cpu_dbs_info_s *dbs_info = container_of(work,
+			struct cpu_dbs_info_s, cdbs.work.work);
+	unsigned int cpu = dbs_info->cdbs.cur_policy->cpu;
+	struct dbs_data *dbs_data = dbs_info->cdbs.cur_policy->governor_data;
+	struct dbs_tuners *tuners = dbs_data->tuners;
+	unsigned int delay = 0;
+
+	delay = max(tuners->sampling_rate, dbs_data->min_sampling_rate);
+	delay = usecs_to_jiffies(delay);
+
+	mutex_lock(&dbs_info->cdbs.timer_mutex);
+	dbs_check_cpu(dbs_data, cpu);
+	gov_queue_work(dbs_data, dbs_info->cdbs.cur_policy, delay, false);
+	mutex_unlock(&dbs_info->cdbs.timer_mutex);
+}
+
+static int ps_init(struct dbs_data *dbs_data)
+{
+	struct dbs_tuners *tuners;
+
+	tuners = kzalloc(sizeof(struct dbs_tuners), GFP_KERNEL);
+	if (!tuners) {
+		pr_err("%s: kzalloc failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	tuners->ignore_nice = 0;
+
+	dbs_data->tuners = tuners;
+	dbs_data->min_sampling_rate = MIN_SAMPLING_RATE_RATIO
+					* jiffies_to_usecs(100);
+	mutex_init(&dbs_data->mutex);
+
+	return 0;
+}
+static void ps_exit(struct dbs_data *dbs_data)
+{
+	kfree(dbs_data->tuners);
+}
+
+define_get_cpu_dbs_routines(ps_cpu_dbs_info);
+
+static struct common_dbs_data ps_dbs_cdata = {
+	.governor = GOV_POWERSAVE,
+	.attr_group_gov_sys = &ps_attr_group_gov_sys,
+	.attr_group_gov_pol = &ps_attr_group_gov_pol,
+	.get_cpu_cdbs = get_cpu_cdbs,
+	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
+	.gov_dbs_timer = ps_dbs_timer,
+	.init = ps_init,
+	.exit = ps_exit,
+};
+#endif	/* CONFIG_CPU_FREQ_STAT */
+
 static int cpufreq_governor_powersave(struct cpufreq_policy *policy,
 					unsigned int event)
 {
+	int ret = 0;
+
 	switch (event) {
 	case CPUFREQ_GOV_START:
 	case CPUFREQ_GOV_LIMITS:
@@ -28,10 +178,12 @@ static int cpufreq_governor_powersave(struct cpufreq_policy *policy,
 		__cpufreq_driver_target(policy, policy->min,
 						CPUFREQ_RELATION_L);
 		break;
-	default:
-		break;
 	}
-	return 0;
+
+#ifdef CONFIG_CPU_FREQ_STAT
+	ret = cpufreq_governor_dbs(policy, &ps_dbs_cdata, event);
+#endif
+	return ret;
 }
 
 #ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE
-- 
1.8.0

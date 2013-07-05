From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 4/6] cpufreq: performance: Add support to collect CPUs load
 periodically
Date: Fri, 05 Jul 2013 17:46:39 +0900
Message-ID: <1373014001-17746-5-git-send-email-cw00.choi@samsung.com>
References: <1373014001-17746-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1373014001-17746-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, rjw@sisk.pl, linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com
List-Id: linux-pm@vger.kernel.org

This patch collect CPUs load when cpufreq governos is performance.
The collected CPUs load is used for providing data through debugfs file.
- /sys/kernel/debug/cpufreq/cpuX/load_table

And this patch create basic sysfs file as below:
- /sys/devices/system/cpu/cpufreq/performance/ignore_nice (rw)
- /sys/devices/system/cpu/cpufreq/performance/sampling_rate (rw)
- /sys/devices/system/cpu/cpufreq/performance/sampling_rate_min (r)

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
---
 drivers/cpufreq/cpufreq_governor.h    |   1 +
 drivers/cpufreq/cpufreq_performance.c | 156 +++++++++++++++++++++++++++++++++-
 2 files changed, 154 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 55ef8c6..7ad4d3b 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -198,6 +198,7 @@ struct common_dbs_data {
 	/* Common across governors */
 	#define GOV_ONDEMAND		0
 	#define GOV_CONSERVATIVE	1
+	#define GOV_PERFORMANCE		2
 	int governor;
 	struct attribute_group *attr_group_gov_sys; /* one governor - system */
 	struct attribute_group *attr_group_gov_pol; /* one governor - policy */
diff --git a/drivers/cpufreq/cpufreq_performance.c b/drivers/cpufreq/cpufreq_performance.c
index ceee068..15195fc9 100644
--- a/drivers/cpufreq/cpufreq_performance.c
+++ b/drivers/cpufreq/cpufreq_performance.c
@@ -17,10 +17,158 @@
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 
+#ifdef CONFIG_CPU_FREQ_STAT
+
+#include <linux/kernel_stat.h>
+#include <linux/slab.h>
+
+#include "cpufreq_governor.h"
+
+#define pf_cpu_dbs_info_s	cpu_dbs_info_s
+#define pf_dbs_tuners		dbs_tuners
+
+static DEFINE_PER_CPU(struct pf_cpu_dbs_info_s, pf_cpu_dbs_info);
+static struct common_dbs_data pf_dbs_cdata;
+
+static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
+		size_t count)
+{
+	struct pf_dbs_tuners *tuners = dbs_data->tuners;
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
+	struct pf_dbs_tuners *tuners = dbs_data->tuners;
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
+		struct pf_cpu_dbs_info_s *dbs_info;
+		dbs_info = &per_cpu(pf_cpu_dbs_info, j);
+		dbs_info->cdbs.prev_cpu_idle = get_cpu_idle_time(j,
+					&dbs_info->cdbs.prev_cpu_wall, 0);
+		if (tuners->ignore_nice)
+			dbs_info->cdbs.prev_cpu_nice =
+				kcpustat_cpu(j).cpustat[CPUTIME_NICE];
+	}
+	return count;
+}
+
+show_store_one(pf, sampling_rate);
+show_store_one(pf, ignore_nice);
+declare_show_sampling_rate_min(pf);
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
+static struct attribute_group pf_attr_group_gov_sys = {
+	.attrs = dbs_attributes_gov_sys,
+	.name = "performance",
+};
+
+static struct attribute *dbs_attributes_gov_pol[] = {
+	&sampling_rate_min_gov_pol.attr,
+	&sampling_rate_gov_pol.attr,
+	&ignore_nice_gov_pol.attr,
+	NULL
+};
+
+static struct attribute_group pf_attr_group_gov_pol = {
+	.attrs = dbs_attributes_gov_pol,
+	.name = "performance",
+};
+
+static void pf_dbs_timer(struct work_struct *work)
+{
+	struct pf_cpu_dbs_info_s *dbs_info = container_of(work,
+			struct pf_cpu_dbs_info_s, cdbs.work.work);
+	unsigned int cpu = dbs_info->cdbs.cur_policy->cpu;
+	struct dbs_data *dbs_data = dbs_info->cdbs.cur_policy->governor_data;
+	unsigned int delay = 0;
+
+	delay = usecs_to_jiffies(dbs_data->min_sampling_rate);
+
+	mutex_lock(&dbs_info->cdbs.timer_mutex);
+	dbs_check_cpu(dbs_data, cpu);
+	gov_queue_work(dbs_data, dbs_info->cdbs.cur_policy, delay, false);
+	mutex_unlock(&dbs_info->cdbs.timer_mutex);
+}
+
+static int pf_init(struct dbs_data *dbs_data)
+{
+	struct pf_dbs_tuners *tuners;
+
+	tuners = kzalloc(sizeof(struct pf_dbs_tuners), GFP_KERNEL);
+	if (!tuners) {
+		pr_err("%s: kzalloc failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	tuners->ignore_nice = 0;
+
+	dbs_data->tuners = tuners;
+	dbs_data->min_sampling_rate = MIN_SAMPLING_RATE_RATIO *
+					jiffies_to_usecs(100);
+
+	mutex_init(&dbs_data->mutex);
+
+	return 0;
+}
+static void pf_exit(struct dbs_data *dbs_data)
+{
+	kfree(dbs_data->tuners);
+}
+
+define_get_cpu_dbs_routines(pf_cpu_dbs_info);
+
+static struct common_dbs_data pf_dbs_cdata = {
+	.governor = GOV_PERFORMANCE,
+	.attr_group_gov_sys = &pf_attr_group_gov_sys,
+	.attr_group_gov_pol = &pf_attr_group_gov_pol,
+	.get_cpu_cdbs = get_cpu_cdbs,
+	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
+	.gov_dbs_timer = pf_dbs_timer,
+	.init = pf_init,
+	.exit = pf_exit,
+};
+#endif	/* CONFIG_CPU_FREQ_STAT */
 
 static int cpufreq_governor_performance(struct cpufreq_policy *policy,
 					unsigned int event)
 {
+	int ret = 0;
+
 	switch (event) {
 	case CPUFREQ_GOV_START:
 	case CPUFREQ_GOV_LIMITS:
@@ -29,10 +177,12 @@ static int cpufreq_governor_performance(struct cpufreq_policy *policy,
 		__cpufreq_driver_target(policy, policy->max,
 						CPUFREQ_RELATION_H);
 		break;
-	default:
-		break;
 	}
-	return 0;
+
+#ifdef CONFIG_CPU_FREQ_STAT
+	ret = cpufreq_governor_dbs(policy, &pf_dbs_cdata, event);
+#endif
+	return ret;
 }
 
 #ifdef CONFIG_CPU_FREQ_GOV_PERFORMANCE_MODULE
-- 
1.8.0

From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [RFC v2 3/3] cpufreq:LAB: Modify cpufreq_governor to support LAB
 Governor
Date: Fri, 03 May 2013 23:07:52 +0900
Message-ID: <1367590072-10496-4-git-send-email-jonghwa3.lee@samsung.com>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Vicent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocky" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

From: Lukasz Majewski <l.majewski@samsung.com>

Store idle_time information at newly created, per CPU struct lb_cpu_dbs_info_s
Moreover new governor #define - GOV_LAB has been added

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/cpufreq/cpufreq_governor.c |    7 +++++++
 drivers/cpufreq/cpufreq_governor.h |   15 +++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 443442d..ab34edf 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -143,6 +143,13 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 			idle_time += jiffies_to_usecs(cur_nice_jiffies);
 		}
 
+		if (dbs_data->governor == GOV_LAB) {
+			struct lb_cpu_dbs_info_s *lb_dbs_info =
+				dbs_data->get_cpu_dbs_info_s(j);
+
+			lb_dbs_info->idle_time = (100 * idle_time) / wall_time;
+		}
+
 		if (unlikely(!wall_time || wall_time < idle_time))
 			continue;
 
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 8ac3353..6bf7dcb 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -163,6 +163,20 @@ struct cs_cpu_dbs_info_s {
 	unsigned int enable:1;
 };
 
+struct lb_cpu_dbs_info_s {
+	struct cpu_dbs_common_info cdbs;
+	u64 prev_cpu_iowait;
+	struct cpufreq_frequency_table *freq_table;
+	unsigned int freq_lo;
+	unsigned int freq_lo_jiffies;
+	unsigned int freq_hi_jiffies;
+	unsigned int rate_mult;
+	unsigned int sample_type:1;
+
+	unsigned int last_sampling_rate;
+	unsigned int idle_time;
+};
+
 /* Per policy Governers sysfs tunables */
 struct od_dbs_tuners {
 	unsigned int ignore_nice;
@@ -189,6 +203,7 @@ struct common_dbs_data {
 	/* Common across governors */
 	#define GOV_ONDEMAND		0
 	#define GOV_CONSERVATIVE	1
+	#define GOV_LAB			2
 	int governor;
 	struct attribute_group *attr_group_gov_sys; /* one governor - system */
 	struct attribute_group *attr_group_gov_pol; /* one governor - policy */
-- 
1.7.9.5

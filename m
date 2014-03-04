From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [RFC v3 2/5] cpufreq:LAB:cpufreq_governor Adjust
 cpufreq_governor.[h|c] to support LAB
Date: Tue, 04 Mar 2014 11:27:29 +0100
Message-ID: <1393928852-22725-3-git-send-email-l.majewski@samsung.com>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
 <1393928852-22725-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1393928852-22725-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Thomas Abraham <ta.omasab@gmail.com>, thomas.ab@samsung.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Some minor adjustments were needed to support LAB operation in the
cpufreq_governor.[h|c] files.

Most notably, code for proper estimation of the idle time for each CPU is
added here.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/cpufreq/cpufreq_governor.c |    7 +++++++
 drivers/cpufreq/cpufreq_governor.h |    2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index ba43991..99fc3e8 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -98,6 +98,13 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 
 		load = 100 * (wall_time - idle_time) / wall_time;
 
+		if (dbs_data->cdata->governor == GOV_LAB) {
+			struct od_cpu_dbs_info_s *od_dbs_info =
+				dbs_data->cdata->get_cpu_dbs_info_s(j);
+
+			od_dbs_info->idle_time = (100 * idle_time) / wall_time;
+		}
+
 		if (load > max_load)
 			max_load = load;
 	}
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 34b1cf2..82a519f 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -152,6 +152,7 @@ struct od_cpu_dbs_info_s {
 	unsigned int freq_lo_jiffies;
 	unsigned int freq_hi_jiffies;
 	unsigned int rate_mult;
+	unsigned int idle_time;
 	unsigned int sample_type:1;
 };
 
@@ -187,6 +188,7 @@ struct common_dbs_data {
 	/* Common across governors */
 	#define GOV_ONDEMAND		0
 	#define GOV_CONSERVATIVE	1
+	#define GOV_LAB                 2
 	int governor;
 	struct attribute_group *attr_group_gov_sys; /* one governor - system */
 	struct attribute_group *attr_group_gov_pol; /* one governor - policy */
-- 
1.7.10.4

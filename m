From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][v3] cpufreq: governor: Fix overflow when calculating idle time
Date: Tue, 19 Apr 2016 11:57:32 +0800
Message-ID: <1461038252-8687-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50567 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752410AbcDSDuu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 Apr 2016 23:50:50 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>

It was reported that after Commit 0df35026c6a5 ("cpufreq: governor:
Fix negative idle_time when configured with CONFIG_HZ_PERIODIC"),
cpufreq ondemand governor started to act oddly. Without any load,
with freshly booted system, it pumped cpu frequency up to maximum
at some point of time and stayed there. The problem is caused by
jiffies overflow in get_cpu_idle_time:

After booting up 5 minutes, the jiffies will round up to zero.
As a result, the following condition in cpu governor will always be
true:
	if (cur_idle_time <= j_cdbs->prev_cpu_idle)
		idle_time = 0;

which caused problems.

For example, once cur_idle_time has rounded up to zero, meanwhile
prev_cpu_idle still remains negative(because of jiffies initial value
of -300HZ, which is very big after converted to unsigned), thus above
condition is met, thus we get a zero of idle running time during
this sample, which causes a high busy time, thus governor always
requests for the highest freq.

This patch fixes this problem by updating prev_cpu_idle for
each sample period, even if prev_cpu_idle is bigger than
cur_idle_time, thus to prevent the scenario of 'prev_cpu_idle always
bigger than cur_idle_time' from happening.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=115261
Reported-by: Timo Valtoaho <timo.valtoaho@gmail.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v3:
 - Do not use INITIAL_JIFFIES because it should be transparent
   to user, meanwhile keep original semanteme to use delta
   of time slice.
---
v2:
 - Send this patch to a wider scope, including timing-system maintainers,
   as well as some modifications in the commit message to make it more clear.
---
 drivers/cpufreq/cpufreq.c          | 4 ++++
 drivers/cpufreq/cpufreq_governor.c | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b87596b..b0479b3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -132,6 +132,10 @@ struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(cpufreq_frequency_get_table);
 
+/**
+ * The wall time and idle time are both possible to round up,
+ * people should use delta rather than the value itself.
+ */
 static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
 {
 	u64 idle_time;
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 10a5cfe..8de3fba 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -197,8 +197,14 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			idle_time = 0;
 		} else {
 			idle_time = cur_idle_time - j_cdbs->prev_cpu_idle;
-			j_cdbs->prev_cpu_idle = cur_idle_time;
 		}
+		/*
+		 * It is possible prev_cpu_idle being bigger than cur_idle_time,
+		 * when 32bit rounds up if !CONFIG_VIRT_CPU_ACCOUNTING,
+		 * thus get a 0% idle estimation. So update prev_cpu_idle during
+		 * each sample period to avoid this situation lasting too long.
+		 */
+		j_cdbs->prev_cpu_idle = cur_idle_time;
 
 		if (ignore_nice) {
 			u64 cur_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
-- 
1.8.4.2


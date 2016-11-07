From: Markus Mayer <code@mmayer.net>
Subject: [PATCH v3] cpufreq: stats: clear statistics
Date: Mon,  7 Nov 2016 10:02:23 -0800
Message-ID: <20161107180223.44536-1-code@mmayer.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-out-so.shaw.ca ([64.59.136.137]:45839 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932411AbcKGSCi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2016 13:02:38 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>

From: Markus Mayer <mmayer@broadcom.com>

Allow CPUfreq statistics to be cleared by writing anything to
/sys/.../cpufreq/stats/reset.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---

Changes since v2:
    - changed name of write-only macro to cpufreq_freq_attr_wo()
    - removed "perm" parameter from write-only macro
    - squashed the two separate commits into a single one

Changes since v1:
    - add new cpufreq_freq_attr_wr_perm() macro for write-only
      attributes (because this is a separate commit, this patch has
      turned into a series)
    - remove the Kconfig option, compiling the code unconditionally
    - remove show_reset()
    - cpufreq_stats_clear_table() takes a struct cpufreq_stats * as
      argument rather than a struct cpufreq_policy *

 Documentation/cpu-freq/cpufreq-stats.txt |  6 ++++++
 drivers/cpufreq/cpufreq_stats.c          | 22 ++++++++++++++++++++++
 include/linux/cpufreq.h                  |  4 ++++
 3 files changed, 32 insertions(+)

diff --git a/Documentation/cpu-freq/cpufreq-stats.txt b/Documentation/cpu-freq/cpufreq-stats.txt
index 8d9773f..3c355f6 100644
--- a/Documentation/cpu-freq/cpufreq-stats.txt
+++ b/Documentation/cpu-freq/cpufreq-stats.txt
@@ -44,11 +44,17 @@ the stats driver insertion.
 total 0
 drwxr-xr-x  2 root root    0 May 14 16:06 .
 drwxr-xr-x  3 root root    0 May 14 15:58 ..
+--w-------  1 root root 4096 May 14 16:06 reset
 -r--r--r--  1 root root 4096 May 14 16:06 time_in_state
 -r--r--r--  1 root root 4096 May 14 16:06 total_trans
 -r--r--r--  1 root root 4096 May 14 16:06 trans_table
 --------------------------------------------------------------------------------
 
+-  reset
+Write-only attribute that can be used to reset the stat counters. This can be
+useful for evaluating system behaviour under different governors without the
+need for a reboot.
+
 -  time_in_state
 This gives the amount of time spent in each of the frequencies supported by
 this CPU. The cat output will have "<frequency> <time>" pair in each line, which
diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 06d3abd..ac284e6 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -41,6 +41,18 @@ static int cpufreq_stats_update(struct cpufreq_stats *stats)
 	return 0;
 }
 
+static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
+{
+	unsigned int count = stats->max_state;
+
+	memset(stats->time_in_state, 0, count * sizeof(u64));
+#ifdef CONFIG_CPU_FREQ_STAT_DETAILS
+	memset(stats->trans_table, 0, count * count * sizeof(int));
+#endif
+	stats->last_time = get_jiffies_64();
+	stats->total_trans = 0;
+}
+
 static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
 {
 	return sprintf(buf, "%d\n", policy->stats->total_trans);
@@ -64,6 +76,14 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 	return len;
 }
 
+static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
+			   size_t count)
+{
+	/* We don't care what is written to the attribute. */
+	cpufreq_stats_clear_table(policy->stats);
+	return count;
+}
+
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
 static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 {
@@ -113,10 +133,12 @@ cpufreq_freq_attr_ro(trans_table);
 
 cpufreq_freq_attr_ro(total_trans);
 cpufreq_freq_attr_ro(time_in_state);
+cpufreq_freq_attr_wo(reset);
 
 static struct attribute *default_attrs[] = {
 	&total_trans.attr,
 	&time_in_state.attr,
+	&reset.attr,
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
 	&trans_table.attr,
 #endif
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 5fa55fc..490573e 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -234,6 +234,10 @@ __ATTR(_name, _perm, show_##_name, NULL)
 static struct freq_attr _name =			\
 __ATTR(_name, 0644, show_##_name, store_##_name)
 
+#define cpufreq_freq_attr_wo(_name)		\
+static struct freq_attr _name =			\
+__ATTR(_name, 0200, NULL, store_##_name)
+
 struct global_attr {
 	struct attribute attr;
 	ssize_t (*show)(struct kobject *kobj,
-- 
2.7.4


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] cpufreq: stats: Declare freq-attr right after their callbacks
Date: Fri,  1 Feb 2019 11:45:44 +0530
Message-ID: <d5d8c15aca712342350d2f451002f55e15e9e93b.1549001732.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Freq attribute for "trans_table" is defined right after its callback
(without any blank line between them), but the others are defined
separately later on. Keep this consistent and define all attributes
right after their callbacks.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 1572129844a5..941e63e3e652 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -51,6 +51,7 @@ static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
 {
 	return sprintf(buf, "%d\n", policy->stats->total_trans);
 }
+cpufreq_freq_attr_ro(total_trans);
 
 static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 {
@@ -69,6 +70,7 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 	}
 	return len;
 }
+cpufreq_freq_attr_ro(time_in_state);
 
 static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
 			   size_t count)
@@ -77,6 +79,7 @@ static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
 	cpufreq_stats_clear_table(policy->stats);
 	return count;
 }
+cpufreq_freq_attr_wo(reset);
 
 static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 {
@@ -126,10 +129,6 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 }
 cpufreq_freq_attr_ro(trans_table);
 
-cpufreq_freq_attr_ro(total_trans);
-cpufreq_freq_attr_ro(time_in_state);
-cpufreq_freq_attr_wo(reset);
-
 static struct attribute *default_attrs[] = {
 	&total_trans.attr,
 	&time_in_state.attr,
-- 
2.20.1.321.g9e740568ce00

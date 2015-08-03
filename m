From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6/7] cpufreq: rename cpufreq_real_policy as cpufreq_user_policy
Date: Mon,  3 Aug 2015 08:36:19 +0530
Message-ID: <769b610d34870926a148edcd3ce2308eff497a6a.1438571116.git.viresh.kumar@linaro.org>
References: <cover.1438571116.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438571116.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438571116.git.viresh.kumar@linaro.org>
References: <cover.1438571116.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Its all about caching min/max freq requested by userspace, and
the name 'cpufreq_real_policy' doesn't fit that well. Rename it to
cpufreq_user_policy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/cpufreq.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 54dbbff0a55e..6ff6a4d95eea 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -51,7 +51,7 @@ struct cpufreq_cpuinfo {
 	unsigned int		transition_latency;
 };
 
-struct cpufreq_real_policy {
+struct cpufreq_user_policy {
 	unsigned int		min;    /* in kHz */
 	unsigned int		max;    /* in kHz */
 };
@@ -86,7 +86,7 @@ struct cpufreq_policy {
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
 
-	struct cpufreq_real_policy	user_policy;
+	struct cpufreq_user_policy user_policy;
 	struct cpufreq_frequency_table	*freq_table;
 
 	struct list_head        policy_list;
-- 
2.4.0

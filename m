From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 2/2] cpufreq: prevent lockup on reading scaling_available_frequencies
Date: Wed,  7 Oct 2015 13:50:44 -0700
Message-ID: <1444251044-11231-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1444251044-11231-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8113 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487AbbJGUvZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 16:51:25 -0400
In-Reply-To: <1444251044-11231-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When scaling_available_frequencies is read on an offlined cpu, then
either lockup or junk values are displayed. This is caused by
freed freq_table, which policy is using.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ef5ed94..25c4c15 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1436,8 +1436,10 @@ static void cpufreq_offline_finish(unsigned int cpu)
 	 * since this is a core component, and is essential for the
 	 * subsequent light-weight ->init() to succeed.
 	 */
-	if (cpufreq_driver->exit)
+	if (cpufreq_driver->exit) {
 		cpufreq_driver->exit(policy);
+		policy->freq_table = NULL;
+	}
 }
 
 /**
-- 
1.9.3


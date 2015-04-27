From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 1/2] cpufreq: arm_big_little: check if the frequency is set correctly
Date: Mon, 27 Apr 2015 10:51:05 +0100
Message-ID: <1430128266-15012-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56261 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752947AbbD0JvS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Apr 2015 05:51:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

The actual frequency is set through "clk_change_rate" which is void
function. If the underlying hardware fails and returns error, the error
is lost in the clk layer. In order to track such failures, we need to
read back the frequency(just the cached value as clk_recalc called after
clk->ops->set_rate gets the frequency)

This patch adds check to see if the frequency is set correctly or if
they were any hardware failures and sends the appropriate errors to the
cpufreq core.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Michael Turquette <mike.turquette@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/arm_big_little.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index e1a6ba66a7f5..f65e19f340d0 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -186,6 +186,15 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 		mutex_unlock(&cluster_lock[old_cluster]);
 	}
 
+	/*
+	 * FIXME: clk_set_rate has to handle the case where clk_change_rate
+	 * can fail due to hardware or firmware issues. Until the clk core
+	 * layer is fixed, we can check here. In most of the cases we will
+	 * be reading only the cached value anyway. This needs to  be removed
+	 * once clk core is fixed.
+	 */
+	if (bL_cpufreq_get_rate(cpu) != new_rate)
+		return -EIO;
 	return 0;
 }
 
-- 
1.9.1


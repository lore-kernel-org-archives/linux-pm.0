From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 1/2] cpufreq: arm_big_little: check if the frequency is set correctly
Date: Mon, 30 Mar 2015 13:27:17 +0100
Message-ID: <1427718438-31098-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60814 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbbC3M0b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 30 Mar 2015 08:26:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

The actual frequency is set through "clk_change_rate" which is void
function. If the underlying hardware fails and returns error, the error
is lost in the clk layer. In order to track such failures, we need to
read back the frequency(just the cached value as clk_recalc called after
clk->ops->set_rate gets the frequency)

This patch adds check to see if the frequency is set correctly or if
they were any hardware failures and sends the appropriate errors to the
cpufreq core.

Cc: Viresh Kumar <viresh.kumar@linaro.org> 
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/arm_big_little.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index e1a6ba66a7f5..3fc676c63f91 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -186,6 +186,8 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 		mutex_unlock(&cluster_lock[old_cluster]);
 	}
 
+	if (bL_cpufreq_get_rate(cpu) != new_rate)
+		return -EIO;
 	return 0;
 }
 
-- 
1.9.1


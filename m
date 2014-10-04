From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 2/2] cpufreq: cpu0: Handle regulator_get_voltage() failure
Date: Sat,  4 Oct 2014 20:26:04 +0000
Message-ID: <1412454365-17804-3-git-send-email-stefan.wahren@i2se.com>
References: <1412454365-17804-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:59547 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbaJDU0W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 4 Oct 2014 16:26:22 -0400
In-Reply-To: <1412454365-17804-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, shawn.guo@freescale.com, Stefan Wahren <stefan.wahren@i2se.com>

In error cases regulator_get_voltage() returns a negative value.
So take care of it.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/cpufreq/cpufreq-cpu0.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index ef3d618..6aa2104 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -77,7 +77,7 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
 	}
 
 	dev_dbg(cpu_dev, "%u MHz, %ld mV --> %u MHz, %ld mV\n",
-		old_freq / 1000, volt_old ? volt_old / 1000 : -1,
+		old_freq / 1000, (volt_old > 0) ? volt_old / 1000 : -1,
 		new_freq / 1000, volt ? volt / 1000 : -1);
 
 	/* scaling up?  scale voltage before frequency */
@@ -93,7 +93,7 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
 	ret = clk_set_rate(cpu_clk, freq_exact);
 	if (ret) {
 		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
-		if (!IS_ERR(cpu_reg))
+		if (!IS_ERR(cpu_reg) && volt_old > 0)
 			regulator_set_voltage_tol(cpu_reg, volt_old, tol);
 		return ret;
 	}
-- 
1.7.9.5


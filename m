From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 1/2] cpufreq: cpu0: Improve debug about matching OPP
Date: Sat,  4 Oct 2014 20:26:03 +0000
Message-ID: <1412454365-17804-2-git-send-email-stefan.wahren@i2se.com>
References: <1412454365-17804-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:62910 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbaJDU01 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 4 Oct 2014 16:26:27 -0400
In-Reply-To: <1412454365-17804-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, shawn.guo@freescale.com, Stefan Wahren <stefan.wahren@i2se.com>

During test of new DT OPPs it's very helpful to print the matching
OPP in case of frequency change. So it will be easier to find frequency
rounding issues in the dts file.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/cpufreq/cpufreq-cpu0.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index a5f8c5f..ef3d618 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -57,6 +57,8 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
 	old_freq = clk_get_rate(cpu_clk) / 1000;
 
 	if (!IS_ERR(cpu_reg)) {
+		unsigned long opp_freq;
+
 		rcu_read_lock();
 		opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_Hz);
 		if (IS_ERR(opp)) {
@@ -66,9 +68,12 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
 			return PTR_ERR(opp);
 		}
 		volt = dev_pm_opp_get_voltage(opp);
+		opp_freq = dev_pm_opp_get_freq(opp);
 		rcu_read_unlock();
 		tol = volt * priv->voltage_tolerance / 100;
 		volt_old = regulator_get_voltage(cpu_reg);
+		dev_dbg(cpu_dev, "Found OPP: %ld kHz, %ld uV\n",
+			opp_freq / 1000, volt);
 	}
 
 	dev_dbg(cpu_dev, "%u MHz, %ld mV --> %u MHz, %ld mV\n",
-- 
1.7.9.5


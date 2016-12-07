From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] Revert "PM / OPP: Don't assume platform doesn't have regulators"
Date: Wed,  7 Dec 2016 16:01:52 +0530
Message-ID: <1560e022c1584376cf5a55ed048e0b60485adf2b.1481106666.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36651 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752481AbcLGKcJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 05:32:09 -0500
Received: by mail-pg0-f47.google.com with SMTP id f188so160204119pgc.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2016 02:32:09 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, jonathanh@nvidia.com, swarren@nvidia.com, treding@nvidia.com, Viresh Kumar <viresh.kumar@linaro.org>

This reverts commit ef3caabee9691386e6801ea92150e37277db9c7a.

The commit was based on the assumption that a platform with voltages
specified with individual OPPs, would have registered a regulator as
well in order to do full DVFS.

That assumption is broken by the Tegra124 platform.

For Tegra124, the voltage is not scaled via a direct call to the
regulator subsystem because the DFLL directly controls the I2C interface
that controls the voltage. The DFLL essentially figures out the max
frequency for a given voltage. So to run at a particular frequency, the
DFLL continuously adjusts the voltage in a control loop fashion to get
the desired frequency.

Following are the logs from: NVIDIA Tegra124 Jetson TK1

  cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 696000 KHz
  cpu cpu0: dev_pm_opp_set_rate: Regulator not registered with OPP core
  cpufreq: __target_index: Failed to change cpu frequency: -22
  ------------[ cut here ]------------
  kernel BUG at drivers/cpufreq/cpufreq.c:1235!

Fix these by reverting the offending commit.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
Rafael, you can simply drop the patch if that is easier for you.
---
 drivers/base/power/opp/core.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 7db672f632d9..6af371a55062 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -747,20 +747,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	/* Only frequency scaling */
 	if (!regulators) {
-		unsigned long u_volt = opp->supplies[0].u_volt;
-
 		rcu_read_unlock();
-
-		/*
-		 * DT contained supply ratings? Consider platform failed to set
-		 * regulators.
-		 */
-		if (unlikely(u_volt)) {
-			dev_err(dev, "%s: Regulator not registered with OPP core\n",
-				__func__);
-			return -EINVAL;
-		}
-
 		return _generic_set_opp_clk_only(dev, clk, old_freq, freq);
 	}
 
-- 
2.7.1.410.g6faf27b


From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH -next] PM / OPP: Fix crash seen if CPU clock has no voltage regulator
Date: Mon, 15 Feb 2016 11:34:53 -0800
Message-ID: <1455564893-25455-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54414 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbcBOTe6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 14:34:58 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Viresh Kumar <viresh.kumar@linaro.org>

omap3 overo boots crash with

Unable to handle kernel NULL pointer dereference at virtual address 00000030
pgd = c0204000
[00000030] *pgd=00000000
Internal error: Oops: 17 [#1] SMP ARM
...
[] (regulator_set_voltage) from [] (_set_opp_voltage+0x34/0x90)
[] (_set_opp_voltage) from [] (dev_pm_opp_set_rate+0x19c/0x288)
[] (dev_pm_opp_set_rate) from [] (__cpufreq_driver_target+0x17c/0x29c)
[] (__cpufreq_driver_target) from [] (dbs_check_cpu+0x19c/0x1e4)
[] (dbs_check_cpu) from [] (cpufreq_governor_dbs+0x308/0x5c4)
[] (cpufreq_governor_dbs) from [] (__cpufreq_governor+0x20c/0x24c)
[] (__cpufreq_governor) from [] (cpufreq_init_policy+0x60/0x8c)
[] (cpufreq_init_policy) from [] (cpufreq_online+0x2cc/0x6d8)
[] (cpufreq_online) from [] (subsys_interface_register+0x80/0xc4)
[] (subsys_interface_register) from [] (cpufreq_register_driver+0x144/0x1a0)
[] (cpufreq_register_driver) from [] (dt_cpufreq_probe+0x64/0xe8)
[] (dt_cpufreq_probe) from [] (platform_drv_probe+0x50/0xb0)
[] (platform_drv_probe) from [] (driver_probe_device+0x1f4/0x2b0)
...

Analysis shows that regulator==NULL in regulator_set_voltage().
Code around _set_opp_voltage() suggests that having no voltage regulator
attached to a CPU clock is valid, so do not attempt to set a voltage
in that case.

Fixes: 6a0712f6f199e ("PM / OPP: Add dev_pm_opp_set_rate()"
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/base/power/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index d7cd4e265766..82ad5ae72427 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -564,7 +564,7 @@ static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 	int ret;
 
 	/* Regulator not available for device */
-	if (IS_ERR(reg)) {
+	if (IS_ERR_OR_NULL(reg)) {
 		dev_dbg(dev, "%s: regulator not available: %ld\n", __func__,
 			PTR_ERR(reg));
 		return 0;
-- 
2.5.0


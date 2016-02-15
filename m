From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: Initialize u_volt_min/max to a valid value
Date: Mon, 15 Feb 2016 10:21:53 +0530
Message-ID: <13b96a7623af4969747e1c2f9f7994e7affb00d4.1455511404.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34400 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbcBOEwG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Feb 2016 23:52:06 -0500
Received: by mail-pa0-f44.google.com with SMTP id fy10so39940233pac.1
        for <linux-pm@vger.kernel.org>; Sun, 14 Feb 2016 20:52:05 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <vireshk@kernel.org>

We kept u_volt_min/max initialized to 0, when only the target voltage is
present in DT, instead of the target/min/max triplet.

This didn't go well with the regulator framework, as on few calls the
min voltage was set to target and max was set to 0 and so resulted in a
kernel crash like below:

kernel BUG at ../drivers/regulator/core.c:216!

[<c0684af4>] (regulator_check_voltage) from [<c06857ac>] (regulator_set_voltage_unlocked+0x58/0x230)
[<c06857ac>] (regulator_set_voltage_unlocked) from [<c06859ac>] (regulator_set_voltage+0x28/0x54)
[<c06859ac>] (regulator_set_voltage) from [<c0775b28>] (_set_opp_voltage+0x30/0x98)
[<c0775b28>] (_set_opp_voltage) from [<c0776630>] (dev_pm_opp_set_rate+0xf0/0x28c)
[<c0776630>] (dev_pm_opp_set_rate) from [<c096f784>] (__cpufreq_driver_target+0x184/0x2b4)
[<c096f784>] (__cpufreq_driver_target) from [<c0973760>] (dbs_check_cpu+0x1b0/0x1f4)
[<c0973760>] (dbs_check_cpu) from [<c0973f30>] (cpufreq_governor_dbs+0x324/0x5c4)
[<c0973f30>] (cpufreq_governor_dbs) from [<c0970958>] (__cpufreq_governor+0xe4/0x1ec)
[<c0970958>] (__cpufreq_governor) from [<c09711e0>] (cpufreq_init_policy+0x64/0x8c)
[<c09711e0>] (cpufreq_init_policy) from [<c09718cc>] (cpufreq_online+0x2fc/0x708)
[<c09718cc>] (cpufreq_online) from [<c0765ff0>] (subsys_interface_register+0x94/0xd8)
[<c0765ff0>] (subsys_interface_register) from [<c0970530>] (cpufreq_register_driver+0x14c/0x19c)
[<c0970530>] (cpufreq_register_driver) from [<c09746dc>] (dt_cpufreq_probe+0x70/0xec)
[<c09746dc>] (dt_cpufreq_probe) from [<c076907c>] (platform_drv_probe+0x4c/0xb0)
[<c076907c>] (platform_drv_probe) from [<c07678e0>] (driver_probe_device+0x214/0x2c0)
[<c07678e0>] (driver_probe_device) from [<c0767a18>] (__driver_attach+0x8c/0x90)
[<c0767a18>] (__driver_attach) from [<c0765c2c>] (bus_for_each_dev+0x68/0x9c)
[<c0765c2c>] (bus_for_each_dev) from [<c0766d78>] (bus_add_driver+0x1a0/0x218)
[<c0766d78>] (bus_add_driver) from [<c076810c>] (driver_register+0x78/0xf8)
[<c076810c>] (driver_register) from [<c0301d74>] (do_one_initcall+0x90/0x1d8)
[<c0301d74>] (do_one_initcall) from [<c1100e14>] (kernel_init_freeable+0x15c/0x1fc)
[<c1100e14>] (kernel_init_freeable) from [<c0b27a0c>] (kernel_init+0x8/0xf0)
[<c0b27a0c>] (kernel_init) from [<c0307d78>] (ret_from_fork+0x14/0x3c)
Code: e1550004 baffffeb e3a00000 e8bd8070 (e7f001f2)

Fix that by initializing u_volt_min/max to the target voltage in such cases.

Reported-and-tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: 274659029c9d ("PM / OPP: Add support to parse "operating-points-v2" bindings")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Rafael,

This fixes a patch which was introduced in 4.2, but that wasn't used
until recently and is only used in linux-next as of now. So, no need of
a stable kernel tag.

 drivers/base/power/opp/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index d7cd4e265766..19fd7e7a3969 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1157,8 +1157,14 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 	}
 
 	opp->u_volt = microvolt[0];
-	opp->u_volt_min = microvolt[1];
-	opp->u_volt_max = microvolt[2];
+
+	if (count == 1) {
+		opp->u_volt_min = opp->u_volt;
+		opp->u_volt_max = opp->u_volt;
+	} else {
+		opp->u_volt_min = microvolt[1];
+		opp->u_volt_max = microvolt[2];
+	}
 
 	/* Search for "opp-microamp-<name>" */
 	prop = NULL;
-- 
2.7.1.397.g2a43f26


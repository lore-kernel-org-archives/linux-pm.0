From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V4 patch 05/15] ARM: at91: cpuidle: use init/exit common routine
Date: Tue, 23 Apr 2013 10:54:35 +0200
Message-ID: <1366707285-12179-6-git-send-email-daniel.lezcano@linaro.org>
References: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:43443 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756492Ab3DWIzE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 04:55:04 -0400
Received: by mail-we0-f173.google.com with SMTP id o7so331663wea.4
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2013 01:55:01 -0700 (PDT)
In-Reply-To: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: andrew@lunn.ch, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, rob.herring@calxeda.com, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, kernel@pengutronix.de

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/cpuidle.c |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
index 0130df7..48f1228 100644
--- a/arch/arm/mach-at91/cpuidle.c
+++ b/arch/arm/mach-at91/cpuidle.c
@@ -27,8 +27,6 @@
 
 #define AT91_MAX_STATES	2
 
-static DEFINE_PER_CPU(struct cpuidle_device, at91_cpuidle_device);
-
 /* Actual code that puts the SoC in different idle states */
 static int at91_enter_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
@@ -60,20 +58,9 @@ static struct cpuidle_driver at91_idle_driver = {
 };
 
 /* Initialize CPU idle by registering the idle states */
-static int at91_init_cpuidle(void)
+static int __init at91_init_cpuidle(void)
 {
-	struct cpuidle_device *device;
-
-	device = &per_cpu(at91_cpuidle_device, smp_processor_id());
-	device->state_count = AT91_MAX_STATES;
-
-	cpuidle_register_driver(&at91_idle_driver);
-
-	if (cpuidle_register_device(device)) {
-		printk(KERN_ERR "at91_init_cpuidle: Failed registering\n");
-		return -EIO;
-	}
-	return 0;
+	return cpuidle_register(&at91_idle_driver, NULL);
 }
 
 device_initcall(at91_init_cpuidle);
-- 
1.7.9.5


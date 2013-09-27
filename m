From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] ARM: highbank: cpuidle: convert to platform driver
Date: Fri, 27 Sep 2013 12:47:45 +0200
Message-ID: <1380278865-27457-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:58494 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab3I0Krx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 06:47:53 -0400
Received: by mail-we0-f172.google.com with SMTP id w61so2443665wes.17
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2013 03:47:52 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rob.herring@calxeda.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

As the ux500 and the kirkwood driver, make the calxeda driver a platform driver

[Compiled only]

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-highbank/highbank.c |    8 ++++++++
 drivers/cpuidle/cpuidle-calxeda.c |   18 ++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 8e63ccd..a78ed62 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -25,6 +25,7 @@
 #include <linux/of_address.h>
 #include <linux/amba/bus.h>
 #include <linux/clk-provider.h>
+#include <linux/platform_device.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
@@ -153,6 +154,10 @@ static struct notifier_block highbank_platform_nb = {
 	.notifier_call = highbank_platform_notifier,
 };
 
+static struct platform_device highbank_cpuidle_device = {
+	.name = "cpuidle-calxeda",
+};
+
 static void __init highbank_init(void)
 {
 	pm_power_off = highbank_power_off;
@@ -162,6 +167,9 @@ static void __init highbank_init(void)
 	bus_register_notifier(&amba_bustype, &highbank_amba_nb);
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	if (of_machine_is_compatible("calxeda,highbank"))
+		platform_device_register(&highbank_cpuidle_device);
 }
 
 static const char *highbank_match[] __initconst = {
diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
index 3460584..7b6105b 100644
--- a/drivers/cpuidle/cpuidle-calxeda.c
+++ b/drivers/cpuidle/cpuidle-calxeda.c
@@ -23,10 +23,10 @@
 #include <linux/cpuidle.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of.h>
 #include <linux/time.h>
 #include <linux/delay.h>
 #include <linux/suspend.h>
+#include <linux/platform_device.h>
 #include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
 #include <asm/smp_scu.h>
@@ -88,11 +88,17 @@ static struct cpuidle_driver calxeda_idle_driver = {
 	.state_count = 2,
 };
 
-static int __init calxeda_cpuidle_init(void)
+static int __init calxeda_cpuidle_probe(struct platform_device *pdev)
 {
-	if (!of_machine_is_compatible("calxeda,highbank"))
-		return -ENODEV;
-
 	return cpuidle_register(&calxeda_idle_driver, NULL);
 }
-module_init(calxeda_cpuidle_init);
+
+static struct platform_driver calxeda_cpuidle_plat_driver = {
+        .driver = {
+                .name = "cpuidle-calxeda",
+                .owner = THIS_MODULE,
+        },
+        .probe = calxeda_cpuidle_probe,
+};
+
+module_platform_driver(calxeda_cpuidle_plat_driver);
-- 
1.7.9.5


From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] cpufreq: dt: Create platform device from generic code
Date: Thu, 24 Mar 2016 14:36:18 +0100
Message-ID: <5800397.rNERvs0XYE@wuerfel>
References: <cover.1458801338.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56177 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757657AbcCXNgl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 09:36:41 -0400
In-Reply-To: <cover.1458801338.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, kgene.kim@samsung.com, heiko@sntech.de, xf@rock-chips.com, mmcclint@codeaurora.org, linux-pm@vger.kernel.org

On Thursday 24 March 2016 12:10:27 Viresh Kumar wrote:
> Multiple platforms are using the generic cpufreq-dt driver now, and all
> of them are required to create a platform device with name "cpufreq-dt",
> in order to get the cpufreq-dt probed.
> 
> Many of them do it from platform code, others have special drivers just
> to do that.
> 
> It would be more sensible to do this at a generic place, where all such
> platform can mark their entries.
> 
> The first patch fixes an issue that becomes visible only after the
> second patch is applied. The second one creates a new driver to create
> platform-device based on current platform and the last one converts
> exynos platform to use this common infrastructure.
> 
> I will migrate rest of the platforms after this is accepted as the right
> way ahead.
> 
> @Arnd: Does this look sane? We can fix the arm64 (no platform code)
> issue with this now.
> 
> Viresh Kumar (3):
>   cpufreq: dt: Include types.h from cpufreq-dt.h
>   cpufreq: dt: Add generic platform-device creation support
>   cpufreq: exynos: Use generic platdev driver
> 

Hi Viresh,

Thanks for picking this up again!

I've tried implementing something similar when we last discussed it,
but didn't get far enough to test it our properly, and I had trouble
integrating some of the more complex platforms (omap, imx, sunxi)
that have lots of root compatible strings to fit in nicely.

I think having a lookup table as in your patch 2 makes sense here,
but I still would prefer not having a device at all. See the patch
below for how I think that can be avoided. Do you see any problems
with that?

Another idea I had was to make dt_cpufreq_init() a global function
that can simply be called by platforms that pass non-NULL platform
data today, avoiding the need for the pdata in a global location.

	Arnd

commit 63a47a8ac1568bb4331a624f3267f8ee8532d211
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Mon Feb 8 16:51:54 2016 +0100

    cpufreq/berlin: move berlin platform device into cpufreq-dt.c
    
    It's completely senseless to create a platform device for cpufreq-dt,
    so this removes the platform and instead adds a minimal check into
    the cpufreq-dt.c code as the start of a platform whitelist.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
index 25d73870ccca..ac181c6797ee 100644
--- a/arch/arm/mach-berlin/berlin.c
+++ b/arch/arm/mach-berlin/berlin.c
@@ -18,11 +18,6 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 
-static void __init berlin_init_late(void)
-{
-	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
-}
-
 static const char * const berlin_dt_compat[] = {
 	"marvell,berlin",
 	NULL,
@@ -30,7 +25,6 @@ static const char * const berlin_dt_compat[] = {
 
 DT_MACHINE_START(BERLIN_DT, "Marvell Berlin")
 	.dt_compat	= berlin_dt_compat,
-	.init_late	= berlin_init_late,
 	/*
 	 * with DT probing for L2CCs, berlin_init_machine can be removed.
 	 * Note: 88DE3005 (Armada 1500-mini) uses pl310 l2cc
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index f951f911786e..b3817cc86597 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -356,7 +356,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.suspend = cpufreq_generic_suspend,
 };
 
-static int dt_cpufreq_probe(struct platform_device *pdev)
+static int 	(void *data)
 {
 	int ret;
 
@@ -371,15 +371,22 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);
+	dt_cpufreq_driver.driver_data = data;
 
 	ret = cpufreq_register_driver(&dt_cpufreq_driver);
 	if (ret)
-		dev_err(&pdev->dev, "failed register driver: %d\n", ret);
+		pr_err("failed register driver: %d\n", ret);
 
 	return ret;
 }
 
+/* a minimal fake platform device for platforms that still call
+ * platform_device_create(). Don't use */
+static int dt_cpufreq_probe(struct platform_device *pdev)
+{
+	return dt_cpufreq_init(dev_get_platdata(&pdev->dev));
+}
+
 static int dt_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&dt_cpufreq_driver);
@@ -393,7 +400,24 @@ static struct platform_driver dt_cpufreq_platdrv = {
 	.probe		= dt_cpufreq_probe,
 	.remove		= dt_cpufreq_remove,
 };
-module_platform_driver(dt_cpufreq_platdrv);
+
+static int __init cpufreq_dt_init(void)
+{
+	if (of_machine_is_compatible("marvell,berlin"))
+		return dt_cpufreq_init(NULL);
+
+	return platform_driver_register(&dt_cpufreq_platdrv);
+}
+module_init(cpufreq_dt_init);
+
+static void cpufreq_dt_exit(void)
+{
+	if (dt_cpufreq_platdrv.driver.bus)
+		platform_driver_unregister(&dt_cpufreq_platdrv);
+	else
+		cpufreq_unregister_driver(&dt_cpufreq_driver);
+}
+module_exit(cpufreq_dt_exit);
 
 MODULE_ALIAS("platform:cpufreq-dt");
 MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");


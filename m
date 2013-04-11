From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V2 patch 03/19] cpuidle: remove en_core_tk_irqen flag
Date: Thu, 11 Apr 2013 22:42:33 +0200
Message-ID: <1365712969-7541-4-git-send-email-daniel.lezcano@linaro.org>
References: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:34790 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161035Ab3DKUnD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2013 16:43:03 -0400
Received: by mail-wg0-f43.google.com with SMTP id f12so2098636wgh.10
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2013 13:43:02 -0700 (PDT)
In-Reply-To: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

The en_core_tk_irqen flag is set in all the cpuidle driver which
means it is not necessary to specify this flag.

Remove the flag and the code related to it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/cpuidle.c                    |    1 -
 arch/arm/mach-davinci/cpuidle.c                 |    1 -
 arch/arm/mach-exynos/cpuidle.c                  |    1 -
 arch/arm/mach-imx/cpuidle-imx6q.c               |    1 -
 arch/arm/mach-imx/pm-imx5.c                     |    1 -
 arch/arm/mach-omap2/cpuidle34xx.c               |    1 -
 arch/arm/mach-omap2/cpuidle44xx.c               |    1 -
 arch/arm/mach-s3c64xx/cpuidle.c                 |    1 -
 arch/arm/mach-shmobile/cpuidle.c                |    1 -
 arch/arm/mach-shmobile/pm-sh7372.c              |    1 -
 arch/arm/mach-tegra/cpuidle-tegra114.c          |    1 -
 arch/arm/mach-tegra/cpuidle-tegra20.c           |    1 -
 arch/arm/mach-tegra/cpuidle-tegra30.c           |    1 -
 arch/arm/mach-ux500/cpuidle.c                   |    1 -
 arch/powerpc/platforms/pseries/processor_idle.c |    1 -
 arch/sh/kernel/cpu/shmobile/cpuidle.c           |    1 -
 arch/x86/kernel/apm_32.c                        |    1 -
 drivers/acpi/processor_idle.c                   |    1 -
 drivers/cpuidle/cpuidle-calxeda.c               |    1 -
 drivers/cpuidle/cpuidle-kirkwood.c              |    1 -
 drivers/cpuidle/cpuidle.c                       |   72 ++++++-----------------
 drivers/idle/intel_idle.c                       |    1 -
 include/linux/cpuidle.h                         |   11 ----
 23 files changed, 18 insertions(+), 86 deletions(-)

diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
index 0c63815..0130df7 100644
--- a/arch/arm/mach-at91/cpuidle.c
+++ b/arch/arm/mach-at91/cpuidle.c
@@ -47,7 +47,6 @@ static int at91_enter_idle(struct cpuidle_device *dev,
 static struct cpuidle_driver at91_idle_driver = {
 	.name			= "at91_idle",
 	.owner			= THIS_MODULE,
-	.en_core_tk_irqen	= 1,
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.states[1]		= {
 		.enter			= at91_enter_idle,
diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 22d6d4a..c2887c5 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -62,7 +62,6 @@ static int davinci_enter_idle(struct cpuidle_device *dev,
 static struct cpuidle_driver davinci_idle_driver = {
 	.name			= "cpuidle-davinci",
 	.owner			= THIS_MODULE,
-	.en_core_tk_irqen	= 1,
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.states[1]		= {
 		.enter			= davinci_enter_idle,
diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index fcfe025..498a7a2 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -58,7 +58,6 @@ static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
 static struct cpuidle_driver exynos4_idle_driver = {
 	.name			= "exynos4_idle",
 	.owner			= THIS_MODULE,
-	.en_core_tk_irqen	= 1,
 };
 
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index a783a63..e2739ad 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -45,7 +45,6 @@ done:
 static struct cpuidle_driver imx6q_cpuidle_driver = {
 	.name = "imx6q_cpuidle",
 	.owner = THIS_MODULE,
-	.en_core_tk_irqen = 1,
 	.states = {
 		/* WFI */
 		ARM_CPUIDLE_WFI_STATE,
diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index f67fd7e..4b52b3e 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -164,7 +164,6 @@ static int imx5_cpuidle_enter(struct cpuidle_device *dev,
 static struct cpuidle_driver imx5_cpuidle_driver = {
 	.name			= "imx5_cpuidle",
 	.owner			= THIS_MODULE,
-	.en_core_tk_irqen	= 1,
 	.states[0]	= {
 		.enter			= imx5_cpuidle_enter,
 		.exit_latency		= 2,
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index a56310a..027a787 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -264,7 +264,6 @@ static DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
 static struct cpuidle_driver omap3_idle_driver = {
 	.name             = "omap3_idle",
 	.owner            = THIS_MODULE,
-	.en_core_tk_irqen = 1,
 	.states = {
 		{
 			.enter		  = omap3_enter_idle_bm,
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index f4b1b23..cd188de 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -162,7 +162,6 @@ static DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
 static struct cpuidle_driver omap4_idle_driver = {
 	.name				= "omap4_idle",
 	.owner				= THIS_MODULE,
-	.en_core_tk_irqen		= 1,
 	.states = {
 		{
 			/* C1 - CPU0 ON + CPU1 ON + MPU ON */
diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx/cpuidle.c
index ead5fab..852ff16 100644
--- a/arch/arm/mach-s3c64xx/cpuidle.c
+++ b/arch/arm/mach-s3c64xx/cpuidle.c
@@ -45,7 +45,6 @@ static DEFINE_PER_CPU(struct cpuidle_device, s3c64xx_cpuidle_device);
 static struct cpuidle_driver s3c64xx_cpuidle_driver = {
 	.name	= "s3c64xx_cpuidle",
 	.owner  = THIS_MODULE,
-	.en_core_tk_irqen = 1,
 	.states = {
 		{
 			.enter            = s3c64xx_enter_idle,
diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index c872ae8..d671ae9 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -20,7 +20,6 @@ static struct cpuidle_device shmobile_cpuidle_dev;
 static struct cpuidle_driver shmobile_cpuidle_default_driver = {
 	.name			= "shmobile_cpuidle",
 	.owner			= THIS_MODULE,
-	.en_core_tk_irqen	= 1,
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.safe_state_index	= 0, /* C1 */
 	.state_count		= 1,
diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index fbef7b9..dec9293 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -410,7 +410,6 @@ static int sh7372_enter_a4s(struct cpuidle_device *dev,
 static struct cpuidle_driver sh7372_cpuidle_driver = {
 	.name			= "sh7372_cpuidle",
 	.owner			= THIS_MODULE,
-	.en_core_tk_irqen	= 1,
 	.state_count		= 5,
 	.safe_state_index	= 0, /* C1 */
 	.states[0] = ARM_CPUIDLE_WFI_STATE,
diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index c527cff..c5fadf9 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -23,7 +23,6 @@
 static struct cpuidle_driver tegra_idle_driver = {
 	.name = "tegra_idle",
 	.owner = THIS_MODULE,
-	.en_core_tk_irqen = 1,
 	.state_count = 1,
 	.states = {
 		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index b94d76a..f1f6ac4 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -51,7 +51,6 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 static struct cpuidle_driver tegra_idle_driver = {
 	.name = "tegra_idle",
 	.owner = THIS_MODULE,
-	.en_core_tk_irqen = 1,
 	.states = {
 		ARM_CPUIDLE_WFI_STATE_PWR(600),
 #ifdef CONFIG_PM_SLEEP
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index c4e01fe..f6a0c72 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -43,7 +43,6 @@ static int tegra30_idle_lp2(struct cpuidle_device *dev,
 static struct cpuidle_driver tegra_idle_driver = {
 	.name = "tegra_idle",
 	.owner = THIS_MODULE,
-	.en_core_tk_irqen = 1,
 #ifdef CONFIG_PM_SLEEP
 	.state_count = 2,
 #else
diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
index 1b16d9e..c29c1bf 100644
--- a/arch/arm/mach-ux500/cpuidle.c
+++ b/arch/arm/mach-ux500/cpuidle.c
@@ -94,7 +94,6 @@ out:
 static struct cpuidle_driver ux500_idle_driver = {
 	.name = "ux500_idle",
 	.owner = THIS_MODULE,
-	.en_core_tk_irqen = 1,
 	.states = {
 		ARM_CPUIDLE_WFI_STATE,
 		{
diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index a197120..4644efa0 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -25,7 +25,6 @@
 struct cpuidle_driver pseries_idle_driver = {
 	.name             = "pseries_idle",
 	.owner            = THIS_MODULE,
-	.en_core_tk_irqen = 1,
 };
 
 #define MAX_IDLE_STATE_COUNT	2
diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
index 1ddc876..0986f21 100644
--- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
@@ -55,7 +55,6 @@ static struct cpuidle_device cpuidle_dev;
 static struct cpuidle_driver cpuidle_driver = {
 	.name			= "sh_idle",
 	.owner			= THIS_MODULE,
-	.en_core_tk_irqen	= 1,
 };
 
 void sh_mobile_setup_cpuidle(void)
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 66b5faf..53a4e27 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -373,7 +373,6 @@ static int apm_cpu_idle(struct cpuidle_device *dev,
 static struct cpuidle_driver apm_idle_driver = {
 	.name = "apm_idle",
 	.owner = THIS_MODULE,
-	.en_core_tk_irqen = 1,
 	.states = {
 		{ /* entry 0 is for polling */ },
 		{ /* entry 1 is for APM idle */
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ee255c6..f0df2c9 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -918,7 +918,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 struct cpuidle_driver acpi_idle_driver = {
 	.name =		"acpi_idle",
 	.owner =	THIS_MODULE,
-	.en_core_tk_irqen = 1,
 };
 
 /**
diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
index e1aab38..a3b56f5 100644
--- a/drivers/cpuidle/cpuidle-calxeda.c
+++ b/drivers/cpuidle/cpuidle-calxeda.c
@@ -100,7 +100,6 @@ static void calxeda_idle_cpuidle_devices_uninit(void)
 
 static struct cpuidle_driver calxeda_idle_driver = {
 	.name = "calxeda_idle",
-	.en_core_tk_irqen = 1,
 	.states = {
 		ARM_CPUIDLE_WFI_STATE,
 		{
diff --git a/drivers/cpuidle/cpuidle-kirkwood.c b/drivers/cpuidle/cpuidle-kirkwood.c
index 53aad73..6f31524 100644
--- a/drivers/cpuidle/cpuidle-kirkwood.c
+++ b/drivers/cpuidle/cpuidle-kirkwood.c
@@ -41,7 +41,6 @@ static int kirkwood_enter_idle(struct cpuidle_device *dev,
 static struct cpuidle_driver kirkwood_idle_driver = {
 	.name			= "kirkwood_idle",
 	.owner			= THIS_MODULE,
-	.en_core_tk_irqen	= 1,
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.states[1]		= {
 		.enter			= kirkwood_enter_idle,
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c500370..0da795b 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -43,24 +43,6 @@ void disable_cpuidle(void)
 
 static int __cpuidle_register_device(struct cpuidle_device *dev);
 
-static inline int cpuidle_enter(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int index)
-{
-	struct cpuidle_state *target_state = &drv->states[index];
-	return target_state->enter(dev, drv, index);
-}
-
-static inline int cpuidle_enter_tk(struct cpuidle_device *dev,
-			       struct cpuidle_driver *drv, int index)
-{
-	return cpuidle_wrap_enter(dev, drv, index, cpuidle_enter);
-}
-
-typedef int (*cpuidle_enter_t)(struct cpuidle_device *dev,
-			       struct cpuidle_driver *drv, int index);
-
-static cpuidle_enter_t cpuidle_enter_ops;
-
 /**
  * cpuidle_play_dead - cpu off-lining
  *
@@ -90,11 +72,27 @@ int cpuidle_play_dead(void)
  * @next_state: index into drv->states of the state to enter
  */
 int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
-		int next_state)
+			int index)
 {
 	int entered_state;
 
-	entered_state = cpuidle_enter_ops(dev, drv, next_state);
+	struct cpuidle_state *target_state = &drv->states[index];
+	ktime_t time_start, time_end;
+	s64 diff;
+
+	time_start = ktime_get();
+
+	entered_state = target_state->enter(dev, drv, index);
+
+	time_end = ktime_get();
+
+	local_irq_enable();
+
+	diff = ktime_to_us(ktime_sub(time_end, time_start));
+	if (diff > INT_MAX)
+		diff = INT_MAX;
+
+	dev->last_residency = (int) diff;
 
 	if (entered_state >= 0) {
 		/* Update cpuidle counters */
@@ -231,37 +229,6 @@ void cpuidle_resume(void)
 	mutex_unlock(&cpuidle_lock);
 }
 
-/**
- * cpuidle_wrap_enter - performs timekeeping and irqen around enter function
- * @dev: pointer to a valid cpuidle_device object
- * @drv: pointer to a valid cpuidle_driver object
- * @index: index of the target cpuidle state.
- */
-int cpuidle_wrap_enter(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int index,
-				int (*enter)(struct cpuidle_device *dev,
-					struct cpuidle_driver *drv, int index))
-{
-	ktime_t time_start, time_end;
-	s64 diff;
-
-	time_start = ktime_get();
-
-	index = enter(dev, drv, index);
-
-	time_end = ktime_get();
-
-	local_irq_enable();
-
-	diff = ktime_to_us(ktime_sub(time_end, time_start));
-	if (diff > INT_MAX)
-		diff = INT_MAX;
-
-	dev->last_residency = (int) diff;
-
-	return index;
-}
-
 #ifdef CONFIG_ARCH_HAS_CPU_RELAX
 static int poll_idle(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
@@ -333,9 +300,6 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 			return ret;
 	}
 
-	cpuidle_enter_ops = drv->en_core_tk_irqen ?
-		cpuidle_enter_tk : cpuidle_enter;
-
 	poll_idle_init(drv);
 
 	ret = cpuidle_add_device_sysfs(dev);
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 5d66750..48d7584 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -71,7 +71,6 @@
 static struct cpuidle_driver intel_idle_driver = {
 	.name = "intel_idle",
 	.owner = THIS_MODULE,
-	.en_core_tk_irqen = 1,
 };
 /* intel_idle.max_cstate=0 disables driver */
 static int max_cstate = CPUIDLE_STATE_MAX - 1;
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index fc3e580..79e3811 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -105,8 +105,6 @@ struct cpuidle_driver {
 	struct module 		*owner;
 	int                     refcnt;
 
-	/* set to 1 to use the core cpuidle time keeping (for all states). */
-	unsigned int		en_core_tk_irqen:1;
         /* used by the cpuidle framework to setup the broadcast timer */
 	unsigned int            bctimer:1;
 	/* states array must be ordered in decreasing power consumption */
@@ -132,10 +130,6 @@ extern void cpuidle_pause(void);
 extern void cpuidle_resume(void);
 extern int cpuidle_enable_device(struct cpuidle_device *dev);
 extern void cpuidle_disable_device(struct cpuidle_device *dev);
-extern int cpuidle_wrap_enter(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int index,
-				int (*enter)(struct cpuidle_device *dev,
-					struct cpuidle_driver *drv, int index));
 extern int cpuidle_play_dead(void);
 
 extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev);
@@ -162,11 +156,6 @@ static inline void cpuidle_resume(void) { }
 static inline int cpuidle_enable_device(struct cpuidle_device *dev)
 {return -ENODEV; }
 static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
-static inline int cpuidle_wrap_enter(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int index,
-				int (*enter)(struct cpuidle_device *dev,
-					struct cpuidle_driver *drv, int index))
-{ return -ENODEV; }
 static inline int cpuidle_play_dead(void) {return -ENODEV; }
 #endif
 
-- 
1.7.9.5


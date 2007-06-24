From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH -mm 4/4] PM: Rework struct
	platform_suspend_operations
Date: Sun, 24 Jun 2007 22:44:50 +0200
Message-ID: <200706242244.51335.rjw__46871.8821568929$1182721138$gmane$org@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706242239.05678.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

There is no reason why the .prepare() and .finish() methods in 'struct
platform_suspend_operations' should take any arguments, since architectures
don't use these methods' argument in any practically meaningful way (ie. either
the target system sleep state is conveyed to the platform by .set_target(), or
there is only one suspend state supported and it is indicated to the PM core by
.valid(), or .prepare() and .finish() aren't defined at all).  There also is
no reason why .finish() should return any result.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/common/sharpsl_pm.c             |    2 -
 arch/arm/mach-omap1/pm.c                 |   20 +-----------
 arch/arm/mach-omap2/pm.c                 |   21 +------------
 arch/arm/mach-pxa/pm.c                   |   24 ---------------
 arch/arm/mach-pxa/pxa25x.c               |   12 -------
 arch/arm/mach-pxa/pxa27x.c               |   11 ------
 arch/blackfin/mach-common/pm.c           |   49 +++----------------------------
 arch/powerpc/platforms/52xx/mpc52xx_pm.c |    8 +----
 drivers/acpi/sleep/main.c                |    7 +---
 include/asm-arm/arch-pxa/pm.h            |    2 -
 include/linux/suspend.h                  |   19 ++++++------
 kernel/power/main.c                      |   12 +------
 12 files changed, 30 insertions(+), 157 deletions(-)

Index: linux-2.6.22-rc5/include/linux/suspend.h
===================================================================
--- linux-2.6.22-rc5.orig/include/linux/suspend.h	2007-06-24 20:45:20.000000000 +0200
+++ linux-2.6.22-rc5/include/linux/suspend.h	2007-06-24 20:48:56.000000000 +0200
@@ -40,8 +40,9 @@ typedef int __bitwise suspend_state_t;
  *	entered.  The information passed to @set_target should be disregarded
  *	by the platform as soon as @finish() is executed and if	@prepare()
  *	fails.
- *	This callback is optional.  However, if it is implemented, the
- *	argument passed to @prepare(), @enter and @finish() must be ignored.
+ *	This callback is optional, but it must be implemented if @prepare() and
+ *	@finish() are.  Moreover, if it is implemented, the argument passed to
+ *	@enter() is meaningless and therefore must be ignored.
  *
  * @prepare: Prepare the platform for entering the system sleep state indicated
  *	by @set_target().
@@ -49,22 +50,24 @@ typedef int __bitwise suspend_state_t;
  *	error code otherwise, in which case the system cannot enter given
  *	sleep state.
  *
- * @enter: Enter the system sleep state indicated by @set_target().
+ * @enter: Enter the system sleep state indicated by @set_target() or given as
+ *	the argument if @set_target() is not implemented.
  *	This callback is mandatory.  It returns 0 on success or a negative
  *	error code otherwise, in which case the system cannot enter given
- *	sleep state.
+ *	sleep state.  If @set_target() is called prior to it, the argument is
+ *	meaningless and must be ignored.
  *
  * @finish: Called when the system has just left a sleep state.
  *	This callback is optional, but should be implemented by platforms that
- *	implement @prepare().  It is always called after @enter() (even if
- *	@enter() fails).
+ *	implement @prepare().  If implemented, it is always called after
+ *	@enter() (even if @enter() fails).
  */
 struct platform_suspend_operations {
 	int (*valid)(suspend_state_t state);
 	int (*set_target)(suspend_state_t state);
-	int (*prepare)(suspend_state_t state);
+	int (*prepare)(void);
 	int (*enter)(suspend_state_t state);
-	int (*finish)(suspend_state_t state);
+	void (*finish)(void);
 };
 
 extern struct platform_suspend_operations *suspend_ops;
Index: linux-2.6.22-rc5/kernel/power/main.c
===================================================================
--- linux-2.6.22-rc5.orig/kernel/power/main.c	2007-06-24 20:45:20.000000000 +0200
+++ linux-2.6.22-rc5/kernel/power/main.c	2007-06-24 20:45:26.000000000 +0200
@@ -59,13 +59,6 @@ int suspend_valid_only_mem(suspend_state
 	return state == PM_SUSPEND_MEM;
 }
 
-
-static inline void pm_finish(suspend_state_t state)
-{
-	if (suspend_ops->finish)
-		suspend_ops->finish(state);
-}
-
 /**
  *	suspend_prepare - Do prep work before entering low-power state.
  *
@@ -172,7 +165,7 @@ int suspend_devices_and_enter(suspend_st
 		goto Resume_console;
 	}
 	if (suspend_ops->prepare) {
-		error = suspend_ops->prepare(state);
+		error = suspend_ops->prepare();
 		if (error)
 			goto Resume_devices;
 	}
@@ -181,7 +174,8 @@ int suspend_devices_and_enter(suspend_st
 		suspend_enter(state);
 
 	enable_nonboot_cpus();
-	pm_finish(state);
+	if (suspend_ops->finish)
+		suspend_ops->finish();
  Resume_devices:
 	device_resume();
  Resume_console:
Index: linux-2.6.22-rc5/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.22-rc5.orig/drivers/acpi/sleep/main.c	2007-06-24 20:45:20.000000000 +0200
+++ linux-2.6.22-rc5/drivers/acpi/sleep/main.c	2007-06-24 20:49:21.000000000 +0200
@@ -61,13 +61,12 @@ static int acpi_pm_set_target(suspend_st
 
 /**
  *	acpi_pm_prepare - Do preliminary suspend work.
- *	@pm_state: ignored
  *
  *	If necessary, set the firmware waking vector and do arch-specific
  *	nastiness to get the wakeup code to the waking vector.
  */
 
-static int acpi_pm_prepare(suspend_state_t pm_state)
+static int acpi_pm_prepare(void)
 {
 	int error = acpi_sleep_prepare(acpi_target_suspend_state);
 
@@ -144,13 +143,12 @@ static int acpi_pm_enter(suspend_state_t
 
 /**
  *	acpi_pm_finish - Finish up suspend sequence.
- *	@pm_state: ignored
  *
  *	This is called after we wake back up (or if entering the sleep state
  *	failed). 
  */
 
-static int acpi_pm_finish(suspend_state_t pm_state)
+static void acpi_pm_finish(void)
 {
 	u32 acpi_state = acpi_target_suspend_state;
 
@@ -166,7 +164,6 @@ static int acpi_pm_finish(suspend_state_
 		printk("Broken toshiba laptop -> kicking interrupts\n");
 		init_8259A(0);
 	}
-	return 0;
 }
 
 int acpi_suspend(u32 acpi_state)
Index: linux-2.6.22-rc5/arch/arm/common/sharpsl_pm.c
===================================================================
--- linux-2.6.22-rc5.orig/arch/arm/common/sharpsl_pm.c	2007-06-24 20:45:20.000000000 +0200
+++ linux-2.6.22-rc5/arch/arm/common/sharpsl_pm.c	2007-06-24 20:45:26.000000000 +0200
@@ -767,9 +767,7 @@ static void sharpsl_apm_get_power_status
 }
 
 static struct platform_suspend_operations sharpsl_pm_ops = {
-	.prepare	= pxa_pm_prepare,
 	.enter		= corgi_pxa_pm_enter,
-	.finish		= pxa_pm_finish,
 	.valid		= suspend_valid_only_mem,
 };
 
Index: linux-2.6.22-rc5/arch/arm/mach-pxa/pm.c
===================================================================
--- linux-2.6.22-rc5.orig/arch/arm/mach-pxa/pm.c	2007-06-24 20:45:21.000000000 +0200
+++ linux-2.6.22-rc5/arch/arm/mach-pxa/pm.c	2007-06-24 20:45:26.000000000 +0200
@@ -201,32 +201,8 @@ unsigned long sleep_phys_sp(void *sp)
 	return virt_to_phys(sp);
 }
 
-/*
- * Called after processes are frozen, but before we shut down devices.
- */
-int pxa_pm_prepare(suspend_state_t state)
-{
-	extern int pxa_cpu_pm_prepare(suspend_state_t state);
-
-	return pxa_cpu_pm_prepare(state);
-}
-
-EXPORT_SYMBOL_GPL(pxa_pm_prepare);
-
-/*
- * Called after devices are re-setup, but before processes are thawed.
- */
-int pxa_pm_finish(suspend_state_t state)
-{
-	return 0;
-}
-
-EXPORT_SYMBOL_GPL(pxa_pm_finish);
-
 static struct platform_suspend_operations pxa_pm_ops = {
-	.prepare	= pxa_pm_prepare,
 	.enter		= pxa_pm_enter,
-	.finish		= pxa_pm_finish,
 	.valid		= suspend_valid_only_mem,
 };
 
Index: linux-2.6.22-rc5/arch/arm/mach-pxa/pxa25x.c
===================================================================
--- linux-2.6.22-rc5.orig/arch/arm/mach-pxa/pxa25x.c	2007-06-24 20:38:28.000000000 +0200
+++ linux-2.6.22-rc5/arch/arm/mach-pxa/pxa25x.c	2007-06-24 20:45:26.000000000 +0200
@@ -105,18 +105,6 @@ EXPORT_SYMBOL(get_lcdclk_frequency_10khz
 
 #ifdef CONFIG_PM
 
-int pxa_cpu_pm_prepare(suspend_state_t state)
-{
-	switch (state) {
-	case PM_SUSPEND_MEM:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 void pxa_cpu_pm_enter(suspend_state_t state)
 {
 	extern void pxa_cpu_suspend(unsigned int);
Index: linux-2.6.22-rc5/arch/arm/mach-pxa/pxa27x.c
===================================================================
--- linux-2.6.22-rc5.orig/arch/arm/mach-pxa/pxa27x.c	2007-06-24 20:38:28.000000000 +0200
+++ linux-2.6.22-rc5/arch/arm/mach-pxa/pxa27x.c	2007-06-24 20:45:26.000000000 +0200
@@ -122,17 +122,6 @@ EXPORT_SYMBOL(get_lcdclk_frequency_10khz
 
 #ifdef CONFIG_PM
 
-int pxa_cpu_pm_prepare(suspend_state_t state)
-{
-	switch (state) {
-	case PM_SUSPEND_MEM:
-	case PM_SUSPEND_STANDBY:
-		return 0;
-	default:
-		return -EINVAL;
-	}
-}
-
 void pxa_cpu_pm_enter(suspend_state_t state)
 {
 	extern void pxa_cpu_standby(void);
Index: linux-2.6.22-rc5/include/asm-arm/arch-pxa/pm.h
===================================================================
--- linux-2.6.22-rc5.orig/include/asm-arm/arch-pxa/pm.h	2007-06-24 20:38:28.000000000 +0200
+++ linux-2.6.22-rc5/include/asm-arm/arch-pxa/pm.h	2007-06-24 20:45:26.000000000 +0200
@@ -7,6 +7,4 @@
  *
  */
 
-extern int pxa_pm_prepare(suspend_state_t state);
 extern int pxa_pm_enter(suspend_state_t state);
-extern int pxa_pm_finish(suspend_state_t state);
Index: linux-2.6.22-rc5/arch/arm/mach-omap1/pm.c
===================================================================
--- linux-2.6.22-rc5.orig/arch/arm/mach-omap1/pm.c	2007-06-24 20:45:21.000000000 +0200
+++ linux-2.6.22-rc5/arch/arm/mach-omap1/pm.c	2007-06-24 20:48:48.000000000 +0200
@@ -613,27 +613,15 @@ static void (*saved_idle)(void) = NULL;
 
 /*
  *	omap_pm_prepare - Do preliminary suspend work.
- *	@state:		suspend state we're entering.
  *
  */
-static int omap_pm_prepare(suspend_state_t state)
+static int omap_pm_prepare(void)
 {
-	int error = 0;
-
 	/* We cannot sleep in idle until we have resumed */
 	saved_idle = pm_idle;
 	pm_idle = NULL;
 
-	switch (state)
-	{
-	case PM_SUSPEND_STANDBY:
-	case PM_SUSPEND_MEM:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return error;
+	return 0;
 }
 
 
@@ -661,16 +649,14 @@ static int omap_pm_enter(suspend_state_t
 
 /**
  *	omap_pm_finish - Finish up suspend sequence.
- *	@state:		State we're coming out of.
  *
  *	This is called after we wake back up (or if entering the sleep state
  *	failed).
  */
 
-static int omap_pm_finish(suspend_state_t state)
+static void omap_pm_finish(void)
 {
 	pm_idle = saved_idle;
-	return 0;
 }
 
 
Index: linux-2.6.22-rc5/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-2.6.22-rc5.orig/arch/arm/mach-omap2/pm.c	2007-06-24 20:45:21.000000000 +0200
+++ linux-2.6.22-rc5/arch/arm/mach-omap2/pm.c	2007-06-24 20:53:15.000000000 +0200
@@ -72,26 +72,10 @@ void omap2_pm_idle(void)
 
 static int omap2_pm_prepare(suspend_state_t state)
 {
-	int error = 0;
-
 	/* We cannot sleep in idle until we have resumed */
 	saved_idle = pm_idle;
 	pm_idle = NULL;
-
-	switch (state)
-	{
-	case PM_SUSPEND_STANDBY:
-	case PM_SUSPEND_MEM:
-		break;
-
-	case PM_SUSPEND_DISK:
-		return -ENOTSUPP;
-
-	default:
-		return -EINVAL;
-	}
-
-	return error;
+	return 0;
 }
 
 #define INT0_WAKE_MASK	(OMAP_IRQ_BIT(INT_24XX_GPIO_BANK1) |	\
@@ -362,10 +346,9 @@ static int omap2_pm_enter(suspend_state_
 	return ret;
 }
 
-static int omap2_pm_finish(suspend_state_t state)
+static void omap2_pm_finish(suspend_state_t state)
 {
 	pm_idle = saved_idle;
-	return 0;
 }
 
 static struct platform_suspend_operations omap_pm_ops = {
Index: linux-2.6.22-rc5/arch/blackfin/mach-common/pm.c
===================================================================
--- linux-2.6.22-rc5.orig/arch/blackfin/mach-common/pm.c	2007-06-24 20:45:21.000000000 +0200
+++ linux-2.6.22-rc5/arch/blackfin/mach-common/pm.c	2007-06-24 21:00:17.000000000 +0200
@@ -89,28 +89,15 @@ void bfin_pm_suspend_standby_enter(void)
 #endif				/* CONFIG_PM_WAKEUP_GPIO_BY_SIC_IWR */
 }
 
-
 /*
- *	bfin_pm_prepare - Do preliminary suspend work.
- *	@state:		suspend state we're entering.
+ *	bfin_pm_valid - Tell the PM core that we only support the standby sleep
+ *			state
+ *	@state:		suspend state we're checking.
  *
  */
-static int bfin_pm_prepare(suspend_state_t state)
+static int bfin_pm_valid(suspend_state_t state)
 {
-	int error = 0;
-
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
-		break;
-
-	case PM_SUSPEND_MEM:
-		return -ENOTSUPP;
-
-	default:
-		return -EINVAL;
-	}
-
-	return error;
+	return (state == PM_SUSPEND_STANDBY);
 }
 
 /*
@@ -135,33 +122,9 @@ static int bfin_pm_enter(suspend_state_t
 	return 0;
 }
 
-/*
- *	bfin_pm_finish - Finish up suspend sequence.
- *	@state:		State we're coming out of.
- *
- *	This is called after we wake back up (or if entering the sleep state
- *	failed).
- */
-static int bfin_pm_finish(suspend_state_t state)
-{
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
-		break;
-
-	case PM_SUSPEND_MEM:
-		return -ENOTSUPP;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 struct platform_suspend_operations bfin_pm_ops = {
-	.prepare = bfin_pm_prepare,
+	.valid = bfin_pm_valid,
 	.enter = bfin_pm_enter,
-	.finish = bfin_pm_finish,
 };
 
 static int __init bfin_pm_init(void)
Index: linux-2.6.22-rc5/arch/powerpc/platforms/52xx/mpc52xx_pm.c
===================================================================
--- linux-2.6.22-rc5.orig/arch/powerpc/platforms/52xx/mpc52xx_pm.c	2007-06-24 20:45:21.000000000 +0200
+++ linux-2.6.22-rc5/arch/powerpc/platforms/52xx/mpc52xx_pm.c	2007-06-24 21:07:41.000000000 +0200
@@ -25,6 +25,7 @@ static void *sram;
 static int sram_size;
 
 struct mpc52xx_suspend mpc52xx_suspend;
+static suspend_state_t mpc52xx_pm_target_state;
 
 static int mpc52xx_pm_valid(suspend_state_t state)
 {
@@ -57,11 +58,8 @@ int mpc52xx_set_wakeup_gpio(u8 pin, u8 l
 	return 0;
 }
 
-int mpc52xx_pm_prepare(suspend_state_t state)
+static int mpc52xx_pm_prepare(void)
 {
-	if (state != PM_SUSPEND_STANDBY)
-		return -EINVAL;
-
 	/* map the whole register space */
 	mbar = mpc52xx_find_and_map("mpc5200");
 	if (!mbar) {
@@ -166,7 +164,7 @@ int mpc52xx_pm_enter(suspend_state_t sta
 	return 0;
 }
 
-int mpc52xx_pm_finish(suspend_state_t state)
+static void mpc52xx_pm_finish(void)
 {
 	/* call board resume code */
 	if (mpc52xx_suspend.board_resume_finish)

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH -mm 5/8] PM: Rename struct pm_ops and
	related things
Date: Tue, 26 Jun 2007 00:48:32 +0200
Message-ID: <200706260048.33588.rjw__29403.4791332253$1182812323$gmane$org@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl> <200706260039.17530.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706260039.17530.rjw@sisk.pl>
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

The name of 'struct pm_ops' suggests that it is related to the power management
in general, but in fact it is only related to suspend.  Moreover, its name
should indicate what this structure is used for, so it seems reasonable to
change it to 'struct platform_suspend_operations'.  In that case, the name of
the global variable of this type used by the PM core and the names of related
functions should be changed accordingly.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 Documentation/power/interface.txt        |    2 -
 arch/arm/common/sharpsl_pm.c             |    8 +++----
 arch/arm/mach-at91/pm.c                  |    4 +--
 arch/arm/mach-omap1/pm.c                 |    6 ++---
 arch/arm/mach-omap2/pm.c                 |    6 ++---
 arch/arm/mach-pnx4008/pm.c               |    4 +--
 arch/arm/mach-pxa/pm.c                   |    6 ++---
 arch/arm/mach-sa1100/pm.c                |    6 ++---
 arch/arm/plat-s3c24xx/pm.c               |    6 ++---
 arch/blackfin/mach-common/pm.c           |    4 +--
 arch/powerpc/platforms/52xx/mpc52xx_pm.c |    4 +--
 arch/sh/boards/hp6xx/pm.c                |    6 ++---
 drivers/acpi/sleep/main.c                |    6 ++---
 include/linux/suspend.h                  |   20 +++++++++---------
 kernel/power/main.c                      |   34 +++++++++++++++----------------
 15 files changed, 61 insertions(+), 61 deletions(-)

Index: linux-2.6.22-rc6/include/linux/suspend.h
===================================================================
--- linux-2.6.22-rc6.orig/include/linux/suspend.h	2007-06-25 21:53:50.000000000 +0200
+++ linux-2.6.22-rc6/include/linux/suspend.h	2007-06-25 21:53:51.000000000 +0200
@@ -26,16 +26,16 @@ typedef int __bitwise suspend_state_t;
 #define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
 
 /**
- * struct pm_ops - Callbacks for managing platform dependent system sleep
- *	states.
+ * struct platform_suspend_operations - Callbacks for managing platform
+ *	dependent system sleep states.
  *
  * @valid: Callback to determine if given system sleep state is supported by
  *	the platform.
  *	Valid (ie. supported) states are advertised in /sys/power/state.  Note
  *	that it still may be impossible to enter given system sleep state if the
  *	conditions aren't right.
- *	There is the %pm_valid_only_mem function available that can be assigned
- *	to this if the platform only supports mem sleep.
+ *	There is the %suspend_valid_only_mem function available that can be
+ *	assigned to this if the platform only supports mem sleep.
  *
  * @set_target: Tell the platform which system sleep state is going to be
  *	entered.
@@ -72,7 +72,7 @@ typedef int __bitwise suspend_state_t;
  *	that implement @prepare().  If implemented, it is always called after
  *	@enter() (even if @enter() fails).
  */
-struct pm_ops {
+struct platform_suspend_operations {
 	int (*valid)(suspend_state_t state);
 	int (*set_target)(suspend_state_t state);
 	int (*prepare)(suspend_state_t state);
@@ -80,14 +80,14 @@ struct pm_ops {
 	int (*finish)(suspend_state_t state);
 };
 
-extern struct pm_ops *pm_ops;
+extern struct platform_suspend_operations *suspend_ops;
 
 /**
- * pm_set_ops - set platform dependent power management ops
- * @pm_ops: The new power management operations to set.
+ * suspend_set_ops - set platform dependent suspend operations
+ * @ops: The new suspend operations to set.
  */
-extern void pm_set_ops(struct pm_ops *pm_ops);
-extern int pm_valid_only_mem(suspend_state_t state);
+extern void suspend_set_ops(struct platform_suspend_operations *ops);
+extern int suspend_valid_only_mem(suspend_state_t state);
 
 /**
  * arch_suspend_disable_irqs - disable IRQs for suspend
Index: linux-2.6.22-rc6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.22-rc6.orig/drivers/acpi/sleep/main.c	2007-06-25 21:53:44.000000000 +0200
+++ linux-2.6.22-rc6/drivers/acpi/sleep/main.c	2007-06-25 21:53:51.000000000 +0200
@@ -21,7 +21,7 @@
 
 u8 sleep_states[ACPI_S_STATE_COUNT];
 
-static struct pm_ops acpi_pm_ops;
+static struct platform_suspend_operations acpi_pm_ops;
 
 extern void do_suspend_lowlevel(void);
 
@@ -200,7 +200,7 @@ static int acpi_pm_state_valid(suspend_s
 	}
 }
 
-static struct pm_ops acpi_pm_ops = {
+static struct platform_suspend_operations acpi_pm_ops = {
 	.valid = acpi_pm_state_valid,
 	.set_target = acpi_pm_set_target,
 	.prepare = acpi_pm_prepare,
@@ -358,7 +358,7 @@ int __init acpi_sleep_init(void)
 	}
 	printk(")\n");
 
-	pm_set_ops(&acpi_pm_ops);
+	suspend_set_ops(&acpi_pm_ops);
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	if (sleep_states[ACPI_STATE_S4])
Index: linux-2.6.22-rc6/kernel/power/main.c
===================================================================
--- linux-2.6.22-rc6.orig/kernel/power/main.c	2007-06-25 21:53:44.000000000 +0200
+++ linux-2.6.22-rc6/kernel/power/main.c	2007-06-25 21:53:51.000000000 +0200
@@ -33,28 +33,28 @@ DEFINE_MUTEX(pm_mutex);
 unsigned int pm_flags;
 EXPORT_SYMBOL(pm_flags);
 
-struct pm_ops *pm_ops;
+struct platform_suspend_operations *suspend_ops;
 
 /**
- *	pm_set_ops - Set the global power method table. 
+ *	suspend_set_ops - Set the global suspend method table.
  *	@ops:	Pointer to ops structure.
  */
 
-void pm_set_ops(struct pm_ops * ops)
+void suspend_set_ops(struct platform_suspend_operations *ops)
 {
 	mutex_lock(&pm_mutex);
-	pm_ops = ops;
+	suspend_ops = ops;
 	mutex_unlock(&pm_mutex);
 }
 
 /**
- * pm_valid_only_mem - generic memory-only valid callback
+ * suspend_valid_only_mem - generic memory-only valid callback
  *
- * pm_ops drivers that implement mem suspend only and only need
+ * Platform drivers that implement mem suspend only and only need
  * to check for that in their .valid callback can use this instead
  * of rolling their own .valid callback.
  */
-int pm_valid_only_mem(suspend_state_t state)
+int suspend_valid_only_mem(suspend_state_t state)
 {
 	return state == PM_SUSPEND_MEM;
 }
@@ -62,8 +62,8 @@ int pm_valid_only_mem(suspend_state_t st
 
 static inline void pm_finish(suspend_state_t state)
 {
-	if (pm_ops->finish)
-		pm_ops->finish(state);
+	if (suspend_ops->finish)
+		suspend_ops->finish(state);
 }
 
 /**
@@ -77,7 +77,7 @@ static int suspend_prepare(void)
 	int error;
 	unsigned int free_pages;
 
-	if (!pm_ops || !pm_ops->enter)
+	if (!suspend_ops || !suspend_ops->enter)
 		return -EPERM;
 
 	error = pm_notifier_call_chain(PM_SUSPEND_PREPARE);
@@ -140,7 +140,7 @@ int suspend_enter(suspend_state_t state)
 		printk(KERN_ERR "Some devices failed to power down\n");
 		goto Done;
 	}
-	error = pm_ops->enter(state);
+	error = suspend_ops->enter(state);
 	device_power_up();
  Done:
 	arch_suspend_enable_irqs();
@@ -157,11 +157,11 @@ int suspend_devices_and_enter(suspend_st
 {
 	int error;
 
-	if (!pm_ops)
+	if (!suspend_ops)
 		return -ENOSYS;
 
-	if (pm_ops->set_target) {
-		error = pm_ops->set_target(state);
+	if (suspend_ops->set_target) {
+		error = suspend_ops->set_target(state);
 		if (error)
 			return error;
 	}
@@ -171,8 +171,8 @@ int suspend_devices_and_enter(suspend_st
 		printk(KERN_ERR "Some devices failed to suspend\n");
 		goto Resume_console;
 	}
-	if (pm_ops->prepare) {
-		error = pm_ops->prepare(state);
+	if (suspend_ops->prepare) {
+		error = suspend_ops->prepare(state);
 		if (error)
 			goto Resume_devices;
 	}
@@ -215,7 +215,7 @@ static inline int valid_state(suspend_st
 	/* All states need lowlevel support and need to be valid
 	 * to the lowlevel implementation, no valid callback
 	 * implies that none are valid. */
-	if (!pm_ops || !pm_ops->valid || !pm_ops->valid(state))
+	if (!suspend_ops || !suspend_ops->valid || !suspend_ops->valid(state))
 		return 0;
 	return 1;
 }
Index: linux-2.6.22-rc6/Documentation/power/interface.txt
===================================================================
--- linux-2.6.22-rc6.orig/Documentation/power/interface.txt	2007-06-25 21:53:44.000000000 +0200
+++ linux-2.6.22-rc6/Documentation/power/interface.txt	2007-06-25 21:53:51.000000000 +0200
@@ -20,7 +20,7 @@ states.
 /sys/power/disk controls the operating mode of the suspend-to-disk
 mechanism. Suspend-to-disk can be handled in several ways. We have a
 few options for putting the system to sleep - using the platform driver
-(e.g. ACPI or other pm_ops), powering off the system or rebooting the
+(e.g. ACPI or other suspend_ops), powering off the system or rebooting the
 system (for testing).
 
 Additionally, /sys/power/disk can be used to turn on one of the two testing
Index: linux-2.6.22-rc6/arch/arm/common/sharpsl_pm.c
===================================================================
--- linux-2.6.22-rc6.orig/arch/arm/common/sharpsl_pm.c	2007-06-25 21:53:50.000000000 +0200
+++ linux-2.6.22-rc6/arch/arm/common/sharpsl_pm.c	2007-06-25 21:53:51.000000000 +0200
@@ -766,11 +766,11 @@ static void sharpsl_apm_get_power_status
 	info->battery_life = sharpsl_pm.battstat.mainbat_percent;
 }
 
-static struct pm_ops sharpsl_pm_ops = {
+static struct platform_suspend_operations sharpsl_pm_ops = {
 	.prepare	= pxa_pm_prepare,
 	.enter		= corgi_pxa_pm_enter,
 	.finish		= pxa_pm_finish,
-	.valid		= pm_valid_only_mem,
+	.valid		= suspend_valid_only_mem,
 };
 
 static int __init sharpsl_pm_probe(struct platform_device *pdev)
@@ -802,7 +802,7 @@ static int __init sharpsl_pm_probe(struc
 
 	apm_get_power_status = sharpsl_apm_get_power_status;
 
-	pm_set_ops(&sharpsl_pm_ops);
+	suspend_set_ops(&sharpsl_pm_ops);
 
 	mod_timer(&sharpsl_pm.ac_timer, jiffies + msecs_to_jiffies(250));
 
@@ -811,7 +811,7 @@ static int __init sharpsl_pm_probe(struc
 
 static int sharpsl_pm_remove(struct platform_device *pdev)
 {
-	pm_set_ops(NULL);
+	suspend_set_ops(NULL);
 
 	device_remove_file(&pdev->dev, &dev_attr_battery_percentage);
 	device_remove_file(&pdev->dev, &dev_attr_battery_voltage);
Index: linux-2.6.22-rc6/arch/arm/mach-at91/pm.c
===================================================================
--- linux-2.6.22-rc6.orig/arch/arm/mach-at91/pm.c	2007-06-25 21:53:50.000000000 +0200
+++ linux-2.6.22-rc6/arch/arm/mach-at91/pm.c	2007-06-25 21:53:51.000000000 +0200
@@ -198,7 +198,7 @@ error:
 }
 
 
-static struct pm_ops at91_pm_ops ={
+static struct platform_suspend_operations at91_pm_ops ={
 	.valid		= at91_pm_valid_state,
 	.set_target	= at91_pm_set_target,
 	.enter		= at91_pm_enter,
@@ -219,7 +219,7 @@ static int __init at91_pm_init(void)
 	/* Disable SDRAM low-power mode.  Cannot be used with self-refresh. */
 	at91_sys_write(AT91_SDRAMC_LPR, 0);
 
-	pm_set_ops(&at91_pm_ops);
+	suspend_set_ops(&at91_pm_ops);
 
 	return 0;
 }
Index: linux-2.6.22-rc6/arch/arm/mach-omap1/pm.c
===================================================================
--- linux-2.6.22-rc6.orig/arch/arm/mach-omap1/pm.c	2007-06-25 21:53:50.000000000 +0200
+++ linux-2.6.22-rc6/arch/arm/mach-omap1/pm.c	2007-06-25 21:53:51.000000000 +0200
@@ -687,11 +687,11 @@ static struct irqaction omap_wakeup_irq 
 
 
 
-static struct pm_ops omap_pm_ops ={
+static struct platform_suspend_operations omap_pm_ops ={
 	.prepare	= omap_pm_prepare,
 	.enter		= omap_pm_enter,
 	.finish		= omap_pm_finish,
-	.valid		= pm_valid_only_mem,
+	.valid		= suspend_valid_only_mem,
 };
 
 static int __init omap_pm_init(void)
@@ -748,7 +748,7 @@ static int __init omap_pm_init(void)
 	else if (cpu_is_omap16xx())
 		omap_writel(OMAP1610_IDLECT3_VAL, OMAP1610_IDLECT3);
 
-	pm_set_ops(&omap_pm_ops);
+	suspend_set_ops(&omap_pm_ops);
 
 #if defined(DEBUG) && defined(CONFIG_PROC_FS)
 	omap_pm_init_proc();
Index: linux-2.6.22-rc6/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-2.6.22-rc6.orig/arch/arm/mach-omap2/pm.c	2007-06-25 21:53:50.000000000 +0200
+++ linux-2.6.22-rc6/arch/arm/mach-omap2/pm.c	2007-06-25 21:53:51.000000000 +0200
@@ -368,11 +368,11 @@ static int omap2_pm_finish(suspend_state
 	return 0;
 }
 
-static struct pm_ops omap_pm_ops = {
+static struct platform_suspend_operations omap_pm_ops = {
 	.prepare	= omap2_pm_prepare,
 	.enter		= omap2_pm_enter,
 	.finish		= omap2_pm_finish,
-	.valid		= pm_valid_only_mem,
+	.valid		= suspend_valid_only_mem,
 };
 
 int __init omap2_pm_init(void)
@@ -396,7 +396,7 @@ int __init omap2_pm_init(void)
 	omap2_sram_suspend = omap_sram_push(omap24xx_cpu_suspend,
 					    omap24xx_cpu_suspend_sz);
 
-	pm_set_ops(&omap_pm_ops);
+	suspend_set_ops(&omap_pm_ops);
 	pm_idle = omap2_pm_idle;
 
 	pmdomain_init();
Index: linux-2.6.22-rc6/arch/arm/mach-pnx4008/pm.c
===================================================================
--- linux-2.6.22-rc6.orig/arch/arm/mach-pnx4008/pm.c	2007-06-25 21:53:50.000000000 +0200
+++ linux-2.6.22-rc6/arch/arm/mach-pnx4008/pm.c	2007-06-25 21:53:51.000000000 +0200
@@ -117,7 +117,7 @@ static int pnx4008_pm_valid(suspend_stat
 	       (state == PM_SUSPEND_MEM);
 }
 
-static struct pm_ops pnx4008_pm_ops = {
+static struct platform_suspend_operations pnx4008_pm_ops = {
 	.enter = pnx4008_pm_enter,
 	.valid = pnx4008_pm_valid,
 };
@@ -146,7 +146,7 @@ static int __init pnx4008_pm_init(void)
 		return -ENOMEM;
 	}
 
-	pm_set_ops(&pnx4008_pm_ops);
+	suspend_set_ops(&pnx4008_pm_ops);
 	return 0;
 }
 
Index: linux-2.6.22-rc6/arch/arm/mach-pxa/pm.c
===================================================================
--- linux-2.6.22-rc6.orig/arch/arm/mach-pxa/pm.c	2007-06-25 21:53:44.000000000 +0200
+++ linux-2.6.22-rc6/arch/arm/mach-pxa/pm.c	2007-06-25 21:53:51.000000000 +0200
@@ -223,16 +223,16 @@ int pxa_pm_finish(suspend_state_t state)
 
 EXPORT_SYMBOL_GPL(pxa_pm_finish);
 
-static struct pm_ops pxa_pm_ops = {
+static struct platform_suspend_operations pxa_pm_ops = {
 	.prepare	= pxa_pm_prepare,
 	.enter		= pxa_pm_enter,
 	.finish		= pxa_pm_finish,
-	.valid		= pm_valid_only_mem,
+	.valid		= suspend_valid_only_mem,
 };
 
 static int __init pxa_pm_init(void)
 {
-	pm_set_ops(&pxa_pm_ops);
+	suspend_set_ops(&pxa_pm_ops);
 	return 0;
 }
 
Index: linux-2.6.22-rc6/arch/arm/mach-sa1100/pm.c
===================================================================
--- linux-2.6.22-rc6.orig/arch/arm/mach-sa1100/pm.c	2007-06-25 21:53:44.000000000 +0200
+++ linux-2.6.22-rc6/arch/arm/mach-sa1100/pm.c	2007-06-25 21:53:51.000000000 +0200
@@ -131,14 +131,14 @@ unsigned long sleep_phys_sp(void *sp)
 	return virt_to_phys(sp);
 }
 
-static struct pm_ops sa11x0_pm_ops = {
+static struct platform_suspend_operations sa11x0_pm_ops = {
 	.enter		= sa11x0_pm_enter,
-	.valid		= pm_valid_only_mem,
+	.valid		= suspend_valid_only_mem,
 };
 
 static int __init sa11x0_pm_init(void)
 {
-	pm_set_ops(&sa11x0_pm_ops);
+	suspend_set_ops(&sa11x0_pm_ops);
 	return 0;
 }
 
Index: linux-2.6.22-rc6/arch/arm/plat-s3c24xx/pm.c
===================================================================
--- linux-2.6.22-rc6.orig/arch/arm/plat-s3c24xx/pm.c	2007-06-25 21:53:44.000000000 +0200
+++ linux-2.6.22-rc6/arch/arm/plat-s3c24xx/pm.c	2007-06-25 21:53:51.000000000 +0200
@@ -612,9 +612,9 @@ static int s3c2410_pm_enter(suspend_stat
 	return 0;
 }
 
-static struct pm_ops s3c2410_pm_ops = {
+static struct platform_suspend_operations s3c2410_pm_ops = {
 	.enter		= s3c2410_pm_enter,
-	.valid		= pm_valid_only_mem,
+	.valid		= suspend_valid_only_mem,
 };
 
 /* s3c2410_pm_init
@@ -628,6 +628,6 @@ int __init s3c2410_pm_init(void)
 {
 	printk("S3C2410 Power Management, (c) 2004 Simtec Electronics\n");
 
-	pm_set_ops(&s3c2410_pm_ops);
+	suspend_set_ops(&s3c2410_pm_ops);
 	return 0;
 }
Index: linux-2.6.22-rc6/arch/blackfin/mach-common/pm.c
===================================================================
--- linux-2.6.22-rc6.orig/arch/blackfin/mach-common/pm.c	2007-06-25 21:53:50.000000000 +0200
+++ linux-2.6.22-rc6/arch/blackfin/mach-common/pm.c	2007-06-25 21:53:51.000000000 +0200
@@ -158,7 +158,7 @@ static int bfin_pm_finish(suspend_state_
 	return 0;
 }
 
-struct pm_ops bfin_pm_ops = {
+struct platform_suspend_operations bfin_pm_ops = {
 	.prepare = bfin_pm_prepare,
 	.enter = bfin_pm_enter,
 	.finish = bfin_pm_finish,
@@ -166,7 +166,7 @@ struct pm_ops bfin_pm_ops = {
 
 static int __init bfin_pm_init(void)
 {
-	pm_set_ops(&bfin_pm_ops);
+	suspend_set_ops(&bfin_pm_ops);
 	return 0;
 }
 
Index: linux-2.6.22-rc6/arch/powerpc/platforms/52xx/mpc52xx_pm.c
===================================================================
--- linux-2.6.22-rc6.orig/arch/powerpc/platforms/52xx/mpc52xx_pm.c	2007-06-25 21:53:50.000000000 +0200
+++ linux-2.6.22-rc6/arch/powerpc/platforms/52xx/mpc52xx_pm.c	2007-06-25 21:53:51.000000000 +0200
@@ -177,7 +177,7 @@ int mpc52xx_pm_finish(suspend_state_t st
 	return 0;
 }
 
-static struct pm_ops mpc52xx_pm_ops = {
+static struct platform_suspend_operations mpc52xx_pm_ops = {
 	.valid		= mpc52xx_pm_valid,
 	.prepare	= mpc52xx_pm_prepare,
 	.enter		= mpc52xx_pm_enter,
@@ -186,6 +186,6 @@ static struct pm_ops mpc52xx_pm_ops = {
 
 int __init mpc52xx_pm_init(void)
 {
-	pm_set_ops(&mpc52xx_pm_ops);
+	suspend_set_ops(&mpc52xx_pm_ops);
 	return 0;
 }
Index: linux-2.6.22-rc6/arch/sh/boards/hp6xx/pm.c
===================================================================
--- linux-2.6.22-rc6.orig/arch/sh/boards/hp6xx/pm.c	2007-06-25 21:53:44.000000000 +0200
+++ linux-2.6.22-rc6/arch/sh/boards/hp6xx/pm.c	2007-06-25 21:53:51.000000000 +0200
@@ -67,14 +67,14 @@ static int hp6x0_pm_enter(suspend_state_
 	return 0;
 }
 
-static struct pm_ops hp6x0_pm_ops = {
+static struct platform_suspend_operations hp6x0_pm_ops = {
 	.enter		= hp6x0_pm_enter,
-	.valid		= pm_valid_only_mem,
+	.valid		= suspend_valid_only_mem,
 };
 
 static int __init hp6x0_pm_init(void)
 {
-	pm_set_ops(&hp6x0_pm_ops);
+	suspend_set_ops(&hp6x0_pm_ops);
 	return 0;
 }
 

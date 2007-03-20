From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] rework pm_ops pm_disk_modes foo
Date: Tue, 20 Mar 2007 02:58:32 +0100
Message-ID: <20070320015846.636692000@sipsolutions.net>
References: <20070320015821.782406000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=011-pm-ops-diskmode.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.osdl.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Cliff Brake <cbrake@accelent.com>, Dirk Behme <dirk.behme@de.bosch.com>, Andriy Skulysh <askulsyh@gmail.com>, Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@osdl.org>, Nicolas Pitre <nico@cam.org>, Ben Dooks <ben@simtec.co.uk>
List-Id: linux-pm@vger.kernel.org

The pm_ops.pm_disk_mode is used in totally bogus ways since
nobody really seems to understand what it actually does.

This patch clarifies what pm_disk_mode is actually for by
splitting it up into default_pm_disk_mode and a bitmask of
pm_disk_modes.

It also removes all the arm and sh users that think they can veto
suspend to disk via pm_ops; not so since the user can always
do echo shutdown > /sys/power/disk, you need to find a better
way involving Kconfig or such.

ACPI is the only user left with a non-zero pm_disk_modes bitmask.

The patch also sets the default mode to shutdown again, but
when a new pm_ops is registered its default mode is honoured.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Andriy Skulysh <askulsyh@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: David Brownell <david-b@pacbell.net>
Cc: Cliff Brake <cbrake@accelent.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Nicolas Pitre <nico@cam.org>
Cc: David Singleton <daviado@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Cc: David Shaohua Li <shaohua.li@intel.com>
Cc: Patrick Mochel <mochel@osdl.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org

---
 arch/arm/common/sharpsl_pm.c |    7 ++---
 arch/arm/mach-at91/pm.c      |    1 =

 arch/arm/mach-omap1/pm.c     |    1 =

 arch/arm/mach-omap2/pm.c     |    1 =

 arch/arm/mach-pxa/pm.c       |    4 ---
 arch/arm/mach-sa1100/pm.c    |    9 -------
 arch/arm/plat-s3c24xx/pm.c   |    9 -------
 arch/sh/boards/hp6xx/pm.c    |    7 -----
 drivers/acpi/sleep/main.c    |   10 +++++---
 include/linux/pm.h           |   18 ++++++++++-----
 kernel/power/disk.c          |   51 ++++++++++++++++++++++++++++++--------=
-----
 kernel/power/main.c          |    7 +++++
 12 files changed, 65 insertions(+), 60 deletions(-)

--- linux-2.6.orig/include/linux/pm.h	2007-03-20 02:18:54.830252495 +0100
+++ linux-2.6/include/linux/pm.h	2007-03-20 02:26:32.270252495 +0100
@@ -137,24 +137,30 @@ typedef int __bitwise suspend_disk_metho
  * @finish: Called when the system has left the given state and all devices
  *	are resumed. The return value is ignored.
  *
- * @pm_disk_mode: Set to the disk method that the user should be able to
- *	configure for suspend-to-disk. Since %PM_DISK_SHUTDOWN,
- *	%PM_DISK_REBOOT, %PM_DISK_TEST and %PM_DISK_TESTPROC
- *	are always allowed, currently only %PM_DISK_PLATFORM
- *	makes sense. If the user then choses %PM_DISK_PLATFORM,
+ * @pm_disk_modes: Set to a bitfield of the available shutdown methods
+ *	the user should be able to configure for suspend-to-disk, use
+ *	1<<%PM_DISK_PLATFORM etc. %PM_DISK_SHUTDOWN, %PM_DISK_REBOOT,
+ *	%PM_DISK_TEST and %PM_DISK_TESTPROC are always allowed regardless
+ *	of whether they are included in this mask.
+ *	If the user then choses any one other than those four,
  *	the @prepare call will be called before suspending to disk
  *	(if present), the @enter call should be present and will
  *	be called after all state has been saved and the machine
  *	is ready to be shut down/suspended/..., and the @finish
  *	callback is called after state has been restored. All
  *	these calls are called with %PM_SUSPEND_DISK as the state.
+ *	Note that despite all this, you absolutely must turn off
+ *	the machine and not just suspend it.
+ *
+ * @default_pm_disk_mode: Set to the default suspend to disk method.
  */
 struct pm_ops {
 	int (*valid)(suspend_state_t state);
 	int (*prepare)(suspend_state_t state);
 	int (*enter)(suspend_state_t state);
 	int (*finish)(suspend_state_t state);
-	suspend_disk_method_t pm_disk_mode;
+	unsigned long pm_disk_modes;
+	suspend_disk_method_t default_pm_disk_mode;
 };
 =

 /**
--- linux-2.6.orig/kernel/power/disk.c	2007-03-20 02:18:54.960252495 +0100
+++ linux-2.6/kernel/power/disk.c	2007-03-20 02:19:12.750252495 +0100
@@ -39,7 +39,13 @@ static inline int platform_prepare(void)
 {
 	int error =3D 0;
 =

-	if (pm_disk_mode =3D=3D PM_DISK_PLATFORM) {
+	switch (pm_disk_mode) {
+	case PM_DISK_TEST:
+	case PM_DISK_TESTPROC:
+	case PM_DISK_SHUTDOWN:
+	case PM_DISK_REBOOT:
+		break;
+	default:
 		if (pm_ops && pm_ops->prepare)
 			error =3D pm_ops->prepare(PM_SUSPEND_DISK);
 	}
@@ -56,23 +62,28 @@ static inline int platform_prepare(void)
  *	there ain't no turning back.
  */
 =

-static void power_down(suspend_disk_method_t mode)
+static void power_down(void)
 {
 	disable_nonboot_cpus();
-	switch(mode) {
-	case PM_DISK_PLATFORM:
-		if (pm_ops && pm_ops->enter) {
-			kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
-			pm_ops->enter(PM_SUSPEND_DISK);
-			break;
-		}
+
+	switch (pm_disk_mode) {
+	case PM_DISK_TEST:
+	case PM_DISK_TESTPROC:
+		break;
 	case PM_DISK_SHUTDOWN:
 		kernel_power_off();
 		break;
 	case PM_DISK_REBOOT:
 		kernel_restart(NULL);
 		break;
+	default:
+		if (pm_ops && pm_ops->enter) {
+			kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
+			pm_ops->enter(PM_SUSPEND_DISK);
+			break;
+		}
 	}
+
 	kernel_halt();
 	/* Valid image is on the disk, if we continue we risk serious data corrup=
tion
 	   after resume. */
@@ -82,7 +93,13 @@ static void power_down(suspend_disk_meth
 =

 static inline void platform_finish(void)
 {
-	if (pm_disk_mode =3D=3D PM_DISK_PLATFORM) {
+	switch (pm_disk_mode) {
+	case PM_DISK_TEST:
+	case PM_DISK_TESTPROC:
+	case PM_DISK_SHUTDOWN:
+	case PM_DISK_REBOOT:
+		break;
+	default:
 		if (pm_ops && pm_ops->finish)
 			pm_ops->finish(PM_SUSPEND_DISK);
 	}
@@ -167,7 +184,7 @@ int pm_suspend_disk(void)
 		pr_debug("PM: writing image.\n");
 		error =3D swsusp_write();
 		if (!error)
-			power_down(pm_disk_mode);
+			power_down();
 		else {
 			swsusp_free();
 			goto Thaw;
@@ -347,12 +364,16 @@ static ssize_t disk_store(struct subsyst
 		}
 	}
 	if (mode) {
-		if (mode =3D=3D PM_DISK_SHUTDOWN || mode =3D=3D PM_DISK_REBOOT ||
-		     mode =3D=3D PM_DISK_TEST || mode =3D=3D PM_DISK_TESTPROC) {
+		switch (mode) {
+		case PM_DISK_SHUTDOWN:
+		case PM_DISK_REBOOT:
+		case PM_DISK_TEST:
+		case PM_DISK_TESTPROC:
 			pm_disk_mode =3D mode;
-		} else {
+			break;
+		default:
 			if (pm_ops && pm_ops->enter &&
-			    (mode =3D=3D pm_ops->pm_disk_mode))
+			    ((1<<mode) & pm_ops->pm_disk_modes))
 				pm_disk_mode =3D mode;
 			else
 				error =3D -EINVAL;
--- linux-2.6.orig/kernel/power/main.c	2007-03-20 02:18:54.850252495 +0100
+++ linux-2.6/kernel/power/main.c	2007-03-20 02:57:38.400252495 +0100
@@ -30,7 +30,7 @@
 DEFINE_MUTEX(pm_mutex);
 =

 struct pm_ops *pm_ops;
-suspend_disk_method_t pm_disk_mode =3D PM_DISK_PLATFORM;
+suspend_disk_method_t pm_disk_mode =3D PM_DISK_SHUTDOWN;
 =

 /**
  *	pm_set_ops - Set the global power method table. =

@@ -41,6 +41,11 @@ void pm_set_ops(struct pm_ops * ops)
 {
 	mutex_lock(&pm_mutex);
 	pm_ops =3D ops;
+	if (ops && ops->default_pm_disk_mode) {
+		WARN_ON(!( (1<<ops->default_pm_disk_mode) & ops->pm_disk_modes));
+		pm_disk_mode =3D ops->default_pm_disk_mode;
+	} else
+		pm_disk_mode =3D PM_DISK_SHUTDOWN;
 	mutex_unlock(&pm_mutex);
 }
 =

--- linux-2.6.orig/arch/arm/common/sharpsl_pm.c	2007-03-20 02:18:55.0802524=
95 +0100
+++ linux-2.6/arch/arm/common/sharpsl_pm.c	2007-03-20 02:19:12.750252495 +0=
100
@@ -766,10 +766,9 @@ static void sharpsl_apm_get_power_status
 }
 =

 static struct pm_ops sharpsl_pm_ops =3D {
-	.pm_disk_mode	=3D PM_DISK_FIRMWARE,
-	.prepare	=3D pxa_pm_prepare,
-	.enter		=3D corgi_pxa_pm_enter,
-	.finish		=3D pxa_pm_finish,
+	.prepare		=3D pxa_pm_prepare,
+	.enter			=3D corgi_pxa_pm_enter,
+	.finish			=3D pxa_pm_finish,
 };
 =

 static int __init sharpsl_pm_probe(struct platform_device *pdev)
--- linux-2.6.orig/arch/arm/mach-at91/pm.c	2007-03-20 02:18:55.290252495 +0=
100
+++ linux-2.6/arch/arm/mach-at91/pm.c	2007-03-20 02:19:12.750252495 +0100
@@ -201,7 +201,6 @@ error:
 =

 =

 static struct pm_ops at91_pm_ops =3D{
-	.pm_disk_mode	=3D 0,
 	.valid		=3D at91_pm_valid_state,
 	.prepare	=3D at91_pm_prepare,
 	.enter		=3D at91_pm_enter,
--- linux-2.6.orig/arch/arm/mach-omap1/pm.c	2007-03-20 02:18:55.180252495 +=
0100
+++ linux-2.6/arch/arm/mach-omap1/pm.c	2007-03-20 02:19:12.760252495 +0100
@@ -698,7 +698,6 @@ static struct irqaction omap_wakeup_irq =

 =

 =

 static struct pm_ops omap_pm_ops =3D{
-	.pm_disk_mode	=3D 0,
 	.prepare	=3D omap_pm_prepare,
 	.enter		=3D omap_pm_enter,
 	.finish		=3D omap_pm_finish,
--- linux-2.6.orig/arch/arm/mach-omap2/pm.c	2007-03-20 02:18:55.250252495 +=
0100
+++ linux-2.6/arch/arm/mach-omap2/pm.c	2007-03-20 02:19:12.760252495 +0100
@@ -370,7 +370,6 @@ static int omap2_pm_finish(suspend_state
 }
 =

 static struct pm_ops omap_pm_ops =3D {
-	.pm_disk_mode	=3D 0,
 	.prepare	=3D omap2_pm_prepare,
 	.enter		=3D omap2_pm_enter,
 	.finish		=3D omap2_pm_finish,
--- linux-2.6.orig/arch/arm/mach-pxa/pm.c	2007-03-20 02:18:55.350252495 +01=
00
+++ linux-2.6/arch/arm/mach-pxa/pm.c	2007-03-20 02:19:12.760252495 +0100
@@ -223,11 +223,7 @@ int pxa_pm_finish(suspend_state_t state)
 =

 EXPORT_SYMBOL_GPL(pxa_pm_finish);
 =

-/*
- * Set to PM_DISK_FIRMWARE so we can quickly veto suspend-to-disk.
- */
 static struct pm_ops pxa_pm_ops =3D {
-	.pm_disk_mode	=3D PM_DISK_FIRMWARE,
 	.prepare	=3D pxa_pm_prepare,
 	.enter		=3D pxa_pm_enter,
 	.finish		=3D pxa_pm_finish,
--- linux-2.6.orig/arch/arm/mach-sa1100/pm.c	2007-03-20 02:18:55.450252495 =
+0100
+++ linux-2.6/arch/arm/mach-sa1100/pm.c	2007-03-20 02:19:12.760252495 +0100
@@ -59,9 +59,6 @@ static int sa11x0_pm_enter(suspend_state
 	unsigned long gpio, sleep_save[SLEEP_SAVE_SIZE];
 	struct timespec delta, rtc;
 =

-	if (state !=3D PM_SUSPEND_MEM)
-		return -EINVAL;
-
 	/* preserve current time */
 	rtc.tv_sec =3D RCNR;
 	rtc.tv_nsec =3D 0;
@@ -134,12 +131,8 @@ unsigned long sleep_phys_sp(void *sp)
 	return virt_to_phys(sp);
 }
 =

-/*
- * Set to PM_DISK_FIRMWARE so we can quickly veto suspend-to-disk.
- */
 static struct pm_ops sa11x0_pm_ops =3D {
-	.pm_disk_mode	=3D PM_DISK_FIRMWARE,
-	.enter		=3D sa11x0_pm_enter,
+	.enter			=3D sa11x0_pm_enter,
 };
 =

 static int __init sa11x0_pm_init(void)
--- linux-2.6.orig/arch/arm/plat-s3c24xx/pm.c	2007-03-20 02:18:55.520252495=
 +0100
+++ linux-2.6/arch/arm/plat-s3c24xx/pm.c	2007-03-20 02:19:12.770252495 +0100
@@ -511,11 +511,6 @@ static int s3c2410_pm_enter(suspend_stat
 		return -EINVAL;
 	}
 =

-	if (state !=3D PM_SUSPEND_MEM) {
-		printk(KERN_ERR PFX "error: only PM_SUSPEND_MEM supported\n");
-		return -EINVAL;
-	}
-
 	/* check if we have anything to wake-up with... bad things seem
 	 * to happen if you suspend with no wakeup (system will often
 	 * require a full power-cycle)
@@ -633,11 +628,7 @@ static int s3c2410_pm_finish(suspend_sta
 	return 0;
 }
 =

-/*
- * Set to PM_DISK_FIRMWARE so we can quickly veto suspend-to-disk.
- */
 static struct pm_ops s3c2410_pm_ops =3D {
-	.pm_disk_mode	=3D PM_DISK_FIRMWARE,
 	.prepare	=3D s3c2410_pm_prepare,
 	.enter		=3D s3c2410_pm_enter,
 	.finish		=3D s3c2410_pm_finish,
--- linux-2.6.orig/drivers/acpi/sleep/main.c	2007-03-20 02:18:55.050252495 =
+0100
+++ linux-2.6/drivers/acpi/sleep/main.c	2007-03-20 02:19:12.770252495 +0100
@@ -95,7 +95,7 @@ static int acpi_pm_enter(suspend_state_t
 		break;
 =

 	case PM_SUSPEND_DISK:
-		if (acpi_pm_ops.pm_disk_mode =3D=3D PM_DISK_PLATFORM)
+		if (acpi_pm_ops.default_pm_disk_mode =3D=3D PM_DISK_PLATFORM)
 			status =3D acpi_enter_sleep_state(acpi_state);
 		break;
 	case PM_SUSPEND_MAX:
@@ -219,8 +219,12 @@ int __init acpi_sleep_init(void)
 			printk(" S%d", i);
 		}
 		if (i =3D=3D ACPI_STATE_S4) {
-			if (sleep_states[i])
-				acpi_pm_ops.pm_disk_mode =3D PM_DISK_PLATFORM;
+			if (sleep_states[i]) {
+				acpi_pm_ops.default_pm_disk_mode =3D
+					PM_DISK_PLATFORM;
+				acpi_pm_ops.pm_disk_modes =3D
+					1<<PM_DISK_PLATFORM;
+			}
 		}
 	}
 	printk(")\n");
--- linux-2.6.orig/arch/sh/boards/hp6xx/pm.c	2007-03-20 02:18:55.600252495 =
+0100
+++ linux-2.6/arch/sh/boards/hp6xx/pm.c	2007-03-20 02:19:12.770252495 +0100
@@ -27,9 +27,6 @@ static int hp6x0_pm_enter(suspend_state_
 	u16 hd64461_stbcr;
 #endif
 =

-	if (state !=3D PM_SUSPEND_MEM)
-		return -EINVAL;
-
 #ifdef CONFIG_HD64461_ENABLER
 	outb(0, HD64461_PCC1CSCIER);
 =

@@ -70,11 +67,7 @@ static int hp6x0_pm_enter(suspend_state_
 	return 0;
 }
 =

-/*
- * Set to PM_DISK_FIRMWARE so we can quickly veto suspend-to-disk.
- */
 static struct pm_ops hp6x0_pm_ops =3D {
-	.pm_disk_mode	=3D PM_DISK_FIRMWARE,
 	.enter		=3D hp6x0_pm_enter,
 };
 =


--

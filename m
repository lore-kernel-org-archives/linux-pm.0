From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] add firmware disk state and clean up
Date: Tue, 20 Mar 2007 11:17:45 +0100
Message-ID: <1174385865.3770.20.camel@johannes.berg>
References: <20070320015846.636692000@sipsolutions.net>
	<20070320084744.984025000@sipsolutions.net>
	<20070320093105.GD3922@elf.ucw.cz>
	<1174383407.3770.3.camel@johannes.berg>
	<20070320094352.GF3922@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070320094352.GF3922@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Ben Dooks <ben@simtec.co.uk>, Dirk Behme <dirk.behme@de.bosch.com>, linux-pm@lists.osdl.org, Nicolas Pitre <nico@cam.org>
List-Id: linux-pm@vger.kernel.org

This patch adds a new state PM_SUSPEND_FIRMWAREDISK state and cleans up
all pm_ops users to include a .valid callback which in most cases allows
only mem suspend since except ACPI they all don't differentiate between
standby/mem which are currently allowed.

This new state has no users yet but I think APM could be converted to
it. My old laptop used to be able to suspend to disk from firmware, but
it died so I couldn't test such a conversion.

In any case, having a .valid callback will be essential if more suspend
modes are added, and this makes it clearer by example.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
 arch/arm/common/sharpsl_pm.c |    6 ++++++
 arch/arm/mach-at91/pm.c      |    5 +++++
 arch/arm/mach-omap1/pm.c     |    6 +++++-
 arch/arm/mach-omap2/pm.c     |    6 ++++++
 arch/arm/mach-pnx4008/pm.c   |   34 +++-------------------------------
 arch/arm/mach-pxa/pm.c       |    6 ++++++
 arch/arm/mach-sa1100/pm.c    |    6 ++++++
 arch/arm/plat-s3c24xx/pm.c   |   18 +++---------------
 arch/sh/boards/hp6xx/pm.c    |    6 ++++++
 drivers/acpi/sleep/main.c    |   13 +++++++++++--
 include/linux/pm.h           |   16 ++++++++--------
 kernel/power/disk.c          |    3 +--
 kernel/power/main.c          |    9 ++++++---
 13 files changed, 72 insertions(+), 62 deletions(-)

--- linux-2.6.orig/include/linux/pm.h	2007-03-20 10:47:36.543214909 +0100
+++ linux-2.6/include/linux/pm.h	2007-03-20 10:48:06.643214909 +0100
@@ -108,19 +108,19 @@ typedef int __bitwise suspend_state_t;
 #define PM_SUSPEND_STANDBY	((__force suspend_state_t) 1)
 #define PM_SUSPEND_MEM		((__force suspend_state_t) 3)
 #define PM_SUSPEND_DISK		((__force suspend_state_t) 4)
-#define PM_SUSPEND_MAX		((__force suspend_state_t) 5)
+#define PM_SUSPEND_FIRMWAREDISK	((__force suspend_state_t) 5)
+#define PM_SUSPEND_MAX		((__force suspend_state_t) 6)
 =

 typedef int __bitwise suspend_disk_method_t;
 =

 /* invalid must be 0 so struct pm_ops initialisers can leave it out */
 #define PM_DISK_INVALID		((__force suspend_disk_method_t) 0)
-#define	PM_DISK_FIRMWARE	((__force suspend_disk_method_t) 1)
-#define	PM_DISK_PLATFORM	((__force suspend_disk_method_t) 2)
-#define	PM_DISK_SHUTDOWN	((__force suspend_disk_method_t) 3)
-#define	PM_DISK_REBOOT		((__force suspend_disk_method_t) 4)
-#define	PM_DISK_TEST		((__force suspend_disk_method_t) 5)
-#define	PM_DISK_TESTPROC	((__force suspend_disk_method_t) 6)
-#define	PM_DISK_MAX		((__force suspend_disk_method_t) 7)
+#define	PM_DISK_PLATFORM	((__force suspend_disk_method_t) 1)
+#define	PM_DISK_SHUTDOWN	((__force suspend_disk_method_t) 2)
+#define	PM_DISK_REBOOT		((__force suspend_disk_method_t) 3)
+#define	PM_DISK_TEST		((__force suspend_disk_method_t) 4)
+#define	PM_DISK_TESTPROC	((__force suspend_disk_method_t) 5)
+#define	PM_DISK_MAX		((__force suspend_disk_method_t) 6)
 =

 /**
  * struct pm_ops - Callbacks for managing platform dependent suspend state=
s.
--- linux-2.6.orig/arch/arm/common/sharpsl_pm.c	2007-03-20 10:51:02.0532149=
09 +0100
+++ linux-2.6/arch/arm/common/sharpsl_pm.c	2007-03-20 10:51:58.963214909 +0=
100
@@ -765,10 +765,16 @@ static void sharpsl_apm_get_power_status
 	info->battery_life =3D sharpsl_pm.battstat.mainbat_percent;
 }
 =

+static int pxa_pm_valid(suspend_state_t state)
+{
+	return state =3D=3D PM_SUSPEND_MEM;
+}
+
 static struct pm_ops sharpsl_pm_ops =3D {
 	.prepare	=3D pxa_pm_prepare,
 	.enter		=3D corgi_pxa_pm_enter,
 	.finish		=3D pxa_pm_finish,
+	.valid		=3D pxa_pm_valid,
 };
 =

 static int __init sharpsl_pm_probe(struct platform_device *pdev)
--- linux-2.6.orig/arch/arm/mach-at91/pm.c	2007-03-20 10:55:35.433214909 +0=
100
+++ linux-2.6/arch/arm/mach-at91/pm.c	2007-03-20 10:56:02.243214909 +0100
@@ -199,11 +199,16 @@ error:
 	return 0;
 }
 =

+static int at91_pm_valid(suspend_state_t state)
+{
+	return state =3D=3D PM_SUSPEND_MEM;
+}
 =

 static struct pm_ops at91_pm_ops =3D{
 	.valid		=3D at91_pm_valid_state,
 	.prepare	=3D at91_pm_prepare,
 	.enter		=3D at91_pm_enter,
+	.valid		=3D at91_pm_valid,
 };
 =

 static int __init at91_pm_init(void)
--- linux-2.6.orig/arch/arm/mach-omap1/pm.c	2007-03-20 10:52:17.403214909 +=
0100
+++ linux-2.6/arch/arm/mach-omap1/pm.c	2007-03-20 10:52:51.483214909 +0100
@@ -695,12 +695,16 @@ static struct irqaction omap_wakeup_irq =

 	.handler	=3D omap_wakeup_interrupt
 };
 =

-
+static int omap_pm_valid(suspend_state_t state)
+{
+	return state =3D=3D PM_SUSPEND_MEM;
+}
 =

 static struct pm_ops omap_pm_ops =3D{
 	.prepare	=3D omap_pm_prepare,
 	.enter		=3D omap_pm_enter,
 	.finish		=3D omap_pm_finish,
+	.valid		=3D omap_pm_valid,
 };
 =

 static int __init omap_pm_init(void)
--- linux-2.6.orig/arch/arm/mach-omap2/pm.c	2007-03-20 10:52:56.603214909 +=
0100
+++ linux-2.6/arch/arm/mach-omap2/pm.c	2007-03-20 10:53:22.353214909 +0100
@@ -369,10 +369,16 @@ static int omap2_pm_finish(suspend_state
 	return 0;
 }
 =

+static int omap2_pm_valid(suspend_state_t state)
+{
+	return state =3D=3D PM_SUSPEND_MEM;
+}
+
 static struct pm_ops omap_pm_ops =3D {
 	.prepare	=3D omap2_pm_prepare,
 	.enter		=3D omap2_pm_enter,
 	.finish		=3D omap2_pm_finish,
+	.valid		=3D omap2_pm_valid,
 };
 =

 int __init omap2_pm_init(void)
--- linux-2.6.orig/arch/arm/mach-pnx4008/pm.c	2007-03-20 10:53:29.803214909=
 +0100
+++ linux-2.6/arch/arm/mach-pnx4008/pm.c	2007-03-20 11:03:50.133214909 +0100
@@ -115,42 +115,14 @@ static int pnx4008_pm_enter(suspend_stat
 	return 0;
 }
 =

-/*
- * Called after processes are frozen, but before we shut down devices.
- */
-static int pnx4008_pm_prepare(suspend_state_t state)
+static int pnx4008_pm_valid(suspend_state_t state)
 {
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
-	case PM_SUSPEND_MEM:
-		break;
-
-	case PM_SUSPEND_DISK:
-		return -ENOTSUPP;
-		break;
-
-	default:
-		return -EINVAL;
-		break;
-	}
-	return 0;
-}
-
-/*
- * Called after devices are re-setup, but before processes are thawed.
- */
-static int pnx4008_pm_finish(suspend_state_t state)
-{
-	return 0;
+	return state =3D=3D PM_SUSPEND_MEM;
 }
 =

-/*
- * Set to PM_DISK_FIRMWARE so we can quickly veto suspend-to-disk.
- */
 static struct pm_ops pnx4008_pm_ops =3D {
-	.prepare =3D pnx4008_pm_prepare,
 	.enter =3D pnx4008_pm_enter,
-	.finish =3D pnx4008_pm_finish,
+	.valid =3D pnx4008_pm_valid,
 };
 =

 static int __init pnx4008_pm_init(void)
--- linux-2.6.orig/arch/arm/mach-pxa/pm.c	2007-03-20 10:54:29.943214909 +01=
00
+++ linux-2.6/arch/arm/mach-pxa/pm.c	2007-03-20 10:54:59.263214909 +0100
@@ -223,10 +223,16 @@ int pxa_pm_finish(suspend_state_t state)
 =

 EXPORT_SYMBOL_GPL(pxa_pm_finish);
 =

+static int pxa_pm_valid(suspend_state_t state)
+{
+	return state =3D=3D PM_SUSPEND_MEM;
+}
+
 static struct pm_ops pxa_pm_ops =3D {
 	.prepare	=3D pxa_pm_prepare,
 	.enter		=3D pxa_pm_enter,
 	.finish		=3D pxa_pm_finish,
+	.valid		=3D pxa_pm_valid,
 };
 =

 static int __init pxa_pm_init(void)
--- linux-2.6.orig/arch/arm/mach-sa1100/pm.c	2007-03-20 10:55:05.173214909 =
+0100
+++ linux-2.6/arch/arm/mach-sa1100/pm.c	2007-03-20 10:55:30.583214909 +0100
@@ -131,8 +131,14 @@ unsigned long sleep_phys_sp(void *sp)
 	return virt_to_phys(sp);
 }
 =

+static int sa11x0_pm_valid(suspend_state_t state)
+{
+	return state =3D=3D PM_STATE_MEM;
+}
+
 static struct pm_ops sa11x0_pm_ops =3D {
 	.enter		=3D sa11x0_pm_enter,
+	.valid		=3D sa11x0_pm_valid,
 };
 =

 static int __init sa11x0_pm_init(void)
--- linux-2.6.orig/arch/arm/plat-s3c24xx/pm.c	2007-03-20 10:56:06.093214909=
 +0100
+++ linux-2.6/arch/arm/plat-s3c24xx/pm.c	2007-03-20 10:56:47.963214909 +0100
@@ -612,26 +612,14 @@ static int s3c2410_pm_enter(suspend_stat
 	return 0;
 }
 =

-/*
- * Called after processes are frozen, but before we shut down devices.
- */
-static int s3c2410_pm_prepare(suspend_state_t state)
+static int s3c2410_pm_valid(suspend_state_t state)
 {
-	return 0;
-}
-
-/*
- * Called after devices are re-setup, but before processes are thawed.
- */
-static int s3c2410_pm_finish(suspend_state_t state)
-{
-	return 0;
+	return state =3D=3D PM_SUSPEND_MEM;
 }
 =

 static struct pm_ops s3c2410_pm_ops =3D {
-	.prepare	=3D s3c2410_pm_prepare,
 	.enter		=3D s3c2410_pm_enter,
-	.finish		=3D s3c2410_pm_finish,
+	.valid		=3D s3c2410_pm_valid,
 };
 =

 /* s3c2410_pm_init
--- linux-2.6.orig/arch/sh/boards/hp6xx/pm.c	2007-03-20 10:57:05.693214909 =
+0100
+++ linux-2.6/arch/sh/boards/hp6xx/pm.c	2007-03-20 10:58:04.543214909 +0100
@@ -67,8 +67,14 @@ static int hp6x0_pm_enter(suspend_state_
 	return 0;
 }
 =

+static int hp6x0_pm_valid(suspend_state_t state)
+{
+	return state =3D=3D PM_SUSPEND_MEM;
+}
+
 static struct pm_ops hp6x0_pm_ops =3D {
 	.enter		=3D hp6x0_pm_enter,
+	.valid		=3D hp6x0_pm_valid,
 };
 =

 static int __init hp6x0_pm_init(void)
--- linux-2.6.orig/drivers/acpi/sleep/main.c	2007-03-20 10:58:09.733214909 =
+0100
+++ linux-2.6/drivers/acpi/sleep/main.c	2007-03-20 11:02:27.133214909 +0100
@@ -168,9 +168,18 @@ int acpi_suspend(u32 acpi_state)
 =

 static int acpi_pm_state_valid(suspend_state_t pm_state)
 {
-	u32 acpi_state =3D acpi_suspend_states[pm_state];
+	u32 acpi_state;
 =

-	return sleep_states[acpi_state];
+	switch (pm_state) {
+	case PM_SUSPEND_ON:
+	case PM_SUSPEND_STANDBY:
+	case PM_SUSPEND_MEM:
+		acpi_state =3D acpi_suspend_states[pm_state];
+
+		return sleep_states[acpi_state];
+	default:
+		return 0;
+	}
 }
 =

 static struct pm_ops acpi_pm_ops =3D {
--- linux-2.6.orig/kernel/power/disk.c	2007-03-20 11:11:57.793214909 +0100
+++ linux-2.6/kernel/power/disk.c	2007-03-20 11:12:13.683214909 +0100
@@ -304,7 +304,6 @@ late_initcall(software_resume);
 =

 =

 static const char * const pm_disk_modes[] =3D {
-	[PM_DISK_FIRMWARE]	=3D "firmware",
 	[PM_DISK_PLATFORM]	=3D "platform",
 	[PM_DISK_SHUTDOWN]	=3D "shutdown",
 	[PM_DISK_REBOOT]	=3D "reboot",
@@ -357,7 +356,7 @@ static ssize_t disk_store(struct subsyst
 	len =3D p ? p - buf : n;
 =

 	mutex_lock(&pm_mutex);
-	for (i =3D PM_DISK_FIRMWARE; i < PM_DISK_MAX; i++) {
+	for (i =3D PM_DISK_PLATFORM; i < PM_DISK_MAX; i++) {
 		if (!strncmp(buf, pm_disk_modes[i], len)) {
 			mode =3D i;
 			break;
--- linux-2.6.orig/kernel/power/main.c	2007-03-20 11:13:31.173214909 +0100
+++ linux-2.6/kernel/power/main.c	2007-03-20 11:15:30.153214909 +0100
@@ -157,11 +157,14 @@ static void suspend_finish(suspend_state
 =

 =

 static const char * const pm_states[PM_SUSPEND_MAX] =3D {
-	[PM_SUSPEND_STANDBY]	=3D "standby",
-	[PM_SUSPEND_MEM]	=3D "mem",
+	"standby",
+	"mem",
 #ifdef CONFIG_SOFTWARE_SUSPEND
-	[PM_SUSPEND_DISK]	=3D "disk",
+	"disk",
+#else
+	NULL,
 #endif
+	"firmware-disk",
 };
 =

 static inline int valid_state(suspend_state_t state)

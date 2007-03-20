From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] implement pm_ops.valid for everybody
Date: Tue, 20 Mar 2007 12:06:52 +0100
Message-ID: <1174388812.3770.29.camel@johannes.berg>
References: <20070320015846.636692000@sipsolutions.net>
	<20070320084744.984025000@sipsolutions.net>
	<20070320093105.GD3922@elf.ucw.cz>
	<1174383407.3770.3.camel@johannes.berg>
	<20070320094352.GF3922@elf.ucw.cz>
	<1174385865.3770.20.camel@johannes.berg>
	<20070320102551.GB19283@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070320102551.GB19283@elf.ucw.cz>
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
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Ben Dooks <ben@simtec.co.uk>, linux-arm@lists.arm.linux.org.uk, Dirk Behme <dirk.behme@de.bosch.com>, linux-pm@lists.osdl.org, Nicolas Pitre <nico@cam.org>
List-Id: linux-pm@vger.kernel.org

Almost all users of pm_ops only support mem sleep, don't check in .valid
and don't reject any others in .prepare so users can be confused if they
check /sys/power/state, especially when new states are ever added.

This patch implements a generic pm_valid_only_mem function that is then
exported for users as well as using it in almost all pm_ops.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
 arch/arm/common/sharpsl_pm.c |    1 +
 arch/arm/mach-omap1/pm.c     |    1 +
 arch/arm/mach-omap2/pm.c     |    1 +
 arch/arm/mach-pnx4008/pm.c   |   35 +----------------------------------
 arch/arm/mach-pxa/pm.c       |    1 +
 arch/arm/mach-sa1100/pm.c    |    1 +
 arch/arm/plat-s3c24xx/pm.c   |   19 +------------------
 arch/sh/boards/hp6xx/pm.c    |    1 +
 drivers/acpi/sleep/main.c    |   13 +++++++++++--
 include/linux/pm.h           |    4 ++++
 kernel/power/main.c          |   13 +++++++++++++
 11 files changed, 36 insertions(+), 54 deletions(-)

--- linux-2.6.orig/include/linux/pm.h	2007-03-20 11:56:09.783214909 +0100
+++ linux-2.6/include/linux/pm.h	2007-03-20 12:01:46.583214909 +0100
@@ -128,6 +128,9 @@ typedef int __bitwise suspend_disk_metho
  *	always valid and never passed to this call.
  *	If not assigned, all suspend states are advertised as valid
  *	in /sys/power/state (but can still be rejected by prepare or enter.)
+ *	Since new states can be added for other platforms, you should
+ *	assign this callback. There is a %pm_valid_only_mem function
+ *	available if you only implemented mem sleep.
  *
  * @prepare: Prepare the platform for the given suspend state. Can return a
  *	negative error code if necessary.
@@ -167,6 +170,7 @@ extern void pm_set_ops(struct pm_ops *pm
 extern struct pm_ops *pm_ops;
 extern int pm_suspend(suspend_state_t state);
 =

+extern int pm_valid_only_mem(suspend_state_t state);
 =

 /*
  * Device power management
--- linux-2.6.orig/arch/arm/common/sharpsl_pm.c	2007-03-20 11:55:22.6932149=
09 +0100
+++ linux-2.6/arch/arm/common/sharpsl_pm.c	2007-03-20 11:56:34.173214909 +0=
100
@@ -769,6 +769,7 @@ static struct pm_ops sharpsl_pm_ops =3D {
 	.prepare	=3D pxa_pm_prepare,
 	.enter		=3D corgi_pxa_pm_enter,
 	.finish		=3D pxa_pm_finish,
+	.valid		=3D pm_valid_only_mem,
 };
 =

 static int __init sharpsl_pm_probe(struct platform_device *pdev)
--- linux-2.6.orig/arch/arm/mach-omap1/pm.c	2007-03-20 11:55:22.793214909 +=
0100
+++ linux-2.6/arch/arm/mach-omap1/pm.c	2007-03-20 11:56:34.173214909 +0100
@@ -701,6 +701,7 @@ static struct pm_ops omap_pm_ops =3D{
 	.prepare	=3D omap_pm_prepare,
 	.enter		=3D omap_pm_enter,
 	.finish		=3D omap_pm_finish,
+	.valid		=3D pm_valid_only_mem,
 };
 =

 static int __init omap_pm_init(void)
--- linux-2.6.orig/arch/arm/mach-omap2/pm.c	2007-03-20 11:55:22.823214909 +=
0100
+++ linux-2.6/arch/arm/mach-omap2/pm.c	2007-03-20 11:56:34.183214909 +0100
@@ -373,6 +373,7 @@ static struct pm_ops omap_pm_ops =3D {
 	.prepare	=3D omap2_pm_prepare,
 	.enter		=3D omap2_pm_enter,
 	.finish		=3D omap2_pm_finish,
+	.valid		=3D pm_valid_only_mem,
 };
 =

 int __init omap2_pm_init(void)
--- linux-2.6.orig/arch/arm/mach-pnx4008/pm.c	2007-03-20 11:55:22.883214909=
 +0100
+++ linux-2.6/arch/arm/mach-pnx4008/pm.c	2007-03-20 11:56:34.183214909 +0100
@@ -115,42 +115,9 @@ static int pnx4008_pm_enter(suspend_stat
 	return 0;
 }
 =

-/*
- * Called after processes are frozen, but before we shut down devices.
- */
-static int pnx4008_pm_prepare(suspend_state_t state)
-{
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
-}
-
-/*
- * Set to PM_DISK_FIRMWARE so we can quickly veto suspend-to-disk.
- */
 static struct pm_ops pnx4008_pm_ops =3D {
-	.prepare =3D pnx4008_pm_prepare,
 	.enter =3D pnx4008_pm_enter,
-	.finish =3D pnx4008_pm_finish,
+	.valid =3D pm_valid_only_mem,
 };
 =

 static int __init pnx4008_pm_init(void)
--- linux-2.6.orig/arch/arm/mach-pxa/pm.c	2007-03-20 11:55:22.983214909 +01=
00
+++ linux-2.6/arch/arm/mach-pxa/pm.c	2007-03-20 11:56:34.183214909 +0100
@@ -227,6 +227,7 @@ static struct pm_ops pxa_pm_ops =3D {
 	.prepare	=3D pxa_pm_prepare,
 	.enter		=3D pxa_pm_enter,
 	.finish		=3D pxa_pm_finish,
+	.valid		=3D pm_valid_only_mem,
 };
 =

 static int __init pxa_pm_init(void)
--- linux-2.6.orig/arch/arm/mach-sa1100/pm.c	2007-03-20 11:55:23.013214909 =
+0100
+++ linux-2.6/arch/arm/mach-sa1100/pm.c	2007-03-20 11:56:34.183214909 +0100
@@ -133,6 +133,7 @@ unsigned long sleep_phys_sp(void *sp)
 =

 static struct pm_ops sa11x0_pm_ops =3D {
 	.enter		=3D sa11x0_pm_enter,
+	.valid		=3D pm_valid_only_mem,
 };
 =

 static int __init sa11x0_pm_init(void)
--- linux-2.6.orig/arch/arm/plat-s3c24xx/pm.c	2007-03-20 11:55:23.143214909=
 +0100
+++ linux-2.6/arch/arm/plat-s3c24xx/pm.c	2007-03-20 11:56:34.223214909 +0100
@@ -612,26 +612,9 @@ static int s3c2410_pm_enter(suspend_stat
 	return 0;
 }
 =

-/*
- * Called after processes are frozen, but before we shut down devices.
- */
-static int s3c2410_pm_prepare(suspend_state_t state)
-{
-	return 0;
-}
-
-/*
- * Called after devices are re-setup, but before processes are thawed.
- */
-static int s3c2410_pm_finish(suspend_state_t state)
-{
-	return 0;
-}
-
 static struct pm_ops s3c2410_pm_ops =3D {
-	.prepare	=3D s3c2410_pm_prepare,
 	.enter		=3D s3c2410_pm_enter,
-	.finish		=3D s3c2410_pm_finish,
+	.valid		=3D pm_valid_only_mem,
 };
 =

 /* s3c2410_pm_init
--- linux-2.6.orig/arch/sh/boards/hp6xx/pm.c	2007-03-20 11:55:23.253214909 =
+0100
+++ linux-2.6/arch/sh/boards/hp6xx/pm.c	2007-03-20 11:56:34.223214909 +0100
@@ -69,6 +69,7 @@ static int hp6x0_pm_enter(suspend_state_
 =

 static struct pm_ops hp6x0_pm_ops =3D {
 	.enter		=3D hp6x0_pm_enter,
+	.valid		=3D pm_valid_only_mem,
 };
 =

 static int __init hp6x0_pm_init(void)
--- linux-2.6.orig/drivers/acpi/sleep/main.c	2007-03-20 11:55:23.293214909 =
+0100
+++ linux-2.6/drivers/acpi/sleep/main.c	2007-03-20 11:56:34.223214909 +0100
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
--- linux-2.6.orig/kernel/power/main.c	2007-03-20 11:55:23.403214909 +0100
+++ linux-2.6/kernel/power/main.c	2007-03-20 11:56:34.233214909 +0100
@@ -48,6 +48,19 @@ void pm_set_ops(struct pm_ops * ops)
 	mutex_unlock(&pm_mutex);
 }
 =

+/**
+ * pm_valid_only_mem - generic memory-only valid callback
+ *
+ * pm_ops drivers that implement mem suspend only and only need
+ * to check for that in their .valid callback can use this instead
+ * of rolling their own .valid callback.
+ */
+int pm_valid_only_mem(suspend_state_t state)
+{
+	return state =3D=3D PM_SUSPEND_MEM;
+}
+
+
 static inline void pm_finish(suspend_state_t state)
 {
 	if (pm_ops->finish)

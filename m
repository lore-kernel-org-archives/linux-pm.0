From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Wed, 11 Apr 2007 17:54:27 +0200
Message-ID: <1176306867.19348.4.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1175810054.3489.34.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

For powermac, we need to do some things between suspending devices and
device_power_off, for example setting the decrementer. This patch
introduces pm_ops.quiesce and pm_ops.activate which will be called instead
of disabling/enabling irqs so platforms get control over this step.

Since those two new calls are required, this patch also introduces default
methods that can be assigned and updates all pm_ops users to use these
defaults.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
Rafael: I don't need to change SNAPSHOT_S2RAM since it calls suspend_enter
which is where the change is.

I'm not sure if it makes sense to have this for PM_SUSPEND_DISK as well so
unless somebody comes up with a reason for now don't.

 arch/arm/common/sharpsl_pm.c            |    2 ++
 arch/arm/mach-at91/pm.c                 |    2 ++
 arch/arm/mach-omap1/pm.c                |    2 ++
 arch/arm/mach-omap2/pm.c                |    2 ++
 arch/arm/mach-pnx4008/pm.c              |    2 ++
 arch/arm/mach-pxa/pm.c                  |    2 ++
 arch/arm/mach-sa1100/pm.c               |    2 ++
 arch/arm/plat-s3c24xx/pm.c              |    2 ++
 arch/powerpc/platforms/powermac/setup.c |    2 ++
 arch/sh/boards/hp6xx/pm.c               |    2 ++
 drivers/acpi/sleep/main.c               |    7 +++++++
 include/linux/pm.h                      |   12 ++++++++++++
 kernel/power/main.c                     |   29 ++++++++++++++++++++++++++-=
--
 13 files changed, 65 insertions(+), 3 deletions(-)

--- wireless-dev.orig/include/linux/pm.h	2007-04-11 17:02:22.969481358 +0200
+++ wireless-dev/include/linux/pm.h	2007-04-11 17:02:42.609481358 +0200
@@ -135,9 +135,17 @@ typedef int __bitwise suspend_disk_metho
  * @prepare: Prepare the platform for the given suspend state. Can return a
  *	negative error code if necessary.
  *
+ * @quiesce: This callback must be assigned and at least turn off IRQs. If
+ *	your platform requires nothing else, assign %pm_default_quiesce.
+ *	It is currently not called for %PM_SUSPEND_DISK.
+ *
  * @enter: Enter the given suspend state, must be assigned. Can return a
  *	negative error code if necessary.
  *
+ * @activate: This callback must be assigned and at least turn on IRQS. If
+ *	your platform requires nothing else, assign %pm_default_activate.
+ *	It is currently not called for %PM_SUSPEND_DISK.
+ *
  * @finish: Called when the system has left the given state and all devices
  *	are resumed. The return value is ignored.
  *
@@ -155,7 +163,9 @@ typedef int __bitwise suspend_disk_metho
 struct pm_ops {
 	int (*valid)(suspend_state_t state);
 	int (*prepare)(suspend_state_t state);
+	void (*quiesce)(suspend_state_t state);
 	int (*enter)(suspend_state_t state);
+	void (*activate)(suspend_state_t state);
 	int (*finish)(suspend_state_t state);
 	suspend_disk_method_t pm_disk_mode;
 };
@@ -169,6 +179,8 @@ extern struct pm_ops *pm_ops;
 extern int pm_suspend(suspend_state_t state);
 =

 extern int pm_valid_only_mem(suspend_state_t state);
+extern void pm_default_quiesce(suspend_state_t state);
+extern void pm_default_activate(suspend_state_t state);
 =

 /*
  * Device power management
--- wireless-dev.orig/kernel/power/main.c	2007-04-11 17:02:23.149481358 +02=
00
+++ wireless-dev/kernel/power/main.c	2007-04-11 17:18:14.879481358 +0200
@@ -60,6 +60,28 @@ int pm_valid_only_mem(suspend_state_t st
 	return state =3D=3D PM_SUSPEND_MEM;
 }
 =

+/**
+ * pm_default_quiesce - default quiesce callback
+ *
+ * pm_ops drivers that need to do nothing but disable
+ * IRQs use this instead of their own code.
+ */
+void pm_default_quiesce(suspend_state_t state)
+{
+	local_irq_disable();
+}
+
+/**
+ * pm_default_activate - default activate callback
+ *
+ * pm_ops drivers that need to do nothing but enable
+ * IRQs use this instead of their own code.
+ */
+void pm_default_activate(suspend_state_t state)
+{
+	local_irq_enable();
+}
+
 =

 static inline void pm_finish(suspend_state_t state)
 {
@@ -132,9 +154,9 @@ static int suspend_prepare(suspend_state
 int suspend_enter(suspend_state_t state)
 {
 	int error =3D 0;
-	unsigned long flags;
 =

-	local_irq_save(flags);
+	pm_ops->quiesce(state);
+	BUG_ON(!irqs_disabled());
 =

 	if ((error =3D device_power_down(PMSG_SUSPEND))) {
 		printk(KERN_ERR "Some devices failed to power down\n");
@@ -143,7 +165,8 @@ int suspend_enter(suspend_state_t state)
 	error =3D pm_ops->enter(state);
 	device_power_up();
  Done:
-	local_irq_restore(flags);
+	pm_ops->activate(state);
+	BUG_ON(irqs_disabled());
 	return error;
 }
 =

--- wireless-dev.orig/arch/arm/common/sharpsl_pm.c	2007-04-11 17:07:50.1094=
81358 +0200
+++ wireless-dev/arch/arm/common/sharpsl_pm.c	2007-04-11 17:08:28.439481358=
 +0200
@@ -767,7 +767,9 @@ static void sharpsl_apm_get_power_status
 =

 static struct pm_ops sharpsl_pm_ops =3D {
 	.prepare	=3D pxa_pm_prepare,
+	.quiesce	=3D pm_default_quiesce,
 	.enter		=3D corgi_pxa_pm_enter,
+	.activate	=3D pm_default_activate,
 	.finish		=3D pxa_pm_finish,
 	.valid		=3D pm_valid_only_mem,
 };
--- wireless-dev.orig/arch/arm/mach-at91/pm.c	2007-04-11 17:07:50.889481358=
 +0200
+++ wireless-dev/arch/arm/mach-at91/pm.c	2007-04-11 17:10:17.399481358 +0200
@@ -203,7 +203,9 @@ error:
 static struct pm_ops at91_pm_ops =3D{
 	.valid		=3D at91_pm_valid_state,
 	.prepare	=3D at91_pm_prepare,
+	.quiesce	=3D pm_default_quiesce,
 	.enter		=3D at91_pm_enter,
+	.activate	=3D pm_default_activate,
 };
 =

 static int __init at91_pm_init(void)
--- wireless-dev.orig/arch/arm/mach-omap1/pm.c	2007-04-11 17:07:50.21948135=
8 +0200
+++ wireless-dev/arch/arm/mach-omap1/pm.c	2007-04-11 17:08:48.149481358 +02=
00
@@ -699,7 +699,9 @@ static struct irqaction omap_wakeup_irq =

 =

 static struct pm_ops omap_pm_ops =3D{
 	.prepare	=3D omap_pm_prepare,
+	.quiesce	=3D pm_default_quiesce,
 	.enter		=3D omap_pm_enter,
+	.activate	=3D pm_default_activate,
 	.finish		=3D omap_pm_finish,
 	.valid		=3D pm_valid_only_mem,
 };
--- wireless-dev.orig/arch/arm/mach-omap2/pm.c	2007-04-11 17:07:50.34948135=
8 +0200
+++ wireless-dev/arch/arm/mach-omap2/pm.c	2007-04-11 17:09:08.369481358 +02=
00
@@ -371,7 +371,9 @@ static int omap2_pm_finish(suspend_state
 =

 static struct pm_ops omap_pm_ops =3D {
 	.prepare	=3D omap2_pm_prepare,
+	.quiesce	=3D pm_default_quiesce,
 	.enter		=3D omap2_pm_enter,
+	.activate	=3D pm_default_activate,
 	.finish		=3D omap2_pm_finish,
 	.valid		=3D pm_valid_only_mem,
 };
--- wireless-dev.orig/arch/arm/mach-pnx4008/pm.c	2007-04-11 17:07:50.539481=
358 +0200
+++ wireless-dev/arch/arm/mach-pnx4008/pm.c	2007-04-11 17:09:23.759481358 +=
0200
@@ -116,7 +116,9 @@ static int pnx4008_pm_enter(suspend_stat
 }
 =

 static struct pm_ops pnx4008_pm_ops =3D {
+	.quiesce =3D pm_default_quiesce,
 	.enter =3D pnx4008_pm_enter,
+	.activate =3D pm_default_activate,
 	.valid =3D pm_valid_only_mem,
 };
 =

--- wireless-dev.orig/arch/arm/mach-pxa/pm.c	2007-04-11 17:07:50.639481358 =
+0200
+++ wireless-dev/arch/arm/mach-pxa/pm.c	2007-04-11 17:09:45.959481358 +0200
@@ -225,7 +225,9 @@ EXPORT_SYMBOL_GPL(pxa_pm_finish);
 =

 static struct pm_ops pxa_pm_ops =3D {
 	.prepare	=3D pxa_pm_prepare,
+	.quiesce	=3D pm_default_quiesce,
 	.enter		=3D pxa_pm_enter,
+	.activate	=3D pm_default_activate,
 	.finish		=3D pxa_pm_finish,
 	.valid		=3D pm_valid_only_mem,
 };
--- wireless-dev.orig/arch/arm/mach-sa1100/pm.c	2007-04-11 17:07:50.7294813=
58 +0200
+++ wireless-dev/arch/arm/mach-sa1100/pm.c	2007-04-11 17:09:59.759481358 +0=
200
@@ -132,7 +132,9 @@ unsigned long sleep_phys_sp(void *sp)
 }
 =

 static struct pm_ops sa11x0_pm_ops =3D {
+	.quiesce	=3D pm_default_quiesce,
 	.enter		=3D sa11x0_pm_enter,
+	.activate	=3D pm_default_activate,
 	.valid		=3D pm_valid_only_mem,
 };
 =

--- wireless-dev.orig/arch/arm/plat-s3c24xx/pm.c	2007-04-11 17:07:50.959481=
358 +0200
+++ wireless-dev/arch/arm/plat-s3c24xx/pm.c	2007-04-11 17:10:36.039481358 +=
0200
@@ -613,7 +613,9 @@ static int s3c2410_pm_enter(suspend_stat
 }
 =

 static struct pm_ops s3c2410_pm_ops =3D {
+	.quiesce	=3D pm_default_quiesce,
 	.enter		=3D s3c2410_pm_enter,
+	.activate	=3D pm_default_activate,
 	.valid		=3D pm_valid_only_mem,
 };
 =

--- wireless-dev.orig/arch/powerpc/platforms/powermac/setup.c	2007-04-11 17=
:07:51.029481358 +0200
+++ wireless-dev/arch/powerpc/platforms/powermac/setup.c	2007-04-11 17:10:5=
3.659481358 +0200
@@ -475,7 +475,9 @@ static int pmac_pm_valid(suspend_state_t
 static struct pm_ops pmac_pm_ops =3D {
 	.pm_disk_mode	=3D PM_DISK_SHUTDOWN,
 	.prepare	=3D pmac_pm_prepare,
+	.quiesce	=3D pm_default_quiesce,
 	.enter		=3D pmac_pm_enter,
+	.activate	=3D pm_default_activate,
 	.finish		=3D pmac_pm_finish,
 	.valid		=3D pmac_pm_valid,
 };
--- wireless-dev.orig/arch/sh/boards/hp6xx/pm.c	2007-04-11 17:07:51.0994813=
58 +0200
+++ wireless-dev/arch/sh/boards/hp6xx/pm.c	2007-04-11 17:11:06.269481358 +0=
200
@@ -68,7 +68,9 @@ static int hp6x0_pm_enter(suspend_state_
 }
 =

 static struct pm_ops hp6x0_pm_ops =3D {
+	.quiesce	=3D pm_default_quiesce,
 	.enter		=3D hp6x0_pm_enter,
+	.activate	=3D pm_default_activate,
 	.valid		=3D pm_valid_only_mem,
 };
 =

--- wireless-dev.orig/drivers/acpi/sleep/main.c	2007-04-11 17:07:51.3394813=
58 +0200
+++ wireless-dev/drivers/acpi/sleep/main.c	2007-04-11 17:12:49.679481358 +0=
200
@@ -182,10 +182,17 @@ static int acpi_pm_state_valid(suspend_s
 	}
 }
 =

+/*
+ * If .quiesce or .activate are changed, keep in mind
+ * that they aren't currently called for S4. That can
+ * be changed if needed, of course.
+ */
 static struct pm_ops acpi_pm_ops =3D {
 	.valid =3D acpi_pm_state_valid,
 	.prepare =3D acpi_pm_prepare,
+	.quiesce =3D pm_default_quiesce,
 	.enter =3D acpi_pm_enter,
+	.activate =3D pm_default_activate,
 	.finish =3D acpi_pm_finish,
 };
 =

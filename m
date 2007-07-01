From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 2/2] PM: Introduce pm_power_off_prepare
Date: Sun, 1 Jul 2007 20:54:31 +0200
Message-ID: <200707012054.31782.rjw__4225.88427686623$1183315818$gmane$org@sisk.pl>
References: <200707012051.48338.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707012051.48338.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce the pm_power_off_prepare() callback that can be registered by the
interested platforms in analogy with pm_idle() and pm_power_off(), used for
preparing the system to power off (needed by ACPI).

This allows us to drop acpi_sysclass and device_acpi that are only defined in
order to register the ACPI power off preparation callback, which is needed by
pm_power_off() registered in a much different way.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/poweroff.c |   38 +++++++++-----------------------------
 include/linux/pm.h            |    1 +
 kernel/sys.c                  |    9 +++++++++
 3 files changed, 19 insertions(+), 29 deletions(-)

Index: linux-2.6.22-rc6/include/linux/pm.h
===================================================================
--- linux-2.6.22-rc6.orig/include/linux/pm.h	2007-07-01 13:46:49.000000000 +0200
+++ linux-2.6.22-rc6/include/linux/pm.h	2007-07-01 18:37:28.000000000 +0200
@@ -101,6 +101,7 @@ struct pm_dev
  */
 extern void (*pm_idle)(void);
 extern void (*pm_power_off)(void);
+extern void (*pm_power_off_prepare)(void);
 
 /*
  * Device power management
Index: linux-2.6.22-rc6/kernel/sys.c
===================================================================
--- linux-2.6.22-rc6.orig/kernel/sys.c	2007-06-25 21:07:40.000000000 +0200
+++ linux-2.6.22-rc6/kernel/sys.c	2007-07-01 18:40:59.000000000 +0200
@@ -98,6 +98,13 @@ struct pid *cad_pid;
 EXPORT_SYMBOL(cad_pid);
 
 /*
+ * If set, this is used for preparing the system to power off.
+ */
+
+void (*pm_power_off_prepare)(void);
+EXPORT_SYMBOL(pm_power_off_prepare);
+
+/*
  *	Notifier list for kernel code which wants to be called
  *	at shutdown. This is used to stop any idling DMA operations
  *	and the like. 
@@ -865,6 +872,8 @@ EXPORT_SYMBOL_GPL(kernel_halt);
 void kernel_power_off(void)
 {
 	kernel_shutdown_prepare(SYSTEM_POWER_OFF);
+	if (pm_power_off_prepare)
+		pm_power_off_prepare();
 	printk(KERN_EMERG "Power down.\n");
 	machine_power_off();
 }
Index: linux-2.6.22-rc6/drivers/acpi/sleep/poweroff.c
===================================================================
--- linux-2.6.22-rc6.orig/drivers/acpi/sleep/poweroff.c	2007-07-01 15:10:07.000000000 +0200
+++ linux-2.6.22-rc6/drivers/acpi/sleep/poweroff.c	2007-07-01 18:40:09.000000000 +0200
@@ -39,7 +39,13 @@ int acpi_sleep_prepare(u32 acpi_state)
 
 #ifdef CONFIG_PM
 
-void acpi_power_off(void)
+static void acpi_power_off_prepare(void)
+{
+	/* Prepare to power off the system */
+	acpi_sleep_prepare(ACPI_STATE_S5);
+}
+
+static void acpi_power_off(void)
 {
 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
 	printk("%s called\n", __FUNCTION__);
@@ -48,27 +54,6 @@ void acpi_power_off(void)
 	acpi_enter_sleep_state(ACPI_STATE_S5);
 }
 
-static int acpi_shutdown(struct sys_device *x)
-{
-	switch (system_state) {
-	case SYSTEM_POWER_OFF:
-		/* Prepare to power off the system */
-		return acpi_sleep_prepare(ACPI_STATE_S5);
-	default:
-		return 0;
-	}
-}
-
-static struct sysdev_class acpi_sysclass = {
-	set_kset_name("acpi"),
-	.shutdown = acpi_shutdown
-};
-
-static struct sys_device device_acpi = {
-	.id = 0,
-	.cls = &acpi_sysclass,
-};
-
 static int acpi_poweroff_init(void)
 {
 	if (!acpi_disabled) {
@@ -78,13 +63,8 @@ static int acpi_poweroff_init(void)
 		status =
 		    acpi_get_sleep_type_data(ACPI_STATE_S5, &type_a, &type_b);
 		if (ACPI_SUCCESS(status)) {
-			int error;
-			error = sysdev_class_register(&acpi_sysclass);
-			if (!error)
-				error = sysdev_register(&device_acpi);
-			if (!error)
-				pm_power_off = acpi_power_off;
-			return error;
+			pm_power_off_prepare = acpi_power_off_prepare;
+			pm_power_off = acpi_power_off;
 		}
 	}
 	return 0;

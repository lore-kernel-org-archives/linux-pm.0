From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 5/7] Hibernation: Introduce open() and
	close() callbacks
Date: Thu, 27 Dec 2007 19:18:26 +0100
Message-ID: <200712271918.27682.rjw@sisk.pl>
References: <200712271903.53961.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712271903.53961.rjw@sisk.pl>
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
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, LKML <linux-kernel@vger.kernel.org>, "Moore,
	Robert" <robert.moore@intel.com>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce global hibernation callback .close() and rename global
hibernation callback .start() to .open(), in analogy with the
recent modifications of the global suspend callbacks.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |   14 ++++++++++++--
 include/linux/suspend.h   |    8 ++++++--
 kernel/power/disk.c       |   33 ++++++++++++++++++++++++---------
 3 files changed, 42 insertions(+), 13 deletions(-)

Index: linux-2.6/include/linux/suspend.h
===================================================================
--- linux-2.6.orig/include/linux/suspend.h
+++ linux-2.6/include/linux/suspend.h
@@ -138,9 +138,12 @@ extern void mark_free_pages(struct zone 
  *
  * All three methods must be assigned.
  *
- * @start: Tell the platform driver that we're starting hibernation.
+ * @open: Tell the platform driver that we're starting hibernation.
  *	Called right after shrinking memory and before freezing devices.
  *
+ * @close: Called by the PM core right after resuming devices, to indicate to
+ *	the platform that the system has returned to the working state.
+ *
  * @pre_snapshot: Prepare the platform for creating the hibernation image.
  *	Called right after devices have been frozen and before the nonboot
  *	CPUs are disabled (runs with IRQs on).
@@ -175,7 +178,8 @@ extern void mark_free_pages(struct zone 
  *	thawing devices (runs with IRQs on).
  */
 struct platform_hibernation_ops {
-	int (*start)(void);
+	int (*open)(void);
+	void (*close)(void);
 	int (*pre_snapshot)(void);
 	void (*finish)(void);
 	int (*prepare)(void);
Index: linux-2.6/kernel/power/disk.c
===================================================================
--- linux-2.6.orig/kernel/power/disk.c
+++ linux-2.6/kernel/power/disk.c
@@ -54,8 +54,8 @@ static struct platform_hibernation_ops *
 
 void hibernation_set_ops(struct platform_hibernation_ops *ops)
 {
-	if (ops && !(ops->start && ops->pre_snapshot && ops->finish
-	    && ops->prepare && ops->enter && ops->pre_restore
+	if (ops && !(ops->open && ops->close &&  ops->pre_snapshot
+	    && ops->prepare && ops->finish && ops->enter && ops->pre_restore
 	    && ops->restore_cleanup)) {
 		WARN_ON(1);
 		return;
@@ -100,14 +100,25 @@ static int hibernation_test(int level) {
 #endif /* !CONFIG_PM_DEBUG */
 
 /**
- *	platform_start - tell the platform driver that we're starting
+ *	platform_open - tell the platform driver that we're starting
  *	hibernation
  */
 
-static int platform_start(int platform_mode)
+static int platform_open(int platform_mode)
 {
 	return (platform_mode && hibernation_ops) ?
-		hibernation_ops->start() : 0;
+		hibernation_ops->open() : 0;
+}
+
+/**
+ *	platform_close - tell the platform driver that we've entered the
+ *	working state
+ */
+
+static void platform_close(int platform_mode)
+{
+	if (platform_mode && hibernation_ops)
+		hibernation_ops->close();
 }
 
 /**
@@ -237,9 +248,9 @@ int hibernation_snapshot(int platform_mo
 	if (error)
 		return error;
 
-	error = platform_start(platform_mode);
+	error = platform_open(platform_mode);
 	if (error)
-		return error;
+		goto Close;
 
 	suspend_console();
 	error = device_suspend(PMSG_FREEZE);
@@ -272,6 +283,8 @@ int hibernation_snapshot(int platform_mo
 	device_resume();
  Resume_console:
 	resume_console();
+ Close:
+	platform_close(platform_mode);
 	return error;
 }
 
@@ -373,9 +386,9 @@ int hibernation_platform_enter(void)
 	 * hibernation_ops->finish() before saving the image, so we should let
 	 * the firmware know that we're going to enter the sleep state after all
 	 */
-	error = hibernation_ops->start();
+	error = hibernation_ops->open();
 	if (error)
-		return error;
+		goto Close;
 
 	suspend_console();
 	error = device_suspend(PMSG_SUSPEND);
@@ -409,6 +422,8 @@ int hibernation_platform_enter(void)
 	device_resume();
  Resume_console:
 	resume_console();
+ Close:
+	hibernation_ops->close();
 	return error;
 }
 
Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -268,7 +268,7 @@ static struct dmi_system_id __initdata a
 #endif /* CONFIG_SUSPEND */
 
 #ifdef CONFIG_HIBERNATION
-static int acpi_hibernation_start(void)
+static int acpi_hibernation_open(void)
 {
 	acpi_target_sleep_state = ACPI_STATE_S4;
 	return 0;
@@ -328,6 +328,15 @@ static void acpi_hibernation_finish(void
 	acpi_target_sleep_state = ACPI_STATE_S0;
 }
 
+static void acpi_hibernation_close(void)
+{
+	/*
+	 * This is necessary in case acpi_hibernation_finish() is not called
+	 * during a failing transition to the sleep state.
+	 */
+	acpi_target_sleep_state = ACPI_STATE_S0;
+}
+
 static int acpi_hibernation_pre_restore(void)
 {
 	acpi_status status;
@@ -343,7 +352,8 @@ static void acpi_hibernation_restore_cle
 }
 
 static struct platform_hibernation_ops acpi_hibernation_ops = {
-	.start = acpi_hibernation_start,
+	.open = acpi_hibernation_open,
+	.close = acpi_hibernation_close,
 	.pre_snapshot = acpi_hibernation_prepare,
 	.finish = acpi_hibernation_finish,
 	.prepare = acpi_hibernation_prepare,

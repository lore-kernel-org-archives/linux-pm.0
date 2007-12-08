From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/9] Hibernation: Move low level resume to disk.c
Date: Sat, 8 Dec 2007 02:04:21 +0100
Message-ID: <200712080204.21957.rjw__18760.5485007682$1197075451$gmane$org@sisk.pl>
References: <200712080201.40661.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712080201.40661.rjw@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Move the low level restore code to kernel/power/disk.c , since the
corresponding low level hibernation code is already there.

Make restore fail if device_power_down(PMSG_PRETHAW) returns an
error.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/disk.c   |   49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/power/power.h  |    1 -
 kernel/power/swsusp.c |   35 -----------------------------------
 3 files changed, 48 insertions(+), 37 deletions(-)

Index: linux-2.6/kernel/power/disk.c
===================================================================
--- linux-2.6.orig/kernel/power/disk.c
+++ linux-2.6/kernel/power/disk.c
@@ -275,6 +275,53 @@ int hibernation_snapshot(int platform_mo
 }
 
 /**
+ *	resume_target_kernel - prepare devices that need to be suspended with
+ *	interrupts off, restore the contents of highmem that have not been
+ *	restored yet from the image and run the low level code that will restore
+ *	the remaining contents of memory and switch to the just restored target
+ *	kernel.
+ */
+
+static int resume_target_kernel(void)
+{
+	int error;
+
+	local_irq_disable();
+	error = device_power_down(PMSG_PRETHAW);
+	if (error) {
+		printk(KERN_ERR "Some devices failed to power down, "
+			"aborting resume\n");
+		goto Enable_irqs;
+	}
+	/* We'll ignore saved state, but this gets preempt count (etc) right */
+	save_processor_state();
+	error = restore_highmem();
+	if (!error) {
+		error = swsusp_arch_resume();
+		/*
+		 * The code below is only ever reached in case of a failure.
+		 * Otherwise execution continues at place where
+		 * swsusp_arch_suspend() was called
+		 */
+		BUG_ON(!error);
+		/* This call to restore_highmem() undos the previous one */
+		restore_highmem();
+	}
+	/*
+	 * The only reason why swsusp_arch_resume() can fail is memory being
+	 * very tight, so we have to free it as soon as we can to avoid
+	 * subsequent failures
+	 */
+	swsusp_free();
+	restore_processor_state();
+	touch_softlockup_watchdog();
+	device_power_up();
+ Enable_irqs:
+	local_irq_enable();
+	return error;
+}
+
+/**
  *	hibernation_restore - quiesce devices and restore the hibernation
  *	snapshot image.  If successful, control returns in hibernation_snaphot()
  *	@platform_mode - if set, use the platform driver, if available, to
@@ -297,7 +344,7 @@ int hibernation_restore(int platform_mod
 	if (!error) {
 		error = disable_nonboot_cpus();
 		if (!error)
-			error = swsusp_resume();
+			error = resume_target_kernel();
 		enable_nonboot_cpus();
 	}
 	platform_restore_cleanup(platform_mode);
Index: linux-2.6/kernel/power/swsusp.c
===================================================================
--- linux-2.6.orig/kernel/power/swsusp.c
+++ linux-2.6/kernel/power/swsusp.c
@@ -261,38 +261,3 @@ int swsusp_shrink_memory(void)
 
 	return 0;
 }
-
-int swsusp_resume(void)
-{
-	int error;
-
-	local_irq_disable();
-	/* NOTE:  device_power_down() is just a suspend() with irqs off;
-	 * it has no special "power things down" semantics
-	 */
-	if (device_power_down(PMSG_PRETHAW))
-		printk(KERN_ERR "Some devices failed to power down, very bad\n");
-	/* We'll ignore saved state, but this gets preempt count (etc) right */
-	save_processor_state();
-	error = restore_highmem();
-	if (!error) {
-		error = swsusp_arch_resume();
-		/* The code below is only ever reached in case of a failure.
-		 * Otherwise execution continues at place where
-		 * swsusp_arch_suspend() was called
-        	 */
-		BUG_ON(!error);
-		/* This call to restore_highmem() undos the previous one */
-		restore_highmem();
-	}
-	/* The only reason why swsusp_arch_resume() can fail is memory being
-	 * very tight, so we have to free it as soon as we can to avoid
-	 * subsequent failures
-	 */
-	swsusp_free();
-	restore_processor_state();
-	touch_softlockup_watchdog();
-	device_power_up();
-	local_irq_enable();
-	return error;
-}
Index: linux-2.6/kernel/power/power.h
===================================================================
--- linux-2.6.orig/kernel/power/power.h
+++ linux-2.6/kernel/power/power.h
@@ -154,7 +154,6 @@ extern int swsusp_swap_in_use(void);
 extern int swsusp_check(void);
 extern int swsusp_shrink_memory(void);
 extern void swsusp_free(void);
-extern int swsusp_resume(void);
 extern int swsusp_read(unsigned int *flags_p);
 extern int swsusp_write(unsigned int flags);
 extern void swsusp_close(void);

From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/37] Hibernation: Move low level resume to
	disk.c
Date: Thu, 31 Jan 2008 23:36:47 -0500
Message-ID: <d2fdea0305f2b5c6887eff954d1cabb304a376ae.1201840183.git.len.brown__9185.68218262426$1201843064$gmane$org@intel.com>
References: <1201840628-23136-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1201840628-23136-1-git-send-email-lenb@kernel.org>
In-Reply-To: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
References: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Move the low level restore code to kernel/power/disk.c , since the
corresponding low level hibernation code is already there.

Make restore fail if device_power_down(PMSG_PRETHAW) returns an
error.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/disk.c   |   49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/power/power.h  |    1 -
 kernel/power/swsusp.c |   35 -----------------------------------
 3 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index 0866b16..2a4bada 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -275,6 +275,53 @@ int hibernation_snapshot(int platform_mode)
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
@@ -297,7 +344,7 @@ int hibernation_restore(int platform_mode)
 	if (!error) {
 		error = disable_nonboot_cpus();
 		if (!error)
-			error = swsusp_resume();
+			error = resume_target_kernel();
 		enable_nonboot_cpus();
 	}
 	platform_restore_cleanup(platform_mode);
diff --git a/kernel/power/power.h b/kernel/power/power.h
index a9732fd..8ec5499 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -152,7 +152,6 @@ extern int swsusp_swap_in_use(void);
 extern int swsusp_check(void);
 extern int swsusp_shrink_memory(void);
 extern void swsusp_free(void);
-extern int swsusp_resume(void);
 extern int swsusp_read(unsigned int *flags_p);
 extern int swsusp_write(unsigned int flags);
 extern void swsusp_close(void);
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
index 605c536..dc29a20 100644
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
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
-- 
1.5.4.rc5.16.gc0279

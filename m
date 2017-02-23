From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] PM / hibernate: Define pr_fmt() and use pr_*() instead of printk()
Date: Fri, 24 Feb 2017 00:26:15 +0100
Message-ID: <14046145.RsGSoZ7n56@aspire.rjw.lan>
References: <1897611.guix8xla9k@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41979 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751283AbdBWXdM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Feb 2017 18:33:12 -0500
In-Reply-To: <1897611.guix8xla9k@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Define a pr_fmt() for hibernate.c and convert all of the explicit
printk() calls into corresponding pr_*() so that they use the
pr_fmt() format.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/hibernate.c |   60 ++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

Index: linux-pm/kernel/power/hibernate.c
===================================================================
--- linux-pm.orig/kernel/power/hibernate.c
+++ linux-pm/kernel/power/hibernate.c
@@ -10,6 +10,8 @@
  * This file is released under the GPLv2.
  */
 
+#define pr_fmt(fmt) "PM: " fmt
+
 #include <linux/export.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
@@ -104,7 +106,7 @@ EXPORT_SYMBOL(system_entering_hibernatio
 #ifdef CONFIG_PM_DEBUG
 static void hibernation_debug_sleep(void)
 {
-	printk(KERN_INFO "hibernation debug: Waiting for 5 seconds.\n");
+	pr_info("hibernation debug: Waiting for 5 seconds.\n");
 	mdelay(5000);
 }
 
@@ -250,10 +252,9 @@ void swsusp_show_speed(ktime_t start, kt
 		centisecs = 1;	/* avoid div-by-zero */
 	k = nr_pages * (PAGE_SIZE / 1024);
 	kps = (k * 100) / centisecs;
-	printk(KERN_INFO "PM: %s %u kbytes in %u.%02u seconds (%u.%02u MB/s)\n",
-			msg, k,
-			centisecs / 100, centisecs % 100,
-			kps / 1000, (kps % 1000) / 10);
+	pr_info("%s %u kbytes in %u.%02u seconds (%u.%02u MB/s)\n",
+		msg, k, centisecs / 100, centisecs % 100, kps / 1000,
+		(kps % 1000) / 10);
 }
 
 /**
@@ -271,8 +272,7 @@ static int create_image(int platform_mod
 
 	error = dpm_suspend_end(PMSG_FREEZE);
 	if (error) {
-		printk(KERN_ERR "PM: Some devices failed to power down, "
-			"aborting hibernation\n");
+		pr_err("Some devices failed to power down, aborting hibernation\n");
 		return error;
 	}
 
@@ -288,8 +288,7 @@ static int create_image(int platform_mod
 
 	error = syscore_suspend();
 	if (error) {
-		printk(KERN_ERR "PM: Some system devices failed to power down, "
-			"aborting hibernation\n");
+		pr_err("Some system devices failed to power down, aborting hibernation\n");
 		goto Enable_irqs;
 	}
 
@@ -304,8 +303,8 @@ static int create_image(int platform_mod
 	restore_processor_state();
 	trace_suspend_resume(TPS("machine_suspend"), PM_EVENT_HIBERNATE, false);
 	if (error)
-		printk(KERN_ERR "PM: Error %d creating hibernation image\n",
-			error);
+		pr_err("Error %d creating hibernation image\n", error);
+
 	if (!in_suspend) {
 		events_check_enabled = false;
 		clear_free_pages();
@@ -432,8 +431,7 @@ static int resume_target_kernel(bool pla
 
 	error = dpm_suspend_end(PMSG_QUIESCE);
 	if (error) {
-		printk(KERN_ERR "PM: Some devices failed to power down, "
-			"aborting resume\n");
+		pr_err("Some devices failed to power down, aborting resume\n");
 		return error;
 	}
 
@@ -619,7 +617,7 @@ static void power_down(void)
 			/* Restore swap signature. */
 			error = swsusp_unmark();
 			if (error)
-				pr_err("PM: Swap will be unusable! Try swapon -a.\n");
+				pr_err("Swap will be unusable! Try swapon -a.\n");
 
 			return;
 		}
@@ -642,7 +640,7 @@ static void power_down(void)
 	 * Valid image is on the disk, if we continue we risk serious data
 	 * corruption after resume.
 	 */
-	printk(KERN_CRIT "PM: Please power down manually\n");
+	pr_crit("Power down manually\n");
 	while (1)
 		cpu_relax();
 }
@@ -652,7 +650,7 @@ static int load_image_and_restore(void)
 	int error;
 	unsigned int flags;
 
-	pr_debug("PM: Loading hibernation image.\n");
+	pr_debug("Loading hibernation image.\n");
 
 	lock_device_hotplug();
 	error = create_basic_memory_bitmaps();
@@ -664,7 +662,7 @@ static int load_image_and_restore(void)
 	if (!error)
 		hibernation_restore(flags & SF_PLATFORM_MODE);
 
-	printk(KERN_ERR "PM: Failed to load hibernation image, recovering.\n");
+	pr_err("Failed to load hibernation image, recovering.\n");
 	swsusp_free();
 	free_basic_memory_bitmaps();
  Unlock:
@@ -682,7 +680,7 @@ int hibernate(void)
 	bool snapshot_test = false;
 
 	if (!hibernation_available()) {
-		pr_debug("PM: Hibernation not available.\n");
+		pr_debug("Hibernation not available.\n");
 		return -EPERM;
 	}
 
@@ -700,9 +698,9 @@ int hibernate(void)
 		goto Exit;
 	}
 
-	printk(KERN_INFO "PM: Syncing filesystems ... ");
+	pr_info("Syncing filesystems ... \n");
 	sys_sync();
-	printk("done.\n");
+	pr_info("done.\n");
 
 	error = freeze_processes();
 	if (error)
@@ -728,7 +726,7 @@ int hibernate(void)
 		else
 		        flags |= SF_CRC32_MODE;
 
-		pr_debug("PM: writing image.\n");
+		pr_debug("Writing image.\n");
 		error = swsusp_write(flags);
 		swsusp_free();
 		if (!error) {
@@ -740,7 +738,7 @@ int hibernate(void)
 		in_suspend = 0;
 		pm_restore_gfp_mask();
 	} else {
-		pr_debug("PM: Image restored successfully.\n");
+		pr_debug("Image restored successfully.\n");
 	}
 
  Free_bitmaps:
@@ -748,7 +746,7 @@ int hibernate(void)
  Thaw:
 	unlock_device_hotplug();
 	if (snapshot_test) {
-		pr_debug("PM: Checking hibernation image\n");
+		pr_debug("Checking hibernation image\n");
 		error = swsusp_check();
 		if (!error)
 			error = load_image_and_restore();
@@ -812,10 +810,10 @@ static int software_resume(void)
 		goto Unlock;
 	}
 
-	pr_debug("PM: Checking hibernation image partition %s\n", resume_file);
+	pr_debug("Checking hibernation image partition %s\n", resume_file);
 
 	if (resume_delay) {
-		printk(KERN_INFO "Waiting %dsec before reading resume device...\n",
+		pr_info("Waiting %dsec before reading resume device ...\n",
 			resume_delay);
 		ssleep(resume_delay);
 	}
@@ -854,10 +852,10 @@ static int software_resume(void)
 	}
 
  Check_image:
-	pr_debug("PM: Hibernation image partition %d:%d present\n",
+	pr_debug("Hibernation image partition %d:%d present\n",
 		MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
 
-	pr_debug("PM: Looking for hibernation image.\n");
+	pr_debug("Looking for hibernation image.\n");
 	error = swsusp_check();
 	if (error)
 		goto Unlock;
@@ -876,7 +874,7 @@ static int software_resume(void)
 		goto Close_Finish;
 	}
 
-	pr_debug("PM: Preparing processes for restore.\n");
+	pr_debug("Preparing processes for restore.\n");
 	error = freeze_processes();
 	if (error)
 		goto Close_Finish;
@@ -889,7 +887,7 @@ static int software_resume(void)
 	/* For success case, the suspend path will release the lock */
  Unlock:
 	mutex_unlock(&pm_mutex);
-	pr_debug("PM: Hibernation image not present or could not be loaded.\n");
+	pr_debug("Hibernation image not present or could not be loaded.\n");
 	return error;
  Close_Finish:
 	swsusp_close(FMODE_READ);
@@ -1013,7 +1011,7 @@ static ssize_t disk_store(struct kobject
 		error = -EINVAL;
 
 	if (!error)
-		pr_debug("PM: Hibernation mode set to '%s'\n",
+		pr_debug("Hibernation mode set to '%s'\n",
 			 hibernation_modes[mode]);
 	unlock_system_sleep();
 	return error ? error : n;
@@ -1049,7 +1047,7 @@ static ssize_t resume_store(struct kobje
 	lock_system_sleep();
 	swsusp_resume_device = res;
 	unlock_system_sleep();
-	printk(KERN_INFO "PM: Starting manual resume from disk\n");
+	pr_info("Starting manual resume from disk\n");
 	noresume = 0;
 	software_resume();
 	return n;

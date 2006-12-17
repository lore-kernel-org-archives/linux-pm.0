From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 2/4] swsusp: Change code ordering in
	disk.c
Date: Sun, 17 Dec 2006 19:05:03 +0100
Message-ID: <200612171905.04681.rjw@sisk.pl>
References: <200612171858.16380.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200612171858.16380.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: pm list <linux-pm@lists.osdl.org>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, linux-acpi@vger.kernel.org, Stefan Seyfried <seife@suse.de>, Stephen Hemminger <shemminger@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Change the ordering of code in kernel/power/disk.c so that
device_suspend() is called before disable_nonboot_cpus() and
platform_finish() is called after enable_nonboot_cpus() and before
device_resume(), as indicated by the recent discussion on Linux-PM
(cf. http://lists.osdl.org/pipermail/linux-pm/2006-November/004164.html).

The changes here only affect the built-in swsusp.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/cpu.c        |    2 
 kernel/power/disk.c |  110 ++++++++++++++++++++++++++--------------------------
 2 files changed, 57 insertions(+), 55 deletions(-)

Index: linux-2.6.20-rc1/kernel/cpu.c
===================================================================
--- linux-2.6.20-rc1.orig/kernel/cpu.c	2006-12-14 22:35:52.000000000 +0100
+++ linux-2.6.20-rc1/kernel/cpu.c	2006-12-14 23:19:49.000000000 +0100
@@ -309,6 +309,8 @@ void enable_nonboot_cpus(void)
 	mutex_lock(&cpu_add_remove_lock);
 	cpu_hotplug_disabled = 0;
 	mutex_unlock(&cpu_add_remove_lock);
+	if (cpus_empty(frozen_cpus))
+		return;
 
 	printk("Enabling non-boot CPUs ...\n");
 	for_each_cpu_mask(cpu, frozen_cpus) {
Index: linux-2.6.20-rc1/kernel/power/disk.c
===================================================================
--- linux-2.6.20-rc1.orig/kernel/power/disk.c	2006-12-14 22:35:52.000000000 +0100
+++ linux-2.6.20-rc1/kernel/power/disk.c	2006-12-14 23:19:49.000000000 +0100
@@ -85,52 +85,24 @@ static inline void platform_finish(void)
 	}
 }
 
+static void unprepare_processes(void)
+{
+	thaw_processes();
+	pm_restore_console();
+}
+
 static int prepare_processes(void)
 {
 	int error = 0;
 
 	pm_prepare_console();
-
-	error = disable_nonboot_cpus();
-	if (error)
-		goto enable_cpus;
-
 	if (freeze_processes()) {
 		error = -EBUSY;
-		goto thaw;
+		unprepare_processes();
 	}
-
-	if (pm_disk_mode == PM_DISK_TESTPROC) {
-		printk("swsusp debug: Waiting for 5 seconds.\n");
-		mdelay(5000);
-		goto thaw;
-	}
-
-	error = platform_prepare();
-	if (error)
-		goto thaw;
-
-	/* Free memory before shutting down devices. */
-	if (!(error = swsusp_shrink_memory()))
-		return 0;
-
-	platform_finish();
- thaw:
-	thaw_processes();
- enable_cpus:
-	enable_nonboot_cpus();
-	pm_restore_console();
 	return error;
 }
 
-static void unprepare_processes(void)
-{
-	platform_finish();
-	thaw_processes();
-	enable_nonboot_cpus();
-	pm_restore_console();
-}
-
 /**
  *	pm_suspend_disk - The granpappy of hibernation power management.
  *
@@ -148,29 +120,45 @@ int pm_suspend_disk(void)
 	if (error)
 		return error;
 
-	if (pm_disk_mode == PM_DISK_TESTPROC)
-		return 0;
+	if (pm_disk_mode == PM_DISK_TESTPROC) {
+		printk("swsusp debug: Waiting for 5 seconds.\n");
+		mdelay(5000);
+		goto Thaw;
+	}
+	/* Free memory before shutting down devices. */
+	error = swsusp_shrink_memory();
+	if (error)
+		goto Thaw;
+
+	error = platform_prepare();
+	if (error)
+		goto Thaw;
 
 	suspend_console();
 	error = device_suspend(PMSG_FREEZE);
 	if (error) {
-		resume_console();
-		printk("Some devices failed to suspend\n");
-		goto Thaw;
+		printk(KERN_ERR "PM: Some devices failed to suspend\n");
+		goto Resume_devices;
 	}
+	error = disable_nonboot_cpus();
+	if (error)
+		goto Enable_cpus;
 
 	if (pm_disk_mode == PM_DISK_TEST) {
 		printk("swsusp debug: Waiting for 5 seconds.\n");
 		mdelay(5000);
-		goto Done;
+		goto Enable_cpus;
 	}
 
 	pr_debug("PM: snapshotting memory.\n");
 	in_suspend = 1;
-	if ((error = swsusp_suspend()))
-		goto Done;
+	error = swsusp_suspend();
+	if (error)
+		goto Enable_cpus;
 
 	if (in_suspend) {
+		enable_nonboot_cpus();
+		platform_finish();
 		device_resume();
 		resume_console();
 		pr_debug("PM: writing image.\n");
@@ -186,7 +174,10 @@ int pm_suspend_disk(void)
 	}
 
 	swsusp_free();
- Done:
+ Enable_cpus:
+	enable_nonboot_cpus();
+ Resume_devices:
+	platform_finish();
 	device_resume();
 	resume_console();
  Thaw:
@@ -235,41 +226,50 @@ static int software_resume(void)
 
 	pr_debug("PM: Checking swsusp image.\n");
 
-	if ((error = swsusp_check()))
+	error = swsusp_check();
+	if (error)
 		goto Done;
 
 	pr_debug("PM: Preparing processes for restore.\n");
 
-	if ((error = prepare_processes())) {
+	error = prepare_processes();
+	if (error) {
 		swsusp_close();
 		goto Done;
 	}
 
 	pr_debug("PM: Reading swsusp image.\n");
 
-	if ((error = swsusp_read())) {
+	error = swsusp_read();
+	if (error) {
 		swsusp_free();
 		goto Thaw;
 	}
 
 	pr_debug("PM: Preparing devices for restore.\n");
 
-	suspend_console();
-	if ((error = device_suspend(PMSG_PRETHAW))) {
-		resume_console();
-		printk("Some devices failed to suspend\n");
+	error = platform_prepare();
+	if (error) {
 		swsusp_free();
 		goto Thaw;
 	}
+	suspend_console();
+	error = device_suspend(PMSG_PRETHAW);
+	if (error)
+		goto Free;
 
-	mb();
+	error = disable_nonboot_cpus();
+	if (!error)
+		swsusp_resume();
 
-	pr_debug("PM: Restoring saved image.\n");
-	swsusp_resume();
-	pr_debug("PM: Restore failed, recovering.n");
+	enable_nonboot_cpus();
+ Free:
+	swsusp_free();
+	platform_finish();
 	device_resume();
 	resume_console();
  Thaw:
+	printk(KERN_ERR "PM: Restore failed, recovering.\n");
 	unprepare_processes();
  Done:
 	/* For success case, the suspend path will release the lock */


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 2/5] swsusp: Change code ordering
	in disk.c
Date: Sat, 25 Nov 2006 22:34:32 +0100
Message-ID: <200611252234.32567.rjw@sisk.pl>
References: <200611252210.58203.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200611252210.58203.rjw@sisk.pl>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Change the ordering of code in kernel/power/disk.c so that
device_suspend() is called before disable_nonboot_cpus() and
platform_finish() is called after enable_nonboot_cpus() and before
device_resume().

The changes here only affect the built-in swsusp.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/cpu.c        |    2 
 kernel/power/disk.c |  110 ++++++++++++++++++++++++++--------------------------
 2 files changed, 58 insertions(+), 54 deletions(-)

Index: linux-2.6.19-rc6-mm1/kernel/cpu.c
===================================================================
--- linux-2.6.19-rc6-mm1.orig/kernel/cpu.c
+++ linux-2.6.19-rc6-mm1/kernel/cpu.c
@@ -318,6 +318,8 @@ void enable_nonboot_cpus(void)
 	mutex_lock(&cpu_add_remove_lock);
 	cpu_hotplug_disabled = 0;
 	mutex_unlock(&cpu_add_remove_lock);
+	if (cpus_empty(frozen_cpus))
+		return;
 
 	printk("Enabling non-boot CPUs ...\n");
 	for_each_cpu_mask(cpu, frozen_cpus) {
Index: linux-2.6.19-rc6-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.19-rc6-mm1.orig/kernel/power/disk.c
+++ linux-2.6.19-rc6-mm1/kernel/power/disk.c
@@ -89,52 +89,26 @@ static inline void platform_finish(void)
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
-	}
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
+	} else if (pm_disk_mode != PM_DISK_TESTPROC) {
 		return 0;
-
-	platform_finish();
- thaw:
-	thaw_processes();
- enable_cpus:
-	enable_nonboot_cpus();
-	pm_restore_console();
+	}
+	unprepare_processes();
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
@@ -152,29 +126,45 @@ int pm_suspend_disk(void)
 	if (error)
 		return error;
 
-	if (pm_disk_mode == PM_DISK_TESTPROC)
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
 		goto Thaw;
 
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
@@ -190,7 +180,10 @@ int pm_suspend_disk(void)
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
@@ -239,41 +232,50 @@ static int software_resume(void)
 
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

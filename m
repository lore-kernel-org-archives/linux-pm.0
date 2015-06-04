From: Joe Perches <joe@perches.com>
Subject: [PATCH 6/6] power: Use pr_fmt and pr_<level>
Date: Thu,  4 Jun 2015 11:36:49 -0700
Message-ID: <dd664b00f8dad50f1117d72ea12474d1424692ae.1433442778.git.joe@perches.com>
References: <cover.1433442778.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1433442778.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use a more current logging style.

Some of these messages did not use prefixes so
use pr_fmt to prefix every message with "PM: "

In snapshot.c, one of the messages was a single
line emited with KERN_CONT.  Use 2 lines so the
time to allocate memory can be more easily known
by printk/dmesg timestamps.

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/power/hibernate.c    |  61 ++++++++++-----------
 kernel/power/main.c         |   6 +-
 kernel/power/process.c      |   1 +
 kernel/power/qos.c          |   6 +-
 kernel/power/snapshot.c     |  38 ++++++-------
 kernel/power/suspend.c      |  29 +++++-----
 kernel/power/suspend_test.c |  44 ++++++---------
 kernel/power/swap.c         | 131 ++++++++++++++++++++------------------------
 kernel/power/user.c         |   6 +-
 9 files changed, 152 insertions(+), 170 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 2466d78..71f9904 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -10,6 +10,8 @@
  * This file is released under the GPLv2.
  */
 
+#define pr_fmt(fmt) "PM: " fmt
+
 #include <linux/export.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
@@ -103,7 +105,7 @@ EXPORT_SYMBOL(system_entering_hibernation);
 #ifdef CONFIG_PM_DEBUG
 static void hibernation_debug_sleep(void)
 {
-	printk(KERN_INFO "hibernation debug: Waiting for 5 seconds.\n");
+	pr_info("%s: Waiting for 5 seconds\n", __func__);
 	mdelay(5000);
 }
 
@@ -249,10 +251,10 @@ void swsusp_show_speed(ktime_t start, ktime_t stop,
 		centisecs = 1;	/* avoid div-by-zero */
 	k = nr_pages * (PAGE_SIZE / 1024);
 	kps = (k * 100) / centisecs;
-	printk(KERN_INFO "PM: %s %u kbytes in %u.%02u seconds (%u.%02u MB/s)\n",
-			msg, k,
-			centisecs / 100, centisecs % 100,
-			kps / 1000, (kps % 1000) / 10);
+	pr_info("%s %u kbytes in %u.%02u seconds (%u.%02u MB/s)\n",
+		msg, k,
+		centisecs / 100, centisecs % 100,
+		kps / 1000, (kps % 1000) / 10);
 }
 
 /**
@@ -270,8 +272,7 @@ static int create_image(int platform_mode)
 
 	error = dpm_suspend_end(PMSG_FREEZE);
 	if (error) {
-		printk(KERN_ERR "PM: Some devices failed to power down, "
-			"aborting hibernation\n");
+		pr_err("Some devices failed to power down, aborting hibernation\n");
 		return error;
 	}
 
@@ -287,8 +288,7 @@ static int create_image(int platform_mode)
 
 	error = syscore_suspend();
 	if (error) {
-		printk(KERN_ERR "PM: Some system devices failed to power down, "
-			"aborting hibernation\n");
+		pr_err("Some system devices failed to power down, aborting hibernation\n");
 		goto Enable_irqs;
 	}
 
@@ -301,8 +301,7 @@ static int create_image(int platform_mode)
 	error = swsusp_arch_suspend();
 	trace_suspend_resume(TPS("machine_suspend"), PM_EVENT_HIBERNATE, false);
 	if (error)
-		printk(KERN_ERR "PM: Error %d creating hibernation image\n",
-			error);
+		pr_err("Error %d creating hibernation image\n", error);
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 	if (!in_suspend)
@@ -423,8 +422,7 @@ static int resume_target_kernel(bool platform_mode)
 
 	error = dpm_suspend_end(PMSG_QUIESCE);
 	if (error) {
-		printk(KERN_ERR "PM: Some devices failed to power down, "
-			"aborting resume\n");
+		pr_err("Some devices failed to power down, aborting resume\n");
 		return error;
 	}
 
@@ -624,8 +622,7 @@ static void power_down(void)
 		 */
 		error = swsusp_unmark();
 		if (error)
-			printk(KERN_ERR "PM: Swap will be unusable! "
-			                "Try swapon -a.\n");
+			pr_err("Swap will be unusable! Try 'swapon -a'\n");
 		return;
 #endif
 	}
@@ -634,7 +631,7 @@ static void power_down(void)
 	 * Valid image is on the disk, if we continue we risk serious data
 	 * corruption after resume.
 	 */
-	printk(KERN_CRIT "PM: Please power down manually\n");
+	pr_crit("Please power down manually\n");
 	while (1)
 		cpu_relax();
 }
@@ -647,7 +644,7 @@ int hibernate(void)
 	int error;
 
 	if (!hibernation_available()) {
-		pr_debug("PM: Hibernation not available.\n");
+		pr_debug("Hibernation not available\n");
 		return -EPERM;
 	}
 
@@ -663,9 +660,9 @@ int hibernate(void)
 	if (error)
 		goto Exit;
 
-	printk(KERN_INFO "PM: Syncing filesystems ...\n");
+	pr_info("Syncing filesystems...\n");
 	sys_sync();
-	printk(KERN_INFO "PM: Syncing filesystems: done\n");
+	pr_info("Syncing filesystems: done\n");
 
 	error = freeze_processes();
 	if (error)
@@ -691,7 +688,7 @@ int hibernate(void)
 		else
 		        flags |= SF_CRC32_MODE;
 
-		pr_debug("PM: writing image.\n");
+		pr_debug("writing image\n");
 		error = swsusp_write(flags);
 		swsusp_free();
 		if (!error)
@@ -699,7 +696,7 @@ int hibernate(void)
 		in_suspend = 0;
 		pm_restore_gfp_mask();
 	} else {
-		pr_debug("PM: Image restored successfully.\n");
+		pr_debug("Image restored successfully\n");
 	}
 
  Free_bitmaps:
@@ -766,10 +763,10 @@ static int software_resume(void)
 		goto Unlock;
 	}
 
-	pr_debug("PM: Checking hibernation image partition %s\n", resume_file);
+	pr_debug("Checking hibernation image partition %s\n", resume_file);
 
 	if (resume_delay) {
-		printk(KERN_INFO "Waiting %dsec before reading resume device...\n",
+		pr_info("Waiting %dsec before reading resume device...\n",
 			resume_delay);
 		ssleep(resume_delay);
 	}
@@ -808,10 +805,10 @@ static int software_resume(void)
 	}
 
  Check_image:
-	pr_debug("PM: Hibernation image partition %d:%d present\n",
-		MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
+	pr_debug("Hibernation image partition %d:%d present\n",
+		 MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
 
-	pr_debug("PM: Looking for hibernation image.\n");
+	pr_debug("Looking for hibernation image\n");
 	error = swsusp_check();
 	if (error)
 		goto Unlock;
@@ -828,12 +825,12 @@ static int software_resume(void)
 	if (error)
 		goto Close_Finish;
 
-	pr_debug("PM: Preparing processes for restore.\n");
+	pr_debug("Preparing processes for restore\n");
 	error = freeze_processes();
 	if (error)
 		goto Close_Finish;
 
-	pr_debug("PM: Loading hibernation image.\n");
+	pr_debug("Loading hibernation image\n");
 
 	lock_device_hotplug();
 	error = create_basic_memory_bitmaps();
@@ -845,7 +842,7 @@ static int software_resume(void)
 	if (!error)
 		hibernation_restore(flags & SF_PLATFORM_MODE);
 
-	printk(KERN_ERR "PM: Failed to load hibernation image, recovering.\n");
+	pr_err("Failed to load hibernation image, recovering\n");
 	swsusp_free();
 	free_basic_memory_bitmaps();
  Thaw:
@@ -858,7 +855,7 @@ static int software_resume(void)
 	/* For success case, the suspend path will release the lock */
  Unlock:
 	mutex_unlock(&pm_mutex);
-	pr_debug("PM: Hibernation image not present or could not be loaded.\n");
+	pr_debug("Hibernation image not present or could not be loaded\n");
 	return error;
  Close_Finish:
 	swsusp_close(FMODE_READ);
@@ -979,7 +976,7 @@ static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
 		error = -EINVAL;
 
 	if (!error)
-		pr_debug("PM: Hibernation mode set to '%s'\n",
+		pr_debug("Hibernation mode set to '%s'\n",
 			 hibernation_modes[mode]);
 	unlock_system_sleep();
 	return error ? error : n;
@@ -1015,7 +1012,7 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	lock_system_sleep();
 	swsusp_resume_device = res;
 	unlock_system_sleep();
-	printk(KERN_INFO "PM: Starting manual resume from disk\n");
+	pr_info("Starting manual resume from disk\n");
 	noresume = 0;
 	software_resume();
 	return n;
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 63d395b..27d76b4 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -8,6 +8,8 @@
  *
  */
 
+#define pr_fmt(fmt) "PM: " fmt
+
 #include <linux/export.h>
 #include <linux/kobject.h>
 #include <linux/string.h>
@@ -531,8 +533,8 @@ pm_trace_store(struct kobject *kobj, struct kobj_attribute *attr,
 	if (sscanf(buf, "%d", &val) == 1) {
 		pm_trace_enabled = !!val;
 		if (pm_trace_enabled) {
-			pr_warn("PM: Enabling pm_trace changes system date and time during resume.\n"
-				"PM: Correct system time has to be restored manually after resume.\n");
+			pr_warn("Enabling pm_trace changes system date and time during resume\n");
+			pr_warn("Correct system time has to be restored manually after resume\n");
 		}
 		return n;
 	}
diff --git a/kernel/power/process.c b/kernel/power/process.c
index f072ae6..749d88c 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -5,6 +5,7 @@
  * Originally from swsusp.
  */
 
+#define pr_fmt(fmt) "PM: " fmt
 
 #undef DEBUG
 
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 97b0df71..531f5ef 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -29,6 +29,8 @@
 
 /*#define DEBUG*/
 
+#define pr_fmt(fmt) "PM: " fmt
+
 #include <linux/pm_qos.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
@@ -701,8 +703,8 @@ static int __init pm_qos_power_init(void)
 	for (i = PM_QOS_CPU_DMA_LATENCY; i < PM_QOS_NUM_CLASSES; i++) {
 		ret = register_pm_qos_misc(pm_qos_array[i], d);
 		if (ret < 0) {
-			printk(KERN_ERR "pm_qos_param: %s setup failed\n",
-			       pm_qos_array[i]->name);
+			pr_err("%s: %s setup failed\n",
+			       __func__, pm_qos_array[i]->name);
 			return ret;
 		}
 	}
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 5235dd4..0fd7ad8 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -10,6 +10,8 @@
  *
  */
 
+#define pr_fmt(fmt) "PM: " fmt
+
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/mm.h>
@@ -867,7 +869,7 @@ __register_nosave_region(unsigned long start_pfn, unsigned long end_pfn,
 	region->end_pfn = end_pfn;
 	list_add_tail(&region->list, &nosave_regions);
  Report:
-	printk(KERN_INFO "PM: Registered nosave memory: [mem %#010llx-%#010llx]\n",
+	pr_info("Registered nosave memory: [mem %#010llx-%#010llx]\n",
 		(unsigned long long) start_pfn << PAGE_SHIFT,
 		((unsigned long long) end_pfn << PAGE_SHIFT) - 1);
 }
@@ -937,10 +939,9 @@ static void mark_nosave_pages(struct memory_bitmap *bm)
 	list_for_each_entry(region, &nosave_regions, list) {
 		unsigned long pfn;
 
-		pr_debug("PM: Marking nosave pages: [mem %#010llx-%#010llx]\n",
-			 (unsigned long long) region->start_pfn << PAGE_SHIFT,
-			 ((unsigned long long) region->end_pfn << PAGE_SHIFT)
-				- 1);
+		pr_debug("Marking nosave pages: [mem %#010llx-%#010llx]\n",
+			 (unsigned long long)region->start_pfn << PAGE_SHIFT,
+			 ((unsigned long long)region->end_pfn << PAGE_SHIFT) - 1);
 
 		for (pfn = region->start_pfn; pfn < region->end_pfn; pfn++)
 			if (pfn_valid(pfn)) {
@@ -993,7 +994,7 @@ int create_basic_memory_bitmaps(void)
 	free_pages_map = bm2;
 	mark_nosave_pages(forbidden_pages_map);
 
-	pr_debug("PM: Basic memory bitmaps created\n");
+	pr_debug("Basic memory bitmaps created\n");
 
 	return 0;
 
@@ -1029,7 +1030,7 @@ void free_basic_memory_bitmaps(void)
 	memory_bm_free(bm2, PG_UNSAFE_CLEAR);
 	kfree(bm2);
 
-	pr_debug("PM: Basic memory bitmaps freed\n");
+	pr_debug("Basic memory bitmaps freed\n");
 }
 
 /**
@@ -1564,7 +1565,7 @@ int hibernate_preallocate_memory(void)
 	ktime_t start, stop;
 	int error;
 
-	printk(KERN_INFO "PM: Preallocating image memory... ");
+	pr_info("Preallocating image memory...\n");
 	start = ktime_get();
 
 	error = memory_bm_create(&orig_bm, GFP_IMAGE, PG_ANY);
@@ -1695,13 +1696,13 @@ int hibernate_preallocate_memory(void)
 
  out:
 	stop = ktime_get();
-	printk(KERN_CONT "done (allocated %lu pages)\n", pages);
+	pr_info("Preallocating image memory: done (allocated %lu pages)\n",
+		pages);
 	swsusp_show_speed(start, stop, pages, "Allocated");
 
 	return 0;
 
  err_out:
-	printk(KERN_CONT "\n");
 	swsusp_free();
 	return -ENOMEM;
 }
@@ -1743,8 +1744,8 @@ static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
 			free += zone_page_state(zone, NR_FREE_PAGES);
 
 	nr_pages += count_pages_for_highmem(nr_highmem);
-	pr_debug("PM: Normal pages needed: %u + %u, available pages: %u\n",
-		nr_pages, PAGES_FOR_IO, free);
+	pr_debug("Normal pages needed: %u + %u, available pages: %u\n",
+		 nr_pages, PAGES_FOR_IO, free);
 
 	return free > nr_pages + PAGES_FOR_IO;
 }
@@ -1838,20 +1839,20 @@ asmlinkage __visible int swsusp_save(void)
 {
 	unsigned int nr_pages, nr_highmem;
 
-	printk(KERN_INFO "PM: Creating hibernation image:\n");
+	pr_info("Creating hibernation image\n");
 
 	drain_local_pages(NULL);
 	nr_pages = count_data_pages();
 	nr_highmem = count_highmem_pages();
-	printk(KERN_INFO "PM: Need to copy %u pages\n", nr_pages + nr_highmem);
+	pr_info("Need to copy %u pages\n", nr_pages + nr_highmem);
 
 	if (!enough_free_mem(nr_pages, nr_highmem)) {
-		printk(KERN_ERR "PM: Not enough free memory\n");
+		pr_err("Not enough free memory\n");
 		return -ENOMEM;
 	}
 
 	if (swsusp_alloc(&orig_bm, &copy_bm, nr_pages, nr_highmem)) {
-		printk(KERN_ERR "PM: Memory allocation failed\n");
+		pr_err("Memory allocation failed\n");
 		return -ENOMEM;
 	}
 
@@ -1871,8 +1872,7 @@ asmlinkage __visible int swsusp_save(void)
 	nr_copy_pages = nr_pages;
 	nr_meta_pages = DIV_ROUND_UP(nr_pages * sizeof(long), PAGE_SIZE);
 
-	printk(KERN_INFO "PM: Hibernation image created (%d pages copied)\n",
-		nr_pages);
+	pr_info("Hibernation image created (%d pages copied)\n", nr_pages);
 
 	return 0;
 }
@@ -2056,7 +2056,7 @@ static int check_header(struct swsusp_info *info)
 	if (!reason && info->num_physpages != get_num_physpages())
 		reason = "memory size";
 	if (reason) {
-		printk(KERN_ERR "PM: Image mismatch: %s\n", reason);
+		pr_err("Image mismatch: %s\n", reason);
 		return -EPERM;
 	}
 	return 0;
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index c3fec97..730506f 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -8,6 +8,8 @@
  * This file is released under the GPLv2.
  */
 
+#define pr_fmt(fmt) "PM: " fmt
+
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -68,11 +70,11 @@ static void freeze_enter(void)
 
 	/* Push all the CPUs into the idle loop. */
 	wake_up_all_idle_cpus();
-	pr_debug("PM: suspend-to-idle\n");
+	pr_debug("suspend-to-idle\n");
 	/* Make the current CPU wait so it can enter the idle loop too. */
 	wait_event(suspend_freeze_wait_head,
 		   suspend_freeze_state == FREEZE_STATE_WAKE);
-	pr_debug("PM: resume from suspend-to-idle\n");
+	pr_debug("resume from suspend-to-idle\n");
 
 	cpuidle_pause();
 	put_online_cpus();
@@ -245,8 +247,8 @@ static int suspend_test(int level)
 {
 #ifdef CONFIG_PM_DEBUG
 	if (pm_test_level == level) {
-		printk(KERN_INFO "suspend debug: Waiting for %d second(s).\n",
-				pm_test_delay);
+		pr_info("suspend debug: Waiting for %d second(s)\n",
+			pm_test_delay);
 		mdelay(pm_test_delay * 1000);
 		return 1;
 	}
@@ -317,7 +319,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 
 	error = dpm_suspend_late(PMSG_SUSPEND);
 	if (error) {
-		printk(KERN_ERR "PM: late suspend of devices failed\n");
+		pr_err("late suspend of devices failed\n");
 		goto Platform_finish;
 	}
 	error = platform_suspend_prepare_late(state);
@@ -326,7 +328,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 
 	error = dpm_suspend_noirq(PMSG_SUSPEND);
 	if (error) {
-		printk(KERN_ERR "PM: noirq suspend of devices failed\n");
+		pr_err("noirq suspend of devices failed\n");
 		goto Platform_early_resume;
 	}
 	error = platform_suspend_prepare_noirq(state);
@@ -413,7 +415,7 @@ int suspend_devices_and_enter(suspend_state_t state)
 	suspend_test_start();
 	error = dpm_suspend_start(PMSG_SUSPEND);
 	if (error) {
-		pr_err("PM: Some devices failed to suspend, or early wake event detected\n");
+		pr_err("Some devices failed to suspend, or early wake event detected\n");
 		goto Recover_platform;
 	}
 	suspend_test_finish("suspend devices");
@@ -470,8 +472,7 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_FREEZE) {
 #ifdef CONFIG_PM_DEBUG
 		if (pm_test_level != TEST_NONE && pm_test_level <= TEST_CPUS) {
-			pr_warning("PM: Unsupported test mode for suspend to idle,"
-				   "please choose none/freezer/devices/platform.\n");
+			pr_warn("Unsupported test mode for suspend to idle, please choose none/freezer/devices/platform\n");
 			return -EAGAIN;
 		}
 #endif
@@ -485,12 +486,12 @@ static int enter_state(suspend_state_t state)
 		freeze_begin();
 
 	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-	printk(KERN_INFO "PM: Syncing filesystems...\n");
+	pr_info("Syncing filesystems...\n");
 	sys_sync();
-	printk(KERN_INFO "PM: Syncing filesystems: done\n");
+	pr_info("Syncing filesystems: done\n");
 	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
 
-	pr_debug("PM: Preparing system for sleep (%s)\n", pm_states[state]);
+	pr_debug("Preparing system for sleep (%s)\n", pm_states[state]);
 	error = suspend_prepare(state);
 	if (error)
 		goto Unlock;
@@ -499,13 +500,13 @@ static int enter_state(suspend_state_t state)
 		goto Finish;
 
 	trace_suspend_resume(TPS("suspend_enter"), state, false);
-	pr_debug("PM: Suspending system (%s)\n", pm_states[state]);
+	pr_debug("Suspending system (%s)\n", pm_states[state]);
 	pm_restrict_gfp_mask();
 	error = suspend_devices_and_enter(state);
 	pm_restore_gfp_mask();
 
  Finish:
-	pr_debug("PM: Finishing wakeup.\n");
+	pr_debug("Finishing wakeup\n");
 	suspend_finish();
  Unlock:
 	mutex_unlock(&pm_mutex);
diff --git a/kernel/power/suspend_test.c b/kernel/power/suspend_test.c
index 084452e..a59a68d 100644
--- a/kernel/power/suspend_test.c
+++ b/kernel/power/suspend_test.c
@@ -6,6 +6,8 @@
  * This file is released under the GPLv2.
  */
 
+#define pr_fmt(fmt) "PM: " fmt
+
 #include <linux/init.h>
 #include <linux/rtc.h>
 
@@ -40,8 +42,8 @@ void suspend_test_finish(const char *label)
 	unsigned msec;
 
 	msec = jiffies_to_msecs(abs(nj));
-	pr_info("PM: %s took %d.%03d seconds\n", label,
-			msec / 1000, msec % 1000);
+	pr_info("%s took %d.%03d seconds\n",
+		label, msec / 1000, msec % 1000);
 
 	/* Warning on suspend means the RTC alarm period needs to be
 	 * larger -- the system was sooo slooowwww to suspend that the
@@ -62,15 +64,6 @@ void suspend_test_finish(const char *label)
 
 static void __init test_wakealarm(struct rtc_device *rtc, suspend_state_t state)
 {
-	static char err_readtime[] __initdata =
-		KERN_ERR "PM: can't read %s time, err %d\n";
-	static char err_wakealarm [] __initdata =
-		KERN_ERR "PM: can't set %s wakealarm, err %d\n";
-	static char err_suspend[] __initdata =
-		KERN_ERR "PM: suspend test failed, error %d\n";
-	static char info_test[] __initdata =
-		KERN_INFO "PM: test RTC wakeup from '%s' suspend\n";
-
 	unsigned long		now;
 	struct rtc_wkalrm	alm;
 	int			status;
@@ -79,7 +72,8 @@ static void __init test_wakealarm(struct rtc_device *rtc, suspend_state_t state)
 repeat:
 	status = rtc_read_time(rtc, &alm.time);
 	if (status < 0) {
-		printk(err_readtime, dev_name(&rtc->dev), status);
+		pr_err("can't read %s time, err %d\n",
+		       dev_name(&rtc->dev), status);
 		return;
 	}
 	rtc_tm_to_time(&alm.time, &now);
@@ -90,29 +84,33 @@ repeat:
 
 	status = rtc_set_alarm(rtc, &alm);
 	if (status < 0) {
-		printk(err_wakealarm, dev_name(&rtc->dev), status);
+		pr_err("can't set %s wakealarm, err %d\n",
+		       dev_name(&rtc->dev), status);
 		return;
 	}
 
 	if (state == PM_SUSPEND_MEM) {
-		printk(info_test, pm_states[state]);
+		pr_info("test RTC wakeup from '%s' suspend\n",
+			pm_states[state]);
 		status = pm_suspend(state);
 		if (status == -ENODEV)
 			state = PM_SUSPEND_STANDBY;
 	}
 	if (state == PM_SUSPEND_STANDBY) {
-		printk(info_test, pm_states[state]);
+		pr_info("test RTC wakeup from '%s' suspend\n",
+			pm_states[state]);
 		status = pm_suspend(state);
 		if (status < 0)
 			state = PM_SUSPEND_FREEZE;
 	}
 	if (state == PM_SUSPEND_FREEZE) {
-		printk(info_test, pm_states[state]);
+		pr_info("test RTC wakeup from '%s' suspend\n",
+			pm_states[state]);
 		status = pm_suspend(state);
 	}
 
 	if (status < 0)
-		printk(err_suspend, status);
+		pr_err("suspend test failed, error %d\n", status);
 
 	test_repeat_count_current++;
 	if (test_repeat_count_current < test_repeat_count_max)
@@ -145,9 +143,6 @@ static int __init has_wakealarm(struct device *dev, const void *data)
  */
 static const char *test_state_label __initdata;
 
-static char warn_bad_state[] __initdata =
-	KERN_WARNING "PM: can't test '%s' suspend state\n";
-
 static int __init setup_test_suspend(char *value)
 {
 	int i;
@@ -172,16 +167,13 @@ static int __init setup_test_suspend(char *value)
 			return 0;
 		}
 
-	printk(warn_bad_state, suspend_type);
+	pr_warn("can't test '%s' suspend state\n", suspend_type);
 	return 0;
 }
 __setup("test_suspend", setup_test_suspend);
 
 static int __init test_suspend(void)
 {
-	static char		warn_no_rtc[] __initdata =
-		KERN_WARNING "PM: no wakealarm-capable RTC driver is ready\n";
-
 	struct rtc_device	*rtc = NULL;
 	struct device		*dev;
 	suspend_state_t test_state;
@@ -197,7 +189,7 @@ static int __init test_suspend(void)
 			break;
 	}
 	if (test_state == PM_SUSPEND_MAX) {
-		printk(warn_bad_state, test_state_label);
+		pr_warn("can't test '%s' suspend state\n", test_state_label);
 		return 0;
 	}
 
@@ -206,7 +198,7 @@ static int __init test_suspend(void)
 	if (dev)
 		rtc = rtc_class_open(dev_name(dev));
 	if (!rtc) {
-		printk(warn_no_rtc);
+		pr_warn("no wakealarm-capable RTC driver is ready\n");
 		return 0;
 	}
 
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 7aa2635..d63dc6f 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -12,6 +12,8 @@
  *
  */
 
+#define pr_fmt(fmt) "PM: " fmt
+
 #include <linux/module.h>
 #include <linux/file.h>
 #include <linux/delay.h>
@@ -234,10 +236,10 @@ static void hib_end_io(struct bio *bio, int error)
 	struct page *page = bio->bi_io_vec[0].bv_page;
 
 	if (!uptodate || error) {
-		printk(KERN_ALERT "Read-error on swap-device (%u:%u:%Lu)\n",
-				imajor(bio->bi_bdev->bd_inode),
-				iminor(bio->bi_bdev->bd_inode),
-				(unsigned long long)bio->bi_iter.bi_sector);
+		pr_alert("Read-error on swap-device (%u:%u:%llu)\n",
+			 imajor(bio->bi_bdev->bd_inode),
+			 iminor(bio->bi_bdev->bd_inode),
+			 (unsigned long long)bio->bi_iter.bi_sector);
 
 		if (!error)
 			error = -EIO;
@@ -266,8 +268,8 @@ static int hib_submit_io(int rw, pgoff_t page_off, void *addr,
 	bio->bi_bdev = hib_resume_bdev;
 
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
-		printk(KERN_ERR "PM: Adding page to bio failed at %llu\n",
-			(unsigned long long)bio->bi_iter.bi_sector);
+		pr_err("Adding page to bio failed at %llu\n",
+		       (unsigned long long)bio->bi_iter.bi_sector);
 		bio_put(bio);
 		return -EFAULT;
 	}
@@ -311,7 +313,7 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
 		error = hib_submit_io(WRITE_SYNC, swsusp_resume_block,
 					swsusp_header, NULL);
 	} else {
-		printk(KERN_ERR "PM: Swap header not found!\n");
+		pr_err("Swap header not found!\n");
 		error = -ENODEV;
 	}
 	return error;
@@ -399,8 +401,7 @@ static int get_swap_writer(struct swap_map_handle *handle)
 	ret = swsusp_swap_check();
 	if (ret) {
 		if (ret != -ENOSPC)
-			printk(KERN_ERR "PM: Cannot find swap device, try "
-					"swapon -a.\n");
+			pr_err("Cannot find swap device, try 'swapon -a'\n");
 		return ret;
 	}
 	handle->cur = (struct swap_map_page *)get_zeroed_page(GFP_KERNEL);
@@ -477,9 +478,9 @@ static int swap_writer_finish(struct swap_map_handle *handle,
 {
 	if (!error) {
 		flush_swap_writer(handle);
-		printk(KERN_INFO "PM: S");
+		pr_info("S");
 		error = mark_swapfiles(handle, flags);
-		printk("|\n");
+		pr_cont("|\n");
 	}
 
 	if (error)
@@ -528,8 +529,7 @@ static int save_image(struct swap_map_handle *handle,
 
 	hib_init_batch(&hb);
 
-	printk(KERN_INFO "PM: Saving image data pages (%u pages)...\n",
-		nr_to_write);
+	pr_info("Saving image data pages (%u pages)...\n", nr_to_write);
 	m = nr_to_write / 10;
 	if (!m)
 		m = 1;
@@ -543,8 +543,8 @@ static int save_image(struct swap_map_handle *handle,
 		if (ret)
 			break;
 		if (!(nr_pages % m))
-			printk(KERN_INFO "PM: Image saving progress: %3d%%\n",
-			       nr_pages / m * 10);
+			pr_info("Image saving progress: %3d%%\n",
+				nr_pages / m * 10);
 		nr_pages++;
 	}
 	err2 = hib_wait_io(&hb);
@@ -552,7 +552,7 @@ static int save_image(struct swap_map_handle *handle,
 	if (!ret)
 		ret = err2;
 	if (!ret)
-		printk(KERN_INFO "PM: Image saving: done\n");
+		pr_info("Image saving: done\n");
 	swsusp_show_speed(start, stop, nr_to_write, "Wrote");
 	return ret;
 }
@@ -678,14 +678,14 @@ static int save_image_lzo(struct swap_map_handle *handle,
 
 	page = (void *)__get_free_page(__GFP_WAIT | __GFP_HIGH);
 	if (!page) {
-		printk(KERN_ERR "PM: Failed to allocate LZO page\n");
+		pr_err("Failed to allocate LZO page\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
 
 	data = vmalloc(sizeof(*data) * nr_threads);
 	if (!data) {
-		printk(KERN_ERR "PM: Failed to allocate LZO data\n");
+		pr_err("Failed to allocate LZO data\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
@@ -694,7 +694,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 
 	crc = kmalloc(sizeof(*crc), GFP_KERNEL);
 	if (!crc) {
-		printk(KERN_ERR "PM: Failed to allocate crc\n");
+		pr_err("Failed to allocate crc\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
@@ -712,8 +712,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 		                            "image_compress/%u", thr);
 		if (IS_ERR(data[thr].thr)) {
 			data[thr].thr = NULL;
-			printk(KERN_ERR
-			       "PM: Cannot start compression threads\n");
+			pr_err("Cannot start compression threads\n");
 			ret = -ENOMEM;
 			goto out_clean;
 		}
@@ -735,7 +734,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 	crc->thr = kthread_run(crc32_threadfn, crc, "image_crc32");
 	if (IS_ERR(crc->thr)) {
 		crc->thr = NULL;
-		printk(KERN_ERR "PM: Cannot start CRC32 thread\n");
+		pr_err("Cannot start CRC32 thread\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
@@ -746,10 +745,9 @@ static int save_image_lzo(struct swap_map_handle *handle,
 	 */
 	handle->reqd_free_pages = reqd_free_pages();
 
-	printk(KERN_INFO
-		"PM: Using %u thread(s) for compression.\n"
-		"PM: Compressing and saving image data (%u pages)...\n",
-		nr_threads, nr_to_write);
+	pr_info("Using %u thread(s) for compression\n", nr_threads);
+	pr_info("Compressing and saving image data (%u pages)...\n",
+		nr_to_write);
 	m = nr_to_write / 10;
 	if (!m)
 		m = 1;
@@ -769,10 +767,8 @@ static int save_image_lzo(struct swap_map_handle *handle,
 				       data_of(*snapshot), PAGE_SIZE);
 
 				if (!(nr_pages % m))
-					printk(KERN_INFO
-					       "PM: Image saving progress: "
-					       "%3d%%\n",
-				               nr_pages / m * 10);
+					pr_info("Image saving progress: %3d%%\n",
+						nr_pages / m * 10);
 				nr_pages++;
 			}
 			if (!off)
@@ -799,15 +795,14 @@ static int save_image_lzo(struct swap_map_handle *handle,
 			ret = data[thr].ret;
 
 			if (ret < 0) {
-				printk(KERN_ERR "PM: LZO compression failed\n");
+				pr_err("LZO compression failed\n");
 				goto out_finish;
 			}
 
 			if (unlikely(!data[thr].cmp_len ||
 			             data[thr].cmp_len >
 			             lzo1x_worst_compress(data[thr].unc_len))) {
-				printk(KERN_ERR
-				       "PM: Invalid LZO compressed length\n");
+				pr_err("Invalid LZO compressed length\n");
 				ret = -1;
 				goto out_finish;
 			}
@@ -843,7 +838,7 @@ out_finish:
 	if (!ret)
 		ret = err2;
 	if (!ret)
-		printk(KERN_INFO "PM: Image saving: done\n");
+		pr_info("Image saving: done\n");
 	swsusp_show_speed(start, stop, nr_to_write, "Wrote");
 out_clean:
 	if (crc) {
@@ -874,7 +869,7 @@ static int enough_swap(unsigned int nr_pages, unsigned int flags)
 	unsigned int free_swap = count_swap_pages(root_swap, 1);
 	unsigned int required;
 
-	pr_debug("PM: Free swap pages: %u\n", free_swap);
+	pr_debug("Free swap pages: %u\n", free_swap);
 
 	required = PAGES_FOR_IO + nr_pages;
 	return free_swap > required;
@@ -901,12 +896,12 @@ int swsusp_write(unsigned int flags)
 	pages = snapshot_get_image_size();
 	error = get_swap_writer(&handle);
 	if (error) {
-		printk(KERN_ERR "PM: Cannot get swap writer\n");
+		pr_err("Cannot get swap writer\n");
 		return error;
 	}
 	if (flags & SF_NOCOMPRESS_MODE) {
 		if (!enough_swap(pages, flags)) {
-			printk(KERN_ERR "PM: Not enough free swap\n");
+			pr_err("Not enough free swap\n");
 			error = -ENOSPC;
 			goto out_finish;
 		}
@@ -1053,8 +1048,7 @@ static int load_image(struct swap_map_handle *handle,
 
 	hib_init_batch(&hb);
 
-	printk(KERN_INFO "PM: Loading image data pages (%u pages)...\n",
-		nr_to_read);
+	pr_info("Loading image data pages (%u pages)...\n", nr_to_read);
 	m = nr_to_read / 10;
 	if (!m)
 		m = 1;
@@ -1072,8 +1066,8 @@ static int load_image(struct swap_map_handle *handle,
 		if (ret)
 			break;
 		if (!(nr_pages % m))
-			printk(KERN_INFO "PM: Image loading progress: %3d%%\n",
-			       nr_pages / m * 10);
+			pr_info("Image loading progress: %3d%%\n",
+				nr_pages / m * 10);
 		nr_pages++;
 	}
 	err2 = hib_wait_io(&hb);
@@ -1081,7 +1075,7 @@ static int load_image(struct swap_map_handle *handle,
 	if (!ret)
 		ret = err2;
 	if (!ret) {
-		printk(KERN_INFO "PM: Image loading: done\n");
+		pr_info("Image loading: done\n");
 		snapshot_write_finalize(snapshot);
 		if (!snapshot_image_loaded(snapshot))
 			ret = -ENODATA;
@@ -1171,14 +1165,14 @@ static int load_image_lzo(struct swap_map_handle *handle,
 
 	page = vmalloc(sizeof(*page) * LZO_MAX_RD_PAGES);
 	if (!page) {
-		printk(KERN_ERR "PM: Failed to allocate LZO page\n");
+		pr_err("Failed to allocate LZO page\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
 
 	data = vmalloc(sizeof(*data) * nr_threads);
 	if (!data) {
-		printk(KERN_ERR "PM: Failed to allocate LZO data\n");
+		pr_err("Failed to allocate LZO data\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
@@ -1187,7 +1181,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 
 	crc = kmalloc(sizeof(*crc), GFP_KERNEL);
 	if (!crc) {
-		printk(KERN_ERR "PM: Failed to allocate crc\n");
+		pr_err("Failed to allocate crc\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
@@ -1205,8 +1199,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 		                            "image_decompress/%u", thr);
 		if (IS_ERR(data[thr].thr)) {
 			data[thr].thr = NULL;
-			printk(KERN_ERR
-			       "PM: Cannot start decompression threads\n");
+			pr_err("Cannot start decompression threads\n");
 			ret = -ENOMEM;
 			goto out_clean;
 		}
@@ -1228,7 +1221,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	crc->thr = kthread_run(crc32_threadfn, crc, "image_crc32");
 	if (IS_ERR(crc->thr)) {
 		crc->thr = NULL;
-		printk(KERN_ERR "PM: Cannot start CRC32 thread\n");
+		pr_err("Cannot start CRC32 thread\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
@@ -1253,8 +1246,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 		if (!page[i]) {
 			if (i < LZO_CMP_PAGES) {
 				ring_size = i;
-				printk(KERN_ERR
-				       "PM: Failed to allocate LZO pages\n");
+				pr_err("Failed to allocate LZO pages\n");
 				ret = -ENOMEM;
 				goto out_clean;
 			} else {
@@ -1264,10 +1256,9 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	}
 	want = ring_size = i;
 
-	printk(KERN_INFO
-		"PM: Using %u thread(s) for decompression.\n"
-		"PM: Loading and decompressing image data (%u pages)...\n",
-		nr_threads, nr_to_read);
+	pr_info("Using %u thread(s) for decompression\n", nr_threads);
+	pr_info("Loading and decompressing image data (%u pages)...\n",
+		nr_to_read);
 	m = nr_to_read / 10;
 	if (!m)
 		m = 1;
@@ -1327,8 +1318,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 			if (unlikely(!data[thr].cmp_len ||
 			             data[thr].cmp_len >
 			             lzo1x_worst_compress(LZO_UNC_SIZE))) {
-				printk(KERN_ERR
-				       "PM: Invalid LZO compressed length\n");
+				pr_err("Invalid LZO compressed length\n");
 				ret = -1;
 				goto out_finish;
 			}
@@ -1379,16 +1369,14 @@ static int load_image_lzo(struct swap_map_handle *handle,
 			ret = data[thr].ret;
 
 			if (ret < 0) {
-				printk(KERN_ERR
-				       "PM: LZO decompression failed\n");
+				pr_err("LZO decompression failed\n");
 				goto out_finish;
 			}
 
 			if (unlikely(!data[thr].unc_len ||
 			             data[thr].unc_len > LZO_UNC_SIZE ||
 			             data[thr].unc_len & (PAGE_SIZE - 1))) {
-				printk(KERN_ERR
-				       "PM: Invalid LZO uncompressed length\n");
+				pr_err("Invalid LZO uncompressed length\n");
 				ret = -1;
 				goto out_finish;
 			}
@@ -1399,10 +1387,8 @@ static int load_image_lzo(struct swap_map_handle *handle,
 				       data[thr].unc + off, PAGE_SIZE);
 
 				if (!(nr_pages % m))
-					printk(KERN_INFO
-					       "PM: Image loading progress: "
-					       "%3d%%\n",
-					       nr_pages / m * 10);
+					pr_info("Image loading progress: %3d%%\n",
+						nr_pages / m * 10);
 				nr_pages++;
 
 				ret = snapshot_write_next(snapshot);
@@ -1427,15 +1413,14 @@ out_finish:
 	}
 	stop = ktime_get();
 	if (!ret) {
-		printk(KERN_INFO "PM: Image loading done.\n");
+		pr_info("Image loading done\n");
 		snapshot_write_finalize(snapshot);
 		if (!snapshot_image_loaded(snapshot))
 			ret = -ENODATA;
 		if (!ret) {
 			if (swsusp_header->flags & SF_CRC32_MODE) {
 				if(handle->crc32 != swsusp_header->crc32) {
-					printk(KERN_ERR
-					       "PM: Invalid image CRC32!\n");
+					pr_err("Invalid image CRC32!\n");
 					ret = -ENODATA;
 				}
 			}
@@ -1492,9 +1477,9 @@ int swsusp_read(unsigned int *flags_p)
 	swap_reader_finish(&handle);
 end:
 	if (!error)
-		pr_debug("PM: Image successfully loaded\n");
+		pr_debug("Image successfully loaded\n");
 	else
-		pr_debug("PM: Error %d resuming\n", error);
+		pr_debug("Error %d resuming\n", error);
 	return error;
 }
 
@@ -1529,13 +1514,13 @@ put:
 		if (error)
 			blkdev_put(hib_resume_bdev, FMODE_READ);
 		else
-			pr_debug("PM: Image signature found, resuming\n");
+			pr_debug("Image signature found, resuming\n");
 	} else {
 		error = PTR_ERR(hib_resume_bdev);
 	}
 
 	if (error)
-		pr_debug("PM: Image not found (code %d)\n", error);
+		pr_debug("Image not found (code %d)\n", error);
 
 	return error;
 }
@@ -1547,7 +1532,7 @@ put:
 void swsusp_close(fmode_t mode)
 {
 	if (IS_ERR(hib_resume_bdev)) {
-		pr_debug("PM: Image device not initialised\n");
+		pr_debug("Image device not initialised\n");
 		return;
 	}
 
@@ -1569,7 +1554,7 @@ int swsusp_unmark(void)
 		error = hib_submit_io(WRITE_SYNC, swsusp_resume_block,
 					swsusp_header, NULL);
 	} else {
-		printk(KERN_ERR "PM: Cannot find swsusp signature!\n");
+		pr_err("Cannot find swsusp signature!\n");
 		error = -ENODEV;
 	}
 
diff --git a/kernel/power/user.c b/kernel/power/user.c
index e22f6ad..07dba67 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -9,6 +9,8 @@
  *
  */
 
+#define pr_fmt(fmt) "PM: " fmt
+
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <linux/reboot.h>
@@ -221,9 +223,9 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		if (data->frozen)
 			break;
 
-		printk("Syncing filesystems ...\n");
+		pr_info("Syncing filesystems...\n");
 		sys_sync();
-		printk("Syncing filesystems: done\n");
+		pr_info("Syncing filesystems: done\n");
 
 		error = freeze_processes();
 		if (error)
-- 
2.1.2

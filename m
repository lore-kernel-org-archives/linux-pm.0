From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][v6] PM / hibernate: Introduce test_resume mode for hibernation
Date: Fri, 22 Jul 2016 10:30:47 +0800
Message-ID: <1469154647-5860-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1119 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbcGVCXG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Jul 2016 22:23:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Linux Kernel Mail List <linux-kernel@vger.kernel.org>, Chen Yu <yu.c.chen@intel.com>

test_resume mode is to verify if the snapshot data
written to swap device can be successfully restored
to memory. It is useful to ease the debugging process
on hibernation, since this mode can not only bypass
the BIOSes/bootloader, but also the system re-initialization.

To avoid the risk to break the filesystm on persistent storage,
this patch resumes the image with tasks frozen.

For example:
echo test_resume > /sys/power/disk
echo disk > /sys/power/state

[  187.306470] PM: Image saving progress:  70%
[  187.395298] PM: Image saving progress:  80%
[  187.476697] PM: Image saving progress:  90%
[  187.554641] PM: Image saving done.
[  187.558896] PM: Wrote 594600 kbytes in 0.90 seconds (660.66 MB/s)
[  187.566000] PM: S|
[  187.589742] PM: Basic memory bitmaps freed
[  187.594694] PM: Checking hibernation image
[  187.599865] PM: Image signature found, resuming
[  187.605209] PM: Loading hibernation image.
[  187.665753] PM: Basic memory bitmaps created
[  187.691397] PM: Using 3 thread(s) for decompression.
[  187.691397] PM: Loading and decompressing image data (148650 pages)...
[  187.889719] PM: Image loading progress:   0%
[  188.100452] PM: Image loading progress:  10%
[  188.244781] PM: Image loading progress:  20%
[  189.057305] PM: Image loading done.
[  189.068793] PM: Image successfully loaded

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>

---
v6:
 - If swsusp_write() returns an error, snapshot_test shouldn't be set.
v5:
 - Introduce a new function to be shared with software_resume().
v4:
 - Fix some errors and modify the comment for software_resume_unthaw.
v3:
 - As Pavel mentioned, there was a potential risk in previous
   version that might break the filesystem. According to Rafael's suggestion,
   this version avoids that issue by restoring the pages with user/kernel
   threads kept in frozen. Also updated the patch on top of linux-next.
---
 kernel/power/hibernate.c | 65 ++++++++++++++++++++++++++++++++----------------
 kernel/power/swap.c      |  6 +++++
 2 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 5f3523e..0ee1df0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -52,6 +52,7 @@ enum {
 #ifdef CONFIG_SUSPEND
 	HIBERNATION_SUSPEND,
 #endif
+	HIBERNATION_TEST_RESUME,
 	/* keep last */
 	__HIBERNATION_AFTER_LAST
 };
@@ -647,12 +648,39 @@ static void power_down(void)
 		cpu_relax();
 }
 
+static int load_image_and_restore(void)
+{
+	int error;
+	unsigned int flags;
+
+	pr_debug("PM: Loading hibernation image.\n");
+
+	lock_device_hotplug();
+	error = create_basic_memory_bitmaps();
+	if (error)
+		goto Unlock;
+
+	error = swsusp_read(&flags);
+	swsusp_close(FMODE_READ);
+	if (!error)
+		hibernation_restore(flags & SF_PLATFORM_MODE);
+
+	printk(KERN_ERR "PM: Failed to load hibernation image, recovering.\n");
+	swsusp_free();
+	free_basic_memory_bitmaps();
+ Unlock:
+	unlock_device_hotplug();
+
+	return error;
+}
+
 /**
  * hibernate - Carry out system hibernation, including saving the image.
  */
 int hibernate(void)
 {
 	int error, nr_calls = 0;
+	bool snapshot_test = false;
 
 	if (!hibernation_available()) {
 		pr_debug("PM: Hibernation not available.\n");
@@ -704,8 +732,12 @@ int hibernate(void)
 		pr_debug("PM: writing image.\n");
 		error = swsusp_write(flags);
 		swsusp_free();
-		if (!error)
-			power_down();
+		if (!error) {
+			if (hibernation_mode == HIBERNATION_TEST_RESUME)
+				snapshot_test = true;
+			else
+				power_down();
+		}
 		in_suspend = 0;
 		pm_restore_gfp_mask();
 	} else {
@@ -716,6 +748,12 @@ int hibernate(void)
 	free_basic_memory_bitmaps();
  Thaw:
 	unlock_device_hotplug();
+	if (snapshot_test) {
+		pr_debug("PM: Checking hibernation image\n");
+		error = swsusp_check();
+		if (!error)
+			error = load_image_and_restore();
+	}
 	thaw_processes();
 
 	/* Don't bother checking whether freezer_test_done is true */
@@ -748,7 +786,6 @@ int hibernate(void)
 static int software_resume(void)
 {
 	int error, nr_calls = 0;
-	unsigned int flags;
 
 	/*
 	 * If the user said "noresume".. bail out early.
@@ -844,24 +881,7 @@ static int software_resume(void)
 	error = freeze_processes();
 	if (error)
 		goto Close_Finish;
-
-	pr_debug("PM: Loading hibernation image.\n");
-
-	lock_device_hotplug();
-	error = create_basic_memory_bitmaps();
-	if (error)
-		goto Thaw;
-
-	error = swsusp_read(&flags);
-	swsusp_close(FMODE_READ);
-	if (!error)
-		hibernation_restore(flags & SF_PLATFORM_MODE);
-
-	printk(KERN_ERR "PM: Failed to load hibernation image, recovering.\n");
-	swsusp_free();
-	free_basic_memory_bitmaps();
- Thaw:
-	unlock_device_hotplug();
+	error = load_image_and_restore();
 	thaw_processes();
  Finish:
 	__pm_notifier_call_chain(PM_POST_RESTORE, nr_calls, NULL);
@@ -887,6 +907,7 @@ static const char * const hibernation_modes[] = {
 #ifdef CONFIG_SUSPEND
 	[HIBERNATION_SUSPEND]	= "suspend",
 #endif
+	[HIBERNATION_TEST_RESUME]	= "test_resume",
 };
 
 /*
@@ -933,6 +954,7 @@ static ssize_t disk_show(struct kobject *kobj, struct kobj_attribute *attr,
 #ifdef CONFIG_SUSPEND
 		case HIBERNATION_SUSPEND:
 #endif
+		case HIBERNATION_TEST_RESUME:
 			break;
 		case HIBERNATION_PLATFORM:
 			if (hibernation_ops)
@@ -979,6 +1001,7 @@ static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
 #ifdef CONFIG_SUSPEND
 		case HIBERNATION_SUSPEND:
 #endif
+		case HIBERNATION_TEST_RESUME:
 			hibernation_mode = mode;
 			break;
 		case HIBERNATION_PLATFORM:
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 160e100..51cef84 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -348,6 +348,12 @@ static int swsusp_swap_check(void)
 	if (res < 0)
 		blkdev_put(hib_resume_bdev, FMODE_WRITE);
 
+	/*
+	 * Update the resume device to the one actually used,
+	 * so the test_resume mode can use it in case it is
+	 * invoked from hibernate() to test the snapshot.
+	 */
+	swsusp_resume_device = hib_resume_bdev->bd_dev;
 	return res;
 }
 
-- 
2.7.4


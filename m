From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2][RFC v4] PM / hibernate: Introduce snapshot test mode for hibernation
Date: Thu, 14 Jul 2016 21:15:46 +0800
Message-ID: <8f23b8935c5cbb807191f2aff7da3d4ec9a86fa5.1468500857.git.yu.c.chen@intel.com>
References: <cover.1468500857.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1468500857.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

snapshot test mode is used to verify if the snapshot data
written to the swap device can be successfully restored to
the memory. It is useful to ease the debugging process on
hibernation, since this mode can not only bypass the
BIOSes/bootloader, but also the system re-initialization.

For example:

echo snapshot > /sys/power/pm_test
echo disk > /sys/power/state

[  267.959784] PM: Image saving progress:  80%
[  268.038669] PM: Image saving progress:  90%
[  268.111745] PM: Image saving progress: 100%
[  268.129269] PM: Image saving done.
[  268.133485] PM: Wrote 518612 kbytes in 0.75 seconds (691.48 MB/s)
[  268.140564] PM: S|
[  268.160067] hibernation debug: Waiting for 5 seconds.
...
[  273.508638] PM: Looking for hibernation image.
[  273.516583] PM: Image signature found, resuming
[  273.926547] PM: Loading and decompressing image data (129653 pages)...
[  274.122452] PM: Image loading progress:   0%
[  274.322127] PM: Image loading progress:  10%
...

Comments and suggestions would be appreciated.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v4:
 - Fix some errors and modify the comment for software_resume_unthaw.
v3:
 - As Pavel mentioned, there was a potential risk in previous
   version that might break the filesystem. According to Rafael's suggestion,
   this version avoids that issue by restoring the pages with user/kernel
   threads kept in frozen. Also updated the document.
---
 kernel/power/hibernate.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/power/main.c      |  3 +++
 kernel/power/power.h     |  3 +++
 kernel/power/suspend.c   |  8 +++++++
 kernel/power/swap.c      |  7 +++++++
 5 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 51441d8..57864fc 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -643,11 +643,59 @@ static void power_down(void)
 }
 
 /**
+ * software_resume_unthaw - Resume from a saved hibernation image with threads frozen.
+ *
+ * This routine is similar to software_resume, except that this one tries
+ * to resume from hibernation with user/kernel threads frozen. And it is mainly
+ * used for snapshot test mode because it is important to keep the threads frozen,
+ * otherwise the filesystem might be broken due to inconsistent disk-data/metadata
+ * across hibernation.
+ *
+ * software_resume_unthaw() does not invoke PM_RESTORE_PREPARE related callbacks,
+ * since it is unclear whether it is safe to 'jump' from PM_HIBERNATION_PREPARE
+ * to PM_RESTORE_PREPARE directly, and bypass this message should not impact much.
+ */
+static int software_resume_unthaw(void)
+{
+	int error;
+	unsigned int flags;
+
+	pr_debug("PM: Hibernation image partition %d:%d present\n",
+		MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
+
+	pr_debug("PM: Looking for hibernation image.\n");
+	error = swsusp_check();
+	if (error)
+		return error;
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
+/**
  * hibernate - Carry out system hibernation, including saving the image.
  */
 int hibernate(void)
 {
 	int error, nr_calls = 0;
+	bool snapshot_test = false;
 
 	if (!hibernation_available()) {
 		pr_debug("PM: Hibernation not available.\n");
@@ -699,7 +747,9 @@ int hibernate(void)
 		pr_debug("PM: writing image.\n");
 		error = swsusp_write(flags);
 		swsusp_free();
-		if (!error)
+		if (hibernation_test(TEST_SNAPSHOT))
+			snapshot_test = true;
+		if (!error && !snapshot_test)
 			power_down();
 		in_suspend = 0;
 		pm_restore_gfp_mask();
@@ -711,6 +761,8 @@ int hibernate(void)
 	free_basic_memory_bitmaps();
  Thaw:
 	unlock_device_hotplug();
+	if (snapshot_test)
+		software_resume_unthaw();
 	thaw_processes();
 
 	/* Don't bother checking whether freezer_test_done is true */
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 5ea50b1..80fe48e 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -83,6 +83,9 @@ int pm_test_level = TEST_NONE;
 
 static const char * const pm_tests[__TEST_AFTER_LAST] = {
 	[TEST_NONE] = "none",
+#ifdef CONFIG_HIBERNATION
+	[TEST_SNAPSHOT] = "snapshot",
+#endif
 	[TEST_CORE] = "core",
 	[TEST_CPUS] = "processors",
 	[TEST_PLATFORM] = "platform",
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 064963e..101d636 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -225,6 +225,9 @@ static inline int restore_highmem(void) { return 0; }
 enum {
 	/* keep first */
 	TEST_NONE,
+#ifdef CONFIG_HIBERNATION
+	TEST_SNAPSHOT,
+#endif
 	TEST_CORE,
 	TEST_CPUS,
 	TEST_PLATFORM,
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0acab9d..0afa875 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -479,6 +479,14 @@ static int enter_state(suspend_state_t state)
 			return -EAGAIN;
 		}
 #endif
+	} else if (state == PM_SUSPEND_MEM) {
+#ifdef CONFIG_PM_DEBUG
+		if (pm_test_level != TEST_NONE && pm_test_level < TEST_CORE) {
+			pr_warn("PM: Unsupported test mode for suspend to ram, please choose"
+				" none/freezer/devices/platform/processors/core.\n");
+			return -EAGAIN;
+		}
+#endif
 	} else if (!valid_state(state)) {
 		return -EINVAL;
 	}
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 160e100..facd71b 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -348,6 +348,13 @@ static int swsusp_swap_check(void)
 	if (res < 0)
 		blkdev_put(hib_resume_bdev, FMODE_WRITE);
 
+	/*
+	 * Update the resume device to the one actually used,
+	 * so software_resume() can use it in case it is invoked
+	 * from hibernate() to test the snapshot.
+	 */
+	swsusp_resume_device = hib_resume_bdev->bd_dev;
+
 	return res;
 }
 
-- 
2.7.4

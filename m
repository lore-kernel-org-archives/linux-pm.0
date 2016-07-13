From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC v2] PM / hibernate: Introduce snapshot test mode for hibernation
Date: Wed, 13 Jul 2016 14:08:36 +0800
Message-ID: <1468390116-957-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

This mode is used to verify if the snapshot data written to
the swap device can be successfully restored to the memory. It
is useful to ease the debugging process on hibernation,
since this mode can not only bypass the BIOSen/bootloader,
but also the system re-initialization.

For example:
$ sudo echo snapshot > /sys/power/pm_test
$ sudo echo disk > /sys/power/state

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

Rebased on top of linux-next.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/power/hibernate.c | 10 ++++++++--
 kernel/power/main.c      |  3 +++
 kernel/power/power.h     |  3 +++
 kernel/power/swap.c      |  7 +++++++
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 51441d8..30cc5b4 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -43,6 +43,7 @@ static char resume_file[256] = CONFIG_PM_STD_PARTITION;
 dev_t swsusp_resume_device;
 sector_t swsusp_resume_block;
 __visible int in_suspend __nosavedata;
+static int software_resume(void);
 
 enum {
 	HIBERNATION_INVALID,
@@ -647,7 +648,7 @@ static void power_down(void)
  */
 int hibernate(void)
 {
-	int error, nr_calls = 0;
+	int error, nr_calls = 0, snapshot_test = 0;
 
 	if (!hibernation_available()) {
 		pr_debug("PM: Hibernation not available.\n");
@@ -699,7 +700,9 @@ int hibernate(void)
 		pr_debug("PM: writing image.\n");
 		error = swsusp_write(flags);
 		swsusp_free();
-		if (!error)
+		if (hibernation_test(TEST_SNAPSHOT))
+			snapshot_test = 1;
+		if (!error && !snapshot_test)
 			power_down();
 		in_suspend = 0;
 		pm_restore_gfp_mask();
@@ -721,6 +724,9 @@ int hibernate(void)
 	atomic_inc(&snapshot_device_available);
  Unlock:
 	unlock_system_sleep();
+	if (snapshot_test)
+		software_resume();
+
 	return error;
 }
 
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

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] PM / sleep: Enhance test_suspend option with repeat capability
Date: Tue,  2 Sep 2014 11:54:40 -0700
Message-ID: <1409684081-9659-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1409684081-9659-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59716 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125AbaIBSyd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Sep 2014 14:54:33 -0400
In-Reply-To: <1409684081-9659-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Enhanced test_suspend boot paramter to repeat tests multiple times,
by adding optional repeat count. The new boot param syntax:
test_suspend="mem|freeze|standby[,N]"

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 kernel/power/suspend_test.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/power/suspend_test.c b/kernel/power/suspend_test.c
index ede39c8..7939fa7 100644
--- a/kernel/power/suspend_test.c
+++ b/kernel/power/suspend_test.c
@@ -22,6 +22,8 @@
 #define TEST_SUSPEND_SECONDS	10
 
 static unsigned long suspend_test_start_time;
+static u32 test_repeat_count_max = 1;
+static u32 test_repeat_count_current;
 
 void suspend_test_start(void)
 {
@@ -74,6 +76,7 @@ static void __init test_wakealarm(struct rtc_device *rtc, suspend_state_t state)
 	int			status;
 
 	/* this may fail if the RTC hasn't been initialized */
+repeat:
 	status = rtc_read_time(rtc, &alm.time);
 	if (status < 0) {
 		printk(err_readtime, dev_name(&rtc->dev), status);
@@ -111,6 +114,10 @@ static void __init test_wakealarm(struct rtc_device *rtc, suspend_state_t state)
 	if (status < 0)
 		printk(err_suspend, status);
 
+	test_repeat_count_current++;
+	if (test_repeat_count_current < test_repeat_count_max)
+		goto repeat;
+
 	/* Some platforms can't detect that the alarm triggered the
 	 * wakeup, or (accordingly) disable it after it afterwards.
 	 * It's supposed to give oneshot behavior; cope.
@@ -144,16 +151,28 @@ static char warn_bad_state[] __initdata =
 static int __init setup_test_suspend(char *value)
 {
 	int i;
+	char *repeat;
+	char *suspend_type;
 
-	/* "=mem" ==> "mem" */
+	/* example : "=mem[,N]" ==> "mem[,N]" */
 	value++;
+	suspend_type = strsep(&value, ",");
+	if (!suspend_type)
+		return 0;
+
+	repeat = strsep(&value, ",");
+	if (repeat) {
+		if (kstrtou32(repeat, 0, &test_repeat_count_max))
+			return 0;
+	}
+
 	for (i = 0; pm_labels[i]; i++)
-		if (!strcmp(pm_labels[i], value)) {
+		if (!strcmp(pm_labels[i], suspend_type)) {
 			test_state_label = pm_labels[i];
 			return 0;
 		}
 
-	printk(warn_bad_state, value);
+	printk(warn_bad_state, suspend_type);
 	return 0;
 }
 __setup("test_suspend", setup_test_suspend);
-- 
1.9.1


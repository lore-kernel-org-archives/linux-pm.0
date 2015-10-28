From: Saurabh Sengar <saurabh.truth@gmail.com>
Subject: [PATCH v3] PM / suspend: replacing printk
Date: Wed, 28 Oct 2015 08:54:01 +0530
Message-ID: <1446002641-3052-1-git-send-email-saurabh.truth@gmail.com>
References: <saurabh.truth@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36411 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbJ1DYL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 23:24:11 -0400
In-Reply-To: <saurabh.truth@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Saurabh Sengar <saurabh.truth@gmail.com>

replacing printk(s) with appropriate pr_info and pr_err
in order to fix checkpatch.pl warnings

Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
---
 kernel/power/suspend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 7e4cda4..7fec885 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -245,7 +245,7 @@ static int suspend_test(int level)
 {
 #ifdef CONFIG_PM_DEBUG
 	if (pm_test_level == level) {
-		printk(KERN_INFO "suspend debug: Waiting for %d second(s).\n",
+		pr_info("suspend debug: Waiting for %d second(s).\n",
 				pm_test_delay);
 		mdelay(pm_test_delay * 1000);
 		return 1;
@@ -317,7 +317,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 
 	error = dpm_suspend_late(PMSG_SUSPEND);
 	if (error) {
-		printk(KERN_ERR "PM: late suspend of devices failed\n");
+		pr_err("PM: late suspend of devices failed\n");
 		goto Platform_finish;
 	}
 	error = platform_suspend_prepare_late(state);
@@ -326,7 +326,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 
 	error = dpm_suspend_noirq(PMSG_SUSPEND);
 	if (error) {
-		printk(KERN_ERR "PM: noirq suspend of devices failed\n");
+		pr_err("PM: noirq suspend of devices failed\n");
 		goto Platform_early_resume;
 	}
 	error = platform_suspend_prepare_noirq(state);
-- 
1.9.1


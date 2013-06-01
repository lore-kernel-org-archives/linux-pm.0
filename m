From: Bernie Thompson <bhthompson@chromium.org>
Subject: [PATCH] PM / wakeup: Adjust messaging for wake events during suspend
Date: Fri, 31 May 2013 17:47:43 -0700
Message-ID: <1370047663-432-1-git-send-email-bhthompson@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ye0-f202.google.com ([209.85.213.202]:61099 "EHLO
	mail-ye0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098Ab3FAAxr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2013 20:53:47 -0400
Received: by mail-ye0-f202.google.com with SMTP id r11so79831yen.5
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2013 17:53:47 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bernie Thompson <bhthompson@chromium.org>

This adds in a new message to the wakeup code which adds an indication to
the log that suspend was cancelled due to a wake event occouring during
the suspend sequence. It also adjusts the message printed in suspend.c to
reflect the potential that a suspend was aborted, as opposed to a device
failing to suspend.

Without these message adjustments one can end up with a kernel log that says
that a device failed to suspend with no actual device suspend failures,
which can be confusing to the log examiner.

Signed-off-by: Bernie Thompson <bhthompson@chromium.org>
---
 drivers/base/power/wakeup.c | 4 +++-
 kernel/power/suspend.c      | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 79715e7..407a2ef 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -707,8 +707,10 @@ bool pm_wakeup_pending(void)
 	}
 	spin_unlock_irqrestore(&events_lock, flags);
 
-	if (ret)
+	if (ret) {
+		pr_info("PM: Wakeup pending, aborting suspend\n");
 		print_active_wakeup_sources();
+	}
 
 	return ret;
 }
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index bef86d1..ece0422 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -269,7 +269,7 @@ int suspend_devices_and_enter(suspend_state_t state)
 	suspend_test_start();
 	error = dpm_suspend_start(PMSG_SUSPEND);
 	if (error) {
-		printk(KERN_ERR "PM: Some devices failed to suspend\n");
+		pr_err("PM: Some devices failed to suspend, or early wake event detected\n");
 		goto Recover_platform;
 	}
 	suspend_test_finish("suspend devices");
-- 
1.8.2.1


From: Mark Salyzyn <salyzyn@android.com>
Subject: PM / Suspend: Print wall time at suspend entry and exit
Date: Mon,  5 Jun 2017 12:31:14 -0700
Message-ID: <20170605193157.59875-1-salyzyn@android.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33370 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbdFETd2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2017 15:33:28 -0400
Received: by mail-pg0-f53.google.com with SMTP id f185so24530675pgc.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Jun 2017 12:33:28 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Mark Salyzyn <salyzyn@android.com>, Todd Poynor <toddpoynor@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>

Permits power state and battery life diagnosis.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
---
 kernel/power/suspend.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index c0248c74d6d4..464175f04bc5 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -26,6 +26,7 @@
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/ftrace.h>
+#include <linux/rtc.h>
 #include <trace/events/power.h>
 #include <linux/compiler.h>
 #include <linux/moduleparam.h>
@@ -563,6 +564,18 @@ static int enter_state(suspend_state_t state)
 	return error;
 }
 
+static void pm_suspend_marker(char *annotation)
+{
+	struct timespec ts;
+	struct rtc_time tm;
+
+	getnstimeofday(&ts);
+	rtc_time_to_tm(ts.tv_sec, &tm);
+	pr_info("PM: suspend %s %d-%02d-%02d %02d:%02d:%02d.%09lu UTC\n",
+		annotation, tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+		tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);
+}
+
 /**
  * pm_suspend - Externally visible function for suspending the system.
  * @state: System sleep state to enter.
@@ -577,6 +590,7 @@ int pm_suspend(suspend_state_t state)
 	if (state <= PM_SUSPEND_ON || state >= PM_SUSPEND_MAX)
 		return -EINVAL;
 
+	pm_suspend_marker("entry");
 	error = enter_state(state);
 	if (error) {
 		suspend_stats.fail++;
@@ -584,6 +598,7 @@ int pm_suspend(suspend_state_t state)
 	} else {
 		suspend_stats.success++;
 	}
+	pm_suspend_marker("exit");
 	return error;
 }
 EXPORT_SYMBOL(pm_suspend);
-- 
2.13.0.506.g27d5fe0cd-goog

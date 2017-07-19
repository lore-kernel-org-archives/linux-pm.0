From: Mark Salyzyn <salyzyn@android.com>
Subject: [PATCH v2 3/4] PM: Print wall time at suspend & hibernate entry and exit
Date: Wed, 19 Jul 2017 12:48:13 -0700
Message-ID: <20170719194814.29920-1-salyzyn@android.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36029 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754316AbdGSTs1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 15:48:27 -0400
Received: by mail-pg0-f41.google.com with SMTP id 125so4456568pgi.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2017 12:48:26 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, prarit@redhat.com, andy.shevchenko@gmail.com, Mark Salyzyn <salyzyn@android.com>

Permits power state and battery life diagnosis.

Since one is not guaranteed to have a persistent hardware clock to
report Suspended for in milliseconds, we report at a higher level
at just the entry and exit points for suspend and hibernate.

Feature activated by CONFIG_RTC_SHOW_TIME_*

Signed-off-by: Mark Salyzyn <salyzyn@android.com>

v2:
- merge suspend and hibernate into a single patch
---
 kernel/power/hibernate.c | 4 +++-
 kernel/power/suspend.c   | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e1914c7b85b1..0b5460f9189b 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -32,11 +32,11 @@
 #include <linux/ctype.h>
 #include <linux/genhd.h>
 #include <linux/ktime.h>
+#include <linux/rtc.h>
 #include <trace/events/power.h>
 
 #include "power.h"
 
-
 static int nocompress;
 static int noresume;
 static int nohibernate;
@@ -342,6 +342,7 @@ int hibernation_snapshot(int platform_mode)
 	pm_message_t msg;
 	int error;
 
+	rtc_show_time("PM: hibernation entry");
 	pm_suspend_clear_flags();
 	error = platform_begin(platform_mode);
 	if (error)
@@ -409,6 +410,7 @@ int hibernation_snapshot(int platform_mode)
 	thaw_kernel_threads();
  Cleanup:
 	swsusp_free();
+	rtc_show_time("PM: hibernation exit");
 	goto Close;
 }
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 3ecf275d7e44..f44d2152ab3f 100644
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
@@ -579,6 +580,7 @@ int pm_suspend(suspend_state_t state)
 	if (state <= PM_SUSPEND_ON || state >= PM_SUSPEND_MAX)
 		return -EINVAL;
 
+	rtc_show_time("PM: suspend entry");
 	error = enter_state(state);
 	if (error) {
 		suspend_stats.fail++;
@@ -586,6 +588,7 @@ int pm_suspend(suspend_state_t state)
 	} else {
 		suspend_stats.success++;
 	}
+	rtc_show_time("PM: suspend exit");
 	return error;
 }
 EXPORT_SYMBOL(pm_suspend);
-- 
2.14.0.rc0.284.gd933b75aa4-goog

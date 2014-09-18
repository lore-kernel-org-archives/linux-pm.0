From: Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH v2] PM: Print wall time at suspend entry and exit
Date: Fri, 19 Sep 2014 04:57:12 +0530
Message-ID: <1411082832-4713-1-git-send-email-amit.pundir@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:41103 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbaIRX1V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Sep 2014 19:27:21 -0400
Received: by mail-pa0-f48.google.com with SMTP id fb1so1637071pad.7
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2014 16:27:21 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Todd Poynor <toddpoynor@google.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Android Kernel Team <kernel-team@android.com>, Amit Pundir <amit.pundir@linaro.org>

From: Todd Poynor <toddpoynor@google.com>

Existing timestamps in a dmesg only log suspend activities
(e.g. filesystem syncs, freezing/unfreezing tasks etc) while the
system has already started to enter/exit the suspend state.

Sometimes it is handy to have suspend entry/exit overhead
information while debugging suspend issues. This patch print
markers with wall timestamps at suspend Entry and Exit in
the kernel log. These timestamps can be used to compute how
long the system spent in low-power suspend state plus the
entry/exit overhead.

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: Android Kernel Team <kernel-team@android.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
[Amit Pundir: Reworded the commit message]
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
Resending this patch assuming that it might have got lost in between merge
window rush last time and now people might have some time to look at it.

 kernel/power/suspend.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 18c6219..5390c6c 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -26,6 +26,7 @@
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/ftrace.h>
+#include <linux/rtc.h>
 #include <trace/events/power.h>
 #include <linux/compiler.h>
 
@@ -443,6 +444,18 @@ static int enter_state(suspend_state_t state)
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
@@ -457,6 +470,7 @@ int pm_suspend(suspend_state_t state)
 	if (state <= PM_SUSPEND_ON || state >= PM_SUSPEND_MAX)
 		return -EINVAL;
 
+	pm_suspend_marker("entry");
 	error = enter_state(state);
 	if (error) {
 		suspend_stats.fail++;
@@ -464,6 +478,7 @@ int pm_suspend(suspend_state_t state)
 	} else {
 		suspend_stats.success++;
 	}
+	pm_suspend_marker("exit");
 	return error;
 }
 EXPORT_SYMBOL(pm_suspend);
-- 
1.9.1


From: Mark Salyzyn <salyzyn@android.com>
Subject: [PATCH v3 1/4] time: rtc-lib: Add rtc_show_time(const char *prefix_msg)
Date: Tue, 18 Jul 2017 15:15:57 -0700
Message-ID: <20170718221607.132539-1-salyzyn@android.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33494 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751987AbdGRWQ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 18:16:28 -0400
Received: by mail-pg0-f44.google.com with SMTP id k14so19895713pgr.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2017 15:16:28 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, andy.shevchenko@gmail.com, Mark Salyzyn <salyzyn@android.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Mark Salyzyn <salyzyn@google.com>, Thierry Strudel <tstrudel@google.com>, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Josh Triplett <josh@joshtriplett.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Kees Cook <keescook@chromium.org>

Go directly to the rtc for persistent wall clock time and print.
Useful if REALTIME is required to be logged in a low level power
management function or when clock activities are suspended.  An
aid to permit user space alignment of kernel activities.

Feature activated by CONFIG_RTC_SHOW_TIME.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>

v2
- move implementation to kernel timekeeping from rtc_lib files
- use rtc_time64_to_tm() instead of rtc_time_to_tm()
- use inline in include/linux/rtc.h for !CONFIG_RTC_SHOW_TIME
v3
- _correctly_ use rtc_time64_to_tm
---
 include/linux/rtc.h         |  5 +++++
 kernel/time/Kconfig         | 11 +++++++++++
 kernel/time/Makefile        |  1 +
 kernel/time/rtc_show_time.c | 23 +++++++++++++++++++++++
 4 files changed, 40 insertions(+)
 create mode 100644 kernel/time/rtc_show_time.c

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 0a0f0d14a5fb..779401c937d5 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -22,6 +22,11 @@ extern int rtc_year_days(unsigned int day, unsigned int month, unsigned int year
 extern int rtc_valid_tm(struct rtc_time *tm);
 extern time64_t rtc_tm_to_time64(struct rtc_time *tm);
 extern void rtc_time64_to_tm(time64_t time, struct rtc_time *tm);
+#ifdef CONFIG_RTC_SHOW_TIME
+extern void rtc_show_time(const char *prefix_msg);
+#else
+static inline void rtc_show_time(const char *prefix_msg) { }
+#endif
 ktime_t rtc_tm_to_ktime(struct rtc_time tm);
 struct rtc_time rtc_ktime_to_tm(ktime_t kt);
 
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index ac09bc29eb08..4da093ae3e37 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -145,3 +145,14 @@ config HIGH_RES_TIMERS
 
 endmenu
 endif
+
+config RTC_SHOW_TIME
+	bool "rtc_show_time instrumentation"
+	select RTC_LIB
+	help
+	  Activate rtc_show_time(const char *msg) wall clock time
+	  instrumentation.
+
+	  The instrumentation is used to help triage and synchronize
+	  kernel logs using CLOCK_MONOTONIC and user space activity
+	  logs utilizing CLOCK_REALTIME references.
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index 938dbf33ef49..66f17e641052 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_GENERIC_SCHED_CLOCK)		+= sched_clock.o
 obj-$(CONFIG_TICK_ONESHOT)			+= tick-oneshot.o tick-sched.o
 obj-$(CONFIG_DEBUG_FS)				+= timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
+obj-$(CONFIG_RTC_SHOW_TIME)			+= rtc_show_time.o
diff --git a/kernel/time/rtc_show_time.c b/kernel/time/rtc_show_time.c
new file mode 100644
index 000000000000..bbf4f92abf4f
--- /dev/null
+++ b/kernel/time/rtc_show_time.c
@@ -0,0 +1,23 @@
+/*
+ * rtc time printing utility functions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/rtc.h>
+
+void rtc_show_time(const char *prefix_msg)
+{
+	struct timespec64 ts;
+	struct rtc_time tm;
+
+	getnstimeofday64(&ts);
+	rtc_time64_to_tm(ts.tv_sec, &tm);
+	pr_info("%s %d-%02d-%02d %02d:%02d:%02d.%09lu UTC\n",
+		prefix_msg ? prefix_msg : "Time:",
+		tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+		tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);
+}
+EXPORT_SYMBOL(rtc_show_time);
-- 
2.13.2.932.g7449e964c-goog

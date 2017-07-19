From: Mark Salyzyn <salyzyn@android.com>
Subject: [PATCH 4/4] time: rtc-lib: Add CONFIG_RTC_SHOW_TIME_RTC
Date: Wed, 19 Jul 2017 12:50:03 -0700
Message-ID: <20170719195012.30187-1-salyzyn@android.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36458 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753297AbdGSTuY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 15:50:24 -0400
Received: by mail-pg0-f42.google.com with SMTP id 125so4476421pgi.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2017 12:50:24 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, prarit@redhat.com, andy.shevchenko@gmail.com, Mark Salyzyn <salyzyn@android.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Add an option to report REALTIME in RTC time format for
rtc_show_time() function.

Feature activated by CONFIG_RTC_SHOW_TIME_RTC.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
---
 kernel/time/Kconfig         | 17 +++++++++++++++++
 kernel/time/rtc_show_time.c | 12 ++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 2dc891056635..3c2920b8825c 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -221,4 +221,21 @@ choice
 		  continues, and the timestamps help re-orient post-analysis.
 
 		  Print boottime <s>.<ns> timestamp in rtc_show_time
+	config RTC_SHOW_TIME_RTC
+		bool "realtime in wall clock format"
+		select RTC_SHOW_TIME
+		select RTC_LIB
+		help
+		  Activate optional rtc_show_time(const char *msg) wall clock
+		  time instrumentation.
+
+		  The primary use of the instrumentation is to aid field
+		  analysis of Battery and Power usage.  The instrumentation
+		  may also help triage and synchronize kernel logs and user
+		  space activity logs at key displacements.  For instance
+		  CLOCK_MONOTONIC stops while suspended, while CLOCK_REALTIME
+		  continues, and the timestamps help re-orient post-analysis.
+
+		  Print realtime YYYY-MM-DD hh:mm:ss.<ns> timestamp in
+		  rtc_show_time.
 endchoice
diff --git a/kernel/time/rtc_show_time.c b/kernel/time/rtc_show_time.c
index 6c7b8ae6be0c..d861a30aef77 100644
--- a/kernel/time/rtc_show_time.c
+++ b/kernel/time/rtc_show_time.c
@@ -24,9 +24,21 @@ void rtc_show_time(const char *prefix_msg)
 	struct timespec64 ts;
 
 	getnstimeofday64(&ts);
+#if defined(CONFIG_RTC_SHOW_TIME_RTC)
+	{
+		struct rtc_time tm;
+
+		rtc_time64_to_tm(ts.tv_sec, &tm);
+		pr_info("%s %d-%02d-%02d %02d:%02d:%02d.%09lu UTC\n",
+			prefix_msg ? prefix_msg : "Time:",
+			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+			tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);
+	}
+#else
 	pr_info("%s %lu.%09lu UTC\n",
 		prefix_msg ? prefix_msg : "Time:", ts.tv_sec, ts.tv_nsec);
 #endif
+#endif
 }
 EXPORT_SYMBOL(rtc_show_time);
 
-- 
2.14.0.rc0.284.gd933b75aa4-goog

From: Mark Salyzyn <salyzyn@android.com>
Subject: [PATCH 1/4] rtc-lib: Add rtc_show_time(const char *prefix_msg)
Date: Tue, 18 Jul 2017 10:25:23 -0700
Message-ID: <20170718172525.114514-1-salyzyn@android.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36556 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbdGRRZh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 13:25:37 -0400
Received: by mail-pg0-f53.google.com with SMTP id u5so16157571pgq.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2017 10:25:37 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, Mark Salyzyn <salyzyn@android.com>

Go directly to the rtc for persistent wall clock time and print.
Useful if REALTIME is required to be logged in a low level power
management function or when clock activities are suspended.  An
aid to permit user space alignment of kernel activities.

Feature activated by CONFIG_RTC_SHOW_TIME.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
---
 drivers/rtc/Kconfig   | 11 +++++++++++
 drivers/rtc/rtc-lib.c | 16 ++++++++++++++++
 include/linux/rtc.h   |  5 +++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 72419ac2c52a..7c308605bf42 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -5,6 +5,17 @@
 config RTC_LIB
 	bool
 
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
+
 config RTC_MC146818_LIB
 	bool
 	select RTC_LIB
diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
index 1ae7da5cfc60..676d6a83e843 100644
--- a/drivers/rtc/rtc-lib.c
+++ b/drivers/rtc/rtc-lib.c
@@ -94,6 +94,22 @@ void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
 }
 EXPORT_SYMBOL(rtc_time64_to_tm);
 
+#ifdef CONFIG_RTC_SHOW_TIME
+void rtc_show_time(const char *prefix_msg)
+{
+	struct timespec ts;
+	struct rtc_time tm;
+
+	getnstimeofday(&ts);
+	rtc_time_to_tm(ts.tv_sec, &tm);
+	pr_info("%s %d-%02d-%02d %02d:%02d:%02d.%09lu UTC\n",
+		prefix_msg ? prefix_msg : "Time:",
+		tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+		tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);
+}
+EXPORT_SYMBOL(rtc_show_time);
+#endif
+
 /*
  * Does the rtc_time represent a valid date/time?
  */
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 0a0f0d14a5fb..bf625e023799 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -22,6 +22,11 @@ extern int rtc_year_days(unsigned int day, unsigned int month, unsigned int year
 extern int rtc_valid_tm(struct rtc_time *tm);
 extern time64_t rtc_tm_to_time64(struct rtc_time *tm);
 extern void rtc_time64_to_tm(time64_t time, struct rtc_time *tm);
+#ifdef CONFIG_RTC_SHOW_TIME
+extern void rtc_show_time(const char *prefix_msg);
+#else
+#define rtc_show_time(prefix_msg)
+#endif
 ktime_t rtc_tm_to_ktime(struct rtc_time tm);
 struct rtc_time rtc_ktime_to_tm(ktime_t kt);
 
-- 
2.13.2.932.g7449e964c-goog

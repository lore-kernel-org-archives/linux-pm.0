From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][v8] timekeeping: Ignore the bogus sleep time if pm_trace is enabled
Date: Tue, 29 Nov 2016 17:01:57 +0800
Message-ID: <1480410117-6605-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Xunlei Pang <xlpang@redhat.com>, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Prarit Bhargava <prarit@redhat.com>, Richard Cochran <richardcochran@gmail.com>
List-Id: linux-pm@vger.kernel.org

Previously we encountered memory overflow issues due to
bogus sleep time brought by an inconsistent RTC, which is
triggered when pm_trace is enabled, and we have fixed it
in recent kernels. However it's improper in the first place
to call __timekeeping_inject_sleeptime() in case pm_trace
is enabled simply because the "hash" time value will wreckage
the timekeeping subsystem.

This patch was originally written by Thomas, which would bypass
the bogus RTC interval when pm_trace is enabled.
Meanwhile, if the system succeeds to resume back with pm_trace set,
users are warned to adjust the bogus RTC either by 'ntpdate' or
'rdate', by resetting pm_trace_rtc_abused to false, otherwise above
tools might not work as expected.

Originally-from: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Xunlei Pang <xlpang@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
-> v8:
 Rewrite the comments and function declaration according to Ingo's suggestion.
---
 arch/x86/kernel/rtc.c       |  9 +++++++++
 drivers/base/power/trace.c  | 25 +++++++++++++++++++++++++
 drivers/rtc/rtc-cmos.c      |  7 +++++++
 include/linux/mc146818rtc.h |  1 +
 include/linux/pm-trace.h    |  9 ++++++++-
 5 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 79c6311c..7d35a21 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -64,6 +64,15 @@ void mach_get_cmos_time(struct timespec *now)
 	unsigned int status, year, mon, day, hour, min, sec, century = 0;
 	unsigned long flags;
 
+	/*
+	 * If pm_trace abused the RTC as storage, set the timespec to 0,
+	 * which tells the caller that this RTC value is bogus.
+	 */
+	if (!pm_trace_rtc_valid()) {
+		now->tv_sec = now->tv_nsec = 0;
+		return;
+	}
+
 	spin_lock_irqsave(&rtc_lock, flags);
 
 	/*
diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index efec10b..5bc7d80 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -10,6 +10,7 @@
 #include <linux/pm-trace.h>
 #include <linux/export.h>
 #include <linux/rtc.h>
+#include <linux/suspend.h>
 
 #include <linux/mc146818rtc.h>
 
@@ -74,6 +75,9 @@
 
 #define DEVSEED (7919)
 
+bool pm_trace_rtc_abused __read_mostly;
+EXPORT_SYMBOL_GPL(pm_trace_rtc_abused);
+
 static unsigned int dev_hash_value;
 
 static int set_magic_time(unsigned int user, unsigned int file, unsigned int device)
@@ -104,6 +108,7 @@ static int set_magic_time(unsigned int user, unsigned int file, unsigned int dev
 	time.tm_min = (n % 20) * 3;
 	n /= 20;
 	mc146818_set_time(&time);
+	pm_trace_rtc_abused = true;
 	return n ? -1 : 0;
 }
 
@@ -238,10 +243,30 @@ int show_trace_dev_match(char *buf, size_t size)
 	device_pm_unlock();
 	return ret;
 }
+static int pm_trace_notify(struct notifier_block *nb, unsigned long mode, void *_unused)
+{
+	switch (mode) {
+	case PM_POST_HIBERNATION:
+	case PM_POST_SUSPEND:
+		if (pm_trace_rtc_abused) {
+			pm_trace_rtc_abused = false;
+			pr_warn("Possible incorrect RTC due to pm_trace, please use 'ntpdate' or 'rdate' to reset it.\n");
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static struct notifier_block pm_trace_nb = {
+	.notifier_call = pm_trace_notify,
+};
 
 static int early_resume_init(void)
 {
 	hash_value_early_read = read_magic_time();
+	register_pm_notifier(&pm_trace_nb);
 	return 0;
 }
 
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 7030d7c..24a0bf6 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -191,6 +191,13 @@ static inline void cmos_write_bank2(unsigned char val, unsigned char addr)
 
 static int cmos_read_time(struct device *dev, struct rtc_time *t)
 {
+	/*
+	 * If pm_trace abused the RTC as storage, tell the caller that it is
+	 * unusable.
+	 */
+	if (!pm_trace_rtc_valid())
+		return -EIO;
+
 	/* REVISIT:  if the clock has a "century" register, use
 	 * that instead of the heuristic in mc146818_get_time().
 	 * That'll make Y3K compatility (year > 2070) easy!
diff --git a/include/linux/mc146818rtc.h b/include/linux/mc146818rtc.h
index a585b4b..0661af1 100644
--- a/include/linux/mc146818rtc.h
+++ b/include/linux/mc146818rtc.h
@@ -16,6 +16,7 @@
 #include <asm/mc146818rtc.h>		/* register access macros */
 #include <linux/bcd.h>
 #include <linux/delay.h>
+#include <linux/pm-trace.h>
 
 #ifdef __KERNEL__
 #include <linux/spinlock.h>		/* spinlock_t */
diff --git a/include/linux/pm-trace.h b/include/linux/pm-trace.h
index ecbde7a..7b78793 100644
--- a/include/linux/pm-trace.h
+++ b/include/linux/pm-trace.h
@@ -1,11 +1,17 @@
 #ifndef PM_TRACE_H
 #define PM_TRACE_H
 
+#include <linux/types.h>
 #ifdef CONFIG_PM_TRACE
 #include <asm/pm-trace.h>
-#include <linux/types.h>
 
 extern int pm_trace_enabled;
+extern bool pm_trace_rtc_abused;
+
+static inline bool pm_trace_rtc_valid(void)
+{
+	return !pm_trace_rtc_abused;
+}
 
 static inline int pm_trace_is_enabled(void)
 {
@@ -24,6 +30,7 @@ extern int show_trace_dev_match(char *buf, size_t size);
 
 #else
 
+static inline bool pm_trace_rtc_valid(void) { return true; }
 static inline int pm_trace_is_enabled(void) { return 0; }
 
 #define TRACE_DEVICE(dev) do { } while (0)
-- 
2.7.4

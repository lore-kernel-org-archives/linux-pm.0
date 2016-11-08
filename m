From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/2][RFC v6] PM / sleep: save/restore RTC time after resumed if pm_trace enabled
Date: Tue,  8 Nov 2016 17:02:14 +0800
Message-ID: <3bf82cf55c4f5ce3286f6c3fc0b2b7e4b2e5ded3.1478589736.git.yu.c.chen@intel.com>
References: <cover.1478589736.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1478589736.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, Xunlei Pang <xlpang@redhat.com>
List-Id: linux-pm@vger.kernel.org

Previously the bogus CMOS RTC sleep time has been ignored if pm_trace
is enabled, however once the system successfully resumed back,
any further read to CMOS RTC would return an error. Actually it is
more user-friendly to bring the system back to normal after resumed.

This patch has registered an pm notifier to restore the RTC to the
value before been overwitten by pm_trace.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Len Brown <lenb@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Xunlei Pang <xlpang@redhat.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/base/power/trace.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index aa9109a..1e6c611 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -10,6 +10,7 @@
 #include <linux/pm-trace.h>
 #include <linux/export.h>
 #include <linux/rtc.h>
+#include <linux/suspend.h>
 
 #include <linux/mc146818rtc.h>
 
@@ -76,6 +77,11 @@
 
 bool pm_trace_rtc_abused __read_mostly;
 static unsigned int dev_hash_value;
+struct rtc_time_save {
+	struct rtc_time time;
+	atomic_t saved;
+};
+static struct rtc_time_save rtc_saved;
 
 static int set_magic_time(unsigned int user, unsigned int file, unsigned int device)
 {
@@ -104,6 +110,8 @@ static int set_magic_time(unsigned int user, unsigned int file, unsigned int dev
 	n /= 24;
 	time.tm_min = (n % 20) * 3;
 	n /= 20;
+	if (!atomic_cmpxchg(&rtc_saved.saved, 0, 1))
+		mc146818_get_time(&rtc_saved.time);
 	mc146818_set_time(&time);
 	pm_trace_rtc_abused = true;
 	return n ? -1 : 0;
@@ -240,10 +248,31 @@ int show_trace_dev_match(char *buf, size_t size)
 	device_pm_unlock();
 	return ret;
 }
+static int pm_trace_notify(struct notifier_block *nb,
+				unsigned long mode, void *_unused)
+{
+	switch (mode) {
+	case PM_POST_HIBERNATION:
+	case PM_POST_SUSPEND:
+		if (atomic_cmpxchg(&rtc_saved.saved, 1, 0)) {
+			mc146818_set_time(&rtc_saved.time);
+			pm_trace_rtc_abused = false;
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
 
-- 
2.7.4

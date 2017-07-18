From: Mark Salyzyn <salyzyn@android.com>
Subject: [PATCH 2/4] rtc-lib: Print wall time at die and reboot
Date: Tue, 18 Jul 2017 10:25:43 -0700
Message-ID: <20170718172545.114568-1-salyzyn@android.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, Mark Salyzyn <salyzyn@android.com>
List-Id: linux-pm@vger.kernel.org

Permits power state and battery life diagnosis.

Feature activated by CONFIG_RTC_SHOW_TIME.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
---
 drivers/rtc/rtc-lib.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
index 676d6a83e843..c28fdfbb99d4 100644
--- a/drivers/rtc/rtc-lib.c
+++ b/drivers/rtc/rtc-lib.c
@@ -12,6 +12,8 @@
 */
 
 #include <linux/export.h>
+#include <linux/kdebug.h>
+#include <linux/reboot.h>
 #include <linux/rtc.h>
 
 static const unsigned char rtc_days_in_month[] = {
@@ -108,6 +110,62 @@ void rtc_show_time(const char *prefix_msg)
 		tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);
 }
 EXPORT_SYMBOL(rtc_show_time);
+
+static int rtc_show_time_die_notify(struct notifier_block *self,
+		unsigned long event, void *data)
+{
+	if (event != DIE_OOPS)
+		return NOTIFY_DONE;
+	rtc_show_time("Oops");
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block rtc_show_time_die_nb = {
+	.notifier_call = rtc_show_time_die_notify,
+	.priority = 0,
+};
+
+static int rtc_show_time_reboot_notify(struct notifier_block *self,
+		unsigned long event, void *data)
+{
+	const char *txt;
+
+	switch (event) {
+	case SYS_RESTART:
+		txt = "Restart";
+		break;
+	case SYS_HALT:
+		txt = "Halt";
+		break;
+	case SYS_POWER_OFF:
+		txt = "Power-Off";
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+	rtc_show_time(txt);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block rtc_show_time_reboot_nb = {
+	.notifier_call = rtc_show_time_reboot_notify,
+	.priority = 0,
+};
+
+static __init int init_rtc_show_time(void)
+{
+	int ret;
+
+	ret = register_die_notifier(&rtc_show_time_die_nb);
+	if (ret)
+		pr_warn("Failed to register rtc_show_time die notifier\n");
+	ret = register_reboot_notifier(&rtc_show_time_reboot_nb);
+	if (ret)
+		pr_warn("Failed to register rtc_show_time reboot notifier\n");
+
+	return ret;
+}
+device_initcall(init_rtc_show_time);
 #endif
 
 /*
-- 
2.13.2.932.g7449e964c-goog

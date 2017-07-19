From: Mark Salyzyn <salyzyn@android.com>
Subject: [PATCH v2 2/4] time: Print wall time at die and reboot
Date: Wed, 19 Jul 2017 12:45:37 -0700
Message-ID: <20170719194541.29031-1-salyzyn@android.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33925 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934158AbdGSTpt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 15:45:49 -0400
Received: by mail-pf0-f179.google.com with SMTP id q85so3761693pfq.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2017 12:45:48 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, Mark Salyzyn <salyzyn@android.com>

Permits power state and battery life diagnosis.

Feature activated by CONFIG_RTC_SHOW_TIME.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>

v2:
- react to implementation move to kernel timekeeping from rtc_lib
- use late_initcall to ensure rtc_lib driver(s) are loaded

---
 kernel/time/rtc_show_time.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/kernel/time/rtc_show_time.c b/kernel/time/rtc_show_time.c
index 19a8a0cc94f0..6c7b8ae6be0c 100644
--- a/kernel/time/rtc_show_time.c
+++ b/kernel/time/rtc_show_time.c
@@ -6,6 +6,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/kdebug.h>
+#include <linux/reboot.h>
 #include <linux/rtc.h>
 
 void rtc_show_time(const char *prefix_msg)
@@ -27,3 +29,60 @@ void rtc_show_time(const char *prefix_msg)
 #endif
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
+/* rtc driver needs to be loaded before this is truly functional */
+late_initcall(init_rtc_show_time);
-- 
2.14.0.rc0.284.gd933b75aa4-goog

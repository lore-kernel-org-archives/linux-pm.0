From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/2][RFC] PM / sleep: Expose DPM watchdog timeout to sysfs
Date: Thu, 11 Aug 2016 20:29:52 +0800
Message-ID: <539cf51e6c607ef1903c0811f9a1bf0527d98739.1470908324.git.yu.c.chen@intel.com>
References: <cover.1470908324.git.yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:59541 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932271AbcHKMV7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Aug 2016 08:21:59 -0400
In-Reply-To: <cover.1470908324.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM List <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Takashi Iwai <tiwai@suse.de>, Benoit Goby <benoit@android.com>, Chen Yu <yu.c.chen@intel.com>

Default suspend/resume watchdog timeout has once been
modified from 12 to 60 seconds, in case some harddisks
have firmware problems and take too long time to resume
from suspend. And currently we have a new report that this
delay may takes more than 60 seconds. So for future possible
scenario, this patch exposes the watchdog timeout value to
sysfs, and user can customize it to accommodate their use case,
without recompiling the kernel.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=117971
Reported-by: Higuita <higuita@gmx.net>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/base/power/main.c    |  4 +++-
 include/linux/sched/sysctl.h |  4 ++++
 kernel/sysctl.c              | 16 ++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e44944f..7f990c2 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -407,6 +407,8 @@ struct dpm_watchdog {
 #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
 	struct dpm_watchdog wd
 
+int __read_mostly sysctl_dpm_timeout_secs = CONFIG_DPM_WATCHDOG_TIMEOUT;
+
 /**
  * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
  * @data: Watchdog object address.
@@ -439,7 +441,7 @@ static void dpm_watchdog_set(struct dpm_watchdog *wd, struct device *dev)
 
 	init_timer_on_stack(timer);
 	/* use same timeout value for both suspend and resume */
-	timer->expires = jiffies + HZ * CONFIG_DPM_WATCHDOG_TIMEOUT;
+	timer->expires = jiffies + HZ * sysctl_dpm_timeout_secs;
 	timer->function = dpm_watchdog_handler;
 	timer->data = (unsigned long)wd;
 	add_timer(timer);
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 22db1e6..1b7f536 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -14,6 +14,10 @@ extern int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
 enum { sysctl_hung_task_timeout_secs = 0 };
 #endif
 
+#ifdef CONFIG_DPM_WATCHDOG
+extern int sysctl_dpm_timeout_secs;
+#endif
+
 extern unsigned int sysctl_sched_latency;
 extern unsigned int sysctl_sched_min_granularity;
 extern unsigned int sysctl_sched_wakeup_granularity;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b43d0b2..bc8f01d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -149,6 +149,11 @@ static const int cap_last_cap = CAP_LAST_CAP;
 static unsigned long hung_task_timeout_max = (LONG_MAX/HZ);
 #endif
 
+/* this is needed for the proc_dointvec_minmax for sysctl_dpm_timeout_secs */
+#ifdef CONFIG_DPM_WATCHDOG
+static int dpm_timeout_max = 120;
+#endif
+
 #ifdef CONFIG_INOTIFY_USER
 #include <linux/inotify.h>
 #endif
@@ -1084,6 +1089,17 @@ static struct ctl_table kern_table[] = {
 		.extra1		= &neg_one,
 	},
 #endif
+#ifdef CONFIG_DPM_WATCHDOG
+	{
+		.procname	= "dpm_timeout_secs",
+		.data		= &sysctl_dpm_timeout_secs,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &one,
+		.extra2		= &dpm_timeout_max,
+	},
+#endif
 #ifdef CONFIG_COMPAT
 	{
 		.procname	= "compat-log",
-- 
2.7.4


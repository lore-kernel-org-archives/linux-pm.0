From: "Liu, ShuoX" <shuox.liu@intel.com>
Subject: [PATCH] PM: add statistics sysfs file for suspend to ram
Date: Thu, 4 Aug 2011 13:13:38 +0800
Message-ID: <6E3BC7F7C9A4BF4286DD4C043110F30B5B790E5741@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Brown, Len" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@sisk.pl" <rjw@sisk.pl>, "gregkh@suse.de" <gregkh@suse.de>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

>From a906b0b5b4ff3414ceb9fc7a69a3d7c9d66e46b1 Mon Sep 17 00:00:00 2001
From: ShuoX Liu <shuox.liu@intel.com>
Date: Thu, 28 Jul 2011 10:54:22 +0800
Subject: [PATCH] PM: add statistics sysfs file for suspend to ram.

Record S3 failure time about each reason and the latest two failed
devices' name in S3 progress.
We can check it through /sys/power/suspend_stats.

Change-Id: Ieed7fd74e27d3b482675a20cb0bb26b9054a1624
Signed-off-by: ShuoX Liu <shuox.liu@intel.com>
---
 drivers/base/power/main.c |   31 +++++++++++++++++++++++++--
 include/linux/suspend.h   |   16 ++++++++++++++
 kernel/power/main.c       |   49 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/power/suspend.c    |   13 ++++++++++-
 4 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index a854591..da1c561 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -46,6 +46,7 @@ LIST_HEAD(dpm_prepared_list);
 LIST_HEAD(dpm_suspended_list);
 LIST_HEAD(dpm_noirq_list);
 
+struct suspend_stats suspend_stats;
 static DEFINE_MUTEX(dpm_list_mtx);
 static pm_message_t pm_transition;
 
@@ -180,6 +181,15 @@ static void initcall_debug_report(struct device *dev, ktime_t calltime,
 	}
 }
 
+static void dpm_save_dev_name(const char *name)
+{
+	strlcpy(suspend_stats.failed_devs[suspend_stats.last_failed],
+		name,
+		sizeof(suspend_stats.failed_devs[0]));
+	suspend_stats.last_failed++;
+	suspend_stats.last_failed %= REC_FAILED_DEV_NUM;
+}
+
 /**
  * dpm_wait - Wait for a PM operation to complete.
  * @dev: Device to wait for.
@@ -464,8 +474,11 @@ void dpm_resume_noirq(pm_message_t state)
 		mutex_unlock(&dpm_list_mtx);
 
 		error = device_resume_noirq(dev, state);
-		if (error)
+		if (error) {
+			suspend_stats.failed_resume_noirq++;
+			dpm_save_dev_name(dev_name(dev));
 			pm_dev_err(dev, state, " early", error);
+		}
 
 		mutex_lock(&dpm_list_mtx);
 		put_device(dev);
@@ -626,8 +639,11 @@ void dpm_resume(pm_message_t state)
 			mutex_unlock(&dpm_list_mtx);
 
 			error = device_resume(dev, state, false);
-			if (error)
+			if (error) {
+				suspend_stats.failed_resume++;
+				dpm_save_dev_name(dev_name(dev));
 				pm_dev_err(dev, state, "", error);
+			}
 
 			mutex_lock(&dpm_list_mtx);
 		}
@@ -802,6 +818,8 @@ int dpm_suspend_noirq(pm_message_t state)
 		mutex_lock(&dpm_list_mtx);
 		if (error) {
 			pm_dev_err(dev, state, " late", error);
+			suspend_stats.failed_suspend_noirq++;
+			dpm_save_dev_name(dev_name(dev));
 			put_device(dev);
 			break;
 		}
@@ -923,8 +941,10 @@ static void async_suspend(void *data, async_cookie_t cookie)
 	int error;
 
 	error = __device_suspend(dev, pm_transition, true);
-	if (error)
+	if (error) {
+		dpm_save_dev_name(dev_name(dev));
 		pm_dev_err(dev, pm_transition, " async", error);
+	}
 
 	put_device(dev);
 }
@@ -967,6 +987,7 @@ int dpm_suspend(pm_message_t state)
 		mutex_lock(&dpm_list_mtx);
 		if (error) {
 			pm_dev_err(dev, state, "", error);
+			dpm_save_dev_name(dev_name(dev));
 			put_device(dev);
 			break;
 		}
@@ -982,6 +1003,8 @@ int dpm_suspend(pm_message_t state)
 		error = async_error;
 	if (!error)
 		dpm_show_time(starttime, state, NULL);
+	else
+		suspend_stats.failed_suspend++;
 	return error;
 }
 
@@ -1090,6 +1113,8 @@ int dpm_suspend_start(pm_message_t state)
 	error = dpm_prepare(state);
 	if (!error)
 		error = dpm_suspend(state);
+	else
+		suspend_stats.failed_prepare++;
 	return error;
 }
 EXPORT_SYMBOL_GPL(dpm_suspend_start);
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 6bbcef2..6a8ff23 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -34,6 +34,22 @@ typedef int __bitwise suspend_state_t;
 #define PM_SUSPEND_MEM		((__force suspend_state_t) 3)
 #define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
 
+struct suspend_stats {
+	int	success;
+	int	fail;
+	int	failed_freeze;
+	int	failed_prepare;
+	int	failed_suspend;
+	int	failed_suspend_noirq;
+	int	failed_resume;
+	int	failed_resume_noirq;
+#define	REC_FAILED_DEV_NUM	2
+	char	failed_devs[REC_FAILED_DEV_NUM][40];
+	int	last_failed;
+};
+
+extern struct suspend_stats suspend_stats;
+
 /**
  * struct platform_suspend_ops - Callbacks for managing platform dependent
  *	system sleep states.
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 6c601f8..32eb67b 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -133,6 +133,50 @@ power_attr(pm_test);
 
 #endif /* CONFIG_PM_SLEEP */
 
+static ssize_t suspend_stats_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	int i, index, last_index;
+	char *s = buf;
+
+	last_index = suspend_stats.last_failed + REC_FAILED_DEV_NUM - 1;
+	last_index %= REC_FAILED_DEV_NUM;
+	s += sprintf(s, "%s: %d\n%s: %d\n%s: %d\n%s: %d\n"
+			"%s: %d\n%s: %d\n%s: %d\n%s: %d\n",
+			"success", suspend_stats.success,
+			"fail", suspend_stats.fail,
+			"failed_freeze", suspend_stats.failed_freeze,
+			"failed_prepare", suspend_stats.failed_prepare,
+			"failed_suspend", suspend_stats.failed_suspend,
+			"failed_suspend_noirq",
+				suspend_stats.failed_suspend_noirq,
+			"failed_resume", suspend_stats.failed_resume,
+			"failed_resume_noirq",
+				suspend_stats.failed_resume_noirq);
+	s += sprintf(s,	"failed_devs:\n  last_failed:\t%s\n",
+			suspend_stats.failed_devs[last_index]);
+	for (i = 1; i < REC_FAILED_DEV_NUM; i++) {
+		index = last_index + REC_FAILED_DEV_NUM - i;
+		index %= REC_FAILED_DEV_NUM;
+		s += sprintf(s, "\t\t%s\n",
+			suspend_stats.failed_devs[index]);
+	}
+
+	if (s != buf)
+		/* convert the last space to a newline */
+		*(s-1) = '\n';
+
+	return s - buf;
+}
+
+static ssize_t suspend_stats_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t n)
+{
+	return n;
+}
+
+power_attr(suspend_stats);
+
 struct kobject *power_kobj;
 
 /**
@@ -194,6 +238,10 @@ static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
 	}
 	if (state < PM_SUSPEND_MAX && *s)
 		error = enter_state(state);
+		if (error)
+			suspend_stats.fail++;
+		else
+			suspend_stats.success++;
 #endif
 
  Exit:
@@ -310,6 +358,7 @@ static struct attribute * g[] = {
 #ifdef CONFIG_PM_DEBUG
 	&pm_test_attr.attr,
 #endif
+	&suspend_stats_attr.attr,
 #endif
 	NULL,
 };
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index b6b71ad..9bb4281 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -106,6 +106,8 @@ static int suspend_prepare(void)
 	error = suspend_freeze_processes();
 	if (!error)
 		return 0;
+	else
+		suspend_stats.failed_freeze++;
 
 	suspend_thaw_processes();
 	usermodehelper_enable();
@@ -315,8 +317,15 @@ int enter_state(suspend_state_t state)
  */
 int pm_suspend(suspend_state_t state)
 {
-	if (state > PM_SUSPEND_ON && state <= PM_SUSPEND_MAX)
-		return enter_state(state);
+	int ret;
+	if (state > PM_SUSPEND_ON && state <= PM_SUSPEND_MAX) {
+		ret = enter_state(state);
+		if (ret)
+			suspend_stats.fail++;
+		else
+			suspend_stats.success++;
+		return ret;
+	}
 	return -EINVAL;
 }
 EXPORT_SYMBOL(pm_suspend);
-- 
1.7.1

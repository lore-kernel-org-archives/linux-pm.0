From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0077/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:38:55 +0800
Message-ID: <20160802103855.18883-1-baolex.ni@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54197 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755205AbcHBLTi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Aug 2016 07:19:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, hpa@zytor.com, x86@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/base/power/sysfs.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index a7b4679..8750805 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -125,7 +125,7 @@ static ssize_t control_store(struct device * dev, struct device_attribute *attr,
 	return n;
 }
 
-static DEVICE_ATTR(control, 0644, control_show, control_store);
+static DEVICE_ATTR(control, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, control_show, control_store);
 
 static ssize_t rtpm_active_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -138,7 +138,7 @@ static ssize_t rtpm_active_time_show(struct device *dev,
 	return ret;
 }
 
-static DEVICE_ATTR(runtime_active_time, 0444, rtpm_active_time_show, NULL);
+static DEVICE_ATTR(runtime_active_time, S_IRUSR | S_IRGRP | S_IROTH, rtpm_active_time_show, NULL);
 
 static ssize_t rtpm_suspended_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -152,7 +152,7 @@ static ssize_t rtpm_suspended_time_show(struct device *dev,
 	return ret;
 }
 
-static DEVICE_ATTR(runtime_suspended_time, 0444, rtpm_suspended_time_show, NULL);
+static DEVICE_ATTR(runtime_suspended_time, S_IRUSR | S_IRGRP | S_IROTH, rtpm_suspended_time_show, NULL);
 
 static ssize_t rtpm_status_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -184,7 +184,7 @@ static ssize_t rtpm_status_show(struct device *dev,
 	return sprintf(buf, p);
 }
 
-static DEVICE_ATTR(runtime_status, 0444, rtpm_status_show, NULL);
+static DEVICE_ATTR(runtime_status, S_IRUSR | S_IRGRP | S_IROTH, rtpm_status_show, NULL);
 
 static ssize_t autosuspend_delay_ms_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -211,7 +211,7 @@ static ssize_t autosuspend_delay_ms_store(struct device *dev,
 	return n;
 }
 
-static DEVICE_ATTR(autosuspend_delay_ms, 0644, autosuspend_delay_ms_show,
+static DEVICE_ATTR(autosuspend_delay_ms, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, autosuspend_delay_ms_show,
 		autosuspend_delay_ms_store);
 
 static ssize_t pm_qos_resume_latency_show(struct device *dev,
@@ -239,7 +239,7 @@ static ssize_t pm_qos_resume_latency_store(struct device *dev,
 	return ret < 0 ? ret : n;
 }
 
-static DEVICE_ATTR(pm_qos_resume_latency_us, 0644,
+static DEVICE_ATTR(pm_qos_resume_latency_us, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 		   pm_qos_resume_latency_show, pm_qos_resume_latency_store);
 
 static ssize_t pm_qos_latency_tolerance_show(struct device *dev,
@@ -273,7 +273,7 @@ static ssize_t pm_qos_latency_tolerance_store(struct device *dev,
 	return ret < 0 ? ret : n;
 }
 
-static DEVICE_ATTR(pm_qos_latency_tolerance_us, 0644,
+static DEVICE_ATTR(pm_qos_latency_tolerance_us, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 		   pm_qos_latency_tolerance_show, pm_qos_latency_tolerance_store);
 
 static ssize_t pm_qos_no_power_off_show(struct device *dev,
@@ -300,7 +300,7 @@ static ssize_t pm_qos_no_power_off_store(struct device *dev,
 	return ret < 0 ? ret : n;
 }
 
-static DEVICE_ATTR(pm_qos_no_power_off, 0644,
+static DEVICE_ATTR(pm_qos_no_power_off, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 		   pm_qos_no_power_off_show, pm_qos_no_power_off_store);
 
 static ssize_t pm_qos_remote_wakeup_show(struct device *dev,
@@ -327,7 +327,7 @@ static ssize_t pm_qos_remote_wakeup_store(struct device *dev,
 	return ret < 0 ? ret : n;
 }
 
-static DEVICE_ATTR(pm_qos_remote_wakeup, 0644,
+static DEVICE_ATTR(pm_qos_remote_wakeup, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 		   pm_qos_remote_wakeup_show, pm_qos_remote_wakeup_store);
 
 #ifdef CONFIG_PM_SLEEP
@@ -366,7 +366,7 @@ wake_store(struct device * dev, struct device_attribute *attr,
 	return n;
 }
 
-static DEVICE_ATTR(wakeup, 0644, wake_show, wake_store);
+static DEVICE_ATTR(wakeup, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, wake_show, wake_store);
 
 static ssize_t wakeup_count_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -383,7 +383,7 @@ static ssize_t wakeup_count_show(struct device *dev,
 	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_count, 0444, wakeup_count_show, NULL);
+static DEVICE_ATTR(wakeup_count, S_IRUSR | S_IRGRP | S_IROTH, wakeup_count_show, NULL);
 
 static ssize_t wakeup_active_count_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -400,7 +400,7 @@ static ssize_t wakeup_active_count_show(struct device *dev,
 	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_active_count, 0444, wakeup_active_count_show, NULL);
+static DEVICE_ATTR(wakeup_active_count, S_IRUSR | S_IRGRP | S_IROTH, wakeup_active_count_show, NULL);
 
 static ssize_t wakeup_abort_count_show(struct device *dev,
 					struct device_attribute *attr,
@@ -418,7 +418,7 @@ static ssize_t wakeup_abort_count_show(struct device *dev,
 	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_abort_count, 0444, wakeup_abort_count_show, NULL);
+static DEVICE_ATTR(wakeup_abort_count, S_IRUSR | S_IRGRP | S_IROTH, wakeup_abort_count_show, NULL);
 
 static ssize_t wakeup_expire_count_show(struct device *dev,
 					struct device_attribute *attr,
@@ -436,7 +436,7 @@ static ssize_t wakeup_expire_count_show(struct device *dev,
 	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_expire_count, 0444, wakeup_expire_count_show, NULL);
+static DEVICE_ATTR(wakeup_expire_count, S_IRUSR | S_IRGRP | S_IROTH, wakeup_expire_count_show, NULL);
 
 static ssize_t wakeup_active_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -453,7 +453,7 @@ static ssize_t wakeup_active_show(struct device *dev,
 	return enabled ? sprintf(buf, "%u\n", active) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_active, 0444, wakeup_active_show, NULL);
+static DEVICE_ATTR(wakeup_active, S_IRUSR | S_IRGRP | S_IROTH, wakeup_active_show, NULL);
 
 static ssize_t wakeup_total_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -470,7 +470,7 @@ static ssize_t wakeup_total_time_show(struct device *dev,
 	return enabled ? sprintf(buf, "%lld\n", msec) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_total_time_ms, 0444, wakeup_total_time_show, NULL);
+static DEVICE_ATTR(wakeup_total_time_ms, S_IRUSR | S_IRGRP | S_IROTH, wakeup_total_time_show, NULL);
 
 static ssize_t wakeup_max_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -487,7 +487,7 @@ static ssize_t wakeup_max_time_show(struct device *dev,
 	return enabled ? sprintf(buf, "%lld\n", msec) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_max_time_ms, 0444, wakeup_max_time_show, NULL);
+static DEVICE_ATTR(wakeup_max_time_ms, S_IRUSR | S_IRGRP | S_IROTH, wakeup_max_time_show, NULL);
 
 static ssize_t wakeup_last_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -504,7 +504,7 @@ static ssize_t wakeup_last_time_show(struct device *dev,
 	return enabled ? sprintf(buf, "%lld\n", msec) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_last_time_ms, 0444, wakeup_last_time_show, NULL);
+static DEVICE_ATTR(wakeup_last_time_ms, S_IRUSR | S_IRGRP | S_IROTH, wakeup_last_time_show, NULL);
 
 #ifdef CONFIG_PM_AUTOSLEEP
 static ssize_t wakeup_prevent_sleep_time_show(struct device *dev,
@@ -523,7 +523,7 @@ static ssize_t wakeup_prevent_sleep_time_show(struct device *dev,
 	return enabled ? sprintf(buf, "%lld\n", msec) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_prevent_sleep_time_ms, 0444,
+static DEVICE_ATTR(wakeup_prevent_sleep_time_ms, S_IRUSR | S_IRGRP | S_IROTH,
 		   wakeup_prevent_sleep_time_show, NULL);
 #endif /* CONFIG_PM_AUTOSLEEP */
 #endif /* CONFIG_PM_SLEEP */
@@ -554,9 +554,9 @@ static ssize_t rtpm_enabled_show(struct device *dev,
 	return sprintf(buf, "enabled\n");
 }
 
-static DEVICE_ATTR(runtime_usage, 0444, rtpm_usagecount_show, NULL);
-static DEVICE_ATTR(runtime_active_kids, 0444, rtpm_children_show, NULL);
-static DEVICE_ATTR(runtime_enabled, 0444, rtpm_enabled_show, NULL);
+static DEVICE_ATTR(runtime_usage, S_IRUSR | S_IRGRP | S_IROTH, rtpm_usagecount_show, NULL);
+static DEVICE_ATTR(runtime_active_kids, S_IRUSR | S_IRGRP | S_IROTH, rtpm_children_show, NULL);
+static DEVICE_ATTR(runtime_enabled, S_IRUSR | S_IRGRP | S_IROTH, rtpm_enabled_show, NULL);
 
 #ifdef CONFIG_PM_SLEEP
 static ssize_t async_show(struct device *dev, struct device_attribute *attr,
@@ -586,7 +586,7 @@ static ssize_t async_store(struct device *dev, struct device_attribute *attr,
 	return n;
 }
 
-static DEVICE_ATTR(async, 0644, async_show, async_store);
+static DEVICE_ATTR(async, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, async_show, async_store);
 
 #endif /* CONFIG_PM_SLEEP */
 #endif /* CONFIG_PM_ADVANCED_DEBUG */
-- 
2.9.2


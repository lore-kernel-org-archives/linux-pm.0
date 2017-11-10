From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] PM / sysfs: Convert to use DEVICE_ATTR_RO / DEVICE_ATTR_RW
Date: Fri, 10 Nov 2017 20:28:09 +0200
Message-ID: <20171110182809.85953-3-andriy.shevchenko@linux.intel.com>
References: <20171110182809.85953-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56340 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753327AbdKJS3P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Nov 2017 13:29:15 -0500
In-Reply-To: <20171110182809.85953-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Use DEVICE_ATTR_RO() and DEVICE_ATTR_RW() macros instead of
open coding them.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/power/sysfs.c | 133 ++++++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 68 deletions(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 1bf5e163ef1f..0f651efc58a1 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -119,9 +119,9 @@ static ssize_t control_store(struct device * dev, struct device_attribute *attr,
 	return n;
 }
 
-static DEVICE_ATTR(control, 0644, control_show, control_store);
+static DEVICE_ATTR_RW(control);
 
-static ssize_t rtpm_active_time_show(struct device *dev,
+static ssize_t runtime_active_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int ret;
@@ -132,9 +132,9 @@ static ssize_t rtpm_active_time_show(struct device *dev,
 	return ret;
 }
 
-static DEVICE_ATTR(runtime_active_time, 0444, rtpm_active_time_show, NULL);
+static DEVICE_ATTR_RO(runtime_active_time);
 
-static ssize_t rtpm_suspended_time_show(struct device *dev,
+static ssize_t runtime_suspended_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int ret;
@@ -146,9 +146,9 @@ static ssize_t rtpm_suspended_time_show(struct device *dev,
 	return ret;
 }
 
-static DEVICE_ATTR(runtime_suspended_time, 0444, rtpm_suspended_time_show, NULL);
+static DEVICE_ATTR_RO(runtime_suspended_time);
 
-static ssize_t rtpm_status_show(struct device *dev,
+static ssize_t runtime_status_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	const char *p;
@@ -178,7 +178,7 @@ static ssize_t rtpm_status_show(struct device *dev,
 	return sprintf(buf, p);
 }
 
-static DEVICE_ATTR(runtime_status, 0444, rtpm_status_show, NULL);
+static DEVICE_ATTR_RO(runtime_status);
 
 static ssize_t autosuspend_delay_ms_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -205,12 +205,11 @@ static ssize_t autosuspend_delay_ms_store(struct device *dev,
 	return n;
 }
 
-static DEVICE_ATTR(autosuspend_delay_ms, 0644, autosuspend_delay_ms_show,
-		autosuspend_delay_ms_store);
+static DEVICE_ATTR_RW(autosuspend_delay_ms);
 
-static ssize_t pm_qos_resume_latency_show(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
+static ssize_t pm_qos_resume_latency_us_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
 {
 	s32 value = dev_pm_qos_requested_resume_latency(dev);
 
@@ -222,9 +221,9 @@ static ssize_t pm_qos_resume_latency_show(struct device *dev,
 	return sprintf(buf, "%d\n", value);
 }
 
-static ssize_t pm_qos_resume_latency_store(struct device *dev,
-					   struct device_attribute *attr,
-					   const char *buf, size_t n)
+static ssize_t pm_qos_resume_latency_us_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t n)
 {
 	s32 value;
 	int ret;
@@ -250,12 +249,11 @@ static ssize_t pm_qos_resume_latency_store(struct device *dev,
 	return ret < 0 ? ret : n;
 }
 
-static DEVICE_ATTR(pm_qos_resume_latency_us, 0644,
-		   pm_qos_resume_latency_show, pm_qos_resume_latency_store);
+static DEVICE_ATTR_RW(pm_qos_resume_latency_us);
 
-static ssize_t pm_qos_latency_tolerance_show(struct device *dev,
-					     struct device_attribute *attr,
-					     char *buf)
+static ssize_t pm_qos_latency_tolerance_us_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
 {
 	s32 value = dev_pm_qos_get_user_latency_tolerance(dev);
 
@@ -267,9 +265,9 @@ static ssize_t pm_qos_latency_tolerance_show(struct device *dev,
 	return sprintf(buf, "%d\n", value);
 }
 
-static ssize_t pm_qos_latency_tolerance_store(struct device *dev,
-					      struct device_attribute *attr,
-					      const char *buf, size_t n)
+static ssize_t pm_qos_latency_tolerance_us_store(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf, size_t n)
 {
 	s32 value;
 	int ret;
@@ -290,8 +288,7 @@ static ssize_t pm_qos_latency_tolerance_store(struct device *dev,
 	return ret < 0 ? ret : n;
 }
 
-static DEVICE_ATTR(pm_qos_latency_tolerance_us, 0644,
-		   pm_qos_latency_tolerance_show, pm_qos_latency_tolerance_store);
+static DEVICE_ATTR_RW(pm_qos_latency_tolerance_us);
 
 static ssize_t pm_qos_no_power_off_show(struct device *dev,
 					struct device_attribute *attr,
@@ -317,24 +314,22 @@ static ssize_t pm_qos_no_power_off_store(struct device *dev,
 	return ret < 0 ? ret : n;
 }
 
-static DEVICE_ATTR(pm_qos_no_power_off, 0644,
-		   pm_qos_no_power_off_show, pm_qos_no_power_off_store);
+static DEVICE_ATTR_RW(pm_qos_no_power_off);
 
 #ifdef CONFIG_PM_SLEEP
 static const char _enabled[] = "enabled";
 static const char _disabled[] = "disabled";
 
-static ssize_t
-wake_show(struct device * dev, struct device_attribute *attr, char * buf)
+static ssize_t wakeup_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	return sprintf(buf, "%s\n", device_can_wakeup(dev)
 		? (device_may_wakeup(dev) ? _enabled : _disabled)
 		: "");
 }
 
-static ssize_t
-wake_store(struct device * dev, struct device_attribute *attr,
-	const char * buf, size_t n)
+static ssize_t wakeup_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t n)
 {
 	if (!device_can_wakeup(dev))
 		return -EINVAL;
@@ -348,10 +343,10 @@ wake_store(struct device * dev, struct device_attribute *attr,
 	return n;
 }
 
-static DEVICE_ATTR(wakeup, 0644, wake_show, wake_store);
+static DEVICE_ATTR_RW(wakeup);
 
 static ssize_t wakeup_count_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+				 struct device_attribute *attr, char *buf)
 {
 	unsigned long count = 0;
 	bool enabled = false;
@@ -365,10 +360,11 @@ static ssize_t wakeup_count_show(struct device *dev,
 	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_count, 0444, wakeup_count_show, NULL);
+static DEVICE_ATTR_RO(wakeup_count);
 
 static ssize_t wakeup_active_count_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+					struct device_attribute *attr,
+					char *buf)
 {
 	unsigned long count = 0;
 	bool enabled = false;
@@ -382,11 +378,11 @@ static ssize_t wakeup_active_count_show(struct device *dev,
 	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_active_count, 0444, wakeup_active_count_show, NULL);
+static DEVICE_ATTR_RO(wakeup_active_count);
 
 static ssize_t wakeup_abort_count_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+				       struct device_attribute *attr,
+				       char *buf)
 {
 	unsigned long count = 0;
 	bool enabled = false;
@@ -400,7 +396,7 @@ static ssize_t wakeup_abort_count_show(struct device *dev,
 	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_abort_count, 0444, wakeup_abort_count_show, NULL);
+static DEVICE_ATTR_RO(wakeup_abort_count);
 
 static ssize_t wakeup_expire_count_show(struct device *dev,
 					struct device_attribute *attr,
@@ -418,10 +414,10 @@ static ssize_t wakeup_expire_count_show(struct device *dev,
 	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_expire_count, 0444, wakeup_expire_count_show, NULL);
+static DEVICE_ATTR_RO(wakeup_expire_count);
 
 static ssize_t wakeup_active_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+				  struct device_attribute *attr, char *buf)
 {
 	unsigned int active = 0;
 	bool enabled = false;
@@ -435,10 +431,11 @@ static ssize_t wakeup_active_show(struct device *dev,
 	return enabled ? sprintf(buf, "%u\n", active) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_active, 0444, wakeup_active_show, NULL);
+static DEVICE_ATTR_RO(wakeup_active);
 
-static ssize_t wakeup_total_time_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t wakeup_total_time_ms_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
 {
 	s64 msec = 0;
 	bool enabled = false;
@@ -452,10 +449,10 @@ static ssize_t wakeup_total_time_show(struct device *dev,
 	return enabled ? sprintf(buf, "%lld\n", msec) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_total_time_ms, 0444, wakeup_total_time_show, NULL);
+static DEVICE_ATTR_RO(wakeup_total_time_ms);
 
-static ssize_t wakeup_max_time_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t wakeup_max_time_ms_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
 {
 	s64 msec = 0;
 	bool enabled = false;
@@ -469,10 +466,11 @@ static ssize_t wakeup_max_time_show(struct device *dev,
 	return enabled ? sprintf(buf, "%lld\n", msec) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_max_time_ms, 0444, wakeup_max_time_show, NULL);
+static DEVICE_ATTR_RO(wakeup_max_time_ms);
 
-static ssize_t wakeup_last_time_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t wakeup_last_time_ms_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
 {
 	s64 msec = 0;
 	bool enabled = false;
@@ -486,12 +484,12 @@ static ssize_t wakeup_last_time_show(struct device *dev,
 	return enabled ? sprintf(buf, "%lld\n", msec) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_last_time_ms, 0444, wakeup_last_time_show, NULL);
+static DEVICE_ATTR_RO(wakeup_last_time_ms);
 
 #ifdef CONFIG_PM_AUTOSLEEP
-static ssize_t wakeup_prevent_sleep_time_show(struct device *dev,
-					      struct device_attribute *attr,
-					      char *buf)
+static ssize_t wakeup_prevent_sleep_time_ms_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
 {
 	s64 msec = 0;
 	bool enabled = false;
@@ -505,27 +503,29 @@ static ssize_t wakeup_prevent_sleep_time_show(struct device *dev,
 	return enabled ? sprintf(buf, "%lld\n", msec) : sprintf(buf, "\n");
 }
 
-static DEVICE_ATTR(wakeup_prevent_sleep_time_ms, 0444,
-		   wakeup_prevent_sleep_time_show, NULL);
+static DEVICE_ATTR_RO(wakeup_prevent_sleep_time_ms);
 #endif /* CONFIG_PM_AUTOSLEEP */
 #endif /* CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_PM_ADVANCED_DEBUG
-static ssize_t rtpm_usagecount_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static ssize_t runtime_usage_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d\n", atomic_read(&dev->power.usage_count));
 }
+static DEVICE_ATTR_RO(runtime_usage);
 
-static ssize_t rtpm_children_show(struct device *dev,
-				  struct device_attribute *attr, char *buf)
+static ssize_t runtime_active_kids_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
 {
 	return sprintf(buf, "%d\n", dev->power.ignore_children ?
 		0 : atomic_read(&dev->power.child_count));
 }
+static DEVICE_ATTR_RO(runtime_active_kids);
 
-static ssize_t rtpm_enabled_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t runtime_enabled_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
 {
 	if (dev->power.disable_depth && (dev->power.runtime_auto == false))
 		return sprintf(buf, "disabled & forbidden\n");
@@ -535,10 +535,7 @@ static ssize_t rtpm_enabled_show(struct device *dev,
 		return sprintf(buf, "forbidden\n");
 	return sprintf(buf, "enabled\n");
 }
-
-static DEVICE_ATTR(runtime_usage, 0444, rtpm_usagecount_show, NULL);
-static DEVICE_ATTR(runtime_active_kids, 0444, rtpm_children_show, NULL);
-static DEVICE_ATTR(runtime_enabled, 0444, rtpm_enabled_show, NULL);
+static DEVICE_ATTR_RO(runtime_enabled);
 
 #ifdef CONFIG_PM_SLEEP
 static ssize_t async_show(struct device *dev, struct device_attribute *attr,
@@ -561,7 +558,7 @@ static ssize_t async_store(struct device *dev, struct device_attribute *attr,
 	return n;
 }
 
-static DEVICE_ATTR(async, 0644, async_show, async_store);
+static DEVICE_ATTR_RW(async);
 
 #endif /* CONFIG_PM_SLEEP */
 #endif /* CONFIG_PM_ADVANCED_DEBUG */
-- 
2.14.2

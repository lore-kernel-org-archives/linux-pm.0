From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] PM / sysfs: avoid shadowing variables
Date: Mon,  8 Sep 2014 08:48:00 +0200
Message-ID: <1410158880-11413-1-git-send-email-johannes@sipsolutions.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:37959 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185AbaIHGsJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Sep 2014 02:48:09 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

The global variable "enabled" is shadowed in a number of
functions in this file, rename it to "_enabled" to avoid
that. For consistency, also rename "disabled" and move
them both into the #ifdef where they're needed.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/sysfs.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 95b181d1ca6d..a9d26ed11bf4 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -92,9 +92,6 @@
  *	wakeup_count - Report the number of wakeup events related to the device
  */
 
-static const char enabled[] = "enabled";
-static const char disabled[] = "disabled";
-
 const char power_group_name[] = "power";
 EXPORT_SYMBOL_GPL(power_group_name);
 
@@ -336,11 +333,14 @@ static DEVICE_ATTR(pm_qos_remote_wakeup, 0644,
 #endif /* CONFIG_PM_RUNTIME */
 
 #ifdef CONFIG_PM_SLEEP
+static const char _enabled[] = "enabled";
+static const char _disabled[] = "disabled";
+
 static ssize_t
 wake_show(struct device * dev, struct device_attribute *attr, char * buf)
 {
 	return sprintf(buf, "%s\n", device_can_wakeup(dev)
-		? (device_may_wakeup(dev) ? enabled : disabled)
+		? (device_may_wakeup(dev) ? _enabled : _disabled)
 		: "");
 }
 
@@ -357,11 +357,11 @@ wake_store(struct device * dev, struct device_attribute *attr,
 	cp = memchr(buf, '\n', n);
 	if (cp)
 		len = cp - buf;
-	if (len == sizeof enabled - 1
-			&& strncmp(buf, enabled, sizeof enabled - 1) == 0)
+	if (len == sizeof _enabled - 1
+			&& strncmp(buf, _enabled, sizeof _enabled - 1) == 0)
 		device_set_wakeup_enable(dev, 1);
-	else if (len == sizeof disabled - 1
-			&& strncmp(buf, disabled, sizeof disabled - 1) == 0)
+	else if (len == sizeof _disabled - 1
+			&& strncmp(buf, _disabled, sizeof _disabled - 1) == 0)
 		device_set_wakeup_enable(dev, 0);
 	else
 		return -EINVAL;
@@ -570,7 +570,8 @@ static ssize_t async_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	return sprintf(buf, "%s\n",
-			device_async_suspend_enabled(dev) ? enabled : disabled);
+			device_async_suspend_enabled(dev) ?
+				_enabled : _disabled);
 }
 
 static ssize_t async_store(struct device *dev, struct device_attribute *attr,
@@ -582,9 +583,10 @@ static ssize_t async_store(struct device *dev, struct device_attribute *attr,
 	cp = memchr(buf, '\n', n);
 	if (cp)
 		len = cp - buf;
-	if (len == sizeof enabled - 1 && strncmp(buf, enabled, len) == 0)
+	if (len == sizeof _enabled - 1 && strncmp(buf, _enabled, len) == 0)
 		device_enable_async_suspend(dev);
-	else if (len == sizeof disabled - 1 && strncmp(buf, disabled, len) == 0)
+	else if (len == sizeof _disabled - 1 &&
+		 strncmp(buf, _disabled, len) == 0)
 		device_disable_async_suspend(dev);
 	else
 		return -EINVAL;
-- 
2.1.0


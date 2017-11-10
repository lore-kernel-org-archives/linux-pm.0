From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] PM / sysfs: Convert to use sysfs_streq()
Date: Fri, 10 Nov 2017 20:28:07 +0200
Message-ID: <20171110182809.85953-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31726 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751142AbdKJS2P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Nov 2017 13:28:15 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...instead of custom approach.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/power/sysfs.c | 39 +++++++++------------------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index e153e28b1857..662632ac5e0e 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -108,16 +108,10 @@ static ssize_t control_show(struct device *dev, struct device_attribute *attr,
 static ssize_t control_store(struct device * dev, struct device_attribute *attr,
 			     const char * buf, size_t n)
 {
-	char *cp;
-	int len = n;
-
-	cp = memchr(buf, '\n', n);
-	if (cp)
-		len = cp - buf;
 	device_lock(dev);
-	if (len == sizeof ctrl_auto - 1 && strncmp(buf, ctrl_auto, len) == 0)
+	if (sysfs_streq(buf, ctrl_auto))
 		pm_runtime_allow(dev);
-	else if (len == sizeof ctrl_on - 1 && strncmp(buf, ctrl_on, len) == 0)
+	else if (sysfs_streq(buf, ctrl_on))
 		pm_runtime_forbid(dev);
 	else
 		n = -EINVAL;
@@ -245,7 +239,7 @@ static ssize_t pm_qos_resume_latency_store(struct device *dev,
 
 		if (value == 0)
 			value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
-	} else if (!strcmp(buf, "n/a") || !strcmp(buf, "n/a\n")) {
+	} else if (sysfs_streq(buf, "n/a")) {
 		value = 0;
 	} else {
 		return -EINVAL;
@@ -285,9 +279,9 @@ static ssize_t pm_qos_latency_tolerance_store(struct device *dev,
 		if (value < 0)
 			return -EINVAL;
 	} else {
-		if (!strcmp(buf, "auto") || !strcmp(buf, "auto\n"))
+		if (sysfs_streq(buf, "auto"))
 			value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
-		else if (!strcmp(buf, "any") || !strcmp(buf, "any\n"))
+		else if (sysfs_streq(buf, "any"))
 			value = PM_QOS_LATENCY_ANY;
 		else
 			return -EINVAL;
@@ -342,20 +336,12 @@ static ssize_t
 wake_store(struct device * dev, struct device_attribute *attr,
 	const char * buf, size_t n)
 {
-	char *cp;
-	int len = n;
-
 	if (!device_can_wakeup(dev))
 		return -EINVAL;
 
-	cp = memchr(buf, '\n', n);
-	if (cp)
-		len = cp - buf;
-	if (len == sizeof _enabled - 1
-			&& strncmp(buf, _enabled, sizeof _enabled - 1) == 0)
+	if (sysfs_streq(buf, _enabled))
 		device_set_wakeup_enable(dev, 1);
-	else if (len == sizeof _disabled - 1
-			&& strncmp(buf, _disabled, sizeof _disabled - 1) == 0)
+	else if (sysfs_streq(buf, _disabled))
 		device_set_wakeup_enable(dev, 0);
 	else
 		return -EINVAL;
@@ -566,16 +552,9 @@ static ssize_t async_show(struct device *dev, struct device_attribute *attr,
 static ssize_t async_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t n)
 {
-	char *cp;
-	int len = n;
-
-	cp = memchr(buf, '\n', n);
-	if (cp)
-		len = cp - buf;
-	if (len == sizeof _enabled - 1 && strncmp(buf, _enabled, len) == 0)
+	if (sysfs_streq(buf, _enabled))
 		device_enable_async_suspend(dev);
-	else if (len == sizeof _disabled - 1 &&
-		 strncmp(buf, _disabled, len) == 0)
+	else if (sysfs_streq(buf, _disabled))
 		device_disable_async_suspend(dev);
 	else
 		return -EINVAL;
-- 
2.14.2

From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH] PM/CORE: Fix using sizeof without parenthesis in the sysfs.c
Date: Mon, 28 Jan 2013 16:31:49 +0800
Message-ID: <1359361909-28793-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19265 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754176Ab3A1IeI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Jan 2013 03:34:08 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

Kernel style uses parenthesis around sizeof. Commit 66c80b60
has already added such check in the scripts/checkpatch.pl.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/base/power/sysfs.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 50d16e3..f089b80 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -119,9 +119,9 @@ static ssize_t control_store(struct device * dev, struct device_attribute *attr,
 	if (cp)
 		len = cp - buf;
 	device_lock(dev);
-	if (len == sizeof ctrl_auto - 1 && strncmp(buf, ctrl_auto, len) == 0)
+	if (len == sizeof(ctrl_auto - 1) && strncmp(buf, ctrl_auto, len) == 0)
 		pm_runtime_allow(dev);
-	else if (len == sizeof ctrl_on - 1 && strncmp(buf, ctrl_on, len) == 0)
+	else if (len == sizeof(ctrl_on - 1) && strncmp(buf, ctrl_on, len) == 0)
 		pm_runtime_forbid(dev);
 	else
 		n = -EINVAL;
@@ -321,11 +321,11 @@ wake_store(struct device * dev, struct device_attribute *attr,
 	cp = memchr(buf, '\n', n);
 	if (cp)
 		len = cp - buf;
-	if (len == sizeof enabled - 1
-			&& strncmp(buf, enabled, sizeof enabled - 1) == 0)
+	if (len == sizeof(enabled - 1)
+			&& strncmp(buf, enabled, sizeof(enabled - 1)) == 0)
 		device_set_wakeup_enable(dev, 1);
-	else if (len == sizeof disabled - 1
-			&& strncmp(buf, disabled, sizeof disabled - 1) == 0)
+	else if (len == sizeof(disabled - 1)
+			&& strncmp(buf, disabled, sizeof(disabled - 1)) == 0)
 		device_set_wakeup_enable(dev, 0);
 	else
 		return -EINVAL;
@@ -546,9 +546,9 @@ static ssize_t async_store(struct device *dev, struct device_attribute *attr,
 	cp = memchr(buf, '\n', n);
 	if (cp)
 		len = cp - buf;
-	if (len == sizeof enabled - 1 && strncmp(buf, enabled, len) == 0)
+	if (len == sizeof(enabled - 1) && strncmp(buf, enabled, len) == 0)
 		device_enable_async_suspend(dev);
-	else if (len == sizeof disabled - 1 && strncmp(buf, disabled, len) == 0)
+	else if (len == sizeof(disabled - 1) && strncmp(buf, disabled, len) == 0)
 		device_disable_async_suspend(dev);
 	else
 		return -EINVAL;
-- 
1.7.10.4


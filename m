From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] PM / sysfs: Remove redundant 'else' keyword.
Date: Fri, 10 Nov 2017 20:28:08 +0200
Message-ID: <20171110182809.85953-2-andriy.shevchenko@linux.intel.com>
References: <20171110182809.85953-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8104 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751142AbdKJS2o (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Nov 2017 13:28:44 -0500
In-Reply-To: <20171110182809.85953-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is no need to use 'else' if in main branch 'return' is present.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/power/sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 662632ac5e0e..1bf5e163ef1f 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -216,7 +216,7 @@ static ssize_t pm_qos_resume_latency_show(struct device *dev,
 
 	if (value == 0)
 		return sprintf(buf, "n/a\n");
-	else if (value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
+	if (value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
 		value = 0;
 
 	return sprintf(buf, "%d\n", value);
@@ -261,7 +261,7 @@ static ssize_t pm_qos_latency_tolerance_show(struct device *dev,
 
 	if (value < 0)
 		return sprintf(buf, "auto\n");
-	else if (value == PM_QOS_LATENCY_ANY)
+	if (value == PM_QOS_LATENCY_ANY)
 		return sprintf(buf, "any\n");
 
 	return sprintf(buf, "%d\n", value);
@@ -527,11 +527,11 @@ static ssize_t rtpm_children_show(struct device *dev,
 static ssize_t rtpm_enabled_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	if ((dev->power.disable_depth) && (dev->power.runtime_auto == false))
+	if (dev->power.disable_depth && (dev->power.runtime_auto == false))
 		return sprintf(buf, "disabled & forbidden\n");
-	else if (dev->power.disable_depth)
+	if (dev->power.disable_depth)
 		return sprintf(buf, "disabled\n");
-	else if (dev->power.runtime_auto == false)
+	if (dev->power.runtime_auto == false)
 		return sprintf(buf, "forbidden\n");
 	return sprintf(buf, "enabled\n");
 }
-- 
2.14.2

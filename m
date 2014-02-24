From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2 1/8] PM / Runtime: Fetch runtime PM callbacks using a macro
Date: Mon, 24 Feb 2014 11:22:48 +0100
Message-ID: <1393237368-15500-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:62504 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbaBXKWy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2014 05:22:54 -0500
Received: by mail-wi0-f173.google.com with SMTP id bs8so2846216wib.6
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2014 02:22:52 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>

While fetching the proper runtime PM callback, we walk the hierarchy of
device's power domains, subsystems and drivers.

This is common for rpm_suspend(), rpm_idle() and rpm_resume(). Let's
clean up the code by using a macro that handles this.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Alessandro Rubini <rubini@unipv.it>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	Updated the macro to return a callback instead.
	Suggested by Josh Cartwright.

---
 drivers/base/power/runtime.c |   63 ++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 39 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 72e00e6..cc7d1ed 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -13,6 +13,27 @@
 #include <trace/events/rpm.h>
 #include "power.h"
 
+#define RPM_GET_CALLBACK(dev, cb)				\
+({								\
+	int (*__rpm_cb)(struct device *__d);			\
+								\
+	if (dev->pm_domain)					\
+		__rpm_cb = dev->pm_domain->ops.cb;		\
+	else if (dev->type && dev->type->pm)			\
+		__rpm_cb = dev->type->pm->cb;			\
+	else if (dev->class && dev->class->pm)			\
+		__rpm_cb = dev->class->pm->cb;			\
+	else if (dev->bus && dev->bus->pm)			\
+		__rpm_cb = dev->bus->pm->cb;			\
+	else							\
+		__rpm_cb = NULL;				\
+								\
+	if (!__rpm_cb && dev->driver && dev->driver->pm)	\
+		__rpm_cb = dev->driver->pm->cb;			\
+								\
+	__rpm_cb;						\
+})
+
 static int rpm_resume(struct device *dev, int rpmflags);
 static int rpm_suspend(struct device *dev, int rpmflags);
 
@@ -310,19 +331,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
 
 	dev->power.idle_notification = true;
 
-	if (dev->pm_domain)
-		callback = dev->pm_domain->ops.runtime_idle;
-	else if (dev->type && dev->type->pm)
-		callback = dev->type->pm->runtime_idle;
-	else if (dev->class && dev->class->pm)
-		callback = dev->class->pm->runtime_idle;
-	else if (dev->bus && dev->bus->pm)
-		callback = dev->bus->pm->runtime_idle;
-	else
-		callback = NULL;
-
-	if (!callback && dev->driver && dev->driver->pm)
-		callback = dev->driver->pm->runtime_idle;
+	callback = RPM_GET_CALLBACK(dev, runtime_idle);
 
 	if (callback)
 		retval = __rpm_callback(callback, dev);
@@ -492,19 +501,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
 	__update_runtime_status(dev, RPM_SUSPENDING);
 
-	if (dev->pm_domain)
-		callback = dev->pm_domain->ops.runtime_suspend;
-	else if (dev->type && dev->type->pm)
-		callback = dev->type->pm->runtime_suspend;
-	else if (dev->class && dev->class->pm)
-		callback = dev->class->pm->runtime_suspend;
-	else if (dev->bus && dev->bus->pm)
-		callback = dev->bus->pm->runtime_suspend;
-	else
-		callback = NULL;
-
-	if (!callback && dev->driver && dev->driver->pm)
-		callback = dev->driver->pm->runtime_suspend;
+	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
 
 	retval = rpm_callback(callback, dev);
 	if (retval)
@@ -724,19 +721,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 
 	__update_runtime_status(dev, RPM_RESUMING);
 
-	if (dev->pm_domain)
-		callback = dev->pm_domain->ops.runtime_resume;
-	else if (dev->type && dev->type->pm)
-		callback = dev->type->pm->runtime_resume;
-	else if (dev->class && dev->class->pm)
-		callback = dev->class->pm->runtime_resume;
-	else if (dev->bus && dev->bus->pm)
-		callback = dev->bus->pm->runtime_resume;
-	else
-		callback = NULL;
-
-	if (!callback && dev->driver && dev->driver->pm)
-		callback = dev->driver->pm->runtime_resume;
+	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
 	retval = rpm_callback(callback, dev);
 	if (retval) {
-- 
1.7.9.5


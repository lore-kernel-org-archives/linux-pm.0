From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V3 1/8] PM / Runtime: Fetch runtime PM callbacks using a macro
Date: Sat,  1 Mar 2014 11:56:04 +0100
Message-ID: <1393671371-2398-2-git-send-email-ulf.hansson@linaro.org>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:64939 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbaCAK4T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 1 Mar 2014 05:56:19 -0500
Received: by mail-la0-f50.google.com with SMTP id y1so3400228lam.37
        for <linux-pm@vger.kernel.org>; Sat, 01 Mar 2014 02:56:18 -0800 (PST)
In-Reply-To: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
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

Changes in v3:
	Added functions to return the callbacks, which will be the only users of
	the macro. According to comments from Alan Stern and Kevin Hilman.

Changes in v2:
	Updated the macro to return a callback instead.
	Suggested by Josh Cartwright.

---
 drivers/base/power/runtime.c |   78 +++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 72e00e6..ac495b1 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -13,6 +13,42 @@
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
+static int (*rpm_get_suspend_cb(struct device *dev))(struct device *)
+{
+	return RPM_GET_CALLBACK(dev, runtime_suspend);
+}
+
+static int (*rpm_get_resume_cb(struct device *dev))(struct device *)
+{
+	return RPM_GET_CALLBACK(dev, runtime_resume);
+}
+
+static int (*rpm_get_idle_cb(struct device *dev))(struct device *)
+{
+	return RPM_GET_CALLBACK(dev, runtime_idle);
+}
+
 static int rpm_resume(struct device *dev, int rpmflags);
 static int rpm_suspend(struct device *dev, int rpmflags);
 
@@ -310,19 +346,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
 
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
+	callback = rpm_get_idle_cb(dev);
 
 	if (callback)
 		retval = __rpm_callback(callback, dev);
@@ -492,19 +516,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
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
+	callback = rpm_get_suspend_cb(dev);
 
 	retval = rpm_callback(callback, dev);
 	if (retval)
@@ -724,19 +736,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 
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
+	callback = rpm_get_resume_cb(dev);
 
 	retval = rpm_callback(callback, dev);
 	if (retval) {
-- 
1.7.9.5


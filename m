From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/8] PM / Runtime: Fetch runtime PM callbacks using a macro
Date: Thu, 20 Feb 2014 16:31:13 +0100
Message-ID: <1392910280-12891-2-git-send-email-ulf.hansson@linaro.org>
References: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:47434 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706AbaBTPbc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2014 10:31:32 -0500
Received: by mail-wi0-f178.google.com with SMTP id cc10so1919753wib.17
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2014 07:31:30 -0800 (PST)
In-Reply-To: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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
 drivers/base/power/runtime.c |   59 ++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 72e00e6..dedbd64 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -13,6 +13,23 @@
 #include <trace/events/rpm.h>
 #include "power.h"
 
+#define RPM_GET_CALLBACK(dev, cb)				\
+({								\
+	if (dev->pm_domain)					\
+		callback = dev->pm_domain->ops.cb;		\
+	else if (dev->type && dev->type->pm)			\
+		callback = dev->type->pm->cb;			\
+	else if (dev->class && dev->class->pm)			\
+		callback = dev->class->pm->cb;			\
+	else if (dev->bus && dev->bus->pm)			\
+		callback = dev->bus->pm->cb;			\
+	else							\
+		callback = NULL;				\
+								\
+	if (!callback && dev->driver && dev->driver->pm)	\
+		callback = dev->driver->pm->cb;			\
+})
+
 static int rpm_resume(struct device *dev, int rpmflags);
 static int rpm_suspend(struct device *dev, int rpmflags);
 
@@ -310,19 +327,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
 
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
+	RPM_GET_CALLBACK(dev, runtime_idle);
 
 	if (callback)
 		retval = __rpm_callback(callback, dev);
@@ -492,19 +497,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
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
+	RPM_GET_CALLBACK(dev, runtime_suspend);
 
 	retval = rpm_callback(callback, dev);
 	if (retval)
@@ -724,19 +717,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 
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
+	RPM_GET_CALLBACK(dev, runtime_resume);
 
 	retval = rpm_callback(callback, dev);
 	if (retval) {
-- 
1.7.9.5


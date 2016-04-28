From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] PM / sleep: Remove unused `info' variable
Date: Thu, 28 Apr 2016 14:42:34 +0200
Message-ID: <1461847354-11486-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35282 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbcD1Mmn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2016 08:42:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Todd Brandt <todd.e.brandt@linux.intel.com>

From: Thierry Reding <treding@nvidia.com>

Commit 32e8d689dc12 ("PM / sleep: trace_device_pm_callback coverage in
dpm_prepare/complete") removed all users of this variable but forgot to
remove the variable itself.

Cc: Todd Brandt <todd.e.brandt@linux.intel.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/base/power/main.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 6e7c3ccea24b..c81667d4bb60 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1556,7 +1556,6 @@ int dpm_suspend(pm_message_t state)
 static int device_prepare(struct device *dev, pm_message_t state)
 {
 	int (*callback)(struct device *) = NULL;
-	char *info = NULL;
 	int ret = 0;
 
 	if (dev->power.syscore)
@@ -1579,24 +1578,17 @@ static int device_prepare(struct device *dev, pm_message_t state)
 		goto unlock;
 	}
 
-	if (dev->pm_domain) {
-		info = "preparing power domain ";
+	if (dev->pm_domain)
 		callback = dev->pm_domain->ops.prepare;
-	} else if (dev->type && dev->type->pm) {
-		info = "preparing type ";
+	else if (dev->type && dev->type->pm)
 		callback = dev->type->pm->prepare;
-	} else if (dev->class && dev->class->pm) {
-		info = "preparing class ";
+	else if (dev->class && dev->class->pm)
 		callback = dev->class->pm->prepare;
-	} else if (dev->bus && dev->bus->pm) {
-		info = "preparing bus ";
+	else if (dev->bus && dev->bus->pm)
 		callback = dev->bus->pm->prepare;
-	}
 
-	if (!callback && dev->driver && dev->driver->pm) {
-		info = "preparing driver ";
+	if (!callback && dev->driver && dev->driver->pm)
 		callback = dev->driver->pm->prepare;
-	}
 
 	if (callback)
 		ret = callback(dev);
-- 
2.8.0


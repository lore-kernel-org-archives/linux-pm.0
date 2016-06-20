From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] PM / runtime: print error when activating a child to unactive parent
Date: Mon, 20 Jun 2016 11:14:26 +0200
Message-ID: <1466414066-6131-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33284 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbcFTJOm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 05:14:42 -0400
Received: by mail-lf0-f49.google.com with SMTP id f6so33559133lfg.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2016 02:14:41 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

The code currently silently bails out with -EBUSY if you try to
activate a child to an inactive parent.

This typically happens when you have a runtime suspended parent
and runtime resume your child, but forgot to set .ignore_children
on the parent to true with pm_suspend_ignore_children(dev).

Silently ignoring this error is not good as it gives rise to
other strange behaviour like double-resume of devices after
silently bailing out of the .runtime_resume() callback.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/base/power/runtime.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index b74690418504..e7ee8293055b 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1045,10 +1045,14 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
 		 */
 		if (!parent->power.disable_depth
 		    && !parent->power.ignore_children
-		    && parent->power.runtime_status != RPM_ACTIVE)
+		    && parent->power.runtime_status != RPM_ACTIVE) {
+			dev_err(dev, "runtime PM trying to activate child device %s but parent (%s) is not active\n",
+				dev_name(dev),
+				dev_name(parent));
 			error = -EBUSY;
-		else if (dev->power.runtime_status == RPM_SUSPENDED)
+		} else if (dev->power.runtime_status == RPM_SUSPENDED) {
 			atomic_inc(&parent->power.child_count);
+		}
 
 		spin_unlock(&parent->power.lock);
 
-- 
2.4.11


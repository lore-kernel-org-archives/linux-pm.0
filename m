From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Runtime: Fix error path in pm_runtime_force_resume()
Date: Fri,  8 Apr 2016 13:10:23 +0200
Message-ID: <1460113823-32290-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33151 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756517AbcDHLK3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2016 07:10:29 -0400
Received: by mail-lb0-f174.google.com with SMTP id u8so67234445lbk.0
        for <linux-pm@vger.kernel.org>; Fri, 08 Apr 2016 04:10:28 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

As pm_runtime_set_active() may fail because the device's parent isn't
active, we can end up executing the ->runtime_resume() callback for the
device when it isn't allowed.

Fix this by invoking pm_runtime_set_active() before running the callback
and let's also deal with the error code.

Fixes: 37f204164dfb ("PM: Add pm_runtime_suspend|resume_force functions")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/runtime.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 4c70550..b746904 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1506,11 +1506,16 @@ int pm_runtime_force_resume(struct device *dev)
 		goto out;
 	}
 
-	ret = callback(dev);
+	ret = pm_runtime_set_active(dev);
 	if (ret)
 		goto out;
 
-	pm_runtime_set_active(dev);
+	ret = callback(dev);
+	if (ret) {
+		pm_runtime_set_suspended(dev);
+		goto out;
+	}
+
 	pm_runtime_mark_last_busy(dev);
 out:
 	pm_runtime_enable(dev);
-- 
1.9.1


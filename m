From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / runtime: Allow no callbacks in pm_runtime_force_suspend|resume()
Date: Tue, 16 Jan 2018 09:01:27 +0100
Message-ID: <1516089687-32003-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45735 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbeAPIBm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jan 2018 03:01:42 -0500
Received: by mail-lf0-f68.google.com with SMTP id y71so16219386lfd.12
        for <linux-pm@vger.kernel.org>; Tue, 16 Jan 2018 00:01:42 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>

The pm_runtime_force_suspend|resume() helpers currently requires the device
to at some level (PM domain, bus, etc), have the ->runtime_suspend|resume()
callbacks assigned for it, else -ENOSYS is returned as an error.

However, there are no reason for this requirement, so let's simply remove
it by allowing these callbacks to be NULL.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/runtime.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index cb5e48b..8bef3cb 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1640,7 +1640,7 @@ static bool pm_runtime_need_not_resume(struct device *dev)
 int pm_runtime_force_suspend(struct device *dev)
 {
 	int (*callback)(struct device *);
-	int ret = 0;
+	int ret;
 
 	pm_runtime_disable(dev);
 	if (pm_runtime_status_suspended(dev))
@@ -1648,12 +1648,7 @@ int pm_runtime_force_suspend(struct device *dev)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
 
-	if (!callback) {
-		ret = -ENOSYS;
-		goto err;
-	}
-
-	ret = callback(dev);
+	ret = callback ? callback(dev) : 0;
 	if (ret)
 		goto err;
 
@@ -1704,7 +1699,7 @@ int pm_runtime_force_resume(struct device *dev)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
-	ret = callback ? callback(dev) : -ENOSYS;
+	ret = callback ? callback(dev) : 0;
 	if (ret) {
 		pm_runtime_set_suspended(dev);
 		goto out;
-- 
2.7.4

From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V3 2/4] cpuidle: move driver checking within the lock section
Date: Wed, 31 Oct 2012 17:44:46 +0100
Message-ID: <1351701888-19963-3-git-send-email-daniel.lezcano@linaro.org>
References: <1351701888-19963-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35944 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab2JaQpB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 31 Oct 2012 12:45:01 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so767932bkc.19
        for <linux-pm@vger.kernel.org>; Wed, 31 Oct 2012 09:45:01 -0700 (PDT)
In-Reply-To: <1351701888-19963-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com, linaro-dev@lists.linaro.org

The code is racy and the check with cpuidle_curr_driver should be
done under the lock.

I don't find a path in the different drivers where that could happen
because the arch specific drivers are written in such way it is not
possible to register a driver while it is unregistered, except maybe
in a very improbable case when "intel_idle" and "processor_idle" are
competing. One could unregister a driver, while the other one is
registering.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/cpuidle/driver.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 39ba8e1..3e59075 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -85,17 +85,9 @@ EXPORT_SYMBOL_GPL(cpuidle_get_driver);
  */
 void cpuidle_unregister_driver(struct cpuidle_driver *drv)
 {
-	if (drv != cpuidle_curr_driver) {
-		WARN(1, "invalid cpuidle_unregister_driver(%s)\n",
-			drv->name);
-		return;
-	}
-
 	spin_lock(&cpuidle_driver_lock);
-
-	if (!WARN_ON(drv->refcnt > 0))
+	if (drv == cpuidle_curr_driver && !WARN_ON(drv->refcnt > 0))
 		cpuidle_curr_driver = NULL;
-
 	spin_unlock(&cpuidle_driver_lock);
 }
 EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
-- 
1.7.5.4


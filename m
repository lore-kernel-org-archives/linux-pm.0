From: Daniel Fu <danifu@nvidia.com>
Subject: [PATCH] cpuidle: Check cpuidle driver before add refcount
Date: Fri, 30 Aug 2013 19:48:22 +0800
Message-ID: <1377863302-22465-1-git-send-email-danifu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2887 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371Ab3H3Lpv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Aug 2013 07:45:51 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, joqiu@nvidia.com, Daniel Fu <danifu@nvidia.com>

If the current CPU has no cpuidle driver, drv will be NULL.
Check if we get drv successfully before add refount
to prevent Kernel panic.

Signed-off-by: Daniel Fu <danifu@nvidia.com>
---
 drivers/cpuidle/driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 3ac499d..6e11701 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -331,7 +331,8 @@ struct cpuidle_driver *cpuidle_driver_ref(void)
 	spin_lock(&cpuidle_driver_lock);
 
 	drv = cpuidle_get_driver();
-	drv->refcnt++;
+	if (drv)
+		drv->refcnt++;
 
 	spin_unlock(&cpuidle_driver_lock);
 	return drv;
-- 
1.8.1.5


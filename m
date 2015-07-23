From: Xunlei Pang <xlpang@126.com>
Subject: [PATCH] cpuidle/coupled: Init cpuidle_device::safe_state_index
Date: Thu, 23 Jul 2015 20:31:21 +0800
Message-ID: <1437654681-20893-1-git-send-email-xlpang@126.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m50-112.126.com ([123.125.50.112]:33937 "EHLO m50-112.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025AbbGWMdz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 23 Jul 2015 08:33:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Xunlei Pang <pang.xunlei@zte.com.cn>

From: Xunlei Pang <pang.xunlei@zte.com.cn>

cpuidle_device::safe_state_index need to be initialized before use,
so assign the driver's safe_state_index to it.

Signed-off-by: Xunlei Pang <pang.xunlei@zte.com.cn>
---
 drivers/cpuidle/cpuidle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index e8e2775..ed5c8efe 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -585,6 +585,8 @@ int cpuidle_register(struct cpuidle_driver *drv,
 		 */
 		if (coupled_cpus)
 			device->coupled_cpus = *coupled_cpus;
+
+		device->safe_state_index = drv->safe_state_index;
 #endif
 		ret = cpuidle_register_device(device);
 		if (!ret)
-- 
1.9.1



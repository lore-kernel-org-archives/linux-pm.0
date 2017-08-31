From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] thermal : Remove const to make same prototype
Date: Thu, 31 Aug 2017 11:30:45 +0530
Message-ID: <29cf6375f8b1c667de1387e4e865aaa288a125ac.1504159021.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33986 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbdHaGBN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2017 02:01:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, hch@lst.de
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Here, prototype of thermal_zone_device_register is not matching
with static inline thermal_zone_device_register. One is using
const thermal_zone_params. Other is using non-const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 include/linux/thermal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index dab11f9..8ba77ff 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -487,7 +487,7 @@ static inline int power_actor_set_power(struct thermal_cooling_device *cdev,
 static inline struct thermal_zone_device *thermal_zone_device_register(
 	const char *type, int trips, int mask, void *devdata,
 	struct thermal_zone_device_ops *ops,
-	const struct thermal_zone_params *tzp,
+	struct thermal_zone_params *tzp,
 	int passive_delay, int polling_delay)
 { return ERR_PTR(-ENODEV); }
 static inline void thermal_zone_device_unregister(
-- 
1.9.1

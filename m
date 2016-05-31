From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 47/48] thermal: core: use kzalloc(sizeof(*ptr),...)
Date: Mon, 30 May 2016 23:18:54 -0700
Message-ID: <1464675535-2433-48-git-send-email-edubezval@gmail.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36757 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756001AbcEaGUv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 02:20:51 -0400
In-Reply-To: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>

As a safety check, this patch changes thermal
core to check for pointer content size, instead of type size,
while allocating memory.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b3fa47e..792aab7 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -667,8 +667,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	if (lower > upper || upper > max_state)
 		return -EINVAL;
 
-	dev =
-	    kzalloc(sizeof(struct thermal_instance), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 	dev->tz = tz;
@@ -910,7 +909,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	    !ops->set_cur_state)
 		return ERR_PTR(-EINVAL);
 
-	cdev = kzalloc(sizeof(struct thermal_cooling_device), GFP_KERNEL);
+	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
 
@@ -1155,7 +1154,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
 		return ERR_PTR(-EINVAL);
 
-	tz = kzalloc(sizeof(struct thermal_zone_device), GFP_KERNEL);
+	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
 	if (!tz)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.1.4


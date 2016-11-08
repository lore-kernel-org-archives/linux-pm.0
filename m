From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 47/49] thermal: core: use kzalloc(sizeof(*ptr),...)
Date: Mon,  7 Nov 2016 21:09:25 -0800
Message-ID: <1478581767-7009-48-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34989 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753302AbcKHGGD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 01:06:03 -0500
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

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
index 2db21e5..4f93844 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -674,8 +674,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	if (lower > upper || upper > max_state)
 		return -EINVAL;
 
-	dev =
-	    kzalloc(sizeof(struct thermal_instance), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 	dev->tz = tz;
@@ -917,7 +916,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	    !ops->set_cur_state)
 		return ERR_PTR(-EINVAL);
 
-	cdev = kzalloc(sizeof(struct thermal_cooling_device), GFP_KERNEL);
+	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
 
@@ -1163,7 +1162,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
 		return ERR_PTR(-EINVAL);
 
-	tz = kzalloc(sizeof(struct thermal_zone_device), GFP_KERNEL);
+	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
 	if (!tz)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.1.4


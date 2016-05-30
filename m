From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 47/48] thermal: core: use kzalloc(sizeof(*ptr),...)
Date: Mon, 30 May 2016 15:16:23 -0700
Message-ID: <1464646584-14322-48-git-send-email-edubezval@gmail.com>
References: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

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

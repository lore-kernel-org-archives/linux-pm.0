From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 23/31] thermal: core: move __unbind() helper to where it is used
Date: Tue,  3 May 2016 23:02:37 -0700
Message-ID: <1462341765-13268-24-git-send-email-edubezval@gmail.com>
References: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Simply moving the helper to closer where it is actually used.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 480db91..e1515f3 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -319,16 +319,6 @@ static void __bind(struct thermal_zone_device *tz, int mask,
 	}
 }
 
-static void __unbind(struct thermal_zone_device *tz, int mask,
-			struct thermal_cooling_device *cdev)
-{
-	int i;
-
-	for (i = 0; i < tz->trips; i++)
-		if (mask & (1 << i))
-			thermal_zone_unbind_cooling_device(tz, i, cdev);
-}
-
 static void bind_cdev(struct thermal_cooling_device *cdev)
 {
 	int i, ret;
@@ -1012,6 +1002,16 @@ thermal_of_cooling_device_register(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
 
+static void __unbind(struct thermal_zone_device *tz, int mask,
+			struct thermal_cooling_device *cdev)
+{
+	int i;
+
+	for (i = 0; i < tz->trips; i++)
+		if (mask & (1 << i))
+			thermal_zone_unbind_cooling_device(tz, i, cdev);
+}
+
 /**
  * thermal_cooling_device_unregister - removes the registered thermal cooling device
  * @cdev:	the thermal cooling device to remove.
-- 
2.1.4

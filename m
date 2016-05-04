From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 31/31] thermal: core: add a comment describing the device management section
Date: Tue,  3 May 2016 23:02:45 -0700
Message-ID: <1462341765-13268-32-git-send-email-edubezval@gmail.com>
References: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

comment describing the section with function to handle
registration, unregistration, binding, and unbinding of
thermal devices.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b6a94fa..651467e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -580,8 +580,15 @@ void thermal_zone_device_passive_update(struct thermal_zone_device *tz,
 	thermal_zone_device_update(tz);
 }
 
-/* Device management */
-
+/*
+ * Device management section: cooling devices, zones devices, and binding
+ *
+ * Set of functions provided by the thermal core for:
+ * - cooling devices lifecycle: registration, unregistration,
+ *   				binding, and unbinding.
+ * - thermal zone devices lifecycle: registration, unregistration,
+ *   				     binding, and unbinding.
+ */
 static int get_idr(struct idr *idr, struct mutex *lock, int *id)
 {
 	int ret;
-- 
2.1.4

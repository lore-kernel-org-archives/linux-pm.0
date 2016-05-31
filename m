From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 39/48] thermal: core: add a comment describing the device management section
Date: Mon, 30 May 2016 23:18:46 -0700
Message-ID: <1464675535-2433-40-git-send-email-edubezval@gmail.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>
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
index 5ce6504..98176aa 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -581,8 +581,15 @@ void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
 	mutex_unlock(&thermal_list_lock);
 }
 
-/* Device management */
-
+/*
+ * Device management section: cooling devices, zones devices, and binding
+ *
+ * Set of functions provided by the thermal core for:
+ * - cooling devices lifecycle: registration, unregistration,
+ *				binding, and unbinding.
+ * - thermal zone devices lifecycle: registration, unregistration,
+ *				     binding, and unbinding.
+ */
 static int get_idr(struct idr *idr, struct mutex *lock, int *id)
 {
 	int ret;
-- 
2.1.4

From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 39/49] thermal: core: add a comment describing the device management section
Date: Mon,  7 Nov 2016 21:09:17 -0800
Message-ID: <1478581767-7009-40-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
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
index e9e6bb9..01b1a4e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -588,8 +588,15 @@ void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
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

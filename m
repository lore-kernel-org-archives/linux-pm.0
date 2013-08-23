From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 2/5] drivers: thermal: parent virtual hwmon with thermal zone
Date: Fri, 23 Aug 2013 18:03:13 -0400
Message-ID: <1377295396-17289-3-git-send-email-eduardo.valentin@ti.com>
References: <1377295396-17289-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377295396-17289-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, rui.zhang@intel.com
Cc: linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

When  creating virtual hwmon devices based out of thermal
zone devices, the virtual devices won't have parents.

This patch changes the code so that the parent of virtual
hwmon devices is the thermal zone device that they are
based of.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/thermal_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index fdb0719..eeef0e2 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -159,7 +159,7 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 
 	INIT_LIST_HEAD(&hwmon->tz_list);
 	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
-	hwmon->device = hwmon_device_register(NULL);
+	hwmon->device = hwmon_device_register(&tz->device);
 	if (IS_ERR(hwmon->device)) {
 		result = PTR_ERR(hwmon->device);
 		goto free_mem;
-- 
1.8.2.1.342.gfa7285d

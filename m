From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 19/48] thermal: core: move to_thermal_zone() macro to header file
Date: Mon, 30 May 2016 15:15:55 -0700
Message-ID: <1464646584-14322-20-git-send-email-edubezval@gmail.com>
References: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Simply making this macro available to other thermal core
files.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 3 ---
 drivers/thermal/thermal_core.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d3f7124..cfa74e6 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -743,9 +743,6 @@ int thermal_build_list_of_policies(char *buf)
 
 /* sys I/F for thermal zone */
 
-#define to_thermal_zone(_dev) \
-	container_of(_dev, struct thermal_zone_device, device)
-
 static ssize_t
 type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 8994d2a..097abee 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -54,6 +54,9 @@ struct thermal_instance {
 	unsigned int weight; /* The weight of the cooling device */
 };
 
+#define to_thermal_zone(_dev) \
+	container_of(_dev, struct thermal_zone_device, device)
+
 int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
 void thermal_zone_device_rebind_exception(struct thermal_zone_device *,
-- 
2.1.4

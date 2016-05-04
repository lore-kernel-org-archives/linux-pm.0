From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 16/31] thermal: core: move to_thermal_zone() macro to header file
Date: Tue,  3 May 2016 23:02:30 -0700
Message-ID: <1462341765-13268-17-git-send-email-edubezval@gmail.com>
References: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Simply making this macro available to other thermal core
files.

Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 3 ---
 drivers/thermal/thermal_core.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 93da7d9..8506d17 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -742,9 +742,6 @@ int thermal_build_list_of_policies(char *buf)
 
 /* sys I/F for thermal zone */
 
-#define to_thermal_zone(_dev) \
-	container_of(_dev, struct thermal_zone_device, device)
-
 static ssize_t
 type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index b80847c..38d977f 100644
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
 void thermal_zone_device_passive_update(struct thermal_zone_device *, int);
-- 
2.1.4

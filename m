From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 23/40] thermal: core: move to_cooling_device macro to header file
Date: Mon, 30 May 2016 14:27:42 -0700
Message-ID: <1464643679-2733-24-git-send-email-edubezval@gmail.com>
References: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Make the to_cooling_device() macro available across
files in thermal core.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 3 ---
 drivers/thermal/thermal_core.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9778ce5..a81faef 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -742,9 +742,6 @@ int thermal_build_list_of_policies(char *buf)
 }
 
 /* sys I/F for cooling device */
-#define to_cooling_device(_dev)	\
-	container_of(_dev, struct thermal_cooling_device, device)
-
 static ssize_t
 thermal_cooling_device_type_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index bd88693..5619243 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -57,6 +57,9 @@ struct thermal_instance {
 #define to_thermal_zone(_dev) \
 	container_of(_dev, struct thermal_zone_device, device)
 
+#define to_cooling_device(_dev)	\
+	container_of(_dev, struct thermal_cooling_device, device)
+
 int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
 void thermal_zone_device_rebind_exception(struct thermal_zone_device *,
-- 
2.1.4

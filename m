From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH 7/8] Thermal: Make PER_ZONE values configurable
Date: Tue, 18 Dec 2012 14:59:36 +0530
Message-ID: <1355822977-4804-8-git-send-email-durgadoss.r@intel.com>
References: <1355822977-4804-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355822977-4804-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, hongbo.zhang@linaro.org, wni@nvidia.com, Durgadoss R <durgadoss.r@intel.com>
List-Id: linux-pm@vger.kernel.org

This patch makes MAX_SENSORS_PER_ZONE and
MAX_CDEVS_PER_ZONE values configurable. The
default value is 1, and range is 1-12.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
No great reason for using 12.
---
 drivers/thermal/Kconfig |   14 ++++++++++++++
 include/linux/thermal.h |    6 +++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d96da07..c5ba3340 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -15,6 +15,20 @@ menuconfig THERMAL
 
 if THERMAL
 
+config THERMAL_MAX_SENSORS_PER_ZONE
+	int "Maximum number of sensors allowed per thermal zone"
+	default 1
+	range 1 12
+	---help---
+	  Specify the number of sensors allowed per zone
+
+config THERMAL_MAX_CDEVS_PER_ZONE
+	int "Maximum number of cooling devices allowed per thermal zone"
+	default 1
+	range 1 12
+	---help---
+	  Specify the number of cooling devices allowed per zone
+
 config THERMAL_HWMON
 	bool
 	depends on HWMON=y || HWMON=THERMAL
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 581dc87..7b0359b 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -49,9 +49,9 @@
 /* Default Thermal Governor: Does Linear Throttling */
 #define DEFAULT_THERMAL_GOVERNOR	"step_wise"
 
-#define MAX_SENSORS_PER_ZONE		5
-
-#define MAX_CDEVS_PER_ZONE		5
+/* Maximum number of sensors/cdevs per zone, defined through Kconfig */
+#define MAX_SENSORS_PER_ZONE	CONFIG_THERMAL_MAX_SENSORS_PER_ZONE
+#define MAX_CDEVS_PER_ZONE	CONFIG_THERMAL_MAX_CDEVS_PER_ZONE
 
 /* If we map each sensor with every possible cdev for a zone */
 #define MAX_MAPS_PER_ZONE	(MAX_SENSORS_PER_ZONE * MAX_CDEVS_PER_ZONE)
-- 
1.7.9.5

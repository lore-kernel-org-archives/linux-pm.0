From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v3 2/2] drivers: thermal: Move QCOM_SPMI_TEMP_ALARM into the qcom subdir
Date: Wed, 28 Nov 2018 00:28:41 +0530
Message-ID: <e526504923c569e575b8916f77b5c207679316e9.1543343156.git.amit.kucheria@linaro.org>
References: <cover.1543343156.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1543343156.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1543343156.git.amit.kucheria@linaro.org>
References: <cover.1543343156.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

This cleans up the directory a bit allowing just one place to look for
thermal related drivers for QCOM platforms instead of being scattered in
the root directory and the qcom/ subdirectory. Compile-tested with
ARCH=arm64 defconfig and the driver explicitly enabled with menuconfig.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig                           | 11 -----------
 drivers/thermal/Makefile                          |  1 -
 drivers/thermal/qcom/Kconfig                      | 11 +++++++++++
 drivers/thermal/qcom/Makefile                     |  1 +
 drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c |  0
 5 files changed, 12 insertions(+), 12 deletions(-)
 rename drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c (100%)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 772ab9dadda7..344f6459862b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -374,17 +374,6 @@ config TANGO_THERMAL
 
 source "drivers/thermal/tegra/Kconfig"
 
-config QCOM_SPMI_TEMP_ALARM
-	tristate "Qualcomm SPMI PMIC Temperature Alarm"
-	depends on OF && SPMI && IIO
-	select REGMAP_SPMI
-	help
-	  This enables a thermal sysfs driver for Qualcomm plug-and-play (QPNP)
-	  PMIC devices. It shows up in sysfs as a thermal sensor with multiple
-	  trip points. The temperature reported by the thermal sensor reflects the
-	  real time die temperature if an ADC is present or an estimate of the
-	  temperature based upon the over temperature stage value.
-
 config GENERIC_ADC_THERMAL
 	tristate "Generic ADC based thermal sensor"
 	depends on IIO
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 031f61e7dfe8..415361685480 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -29,7 +29,6 @@ thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
 # platform thermal drivers
 obj-y				+= broadcom/
-obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
 obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
 obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index be32e5abce3c..cdb455ffd575 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -9,3 +9,14 @@ config QCOM_TSENS
 	  thermal zone device via the mode file results in disabling the sensor.
 	  Also able to set threshold temperature for both hot and cold and update
 	  when a threshold is reached.
+
+config QCOM_SPMI_TEMP_ALARM
+	tristate "Qualcomm SPMI PMIC Temperature Alarm"
+	depends on OF && SPMI && IIO
+	select REGMAP_SPMI
+	help
+	  This enables a thermal sysfs driver for Qualcomm plug-and-play (QPNP)
+	  PMIC devices. It shows up in sysfs as a thermal sensor with multiple
+	  trip points. The temperature reported by the thermal sensor reflects the
+	  real time die temperature if an ADC is present or an estimate of the
+	  temperature based upon the over temperature stage value.
diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index a821929ede0b..717a08600bb5 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
 qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-v2.o
+obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
similarity index 100%
rename from drivers/thermal/qcom-spmi-temp-alarm.c
rename to drivers/thermal/qcom/qcom-spmi-temp-alarm.c
-- 
2.17.1

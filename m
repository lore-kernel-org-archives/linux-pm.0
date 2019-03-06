From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH] drivers: thermal: Kconfig: pedantic cleanups
Date: Wed,  6 Mar 2019 19:52:22 +0100
Message-ID: <1551898342-19308-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/thermal/st/Kconfig    | 22 +++++++++++-----------
 drivers/thermal/tegra/Kconfig |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/st/Kconfig b/drivers/thermal/st/Kconfig
index b80f9a9..d8b1a45 100644
--- a/drivers/thermal/st/Kconfig
+++ b/drivers/thermal/st/Kconfig
@@ -3,9 +3,9 @@
 #
 
 config ST_THERMAL
-       tristate "Thermal sensors on STMicroelectronics STi series of SoCs"
-       help
-         Support for thermal sensors on STMicroelectronics STi series of SoCs.
+	tristate "Thermal sensors on STMicroelectronics STi series of SoCs"
+	help
+	  Support for thermal sensors on STMicroelectronics STi series of SoCs.
 
 config ST_THERMAL_SYSCFG
 	select ST_THERMAL
@@ -16,11 +16,11 @@ config ST_THERMAL_MEMMAP
 	tristate "STi series memory mapped access based thermal sensors"
 
 config STM32_THERMAL
-       tristate "Thermal framework support on STMicroelectronics STM32 series of SoCs"
-       depends on MACH_STM32MP157
-       default y
-       help
-	Support for thermal framework on STMicroelectronics STM32 series of
-	SoCs. This thermal driver allows to access to general thermal framework
-	functionalities and to acces to SoC sensor functionalities. This
-	configuration is fully dependent of MACH_STM32MP157.
+	tristate "Thermal framework support on STMicroelectronics STM32 series of SoCs"
+	depends on MACH_STM32MP157
+	default y
+	help
+	  Support for thermal framework on STMicroelectronics STM32 series of
+	  SoCs. This thermal driver allows to access to general thermal framework
+	  functionalities and to acces to SoC sensor functionalities. This
+	  configuration is fully dependent of MACH_STM32MP157.
diff --git a/drivers/thermal/tegra/Kconfig b/drivers/thermal/tegra/Kconfig
index f8740f7..fc0b33b 100644
--- a/drivers/thermal/tegra/Kconfig
+++ b/drivers/thermal/tegra/Kconfig
@@ -14,7 +14,7 @@ config TEGRA_BPMP_THERMAL
 	tristate "Tegra BPMP thermal sensing"
 	depends on TEGRA_BPMP || COMPILE_TEST
 	help
-	 Enable this option for support for sensing system temperature of NVIDIA
-	 Tegra systems-on-chip with the BPMP coprocessor (Tegra186).
+	  Enable this option for support for sensing system temperature of NVIDIA
+	  Tegra systems-on-chip with the BPMP coprocessor (Tegra186).
 
 endmenu
-- 
1.9.1

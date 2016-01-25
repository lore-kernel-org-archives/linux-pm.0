From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] thermal: allow u8500-thermal driver to be a module
Date: Mon, 25 Jan 2016 17:44:12 +0100
Message-ID: <1453740264-1972562-4-git-send-email-arnd@arndb.de>
References: <1453740264-1972562-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453740264-1972562-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, spear-devel@list.st.com, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When the thermal subsystem is a loadable module, the u8500 driver
fails to build:

drivers/thermal/built-in.o: In function `db8500_thermal_probe':
db8500_thermal.c:(.text+0x96c): undefined reference to `thermal_zone_device_register'
drivers/thermal/built-in.o: In function `db8500_thermal_work':
db8500_thermal.c:(.text+0xab4): undefined reference to `thermal_zone_device_update'

This changes the symbol to a tristate, so Kconfig can track the
dependency correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/db8500-prcmu.c | 3 +++
 drivers/thermal/Kconfig    | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 2f4a1279b094..c0a86aeb1733 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2045,6 +2045,7 @@ int db8500_prcmu_config_hotmon(u8 low, u8 high)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(db8500_prcmu_config_hotmon);
 
 static int config_hot_period(u16 val)
 {
@@ -2071,11 +2072,13 @@ int db8500_prcmu_start_temp_sense(u16 cycles32k)
 
 	return config_hot_period(cycles32k);
 }
+EXPORT_SYMBOL_GPL(db8500_prcmu_start_temp_sense);
 
 int db8500_prcmu_stop_temp_sense(void)
 {
 	return config_hot_period(0xFFFF);
 }
+EXPORT_SYMBOL_GPL(db8500_prcmu_stop_temp_sense);
 
 static int prcmu_a9wdog(u8 cmd, u8 d0, u8 d1, u8 d2, u8 d3)
 {
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 0852fd028dc9..7c92c09be213 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -237,8 +237,8 @@ config DOVE_THERMAL
 	  framework.
 
 config DB8500_THERMAL
-	bool "DB8500 thermal management"
-	depends on ARCH_U8500
+	tristate "DB8500 thermal management"
+	depends on MFD_DB8500_PRCMU
 	default y
 	help
 	  Adds DB8500 thermal management implementation according to the thermal
-- 
2.7.0

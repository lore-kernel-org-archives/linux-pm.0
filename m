From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/3] thermal: allow spear-thermal driver to be a module
Date: Mon, 25 Jan 2016 17:44:11 +0100
Message-ID: <1453740264-1972562-3-git-send-email-arnd@arndb.de>
References: <1453740264-1972562-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453740264-1972562-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, spear-devel@list.st.com, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When the thermal subsystem is a loadable module, the spear driver
fails to build:

drivers/thermal/built-in.o: In function `spear_thermal_exit':
spear_thermal.c:(.text+0xf8): undefined reference to `thermal_zone_device_unregister'
drivers/thermal/built-in.o: In function `spear_thermal_probe':
spear_thermal.c:(.text+0x230): undefined reference to `thermal_zone_device_register'

This changes the symbol to a tristate, so Kconfig can track the
dependency correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 8cc4ac64a91c..0852fd028dc9 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -195,7 +195,7 @@ config IMX_THERMAL
 	  passive trip is crossed.
 
 config SPEAR_THERMAL
-	bool "SPEAr thermal sensor driver"
+	tristate "SPEAr thermal sensor driver"
 	depends on PLAT_SPEAR || COMPILE_TEST
 	depends on OF
 	help
-- 
2.7.0

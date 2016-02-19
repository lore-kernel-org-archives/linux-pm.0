From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] thermal: mediatek: add missing dependencies
Date: Fri, 19 Feb 2016 23:36:06 +0100
Message-ID: <1455921381-1881305-1-git-send-email-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:58785 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757484AbcBSWhC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2016 17:37:02 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org

The newly added mtk_thermal driver uses the generic reset
and nvmem infrastructure, but lacks a dependency that enforces
them from actually being present:

drivers/thermal/mtk_thermal.c: In function 'mtk_thermal_probe':
drivers/thermal/mtk_thermal.c:560:8: error: implicit declaration of function 'device_reset' [-Werror=implicit-function-declaration]
drivers/thermal/built-in.o: In function `mtk_thermal_probe':
mtk_thermal.c:(.text+0x7fb0): undefined reference to `nvmem_cell_get'
mtk_thermal.c:(.text+0x7fd8): undefined reference to `nvmem_cell_read'
mtk_thermal.c:(.text+0x7fe4): undefined reference to `nvmem_cell_put'

Without CONFIG_THERMAL, the driver cannot build, so this needs
to be a hard dependency.

For CONFIG_NVMEM, the header file allows building the driver even
when the subsystem is disabled, but we get the link error above
when nvmem is built as a module and the thermal driver is built-in,
so we can allow compile-testing when NVMEM is completely disabled,
but otherwise require the dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thermal/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 5e7c97a3f1d8..75d164341f0d 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -368,6 +368,8 @@ config INTEL_PCH_THERMAL
 config MTK_THERMAL
 	tristate "Temperature sensor driver for mediatek SoCs"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on NVMEM || (!NVMEM && COMPILE_TEST)
+	depends on RESET_CONTROLLER
 	default y
 	help
 	  Enable this option if you want to have support for thermal management
-- 
2.7.0


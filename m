From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] thermal: imx: add NVMEM dependency
Date: Mon, 18 Sep 2017 22:48:16 +0200
Message-ID: <20170918204825.159177-1-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:53547 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdIRUsk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2017 16:48:40 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The driver now fails to link into vmlinux when CONFIG_NVMEM is a loadable
module:

drivers/thermal/imx_thermal.o: In function `imx_thermal_probe':
imx_thermal.c:(.text+0x360): undefined reference to `nvmem_cell_read_u32'
imx_thermal.c:(.text+0x360): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `nvmem_cell_read_u32'
imx_thermal.c:(.text+0x388): undefined reference to `nvmem_cell_read_u32'
imx_thermal.c:(.text+0x388): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `nvmem_cell_read_u32'

This adds a Kconfig dependency to force it to be a module as well
when its dependency is loadable.

Fixes: 7fe5ba04fcdc ("thermal: imx: Add support for reading OCOTP through nvmem")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 07002df4f83a..cb14f1ec5953 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -206,6 +206,7 @@ config HISI_THERMAL
 config IMX_THERMAL
 	tristate "Temperature sensor driver for Freescale i.MX SoCs"
 	depends on (ARCH_MXC && CPU_THERMAL) || COMPILE_TEST
+	depends on NVMEM || !NVMEM
 	depends on MFD_SYSCON
 	depends on OF
 	help
-- 
2.9.0

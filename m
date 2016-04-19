From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] thermal: fix mtk_thermal build dependency
Date: Tue, 19 Apr 2016 09:44:23 -0700
Message-ID: <57166067.4090009@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40211 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822AbcDSQo1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2016 12:44:27 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Hanyi Wu <hanyi.wu@mediatek.com>

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors when MTK_THERMAL=y and NVMEM=m by preventing that
Kconfig combination.

drivers/built-in.o: In function `mtk_thermal_probe':
mtk_thermal.c:(.text+0xffa8f): undefined reference to `nvmem_cell_get'
mtk_thermal.c:(.text+0xffabe): undefined reference to `nvmem_cell_read'
mtk_thermal.c:(.text+0xffac9): undefined reference to `nvmem_cell_put'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: <linux-pm@vger.kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Hanyi Wu <hanyi.wu@mediatek.com>
---
 drivers/thermal/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20160419.orig/drivers/thermal/Kconfig
+++ linux-next-20160419/drivers/thermal/Kconfig
@@ -366,6 +366,7 @@ config MTK_THERMAL
 	tristate "Temperature sensor driver for mediatek SoCs"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on HAS_IOMEM
+	depends on NVMEM || NVMEM=n
 	default y
 	help
 	  Enable this option if you want to have support for thermal management

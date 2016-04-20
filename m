From: Eduardo Valentin <edubezval@gmail.com>
Subject: patch "thermal: fix mtk_thermal build dependency" added to thermal-soc tree
Date: Wed, 20 Apr 2016 16:26:21 -0700
Message-ID: <14611947813473@besouro>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36841 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbcDTX1c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 19:27:32 -0400
Received: by mail-pf0-f172.google.com with SMTP id e128so22915409pfe.3
        for <linux-pm@vger.kernel.org>; Wed, 20 Apr 2016 16:27:32 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rdunlap@infradead.org, edubezval@gmail.com, hanyi.wu@mediatek.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de
Cc: Zhang Rui <rui.zhang@intel.com>


This is a simple automated notification to let you know that 
I've just added the patch titled

    thermal: fix mtk_thermal build dependency

to my thermal-soc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
in the fixes branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.

All the best,

Eduardo Valentin

----------
>From 62e14f6fd383f756ff3fe5f6fb7aa5b546bb47e3 Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 19 Apr 2016 09:44:23 -0700
Subject: thermal: fix mtk_thermal build dependency

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
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index c37eedc..5c77110 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -376,6 +376,7 @@ config MTK_THERMAL
 	tristate "Temperature sensor driver for mediatek SoCs"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on HAS_IOMEM
+	depends on NVMEM || NVMEM=n
 	default y
 	help
 	  Enable this option if you want to have support for thermal management
-- 
2.1.4



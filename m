From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] thermal: minor mtk_thermal.c cleanups
Date: Tue, 19 Apr 2016 16:45:01 -0700
Message-ID: <5716C2FD.3080409@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:53976 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbcDSXpJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2016 19:45:09 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Hanyi Wu <hanyi.wu@mediatek.com>

From: Randy Dunlap <rdunlap@infradead.org>

Trivial cleanups:
- delete one duplicate #include
- end email address with closing '>'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Hanyi Wu <hanyi.wu@mediatek.com>
---
 drivers/thermal/mtk_thermal.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-next-20160419.orig/drivers/thermal/mtk_thermal.c
+++ linux-next-20160419/drivers/thermal/mtk_thermal.c
@@ -27,7 +27,6 @@
 #include <linux/thermal.h>
 #include <linux/reset.h>
 #include <linux/types.h>
-#include <linux/nvmem-consumer.h>
 
 /* AUXADC Registers */
 #define AUXADC_CON0_V		0x000
@@ -611,7 +610,7 @@ static struct platform_driver mtk_therma
 
 module_platform_driver(mtk_thermal_driver);
 
-MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de");
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
 MODULE_AUTHOR("Hanyi Wu <hanyi.wu@mediatek.com>");
 MODULE_DESCRIPTION("Mediatek thermal driver");
 MODULE_LICENSE("GPL v2");

From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/1] thermal: mtk: allow compile testing on UM
Date: Tue,  8 Mar 2016 13:39:41 -0800
Message-ID: <1457473181-10631-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36296 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbcCHVjp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2016 16:39:45 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Following the fix on thermal Kconfig, this
patch adds dependency on HAS_IOMEM so driver
properly compile test on UM arch.

Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
Krzysztof,

I had to split your patch into two, because mtk driver
is only in my for-linus branch. I want to send your patch
as a fix for the current kernel. This is why you are seeing
this patch now.

This patch has been added to my linus branch.

BR,
Eduardo
---
 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 5e7c97a..462d014 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -368,6 +368,7 @@ config INTEL_PCH_THERMAL
 config MTK_THERMAL
 	tristate "Temperature sensor driver for mediatek SoCs"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on HAS_IOMEM
 	default y
 	help
 	  Enable this option if you want to have support for thermal management
-- 
2.1.4


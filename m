From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH 1/2] drivers: thermal: Remove ARCH_HAS_BANDGAP dependency for
 samsung
Date: Tue, 02 Dec 2014 12:04:32 +0530
Message-ID: <1417502073-6322-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55660 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbaLBGec (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 01:34:32 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NFX009IXZLIJQ50@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 02 Dec 2014 15:34:30 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, kgene.kim@samsung.com, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com, l.majewski@samsung.com, amit.daniel@samsung.com, kesavan.abhilash@gmail.com

As samsung thermal support is enabled only for ARCH_EXYNOS, there is no
need to select ARCH_HAS_BANDGAP from the arch-specific code. Removing this
dependency will also allow the driver to be enabled on 64-bit SoCs.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
This was based on the discussion regarding adding ARCH_HAS_BANDGAP symbol for
arm64 here: http://www.spinics.net/lists/arm-kernel/msg377560.html

 drivers/thermal/samsung/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index f760389..c43306e 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -1,6 +1,6 @@
 config EXYNOS_THERMAL
 	tristate "Exynos thermal management unit driver"
-	depends on ARCH_HAS_BANDGAP && OF
+	depends on OF
 	help
 	  If you say yes here you get support for the TMU (Thermal Management
 	  Unit) driver for SAMSUNG EXYNOS series of SoCs. This driver initialises
-- 
1.7.9.5


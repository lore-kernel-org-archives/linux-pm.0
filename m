From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH 2/2] ARM: EXYNOS: Remove ARCH_HAS_BANDGAP selection
Date: Tue, 02 Dec 2014 12:04:33 +0530
Message-ID: <1417502073-6322-2-git-send-email-a.kesavan@samsung.com>
References: <1417502073-6322-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38049 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354AbaLBGel (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 01:34:41 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NFX00HU2ZLRBA90@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 02 Dec 2014 15:34:39 +0900 (KST)
In-reply-to: <1417502073-6322-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, kgene.kim@samsung.com, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com, l.majewski@samsung.com, amit.daniel@samsung.com, kesavan.abhilash@gmail.com

On removing the samsung thermal driver dependency on ARCH_HAS_BANDGAP,
selection of this symbol becomes redundant.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index e4a00ba..6ddfce7 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -9,7 +9,6 @@
 
 menuconfig ARCH_EXYNOS
 	bool "Samsung EXYNOS" if ARCH_MULTI_V7
-	select ARCH_HAS_BANDGAP
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
-- 
1.7.9.5


From: Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v6 1/9] ARM: EXYNOS: removing redundant code from regs-pmu.h
Date: Tue, 17 Nov 2015 11:35:43 +0530
Message-ID: <1447740351-14246-2-git-send-email-pankaj.dubey@samsung.com>
References: <1447740351-14246-1-git-send-email-pankaj.dubey@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51218 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbbKQGJy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 01:09:54 -0500
In-reply-to: <1447740351-14246-1-git-send-email-pankaj.dubey@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, k.kozlowski@samsung.com, thomas.ab@samsung.com, amitdanielk@gmail.com, olof@lixom.net, khilman@linaro.org, arnd@arndb.de, Pankaj Dubey <pankaj.dubey@samsung.com>

commit 6ec4f8d0d91f ("ARM: EXYNOS: add generic function to calculate
cpu number") introduced exynos_pmu_cpunr to be used by multi-cluster SoC's
e.g Exynos5420, but it's no more used in the codebase and hence removing
this part of code.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/pmu.c      | 1 +
 arch/arm/mach-exynos/regs-pmu.h | 9 ---------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 5775154..64ea7d6 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -17,6 +17,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 
+#include <asm/cputype.h>
 
 #include "exynos-pmu.h"
 #include "regs-pmu.h"
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index fba9068..5e4f4c2 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -484,15 +484,6 @@
 
 #define EXYNOS5420_SWRESET_KFC_SEL				0x3
 
-#include <asm/cputype.h>
-#define MAX_CPUS_IN_CLUSTER	4
-
-static inline unsigned int exynos_pmu_cpunr(unsigned int mpidr)
-{
-	return ((MPIDR_AFFINITY_LEVEL(mpidr, 1) * MAX_CPUS_IN_CLUSTER)
-		 + MPIDR_AFFINITY_LEVEL(mpidr, 0));
-}
-
 /* Only for EXYNOS5420 */
 #define EXYNOS5420_ISP_ARM_OPTION				0x2488
 #define EXYNOS5420_L2RSTDISABLE_VALUE				BIT(3)
-- 
2.4.5


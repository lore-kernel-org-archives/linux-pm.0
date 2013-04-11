From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 14/30] thermal/exynos: remove unnecessary header inclusions
Date: Thu, 11 Apr 2013 02:04:56 +0200
Message-ID: <1365638712-1028578-15-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64606 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937392Ab3DKAGz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2013 20:06:55 -0400
In-Reply-To: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

In multiplatform configurations, we cannot include headers
provided by only the exynos platform. Fortunately a number
of drivers that include those headers do not actually need
them, so we can just remove the inclusions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/exynos_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index 46568c0..b777ae6 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -39,8 +39,6 @@
 #include <linux/cpu_cooling.h>
 #include <linux/of.h>
 
-#include <plat/cpu.h>
-
 /* Exynos generic registers */
 #define EXYNOS_TMU_REG_TRIMINFO		0x0
 #define EXYNOS_TMU_REG_CONTROL		0x20
-- 
1.8.1.2


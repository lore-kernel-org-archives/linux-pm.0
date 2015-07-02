From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/2] thermal: exynos: Add the dependency of CONFIG_THERMAL_OF
 instead of CONFIG_OF
Date: Thu, 02 Jul 2015 15:40:00 +0900
Message-ID: <1435819201-30729-2-git-send-email-cw00.choi@samsung.com>
References: <1435819201-30729-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:53083 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbbGBGkJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2015 02:40:09 -0400
In-reply-to: <1435819201-30729-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: l.majewski@samsung.com, eduardo.valentin@ti.com, rui.zhang@intel.com
Cc: kgene@kernel.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Eduardo Valentin <edubezval@gmail.com>

The exynos thermal driver use the of_thermal_*() API to parse the basic data
for thermal management from devicetree file. So, if CONFIG_EXYNOS_THERMAL is
selected without CONFIG_THERMAL_OF, kernel can build it without any problem.
But, exynos thermal driver is not working with following error log. This patch
add the dependency of CONFIG_THERMAL_OF instead of CONFIG_OF.

[    1.458644] get_th_reg: Cannot get trip points from of-thermal.c!
[    1.459096] get_th_reg: Cannot get trip points from of-thermal.c!
[    1.465211] exynos4412_tmu_initialize: No CRITICAL trip point defined at of-thermal.c!

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/thermal/samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index c8e35c1a43dc..e0da3865e060 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -1,6 +1,6 @@
 config EXYNOS_THERMAL
 	tristate "Exynos thermal management unit driver"
-	depends on OF
+	depends on THERMAL_OF
 	help
 	  If you say yes here you get support for the TMU (Thermal Management
 	  Unit) driver for SAMSUNG EXYNOS series of SoCs. This driver initialises
-- 
1.8.5.5


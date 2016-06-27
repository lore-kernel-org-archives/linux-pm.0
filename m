From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] devfreq: Add COMPILE_TEST for build coverage
Date: Mon, 27 Jun 2016 15:58:59 +0200
Message-ID: <1467035939-31799-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:62733 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbcF0N7I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 09:59:08 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

The SoC-specific devfreq and event drivers can be build tested on all
architectures.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Success of compilation tested on ARM, ARM64, i386, x86_64 and powerpc
architectures (allyesconfigs).
---
 drivers/devfreq/Kconfig       | 4 ++--
 drivers/devfreq/event/Kconfig | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 78dac0e9da11..8a93d65cf550 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -76,7 +76,7 @@ comment "DEVFREQ Drivers"
 
 config ARM_EXYNOS_BUS_DEVFREQ
 	bool "ARM EXYNOS Generic Memory Bus DEVFREQ Driver"
-	depends on ARCH_EXYNOS
+	depends on ARCH_EXYNOS || COMPILE_TEST
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select DEVFREQ_GOV_PASSIVE
 	select DEVFREQ_EVENT_EXYNOS_PPMU
@@ -92,7 +92,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
 
 config ARM_TEGRA_DEVFREQ
        tristate "Tegra DEVFREQ Driver"
-       depends on ARCH_TEGRA_124_SOC
+       depends on ARCH_TEGRA_124_SOC || (COMPILE_TEST && HAVE_CLK)
        select DEVFREQ_GOV_SIMPLE_ONDEMAND
        select PM_OPP
        help
diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
index 1e8b4f469f38..ad982092359a 100644
--- a/drivers/devfreq/event/Kconfig
+++ b/drivers/devfreq/event/Kconfig
@@ -15,7 +15,7 @@ if PM_DEVFREQ_EVENT
 
 config DEVFREQ_EVENT_EXYNOS_NOCP
 	bool "EXYNOS NoC (Network On Chip) Probe DEVFREQ event Driver"
-	depends on ARCH_EXYNOS
+	depends on ARCH_EXYNOS || COMPILE_TEST
 	select PM_OPP
 	help
 	  This add the devfreq-event driver for Exynos SoC. It provides NoC
@@ -23,7 +23,7 @@ config DEVFREQ_EVENT_EXYNOS_NOCP
 
 config DEVFREQ_EVENT_EXYNOS_PPMU
 	bool "EXYNOS PPMU (Platform Performance Monitoring Unit) DEVFREQ event Driver"
-	depends on ARCH_EXYNOS
+	depends on ARCH_EXYNOS || COMPILE_TEST
 	select PM_OPP
 	help
 	  This add the devfreq-event driver for Exynos SoC. It provides PPMU
-- 
1.9.1


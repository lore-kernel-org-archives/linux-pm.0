From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] PM / devfreq: exynos-nocp: Select REGMAP_MMIO
Date: Tue, 20 Sep 2016 16:57:42 +0800
Message-ID: <1474361863-2319-1-git-send-email-axel.lin@ingics.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
List-Id: linux-pm@vger.kernel.org

This drvier uses devm_regmap_init_mmio(), so select REGMAP_MMIO to avoid
build failure.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/devfreq/event/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
index 0fdae86..cd94980 100644
--- a/drivers/devfreq/event/Kconfig
+++ b/drivers/devfreq/event/Kconfig
@@ -17,6 +17,7 @@ config DEVFREQ_EVENT_EXYNOS_NOCP
 	tristate "EXYNOS NoC (Network On Chip) Probe DEVFREQ event Driver"
 	depends on ARCH_EXYNOS || COMPILE_TEST
 	select PM_OPP
+	select REGMAP_MMIO
 	help
 	  This add the devfreq-event driver for Exynos SoC. It provides NoC
 	  (Network on Chip) Probe counters to measure the bandwidth of AXI bus.
-- 
2.7.4

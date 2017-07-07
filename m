From: <sean.wang@mediatek.com>
Subject: [PATCH v3 1/3] cpufreq: mediatek: Add support of cpufreq to MT2701/MT7623 SoC
Date: Fri, 7 Jul 2017 11:56:45 +0800
Message-ID: <de42e68d86dd161bb18b4ca7f27774c63c1bd55d.1499399121.git.sean.wang@mediatek.com>
References: <cover.1499399121.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1499399121.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

MT2701/MT7623 is a 32-bit ARMv7 based quad-core (4 * Cortex-A7) with
single cluster and this hardware is also compatible with the existing
driver through enabling CPU frequency feature with operating-points-v2
bindings. Also, this driver actually supports all MediaTek SoCs, the
Kconfig menu entry and file name itself should be updated with more
generic name to drop "MT8173"

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.arm                         | 8 ++++----
 drivers/cpufreq/Makefile                            | 2 +-
 drivers/cpufreq/{mt8173-cpufreq.c => mtk-cpufreq.c} | 2 ++
 3 files changed, 7 insertions(+), 5 deletions(-)
 rename drivers/cpufreq/{mt8173-cpufreq.c => mtk-cpufreq.c} (99%)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 74ed7e9..79aece7 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -87,14 +87,14 @@ config ARM_KIRKWOOD_CPUFREQ
 	  This adds the CPUFreq driver for Marvell Kirkwood
 	  SoCs.
 
-config ARM_MT8173_CPUFREQ
-	tristate "Mediatek MT8173 CPUFreq support"
+config ARM_MEDIATEK_CPUFREQ
+	tristate "CPU Frequency scaling support for MediaTek SoCs"
 	depends on ARCH_MEDIATEK && REGULATOR
-	depends on ARM64 || (ARM_CPU_TOPOLOGY && COMPILE_TEST)
+	depends on ARM || ARM64 || COMPILE_TEST
 	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
 	help
-	  This adds the CPUFreq driver support for Mediatek MT8173 SoC.
+	  This adds the CPUFreq driver support for MediaTek SoCs.
 
 config ARM_OMAP2PLUS_CPUFREQ
 	bool "TI OMAP2+"
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index b7e78f0..4956f5d 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -58,7 +58,7 @@ obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
-obj-$(CONFIG_ARM_MT8173_CPUFREQ)	+= mt8173-cpufreq.o
+obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+= mtk-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
 obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
 obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mtk-cpufreq.c
similarity index 99%
rename from drivers/cpufreq/mt8173-cpufreq.c
rename to drivers/cpufreq/mtk-cpufreq.c
index fd1886f..481ec77 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mtk-cpufreq.c
@@ -575,6 +575,8 @@ static struct platform_driver mt8173_cpufreq_platdrv = {
 
 /* List of machines supported by this driver */
 static const struct of_device_id mt8173_cpufreq_machines[] __initconst = {
+	{ .compatible = "mediatek,mt2701", },
+	{ .compatible = "mediatek,mt7623", },
 	{ .compatible = "mediatek,mt817x", },
 	{ .compatible = "mediatek,mt8173", },
 	{ .compatible = "mediatek,mt8176", },
-- 
2.7.4

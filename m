From: <sean.wang@mediatek.com>
Subject: [PATCH 4/6] cpufreq: mediatek: Add support of cpufreq to MT2701/MT7623 SoC
Date: Fri, 5 May 2017 23:26:12 +0800
Message-ID: <1493997974-17699-5-git-send-email-sean.wang@mediatek.com>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

MT2701/MT7623 is an 32-bit ARMv7 based quad-core (4 * Cortex-A7) with
single cluster and this hardware is also compatible with the existing
driver through enabling CPU frequency feature with operating-points-v2
bindings.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/cpufreq/Kconfig.arm      | 4 ++--
 drivers/cpufreq/mt8173-cpufreq.c | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 74ed7e9..68b387a 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -90,11 +90,11 @@ config ARM_KIRKWOOD_CPUFREQ
 config ARM_MT8173_CPUFREQ
 	tristate "Mediatek MT8173 CPUFreq support"
 	depends on ARCH_MEDIATEK && REGULATOR
-	depends on ARM64 || (ARM_CPU_TOPOLOGY && COMPILE_TEST)
+	depends on (ARM || ARM64) || (ARM_CPU_TOPOLOGY && COMPILE_TEST)
 	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
 	help
-	  This adds the CPUFreq driver support for Mediatek MT8173 SoC.
+	  This adds the CPUFreq driver support for Mediatek SoCs.
 
 config ARM_OMAP2PLUS_CPUFREQ
 	bool "TI OMAP2+"
diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index fd1886f..481ec77 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
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

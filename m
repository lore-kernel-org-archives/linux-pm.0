From: <sean.wang@mediatek.com>
Subject: [PATCH 3/6] clk: mediatek: export cpu multiplexer clock for MT8173 SoCs
Date: Fri, 5 May 2017 23:26:11 +0800
Message-ID: <1493997974-17699-4-git-send-email-sean.wang@mediatek.com>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>, Pi-Cheng Chen <pi-cheng.chen@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The patch enables CPU multiplexer clock on MT8173 SoC which fixes up
cpufreq driver fails at acquiring intermediate clock source when driver
probe is called.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8173.c      | 23 +++++++++++++++++++++++
 include/dt-bindings/clock/mt8173-clk.h |  4 +++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 0ac3aee..96c292c 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -18,6 +18,7 @@
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
+#include "clk-cpumux.h"
 
 #include <dt-bindings/clock/mt8173-clk.h>
 
@@ -525,6 +526,25 @@ static const char * const i2s3_b_ck_parents[] __initconst = {
 	"apll2_div5"
 };
 
+static const char * const ca53_parents[] __initconst = {
+	"clk26m",
+	"armca7pll",
+	"mainpll",
+	"univpll"
+};
+
+static const char * const ca57_parents[] __initconst = {
+	"clk26m",
+	"armca15pll",
+	"mainpll",
+	"univpll"
+};
+
+static const struct mtk_composite cpu_muxes[] __initconst = {
+	MUX(CLK_INFRA_CA53SEL, "infra_ca53_sel", ca53_parents, 0x0000, 0, 2),
+	MUX(CLK_INFRA_CA57SEL, "infra_ca57_sel", ca57_parents, 0x0000, 2, 2),
+};
+
 static const struct mtk_composite top_muxes[] __initconst = {
 	/* CLK_CFG_0 */
 	MUX(CLK_TOP_AXI_SEL, "axi_sel", axi_parents, 0x0040, 0, 3),
@@ -948,6 +968,9 @@ static void __init mtk_infrasys_init(struct device_node *node)
 						clk_data);
 	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
 
+	mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
+				  clk_data);
+
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
index 6094bf7..8aea623 100644
--- a/include/dt-bindings/clock/mt8173-clk.h
+++ b/include/dt-bindings/clock/mt8173-clk.h
@@ -193,7 +193,9 @@
 #define CLK_INFRA_PMICSPI		10
 #define CLK_INFRA_PMICWRAP		11
 #define CLK_INFRA_CLK_13M		12
-#define CLK_INFRA_NR_CLK		13
+#define CLK_INFRA_CA53SEL               13
+#define CLK_INFRA_CA57SEL               14
+#define CLK_INFRA_NR_CLK                15
 
 /* PERI_SYS */
 
-- 
2.7.4

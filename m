From: <sean.wang@mediatek.com>
Subject: [PATCH v3 4/4] soc: mediatek: add SCPSYS power domain driver for MediaTek MT7622 SoC
Date: Mon, 7 Aug 2017 15:24:37 +0800
Message-ID: <8167f21922ace6872dc8377488bdcc0161353384.1502090240.git.sean.wang@mediatek.com>
References: <cover.1502090240.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1502090240.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>, Chen Zhong <chen.zhong@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add SCPSYS power domain driver for MT7622 SoC having four power domains
which are respectively ETHSYS for Ethernet including embedded switch,
WBSYS for WIFI and Bluetooth, HIF0SYS for PCI-E and SATA, and HIF1SYS for
USB. Those functions could be selectively powered gated when the
corresponding function is no longer to use in order to reach more minimal
power dissipation.

Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c     | 71 +++++++++++++++++++++++++++++++++++
 include/linux/soc/mediatek/infracfg.h |  7 ++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 6268b28..e1ce8b1 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -22,6 +22,7 @@
 
 #include <dt-bindings/power/mt2701-power.h>
 #include <dt-bindings/power/mt6797-power.h>
+#include <dt-bindings/power/mt7622-power.h>
 #include <dt-bindings/power/mt8173-power.h>
 
 #define SPM_VDE_PWR_CON			0x0210
@@ -39,6 +40,11 @@
 #define SPM_MFG_2D_PWR_CON		0x02c0
 #define SPM_MFG_ASYNC_PWR_CON		0x02c4
 #define SPM_USB_PWR_CON			0x02cc
+#define SPM_ETHSYS_PWR_CON		0x02e0	/* MT7622 */
+#define SPM_HIF0_PWR_CON		0x02e4	/* MT7622 */
+#define SPM_HIF1_PWR_CON		0x02e8	/* MT7622 */
+#define SPM_WB_PWR_CON			0x02ec	/* MT7622 */
+
 
 #define SPM_PWR_STATUS			0x060c
 #define SPM_PWR_STATUS_2ND		0x0610
@@ -64,6 +70,10 @@
 #define PWR_STATUS_MFG_ASYNC		BIT(23)
 #define PWR_STATUS_AUDIO		BIT(24)
 #define PWR_STATUS_USB			BIT(25)
+#define PWR_STATUS_ETHSYS		BIT(24)	/* MT7622 */
+#define PWR_STATUS_HIF0			BIT(25)	/* MT7622 */
+#define PWR_STATUS_HIF1			BIT(26)	/* MT7622 */
+#define PWR_STATUS_WB			BIT(27)	/* MT7622 */
 
 enum clk_id {
 	CLK_NONE,
@@ -73,6 +83,7 @@ enum clk_id {
 	CLK_VENC_LT,
 	CLK_ETHIF,
 	CLK_VDEC,
+	CLK_HIFSEL,
 	CLK_MAX,
 };
 
@@ -84,6 +95,7 @@ static const char * const clk_names[] = {
 	"venc_lt",
 	"ethif",
 	"vdec",
+	"hif_sel",
 	NULL,
 };
 
@@ -653,6 +665,53 @@ static const struct scp_subdomain scp_subdomain_mt6797[] = {
 };
 
 /*
+ * MT7622 power domain support
+ */
+
+static const struct scp_domain_data scp_domain_data_mt7622[] = {
+	[MT7622_POWER_DOMAIN_ETHSYS] = {
+		.name = "ethsys",
+		.sta_mask = PWR_STATUS_ETHSYS,
+		.ctl_offs = SPM_ETHSYS_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.clk_id = {CLK_NONE},
+		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_ETHSYS,
+		.active_wakeup = true,
+	},
+	[MT7622_POWER_DOMAIN_HIF0] = {
+		.name = "hif0",
+		.sta_mask = PWR_STATUS_HIF0,
+		.ctl_offs = SPM_HIF0_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.clk_id = {CLK_HIFSEL},
+		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_HIF0,
+		.active_wakeup = true,
+	},
+	[MT7622_POWER_DOMAIN_HIF1] = {
+		.name = "hif1",
+		.sta_mask = PWR_STATUS_HIF1,
+		.ctl_offs = SPM_HIF1_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.clk_id = {CLK_HIFSEL},
+		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_HIF1,
+		.active_wakeup = true,
+	},
+	[MT7622_POWER_DOMAIN_WB] = {
+		.name = "wb",
+		.sta_mask = PWR_STATUS_WB,
+		.ctl_offs = SPM_WB_PWR_CON,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.clk_id = {CLK_NONE},
+		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_WB,
+		.active_wakeup = true,
+	},
+};
+
+/*
  * MT8173 power domain support
  */
 
@@ -771,6 +830,15 @@ static const struct scp_soc_data mt6797_data = {
 	}
 };
 
+static const struct scp_soc_data mt7622_data = {
+	.domains = scp_domain_data_mt7622,
+	.num_domains = ARRAY_SIZE(scp_domain_data_mt7622),
+	.regs = {
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
+	}
+};
+
 static const struct scp_soc_data mt8173_data = {
 	.domains = scp_domain_data_mt8173,
 	.num_domains = ARRAY_SIZE(scp_domain_data_mt8173),
@@ -794,6 +862,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
 		.compatible = "mediatek,mt6797-scpsys",
 		.data = &mt6797_data,
 	}, {
+		.compatible = "mediatek,mt7622-scpsys",
+		.data = &mt7622_data,
+	}, {
 		.compatible = "mediatek,mt8173-scpsys",
 		.data = &mt8173_data,
 	}, {
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index a5714e9..a0182ec 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -20,6 +20,13 @@
 #define MT8173_TOP_AXI_PROT_EN_MFG_M1		BIT(22)
 #define MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT	BIT(23)
 
+#define MT7622_TOP_AXI_PROT_EN_ETHSYS		(BIT(3) | BIT(17))
+#define MT7622_TOP_AXI_PROT_EN_HIF0		(BIT(24) | BIT(25))
+#define MT7622_TOP_AXI_PROT_EN_HIF1		(BIT(26) | BIT(27) | \
+						 BIT(28))
+#define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
+						 BIT(7) | BIT(8))
+
 int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask);
 int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask);
 
-- 
2.7.4

From: <sean.wang@mediatek.com>
Subject: [PATCH v2 3/3] soc: mediatek: add SCPSYS power domain driver for MediaTek MT7622 SoC
Date: Tue, 1 Aug 2017 18:06:13 +0800
Message-ID: <892e8fb55428c0761620c4472852f86cd56f0f0d.1501581552.git.sean.wang@mediatek.com>
References: <cover.1501581552.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1501581552.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Chen Zhong <chen.zhong@mediatek.com>, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Chen Zhong <chen.zhong@mediatek.com>

Add SCPSYS power domain driver for MT7622 SoC having four power domains
which are respectively ETHSYS for Ethernet including embedded switch,
WBSYS for WIFI and Bluetooth, HIF0SYS for PCI-E and SATA, and HIF1SYS for
USB. Those functions could be selectively powered gated when the
corresponding function is no longer to use in order to reach more minimal
power dissipation.

Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c     | 81 +++++++++++++++++++++++++++++++++++
 include/linux/soc/mediatek/infracfg.h |  8 +++-
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index ceb2cc4..513aa73 100644
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
 
@@ -696,6 +708,72 @@ static int __init scpsys_probe_mt6797(struct platform_device *pdev)
 }
 
 /*
+ * MT7622 power domain support
+ */
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
+#define NUM_DOMAINS_MT7622	ARRAY_SIZE(scp_domain_data_mt7622)
+
+static int __init scpsys_probe_mt7622(struct platform_device *pdev)
+{
+	struct scp *scp;
+	struct scp_ctrl_reg scp_reg;
+
+	scp_reg.pwr_sta_offs = SPM_PWR_STATUS;
+	scp_reg.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND;
+
+	scp = init_scp(pdev, scp_domain_data_mt7622, NUM_DOMAINS_MT7622,
+		       &scp_reg);
+	if (IS_ERR(scp))
+		return PTR_ERR(scp);
+
+	mtk_register_power_domains(pdev, scp, NUM_DOMAINS_MT7622);
+
+	return 0;
+}
+
+/*
  * MT8173 power domain support
  */
 
@@ -835,6 +913,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
 		.compatible = "mediatek,mt6797-scpsys",
 		.data = scpsys_probe_mt6797,
 	}, {
+		.compatible = "mediatek,mt7622-scpsys",
+		.data = scpsys_probe_mt7622,
+	}, {
 		.compatible = "mediatek,mt8173-scpsys",
 		.data = scpsys_probe_mt8173,
 	}, {
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index a5714e9..c1e5062 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -20,7 +20,13 @@
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
-
 #endif /* __SOC_MEDIATEK_INFRACFG_H */
-- 
2.7.4

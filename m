From: <sean.wang@mediatek.com>
Subject: [PATCH v2 2/2] soc: mediatek: add a fixed wait for SRAM stable
Date: Mon, 23 Apr 2018 16:36:22 +0800
Message-ID: <0ef8e87ba7156e626d1a1a48388f222ce917099b.1524472331.git.sean.wang@mediatek.com>
References: <2e16481e1477dfae0cfb24568d8111da81d92628.1524472331.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2e16481e1477dfae0cfb24568d8111da81d92628.1524472331.git.sean.wang@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, Weiyi Lu <weiyi.lu@mediatek.com>, linux-pm@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

MT7622_POWER_DOMAIN_WB doesn't send an ACK when its managed SRAM becomes
stable, which is not like the behavior the other power domains should
have. Therefore, it's necessary for such a power domain to have a fixed
and well-predefined duration to wait until its managed SRAM can be allowed
to access by all functions running on the top.

v1 -> v2:
 - use MTK_SCPD_FWAIT_SRAM flag as an indication requiring force waiting.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index b1b45e4..d4f1a63 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -32,6 +32,7 @@
 #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
 
 #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
+#define MTK_SCPD_FWAIT_SRAM		BIT(1)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
@@ -237,11 +238,22 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	val &= ~scpd->data->sram_pdn_bits;
 	writel(val, ctl_addr);
 
-	/* wait until SRAM_PDN_ACK all 0 */
-	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
-				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
-	if (ret < 0)
-		goto err_pwr_ack;
+	/* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
+	if (!MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
+		ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
+					 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+		if (ret < 0)
+			goto err_pwr_ack;
+	} else {
+		/*
+		 * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
+		 * MT7622_POWER_DOMAIN_WB and thus just a trivial setup is
+		 * applied here. If there're more domains which need to force
+		 * waiting for its own pre-defined value, the duration should
+		 * be coded in the caps field.
+		 */
+		usleep_range(12000, 12100);
+	};
 
 	if (scpd->data->bus_prot_mask) {
 		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
@@ -785,7 +797,7 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
 		.sram_pdn_ack_bits = 0,
 		.clk_id = {CLK_NONE},
 		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_WB,
-		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_FWAIT_SRAM,
 	},
 };
 
-- 
2.7.4

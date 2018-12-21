From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 1/5] drivers: qcom: rpmh-rsc: Add regmap for RSC controller
Date: Fri, 21 Dec 2018 17:29:42 +0530
Message-ID: <20181221115946.10095-2-rplsssn@codeaurora.org>
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221115946.10095-1-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

The RSC controller has dedicated control registers to
send next wakeup timer vale to PDC. The timer value
needs to be programmed by sleep driver client. So add
regmap for the controller.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 75bd9a83aef0..269fd0866647 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -15,6 +15,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -61,6 +62,13 @@
 #define CMD_STATUS_ISSUED		BIT(8)
 #define CMD_STATUS_COMPL		BIT(16)
 
+static const struct regmap_config rsc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+};
+
 static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
 {
 	return readl_relaxed(drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id +
@@ -534,6 +542,7 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
 	struct tcs_group *tcs;
 	struct resource *res;
 	void __iomem *base;
+	struct regmap *regmap;
 	char drv_id[10] = {0};
 
 	snprintf(drv_id, ARRAY_SIZE(drv_id), "drv-%d", drv->id);
@@ -542,6 +551,11 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					&rsc_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
 	ret = of_property_read_u32(dn, "qcom,tcs-offset", &offset);
 	if (ret)
 		return ret;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

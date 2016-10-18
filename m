From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH/RESEND] thermal: qcom-spmi: Treat reg property as a single cell
Date: Tue, 18 Oct 2016 16:40:19 -0700
Message-ID: <20161018234019.5489-1-sboyd@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Ivan T . Ivanov" <iivanov.xz@gmail.com>
List-Id: linux-pm@vger.kernel.org

We only read the first element of the reg property to figure out
the offset of the temperature sensor inside the PMIC.
Furthermore, we want to remove the second element in DT, so just
don't read the second element so that probe keeps working if we
change the DT in the future.

Cc: Ivan T. Ivanov <iivanov.xz@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This was sent in January of this year but hasn't been picked up.

 drivers/thermal/qcom-spmi-temp-alarm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
index 819c6d5d7aa7..f50241962ad2 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom-spmi-temp-alarm.c
@@ -200,7 +200,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	struct qpnp_tm_chip *chip;
 	struct device_node *node;
 	u8 type, subtype;
-	u32 res[2];
+	u32 res;
 	int ret, irq;
 
 	node = pdev->dev.of_node;
@@ -215,7 +215,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	if (!chip->map)
 		return -ENXIO;
 
-	ret = of_property_read_u32_array(node, "reg", res, 2);
+	ret = of_property_read_u32(node, "reg", &res);
 	if (ret < 0)
 		return ret;
 
@@ -228,7 +228,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	if (PTR_ERR(chip->adc) == -EPROBE_DEFER)
 		return PTR_ERR(chip->adc);
 
-	chip->base = res[0];
+	chip->base = res;
 
 	ret = qpnp_tm_read(chip, QPNP_TM_REG_TYPE, &type);
 	if (ret < 0) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] thermal: qcom: tsens: Allow number of sensors to come from DT
Date: Mon,  7 May 2018 16:53:39 -0700
Message-ID: <20180507235339.8836-1-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

For platforms that has multiple copies of the TSENS hardware block it's
necessary to be able to specify the number of sensors per block in DeviceTree.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/thermal/qcom-tsens.txt       |  1 +
 drivers/thermal/qcom/tsens.c                         | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
index 292ed89d900b..06195e8f35e2 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
@@ -8,6 +8,7 @@ Required properties:
 
 - reg: Address range of the thermal registers
 - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
+- #qcom,sensors: Number of sensors in tsens block
 - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
 nvmem cells
 
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 3f9fe6aa51cc..20f3b87d7667 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -116,6 +116,7 @@ static int tsens_probe(struct platform_device *pdev)
 	struct tsens_device *tmdev;
 	const struct tsens_data *data;
 	const struct of_device_id *id;
+	u32 num_sensors;
 
 	if (pdev->dev.of_node)
 		dev = &pdev->dev;
@@ -130,18 +131,23 @@ static int tsens_probe(struct platform_device *pdev)
 	else
 		data = &data_8960;
 
-	if (data->num_sensors <= 0) {
+	num_sensors = data->num_sensors;
+
+	if (np)
+		of_property_read_u32(np, "#qcom,sensors", &num_sensors);
+
+	if (num_sensors <= 0) {
 		dev_err(dev, "invalid number of sensors\n");
 		return -EINVAL;
 	}
 
 	tmdev = devm_kzalloc(dev, sizeof(*tmdev) +
-			     data->num_sensors * sizeof(*s), GFP_KERNEL);
+			     num_sensors * sizeof(*s), GFP_KERNEL);
 	if (!tmdev)
 		return -ENOMEM;
 
 	tmdev->dev = dev;
-	tmdev->num_sensors = data->num_sensors;
+	tmdev->num_sensors = num_sensors;
 	tmdev->ops = data->ops;
 	for (i = 0;  i < tmdev->num_sensors; i++) {
 		if (data->hw_ids)
-- 
2.17.0

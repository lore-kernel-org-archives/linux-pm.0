From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] power: reset: qcom-pon: Add pms405 pon support
Date: Wed, 19 Sep 2018 18:50:44 -0700
Message-ID: <20180920015044.15686-1-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

Update the binding and driver for pms405 pon.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/power/reset/qcom,pon.txt | 5 ++++-
 drivers/power/reset/qcom-pon.c                             | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt b/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
index 651491bb63b7..5705f575862d 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
@@ -6,7 +6,10 @@ and resin along with the Android reboot-mode.
 This DT node has pwrkey and resin as sub nodes.
 
 Required Properties:
--compatible: "qcom,pm8916-pon"
+-compatible: Must be one of:
+	"qcom,pm8916-pon"
+	"qcom,pms405-pon"
+
 -reg: Specifies the physical address of the pon register
 
 Optional subnode:
diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 0c4caaa7e88f..3fa1642d4c54 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -74,6 +74,7 @@ static int pm8916_pon_probe(struct platform_device *pdev)
 
 static const struct of_device_id pm8916_pon_id_table[] = {
 	{ .compatible = "qcom,pm8916-pon" },
+	{ .compatible = "qcom,pms405-pon" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8916_pon_id_table);
-- 
2.18.0

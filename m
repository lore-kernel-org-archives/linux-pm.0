From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH] thermal: qoriq: add i.mx8mq support
Date: Thu, 30 Aug 2018 10:14:46 +0800
Message-ID: <1535595286-18371-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com
List-Id: linux-pm@vger.kernel.org

Add i.mx8mq specific compatible string.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 6 +++---
 drivers/thermal/qoriq_thermal.c                             | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
index 20ca4ef..04cbb90 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
@@ -1,9 +1,9 @@
 * Thermal Monitoring Unit (TMU) on Freescale QorIQ SoCs
 
 Required properties:
-- compatible : Must include "fsl,qoriq-tmu". The version of the device is
-	determined by the TMU IP Block Revision Register (IPBRR0) at
-	offset 0x0BF8.
+- compatible : Must include "fsl,qoriq-tmu" or "fsl,imx8mq-tmu". The
+	version of the device is determined by the TMU IP Block Revision
+	Register (IPBRR0) at offset 0x0BF8.
 	Table of correspondences between IPBRR0 values and example  chips:
 		Value           Device
 		----------      -----
diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index c866cc1..e0e7356 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -305,6 +305,7 @@ static SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
 
 static const struct of_device_id qoriq_tmu_match[] = {
 	{ .compatible = "fsl,qoriq-tmu", },
+	{ .compatible = "fsl,imx8mq-tmu", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, qoriq_tmu_match);
-- 
2.7.4

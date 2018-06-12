From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 4/5] thermal: tsens: Add support for SDM845
Date: Tue, 12 Jun 2018 13:54:56 +0300
Message-ID: <f048a97d1599a54aef3d00126a379f4e5c937057.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1528799892.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

SDM845 uses the TSENS v2 IP block

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.txt |  1 +
 drivers/thermal/qcom/Makefile                            |  2 +-
 drivers/thermal/qcom/tsens-sdm845.c                      | 15 +++++++++++++++
 drivers/thermal/qcom/tsens.c                             |  3 +++
 drivers/thermal/qcom/tsens.h                             |  5 ++++-
 5 files changed, 24 insertions(+), 2 deletions(-)
 create mode 100644 drivers/thermal/qcom/tsens-sdm845.c

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
index 292ed89..8652499 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
@@ -5,6 +5,7 @@ Required properties:
  - "qcom,msm8916-tsens" : For 8916 Family of SoCs
  - "qcom,msm8974-tsens" : For 8974 Family of SoCs
  - "qcom,msm8996-tsens" : For 8996 Family of SoCs
+ - "qcom,sdm845-tsens"  : For SDM845 Family of SoCs
 
 - reg: Address range of the thermal registers
 - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 2cc2193..dc9f169 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
-qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o
+qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o tsens-sdm845.o
diff --git a/drivers/thermal/qcom/tsens-sdm845.c b/drivers/thermal/qcom/tsens-sdm845.c
new file mode 100644
index 0000000..a647265
--- /dev/null
+++ b/drivers/thermal/qcom/tsens-sdm845.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#include "tsens.h"
+
+static const struct tsens_ops ops_sdm845 = {
+	.init		= init_common,
+	.get_temp	= get_temp_tsens_v2,
+};
+
+const struct tsens_data data_sdm845 = {
+	.ops		= &ops_sdm845,
+};
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 3f9fe6a..314a20f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -72,6 +72,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
+	}, {
+		.compatible = "qcom,sdm845-tsens",
+		.data = &data_sdm845,
 	},
 	{}
 };
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 80b273d..e4c0a38 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -88,6 +88,9 @@ int init_common(struct tsens_device *);
 int get_temp_common(struct tsens_device *, int, int *);
 int get_temp_tsens_v2(struct tsens_device *, int, int *);
 
-extern const struct tsens_data data_8916, data_8974, data_8960, data_8996;
+/* TSENS v1 targets */
+extern const struct tsens_data data_8916, data_8974, data_8960;
+/* TSENS v2 targets */
+extern const struct tsens_data data_8996, data_sdm845;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.7.4

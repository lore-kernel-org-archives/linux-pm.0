From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCHv3 07/23] drivers: thermal: tsens: Rename tsens-8916 to prepare to merge with tsens-8974
Date: Wed, 20 Mar 2019 18:47:47 +0530
Message-ID: <fa9063b2d4f0b8bea8163d3fd9880f450fc57bc4.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

8916 and 8974 use v0.1.0 of the TSENS IP. Rename tsens-8916 to prepare
it for merging with tsens-8974 in a later commit.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/Makefile                       | 2 +-
 drivers/thermal/qcom/{tsens-8916.c => tsens-v0_1.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/thermal/qcom/{tsens-8916.c => tsens-v0_1.c} (100%)

diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 717a08600bb5..1f2fafd43dff 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
-qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-v2.o
+qcom_tsens-y			+= tsens.o tsens-common.o tsens-v0_1.o tsens-8974.o tsens-8960.o tsens-v2.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
diff --git a/drivers/thermal/qcom/tsens-8916.c b/drivers/thermal/qcom/tsens-v0_1.c
similarity index 100%
rename from drivers/thermal/qcom/tsens-8916.c
rename to drivers/thermal/qcom/tsens-v0_1.c
-- 
2.17.1

From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCHv3 14/23] drivers: thermal: tsens: change data type for sensor IDs
Date: Wed, 20 Mar 2019 18:47:54 +0530
Message-ID: <5b21bbc7e331a4ee415b62e8cb78ada953c98278.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The IDs cannot be negative, fix the data type.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index a3bf7de88ae8..527c42cfd2d5 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -35,8 +35,8 @@ struct tsens_sensor {
 	struct tsens_priv		*priv;
 	struct thermal_zone_device	*tzd;
 	int				offset;
-	int				id;
-	int				hw_id;
+	unsigned int			id;
+	unsigned int			hw_id;
 	int				slope;
 	u32				status;
 };
-- 
2.17.1

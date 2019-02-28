From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 15/24] drivers: thermal: tsens: change data type for sensor IDs
Date: Thu, 28 Feb 2019 17:51:05 +0530
Message-ID: <031b5d48e77a0372d27cd9c79fe60730e47447e7.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
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
index 023fed3352e3..a20725b1cc67 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -29,8 +29,8 @@ struct tsens_sensor {
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

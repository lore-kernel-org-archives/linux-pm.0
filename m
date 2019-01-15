From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 3/4] power: supply: sc27xx: Fix the incorrect formula when converting capacity to coulomb counter
Date: Tue, 15 Jan 2019 18:32:36 +0800
Message-ID: <7d23781552d6ff1fe6bbabfc56cbbb04d807fffa.1547544142.git.baolin.wang@linaro.org>
References: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
In-Reply-To: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
References: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org, zhang.lyra@gmail.com, orsonzhai@gmail.com
List-Id: linux-pm@vger.kernel.org

We should multiply the calibrated current data (cur_1000ma_adc) when
converting current capacity (mAh) to coulomb counter, which can get
an accurate coulomb counter from the fuel gauge controller.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 4926b8a..ea1349f 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -731,7 +731,7 @@ static int sc27xx_fgu_cap_to_clbcnt(struct sc27xx_fgu_data *data, int capacity)
 	 * Convert current capacity (mAh) to coulomb counter according to the
 	 * formula: 1 mAh =3.6 coulomb.
 	 */
-	return DIV_ROUND_CLOSEST(cur_cap * 36, 10);
+	return DIV_ROUND_CLOSEST(cur_cap * 36 * data->cur_1000ma_adc, 10);
 }
 
 static int sc27xx_fgu_calibration(struct sc27xx_fgu_data *data)
-- 
1.7.9.5

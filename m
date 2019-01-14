From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 2/9] drivers: thermal: of-thermal: Print name of device node with error
Date: Mon, 14 Jan 2019 15:51:04 +0530
Message-ID: <f7c145e6d5164c3386f0a325a4cdcc726362f6db.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, viresh.kumar@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Make it easier to debug devicetree definition in case of errors.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/of-thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 4bfdb4a1e47d..08c3ccbdacf8 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -867,14 +867,14 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	ret = of_property_read_u32(np, "polling-delay-passive", &prop);
 	if (ret < 0) {
-		pr_err("missing polling-delay-passive property\n");
+		pr_err("%pOFn: missing polling-delay-passive property\n", np->name);
 		goto free_tz;
 	}
 	tz->passive_delay = prop;
 
 	ret = of_property_read_u32(np, "polling-delay", &prop);
 	if (ret < 0) {
-		pr_err("missing polling-delay property\n");
+		pr_err("%pOFn: missing polling-delay property\n", np->name);
 		goto free_tz;
 	}
 	tz->polling_delay = prop;
-- 
2.17.1

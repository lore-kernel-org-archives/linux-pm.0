From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 1/2] thermal: of-thermal: Print name of device node with error
Date: Mon, 21 Jan 2019 15:12:22 +0530
Message-ID: <04fc346fe98b9ada6a2bf8f18103fe2fe20240a4.1548063429.git.amit.kucheria@linaro.org>
References: <cover.1548063429.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1548063429.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548063429.git.amit.kucheria@linaro.org>
References: <cover.1548063429.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, edubezval@gmail.com, swboyd@chromium.org, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Make it easier to debug devicetree definition in case of errors.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/of-thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 4bfdb4a1e47d..2df059cc07e2 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -867,14 +867,14 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	ret = of_property_read_u32(np, "polling-delay-passive", &prop);
 	if (ret < 0) {
-		pr_err("missing polling-delay-passive property\n");
+		pr_err("%pOFn: missing polling-delay-passive property\n", np);
 		goto free_tz;
 	}
 	tz->passive_delay = prop;
 
 	ret = of_property_read_u32(np, "polling-delay", &prop);
 	if (ret < 0) {
-		pr_err("missing polling-delay property\n");
+		pr_err("%pOFn: missing polling-delay property\n", np);
 		goto free_tz;
 	}
 	tz->polling_delay = prop;
-- 
2.17.1

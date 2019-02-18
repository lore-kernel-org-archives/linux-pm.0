From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 10/12] thermal: qoriq: Simplify error handling in qoriq_tmu_get_sensor_id()
Date: Mon, 18 Feb 2019 11:11:39 -0800
Message-ID: <20190218191141.3729-11-andrew.smirnov@gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use goto to avoid repeating resource deallocation code.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 3d520d3b2da4..d4f5e180e1ee 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -78,9 +78,8 @@ static int qoriq_tmu_get_sensor_id(void)
 			"#thermal-sensor-cells",
 			0, &sensor_specs);
 	if (ret) {
-		of_node_put(np);
-		of_node_put(sensor_np);
-		return ret;
+		id = ret;
+		goto out;
 	}
 
 	if (sensor_specs.args_count >= 1) {
@@ -91,7 +90,7 @@ static int qoriq_tmu_get_sensor_id(void)
 	} else {
 		id = 0;
 	}
-
+out:
 	of_node_put(np);
 	of_node_put(sensor_np);
 
-- 
2.20.1

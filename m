From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 11/12] thermal: qoriq: Be more strict when parsing "thermal-sensors"
Date: Mon, 18 Feb 2019 11:11:40 -0800
Message-ID: <20190218191141.3729-12-andrew.smirnov@gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

As per Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
thermal-sensor-cells _must_ be 1, so there is no reason to be more
lenient in the code and treat the absence of argument in
thermal-sensors specifier as a valid DT code. Drop that special case
to simplify sensor ID retreival code.

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
 drivers/thermal/qoriq_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index d4f5e180e1ee..f746c62789b0 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -82,14 +82,14 @@ static int qoriq_tmu_get_sensor_id(void)
 		goto out;
 	}
 
-	if (sensor_specs.args_count >= 1) {
-		id = sensor_specs.args[0];
-		WARN(sensor_specs.args_count > 1,
-				"%pOFn: too many cells in sensor specifier %d\n",
-				sensor_specs.np, sensor_specs.args_count);
-	} else {
-		id = 0;
+	if (sensor_specs.args_count != 1) {
+		pr_err("%pOFn: Invalid number of cells in sensor specifier %d\n",
+		       sensor_specs.np, sensor_specs.args_count);
+		id = -EINVAL;
+		goto out;
 	}
+
+	id = sensor_specs.args[0];
 out:
 	of_node_put(np);
 	of_node_put(sensor_np);
-- 
2.20.1

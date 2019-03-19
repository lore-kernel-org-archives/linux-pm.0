From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] thermal: stm32: simplify getting .driver_data
Date: Tue, 19 Mar 2019 17:36:35 +0100
Message-ID: <20190319163635.30891-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/thermal/st/stm_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index bbd73c5a4a4e..cf9ddc52f30e 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -570,8 +570,7 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
 static int stm_thermal_suspend(struct device *dev)
 {
 	int ret;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct stm_thermal_sensor *sensor = platform_get_drvdata(pdev);
+	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
 
 	ret = stm_thermal_sensor_off(sensor);
 	if (ret)
@@ -585,8 +584,7 @@ static int stm_thermal_suspend(struct device *dev)
 static int stm_thermal_resume(struct device *dev)
 {
 	int ret;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct stm_thermal_sensor *sensor = platform_get_drvdata(pdev);
+	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
 
 	ret = stm_thermal_prepare(sensor);
 	if (ret)
-- 
2.11.0

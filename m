From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 4/5] thermal: st: st_thermal: simplify getting .driver_data
Date: Sun, 21 Oct 2018 22:00:51 +0200
Message-ID: <20181021200053.2194-5-wsa+renesas@sang-engineering.com>
References: <20181021200053.2194-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021200053.2194-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/thermal/st/st_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index be637e6b01d2..b2bbdf6eb02b 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -277,8 +277,7 @@ EXPORT_SYMBOL_GPL(st_thermal_unregister);
 #ifdef CONFIG_PM_SLEEP
 static int st_thermal_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct st_thermal_sensor *sensor = platform_get_drvdata(pdev);
+	struct st_thermal_sensor *sensor = dev_get_drvdata(dev);
 
 	return st_thermal_sensor_off(sensor);
 }
@@ -286,8 +285,7 @@ static int st_thermal_suspend(struct device *dev)
 static int st_thermal_resume(struct device *dev)
 {
 	int ret;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct st_thermal_sensor *sensor = platform_get_drvdata(pdev);
+	struct st_thermal_sensor *sensor = dev_get_drvdata(dev);
 
 	ret = st_thermal_sensor_on(sensor);
 	if (ret)
-- 
2.19.0

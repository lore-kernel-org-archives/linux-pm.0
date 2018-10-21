From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 3/5] thermal: spear_thermal: simplify getting .driver_data
Date: Sun, 21 Oct 2018 22:00:50 +0200
Message-ID: <20181021200053.2194-4-wsa+renesas@sang-engineering.com>
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

 drivers/thermal/spear_thermal.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 81b35aace9de..8b9d567134d0 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -56,8 +56,7 @@ static struct thermal_zone_device_ops ops = {
 
 static int __maybe_unused spear_thermal_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct thermal_zone_device *spear_thermal = platform_get_drvdata(pdev);
+	struct thermal_zone_device *spear_thermal = dev_get_drvdata(dev);
 	struct spear_thermal_dev *stdev = spear_thermal->devdata;
 	unsigned int actual_mask = 0;
 
@@ -73,15 +72,14 @@ static int __maybe_unused spear_thermal_suspend(struct device *dev)
 
 static int __maybe_unused spear_thermal_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct thermal_zone_device *spear_thermal = platform_get_drvdata(pdev);
+	struct thermal_zone_device *spear_thermal = dev_get_drvdata(dev);
 	struct spear_thermal_dev *stdev = spear_thermal->devdata;
 	unsigned int actual_mask = 0;
 	int ret = 0;
 
 	ret = clk_enable(stdev->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't enable clock\n");
+		dev_err(dev, "Can't enable clock\n");
 		return ret;
 	}
 
-- 
2.19.0

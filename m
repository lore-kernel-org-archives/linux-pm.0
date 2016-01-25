From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/3] thermal: spear: use __maybe_unused for PM functions
Date: Mon, 25 Jan 2016 17:44:10 +0100
Message-ID: <1453740264-1972562-2-git-send-email-arnd@arndb.de>
References: <1453740264-1972562-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453740264-1972562-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, spear-devel@list.st.com, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The spear thermal driver hides its suspend/resume function conditionally
based on CONFIG_PM, but references them based on CONFIG_PM_SLEEP, so
we get a warning if the former is set but the latter is not:

thermal/spear_thermal.c:58:12: warning: 'spear_thermal_suspend' defined but not used [-Wunused-function]
thermal/spear_thermal.c:75:12: warning: 'spear_thermal_resume' defined but not used [-Wunused-function]

This removes the #ifdef and instead uses a __maybe_uninitialized
annotation to avoid the warning and improve compile-time coverage.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thermal/spear_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 534dd9136662..81b35aace9de 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -54,8 +54,7 @@ static struct thermal_zone_device_ops ops = {
 	.get_temp = thermal_get_temp,
 };
 
-#ifdef CONFIG_PM
-static int spear_thermal_suspend(struct device *dev)
+static int __maybe_unused spear_thermal_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct thermal_zone_device *spear_thermal = platform_get_drvdata(pdev);
@@ -72,7 +71,7 @@ static int spear_thermal_suspend(struct device *dev)
 	return 0;
 }
 
-static int spear_thermal_resume(struct device *dev)
+static int __maybe_unused spear_thermal_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct thermal_zone_device *spear_thermal = platform_get_drvdata(pdev);
@@ -94,7 +93,6 @@ static int spear_thermal_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(spear_thermal_pm_ops, spear_thermal_suspend,
 		spear_thermal_resume);
-- 
2.7.0

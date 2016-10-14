From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/3] thermal: max77620: Fix module autoload
Date: Fri, 14 Oct 2016 11:35:00 -0300
Message-ID: <1476455702-21748-2-git-send-email-javier@osg.samsung.com>
References: <1476455702-21748-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476455702-21748-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/thermal/max77620_thermal.ko | grep alias
$

After this patch:

$ modinfo drivers/thermal/max77620_thermal.ko | grep alias
alias:          platform:max77620-thermal

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/thermal/max77620_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 83905ff46e40..e9a1fe342760 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -149,6 +149,7 @@ static struct platform_device_id max77620_thermal_devtype[] = {
 	{ .name = "max77620-thermal", },
 	{},
 };
+MODULE_DEVICE_TABLE(platform, max77620_thermal_devtype);
 
 static struct platform_driver max77620_thermal_driver = {
 	.driver = {
-- 
2.7.4

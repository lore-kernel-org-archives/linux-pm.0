From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/2] power: supply: axp288_fuel_gauge: Fix module autoload
Date: Mon, 17 Oct 2016 16:13:36 -0300
Message-ID: <1476731616-23995-3-git-send-email-javier@osg.samsung.com>
References: <1476731616-23995-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476731616-23995-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/power/supply/axp288_fuel_gauge.ko | grep alias
$

After this patch:

$ modinfo drivers/power/supply/axp288_fuel_gauge.ko | grep alias
alias:          platform:axp288_fuel_gauge

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/power/supply/axp288_fuel_gauge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 5bdde692f724..539eb41504bb 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -1120,6 +1120,7 @@ static const struct platform_device_id axp288_fg_id_table[] = {
 	{ .name = DEV_NAME },
 	{},
 };
+MODULE_DEVICE_TABLE(platform, axp288_fg_id_table);
 
 static int axp288_fuel_gauge_remove(struct platform_device *pdev)
 {
-- 
2.7.4

From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/2] power: supply: max8997_charger: Fix module autoload
Date: Mon, 17 Oct 2016 16:13:35 -0300
Message-ID: <1476731616-23995-2-git-send-email-javier@osg.samsung.com>
References: <1476731616-23995-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476731616-23995-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/power/supply/max8997_charger.ko | grep alias
$

After this patch:

$ modinfo drivers/power/supply/max8997_charger.ko | grep alias
alias:          platform:max8997-battery

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/power/supply/max8997_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
index 0b2eab571528..290ddc12b040 100644
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@ -184,6 +184,7 @@ static const struct platform_device_id max8997_battery_id[] = {
 	{ "max8997-battery", 0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(platform, max8997_battery_id);
 
 static struct platform_driver max8997_battery_driver = {
 	.driver = {
-- 
2.7.4

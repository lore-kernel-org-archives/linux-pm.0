From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] power: supply: max14656: Export I2C and OF device ID as module aliases
Date: Wed, 25 Jan 2017 10:38:55 -0300
Message-ID: <1485351535-21066-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If the driver is built as a module, I2C module alias information is not
filled so the module won't be autoloaded. Export the I2C and OF devices
ID to the module by using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/power/supply/max14656_charger_detector.ko | grep alias
$

After this patch:

$ modinfo drivers/power/supply/max14656_charger_detector.ko | grep alias
alias:          i2c:max14656
alias:          of:N*T*Cmaxim,max14656C*
alias:          of:N*T*Cmaxim,max14656

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/power/supply/max14656_charger_detector.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/power/supply/max14656_charger_detector.c
index 80f8e5c1b4ec..b91b1d2999dc 100644
--- a/drivers/power/supply/max14656_charger_detector.c
+++ b/drivers/power/supply/max14656_charger_detector.c
@@ -305,11 +305,13 @@ static const struct i2c_device_id max14656_id[] = {
 	{ "max14656", 0 },
 	{}
 };
+MODULE_DEVICE_TABLE(i2c, max14656_id);
 
 static const struct of_device_id max14656_match_table[] = {
 	{ .compatible = "maxim,max14656", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, max14656_match_table);
 
 static struct i2c_driver max14656_i2c_driver = {
 	.driver = {
-- 
2.7.4

From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH v3 2/2] power: supply: max17040: Add OF device ID table
Date: Wed, 15 Mar 2017 00:43:49 -0300
Message-ID: <20170315034349.8494-2-javier@osg.samsung.com>
References: <20170315034349.8494-1-javier@osg.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:45405
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750858AbdCODoD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2017 23:44:03 -0400
In-Reply-To: <20170315034349.8494-1-javier@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes in v3:
- Don't use of_match_ptr() to avoid build warning when CONFIG_OF is disabled.

Changes in v2: None

 drivers/power/supply/max17040_battery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index e7c3649b31a0..33c40f79d23d 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -277,9 +277,17 @@ static const struct i2c_device_id max17040_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max17040_id);
 
+static const struct of_device_id max17040_of_match[] = {
+	{ .compatible = "maxim,max17040" },
+	{ .compatible = "maxim,max77836-battery" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, max17040_of_match);
+
 static struct i2c_driver max17040_i2c_driver = {
 	.driver	= {
 		.name	= "max17040",
+		.of_match_table = max17040_of_match,
 		.pm	= MAX17040_PM_OPS,
 	},
 	.probe		= max17040_probe,
-- 
2.9.3

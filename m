From: elicec <elicec@foxmail.com>
Subject: [PATCH] power:ds2782:Fix description error
Date: Wed, 18 Jul 2018 15:20:33 +0000
Message-ID: <20180718152033.5880-1-elicec@foxmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: elicec <elicec@foxmail.com>
List-Id: linux-pm@vger.kernel.org

After add support for ds2786 battery gas gauge，the description
didn't update. fix it.

Signed-off-by: elicec <elicec@foxmail.com>
---
 drivers/power/supply/ds2782_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply/ds2782_battery.c
index a1b7e0592245..924e99d1e69e 100644
--- a/drivers/power/supply/ds2782_battery.c
+++ b/drivers/power/supply/ds2782_battery.c
@@ -471,5 +471,5 @@ static struct i2c_driver ds278x_battery_driver = {
 module_i2c_driver(ds278x_battery_driver);
 
 MODULE_AUTHOR("Ryan Mallon");
-MODULE_DESCRIPTION("Maxim/Dallas DS2782 Stand-Alone Fuel Gauage IC driver");
+MODULE_DESCRIPTION("Maxim/Dallas DS2782/DS2786 Stand-Alone Fuel Gauage IC driver");
 MODULE_LICENSE("GPL");
-- 
2.17.1

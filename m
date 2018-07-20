From: David Lechner <david@lechnology.com>
Subject: [PATCH 2/2] power: supply: lego_ev3_battery: fix Vce offset
Date: Fri, 20 Jul 2018 15:19:44 -0500
Message-ID: <20180720201944.20503-3-david@lechnology.com>
References: <20180720201944.20503-1-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720201944.20503-1-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: David Lechner <david@lechnology.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This fixes the value that accounts for the Vce of a transistor in the
LEGO MINDSTORMS EV3 power supply driver. The old value (200mV) was the
max value from the data sheet. After testing, the actual value has been
found to be 50mV. By using 50mV we get a more accurate voltage
indication.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/power/supply/lego_ev3_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/lego_ev3_battery.c b/drivers/power/supply/lego_ev3_battery.c
index 6e3b3e384172..1ae3710909b7 100644
--- a/drivers/power/supply/lego_ev3_battery.c
+++ b/drivers/power/supply/lego_ev3_battery.c
@@ -52,7 +52,7 @@ static int lego_ev3_battery_get_property(struct power_supply *psy,
 			return ret;
 
 		val->intval *= 2000;
-		val->intval += 200000;
+		val->intval += 50000;
 
 		/* plus adjust for shunt resistor drop */
 		ret = iio_read_channel_processed(batt->iio_i, &val2);
-- 
2.17.1

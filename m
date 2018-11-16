From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 01/17] power: supply: olpc_battery: correct the temperature
 units
Date: Fri, 16 Nov 2018 17:23:47 +0100
Message-ID: <20181116162403.49854-2-lkundrak@v3.sk>
References: <20181116162403.49854-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181116162403.49854-1-lkundrak@v3.sk>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, platform-driver-x86@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: linux-pm@vger.kernel.org

According to [1] and [2], the temperature values are in tenths of degree
Celsius. Exposing the Celsius value makes the battery appear on fire:

  $ upower -i /org/freedesktop/UPower/devices/battery_olpc_battery
  ...
      temperature:         236.9 degrees C

Tested on OLPC XO-1 and OLPC XO-1.75 laptops.

[1] include/linux/power_supply.h
[2] Documentation/power/power_supply_class.txt

Fixes: fb972873a767 ("[BATTERY] One Laptop Per Child power/battery driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- Add Fixes tag and an Ack

 drivers/power/supply/olpc_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index 6da79ae14860..5a97e42a3547 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -428,14 +428,14 @@ static int olpc_bat_get_property(struct power_supply *psy,
 		if (ret)
 			return ret;
 
-		val->intval = (s16)be16_to_cpu(ec_word) * 100 / 256;
+		val->intval = (s16)be16_to_cpu(ec_word) * 10 / 256;
 		break;
 	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
 		ret = olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_word, 2);
 		if (ret)
 			return ret;
 
-		val->intval = (int)be16_to_cpu(ec_word) * 100 / 256;
+		val->intval = (int)be16_to_cpu(ec_word) * 10 / 256;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
 		ret = olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_word, 2);
-- 
2.19.1

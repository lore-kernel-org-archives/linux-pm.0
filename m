From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] power: supply: mark expected switch fall-throughs
Date: Tue, 17 Jul 2018 16:28:46 -0500
Message-ID: <20180717212846.GA13179@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-pm@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1394724 ("Missing break in switch")
Addresses-Coverity-ID: 114958 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/power/supply/axp20x_usb_power.c   | 1 +
 drivers/power/supply/cros_usbpd-charger.c | 1 +
 drivers/power/supply/wm8350_power.c       | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 44f70dc..42001df 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -222,6 +222,7 @@ static int axp20x_usb_power_set_current_max(struct axp20x_usb_power *power,
 	case 100000:
 		if (power->axp20x_id == AXP221_ID)
 			return -EINVAL;
+		/* fall through */
 	case 500000:
 	case 900000:
 		val = (900000 - intval) / 400000;
diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 3a0c96f..688a16b 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -325,6 +325,7 @@ static int cros_usbpd_charger_get_prop(struct power_supply *psy,
 		 */
 		if (ec_device->mkbp_event_supported || port->psy_online)
 			break;
+		/* fall through */
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
diff --git a/drivers/power/supply/wm8350_power.c b/drivers/power/supply/wm8350_power.c
index a2740cf..15c0ca1 100644
--- a/drivers/power/supply/wm8350_power.c
+++ b/drivers/power/supply/wm8350_power.c
@@ -230,7 +230,8 @@ static irqreturn_t wm8350_charger_handler(int irq, void *data)
 	case WM8350_IRQ_EXT_USB_FB:
 	case WM8350_IRQ_EXT_WALL_FB:
 		wm8350_charger_config(wm8350, policy);
-	case WM8350_IRQ_EXT_BAT_FB:   /* Fall through */
+		/* Fall through */
+	case WM8350_IRQ_EXT_BAT_FB:
 		power_supply_changed(power->battery);
 		power_supply_changed(power->usb);
 		power_supply_changed(power->ac);
-- 
2.7.4

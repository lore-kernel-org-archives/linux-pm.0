From: Chen-Yu Tsai <wens@csie.org>
Subject: [RFT PATCH 3/9] power: supply: axp20x_usb_power: allow disabling input current limiting
Date: Thu,  7 Feb 2019 14:45:29 +0800
Message-ID: <20190207064535.9226-4-wens@csie.org>
References: <20190207064535.9226-1-wens@csie.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207064535.9226-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Quentin Schulz <quentin.schulz@bootlin.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

The AXP PMICs allow the user to disable current limiting on the VBUS
input. While read-out of this setting was already supported by the
driver, it did not allow the user to configure the PMIC to disable
current limiting.

Add support for this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/power/supply/axp20x_usb_power.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index cd9b90d79839..e2f353906bb1 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -230,6 +230,11 @@ static int axp20x_usb_power_set_current_max(struct axp20x_usb_power *power,
 		return regmap_update_bits(power->regmap,
 					  AXP20X_VBUS_IPSOUT_MGMT,
 					  AXP20X_VBUS_CLIMIT_MASK, val);
+	case -1:
+		return regmap_update_bits(power->regmap,
+					  AXP20X_VBUS_IPSOUT_MGMT,
+					  AXP20X_VBUS_CLIMIT_MASK,
+					  AXP20X_VBUS_CLIMIT_NONE);
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1

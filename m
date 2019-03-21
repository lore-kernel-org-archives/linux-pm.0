From: Chen-Yu Tsai <wens@kernel.org>
Subject: [PATCH v3 1/9] dt-bindings: power: supply: axp20x_usb_power: add axp813 compatible
Date: Thu, 21 Mar 2019 16:48:42 +0800
Message-ID: <20190321084850.20769-2-wens@kernel.org>
References: <20190321084850.20769-1-wens@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321084850.20769-1-wens@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

This adds the "x-powers,axp813-usb-power-supply" to the list of
compatibles for AXP20X VBUS power supply driver.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>

---
Changes since v2:

  - Collected Rob's Reviewed-by
---
 .../devicetree/bindings/power/supply/axp20x_usb_power.txt        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
index ba8d35f66cbe..b2d4968fde7d 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
@@ -4,6 +4,7 @@ Required Properties:
 -compatible: One of: "x-powers,axp202-usb-power-supply"
                      "x-powers,axp221-usb-power-supply"
                      "x-powers,axp223-usb-power-supply"
+		     "x-powers,axp813-usb-power-supply"
 
 The AXP223 PMIC shares most of its behaviour with the AXP221 but has slight
 variations such as the former being able to set the VBUS power supply max
-- 
2.20.1

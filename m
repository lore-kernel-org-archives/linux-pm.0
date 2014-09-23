From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v4 1/3] dt-bindings: document gpio-charger bindings
Date: Tue, 23 Sep 2014 22:42:14 +0200
Message-ID: <1411504936-21026-2-git-send-email-heiko@sntech.de>
References: <1411504936-21026-1-git-send-email-heiko@sntech.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:57368 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756582AbaIWUmj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Sep 2014 16:42:39 -0400
In-Reply-To: <1411504936-21026-1-git-send-email-heiko@sntech.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dianders@chromium.org, heiko@sntech.de, Heiko Stuebner <heiko.stuebner@bq.com>

From: Heiko Stuebner <heiko.stuebner@bq.com>

This documents the binding for the gpio-charger power-supply.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
---
 .../bindings/power_supply/gpio-charger.txt         | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/gpio-charger.txt

diff --git a/Documentation/devicetree/bindings/power_supply/gpio-charger.txt b/Documentation/devicetree/bindings/power_supply/gpio-charger.txt
new file mode 100644
index 0000000..adbb5dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/gpio-charger.txt
@@ -0,0 +1,27 @@
+gpio-charger
+
+Required properties :
+ - compatible : "gpio-charger"
+ - gpios : GPIO indicating the charger presence.
+   See GPIO binding in bindings/gpio/gpio.txt .
+ - charger-type : power supply type, one of
+     unknown
+     battery
+     ups
+     mains
+     usb-sdp (USB standard downstream port)
+     usb-dcp (USB dedicated charging port)
+     usb-cdp (USB charging downstream port)
+     usb-aca (USB accessory charger adapter)
+
+Example:
+
+	usb_charger: charger {
+		compatible = "gpio-charger";
+		charger-type = "usb-sdp";
+		gpios = <&gpf0 2 0 0 0>;
+	}
+
+	battery {
+		power-supplies = <&usb_charger>;
+	};
-- 
2.1.0


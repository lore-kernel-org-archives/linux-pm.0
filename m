From: Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 1/2] dt-bindings: power: supply: gpio-charger: Add status-gpios property
Date: Tue,  5 Feb 2019 20:03:15 +0100
Message-ID: <20190205190316.19296-1-contact@artur-rojek.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, Artur Rojek <contact@artur-rojek.eu>
List-Id: linux-pm@vger.kernel.org

Add documentation for the "status-gpios" property.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 .../devicetree/bindings/power/supply/gpio-charger.txt         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
index adbb5dc5b6e9..b98a05a4973c 100644
--- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
@@ -14,12 +14,16 @@ Required properties :
      usb-cdp (USB charging downstream port)
      usb-aca (USB accessory charger adapter)
 
+Optional properties:
+ - status-gpios: GPIO indicating the charger status
+
 Example:
 
 	usb_charger: charger {
 		compatible = "gpio-charger";
 		charger-type = "usb-sdp";
 		gpios = <&gpf0 2 0 0 0>;
+		status-gpios = <&gpf0 3 0 0 0>;
 	}
 
 	battery {
-- 
2.20.1

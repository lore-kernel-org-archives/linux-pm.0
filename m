From: Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v3 1/2] dt-bindings: power: supply: Add charge-status-gpios property
Date: Sun, 14 Apr 2019 14:40:38 +0200
Message-ID: <20190414124039.10040-1-contact@artur-rojek.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, Artur Rojek <contact@artur-rojek.eu>, Rob Herring <robh@kernel.org>
List-Id: linux-pm@vger.kernel.org

Add documentation for the "charge-status-gpios" property.
Update the "gpios" property with a valid example.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes:

v2: - add a better description for the "status-gpios" property,
    - add valid examples for the "gpios" and "status-gpios" properties

v3: rename the "status-gpios" property to "charge-status-gpios"

 .../devicetree/bindings/power/supply/gpio-charger.txt       | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
index adbb5dc5b6e9..30349332f051 100644
--- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
@@ -14,12 +14,16 @@ Required properties :
      usb-cdp (USB charging downstream port)
      usb-aca (USB accessory charger adapter)
 
+Optional properties:
+ - charge-status-gpios: GPIO indicating whether a battery is charging.
+
 Example:
 
 	usb_charger: charger {
 		compatible = "gpio-charger";
 		charger-type = "usb-sdp";
-		gpios = <&gpf0 2 0 0 0>;
+		gpios = <&gpd 28 GPIO_ACTIVE_LOW>;
+		charge-status-gpios = <&gpc 27 GPIO_ACTIVE_LOW>;
 	}
 
 	battery {
-- 
2.21.0

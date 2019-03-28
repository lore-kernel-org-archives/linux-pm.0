From: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Subject: [PATCH 1/1] dt-bindings: power: supply: add missing semi-colon in example
Date: Thu, 28 Mar 2019 16:35:18 -0400
Message-ID: <20190328203518.12100-1-sebastien.bourdelin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
List-Id: linux-pm@vger.kernel.org

Fix the example documentation which is missing a semi-colon.

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/gpio-charger.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
index adbb5dc5b6e9..ddf7b7b971e1 100644
--- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
@@ -20,7 +20,7 @@ Example:
 		compatible = "gpio-charger";
 		charger-type = "usb-sdp";
 		gpios = <&gpf0 2 0 0 0>;
-	}
+	};
 
 	battery {
 		power-supplies = <&usb_charger>;
-- 
2.20.1

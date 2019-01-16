From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 1/8] dt-bindings: arm: atmel: add missing samx7 to reset controller
Date: Wed, 16 Jan 2019 10:57:37 +0100
Message-ID: <b073b46ab85e9c855640e674f12f2a0801876140.1547629763.git.nicolas.ferre@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1547629763.git.nicolas.ferre@microchip.com>
Sender: netdev-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: linux-pm@vger.kernel.org

Add this missing compatibility string to the Reset Controller
compatible string chip list.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 14f319f694b7..36952cc39993 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -21,7 +21,7 @@ Its subnodes can be:
 
 RSTC Reset Controller required properties:
 - compatible: Should be "atmel,<chip>-rstc".
-  <chip> can be "at91sam9260" or "at91sam9g45" or "sama5d3"
+  <chip> can be "at91sam9260", "at91sam9g45", "sama5d3" or "samx7"
 - reg: Should contain registers location and length
 - clocks: phandle to input clock.
 
-- 
2.17.1

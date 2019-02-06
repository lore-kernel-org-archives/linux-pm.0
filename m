From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: atmel: add missing samx7 to reset controller
Date: Wed, 6 Feb 2019 19:12:19 +0100
Message-ID: <20190206181221.27914-1-nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: linux-pm@vger.kernel.org

Add this missing compatibility string to the Reset Controller
compatible string chip list.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2: split series and collect tag

 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index df444073d376..dd7864f2bb2b 100644
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

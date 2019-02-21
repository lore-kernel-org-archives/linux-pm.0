From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Date: Thu, 21 Feb 2019 13:45:56 +0000
Message-ID: <1550756716-3032-4-git-send-email-claudiu.beznea@microchip.com>
References: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, sre@kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for SAM9X60 shutdown controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Docu=
mentation/devicetree/bindings/arm/atmel-sysregs.txt
index 14f319f694b7..50f282ccbcb7 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -83,7 +83,7 @@ SHDWC SAMA5D2-Compatible Shutdown Controller
 1) shdwc node
=20
 required properties:
-- compatible: should be "atmel,sama5d2-shdwc".
+- compatible: should be "atmel,sama5d2-shdwc" or "microchip,sam9x60-shdwc"=
.
 - reg: should contain registers location and length
 - clocks: phandle to input clock.
 - #address-cells: should be one. The cell is the wake-up input index.
@@ -95,6 +95,9 @@ optional properties:
   microseconds. It's usually a board-related property.
 - atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
=20
+optional microchip,sam9x60-shdwc properties:
+- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
+
 The node contains child nodes for each wake-up input that the platform use=
s.
=20
 2) input nodes
--=20
2.7.4

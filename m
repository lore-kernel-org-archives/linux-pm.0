From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 4/8] net/macb: bindings doc/trivial: fix documentation for sama5d3 10/100 interface
Date: Wed, 16 Jan 2019 10:57:40 +0100
Message-ID: <0005c2ef28b985c663e0cd058bbc6d3856e05ec2.1547629763.git.nicolas.ferre@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1547629763.git.nicolas.ferre@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: linux-pm@vger.kernel.org

This removes a line left while adding the correct compatibility string for
sama5d3 10/100 interface. Now use the "atmel,sama5d3-macb" string.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 Documentation/devicetree/bindings/net/macb.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
index 3e17ac1d5d58..f5c414b10e27 100644
--- a/Documentation/devicetree/bindings/net/macb.txt
+++ b/Documentation/devicetree/bindings/net/macb.txt
@@ -3,8 +3,7 @@
 Required properties:
 - compatible: Should be "cdns,[<chip>-]{macb|gem}"
   Use "cdns,at91rm9200-emac" Atmel at91rm9200 SoC.
-  Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs or the 10/100Mbit IP
-  available on sama5d3 SoCs.
+  Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs.
   Use "cdns,np4-macb" for NP4 SoC devices.
   Use "cdns,at32ap7000-macb" for other 10/100 usage or use the generic form: "cdns,macb".
   Use "cdns,pc302-gem" for Picochip picoXcell pc302 and later devices based on
-- 
2.17.1

From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 8/8] net: macb: add sam9x60-macb compatibility string
Date: Wed, 16 Jan 2019 10:57:44 +0100
Message-ID: <dfc7db7606e0898fbedc1f45ed9637379595f9cb.1547629763.git.nicolas.ferre@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1547629763.git.nicolas.ferre@microchip.com>
Sender: netdev-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: linux-pm@vger.kernel.org

Add a new compatibility string for this product. It's using
at91sam9260-macb layout but has a newer hardware revision: it's safer
to use its own string.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 66cc7927061a..a0889ef107a1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3941,6 +3941,7 @@ static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,np4-macb", .data = &np4_config },
 	{ .compatible = "cdns,pc302-gem", .data = &pc302gem_config },
 	{ .compatible = "cdns,gem", .data = &pc302gem_config },
+	{ .compatible = "cdns,sam9x60-macb", .data = &at91sam9260_config },
 	{ .compatible = "atmel,sama5d2-gem", .data = &sama5d2_config },
 	{ .compatible = "atmel,sama5d3-gem", .data = &sama5d3_config },
 	{ .compatible = "atmel,sama5d3-macb", .data = &sama5d3macb_config },
-- 
2.17.1

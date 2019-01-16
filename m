From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 7/8] USB: host: ohci-at91: add sam9x60-sfr definition for ohci
Date: Wed, 16 Jan 2019 10:57:43 +0100
Message-ID: <e7ea12330d4ba8f612110a185a2aa77d91522694.1547629763.git.nicolas.ferre@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1547629763.git.nicolas.ferre@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: linux-pm@vger.kernel.org

Add this SFR compatible definition for the sam9x60 SoC and manage
its use in ohci-at91.c driver.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/usb/host/ohci-at91.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index ec6739ef3129..fc35a7993b7b 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -141,8 +141,11 @@ static struct regmap *at91_dt_syscon_sfr(void)
 	struct regmap *regmap;
 
 	regmap = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
-	if (IS_ERR(regmap))
-		regmap = NULL;
+	if (IS_ERR(regmap)) {
+		regmap = syscon_regmap_lookup_by_compatible("microchip,sam9x60-sfr");
+		if (IS_ERR(regmap))
+			regmap = NULL;
+	}
 
 	return regmap;
 }
-- 
2.17.1

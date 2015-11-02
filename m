From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 1/3] drivers:power:twl4030-charger: fix problem with EPROBE_DEFER
Date: Mon,  2 Nov 2015 12:27:34 +0100
Message-ID: <701c4f311e81dab4b3218cfe03bb9faa2da37747.1446463653.git.hns@goldelico.com>
References: <cover.1446463652.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446463652.git.hns@goldelico.com>
In-Reply-To: <cover.1446463652.git.hns@goldelico.com>
References: <cover.1446463652.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Gra=C5=BEvydas=20Ignotas?= <notasas@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Andreas Kemnade <andreas@kemnade.info>
Cc: linux-pm@vger.kernel.org, gta04-owner@goldelico.com, linux-kernel@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-pm@vger.kernel.org

If the phy-twol4030-usb driver is compiled as a module,
devm_usb_get_phy_by_node() may return -EPROBE_DEFER in which
case we should also defer probing of the twl4030 charger instead of
turning USB charging off (forever or until next reboot) further down in
code.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/twl4030_charger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 74f2d3f..00697e9 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -1057,9 +1057,13 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 
 		phynode = of_find_compatible_node(bci->dev->of_node->parent,
 						  NULL, "ti,twl4030-usb");
-		if (phynode)
+		if (phynode) {
 			bci->transceiver = devm_usb_get_phy_by_node(
 				bci->dev, phynode, &bci->usb_nb);
+			if (IS_ERR(bci->transceiver) &&
+			    PTR_ERR(bci->transceiver) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;	/* PHY not ready */
+		}
 	}
 
 	/* Enable interrupts now. */
-- 
2.5.1

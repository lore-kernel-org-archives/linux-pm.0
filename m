From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 1/2] drivers:power:twl4030-charger: fix problem with EPROBE_DEFER
Date: Thu, 29 Oct 2015 18:01:27 +0100
Message-ID: <cfc5db66692e0415c86a08e2a3d37c2b299bf170.1446138086.git.hns@goldelico.com>
References: <cover.1446138086.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:48036 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757056AbbJ2RBi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2015 13:01:38 -0400
In-Reply-To: <cover.1446138086.git.hns@goldelico.com>
In-Reply-To: <cover.1446138086.git.hns@goldelico.com>
References: <cover.1446138086.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Gra=C5=BEvydas=20Ignotas?= <notasas@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, gta04-owner@goldelico.com, "H. Nikolaus Schaller" <hns@goldelico.com>

devm_usb_get_phy_by_node() may return -EPROBE_DEFER in which
case we should also defer probing of the twl4030 charger
instead of turing USB charging off (forever).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/twl4030_charger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 423e886..859991f 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -1059,9 +1059,13 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 
 		phynode = of_find_compatible_node(bci->dev->of_node->parent,
 						  NULL, "ti,twl4030-usb");
-		if (phynode)
+		if (phynode) {
 			bci->transceiver = devm_usb_get_phy_by_node(
 				bci->dev, phynode, &bci->usb_nb);
+			if (IS_ERR(bci->transceiver) &&
+				PTR_ERR(bci->transceiver) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;	/* PHY not ready */
+		}
 	}
 
 	/* Enable interrupts now. */
-- 
2.5.1


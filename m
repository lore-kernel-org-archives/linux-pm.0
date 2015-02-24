From: NeilBrown <neilb@suse.de>
Subject: [PATCH 2/2] twl4030_charger: find associated phy by more reliable
 means.
Date: Tue, 24 Feb 2015 15:01:29 +1100
Message-ID: <20150224040129.32252.59874.stgit@notabene.brown>
References: <20150224035809.32252.4180.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224035809.32252.4180.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Sebastian Reichel <sre@kernel.org>, Felipe Balbi <balbi@ti.com>
Cc: GTA04 owners <gta04-owner@goldelico.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

twl4030_charger currently finds the associated phy
using usb_get_phy() which will return the first USB2 phy.
If your platform has multiple such phys (as mine does),
this is not reliable (and reliably fails on the GTA04).

Change to use devm_usb_get_phy_by_node(), having found the
node by looking for an appropriately named sibling in
device-tree.

This makes usb-charging dependent on correct device-tree
configuration.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/power/twl4030_charger.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index d35b83e635b5..4cf5ffbc904a 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -629,10 +629,15 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 
 	INIT_WORK(&bci->work, twl4030_bci_usb_work);
 
-	bci->transceiver = usb_get_phy(USB_PHY_TYPE_USB2);
-	if (!IS_ERR_OR_NULL(bci->transceiver)) {
-		bci->usb_nb.notifier_call = twl4030_bci_usb_ncb;
-		usb_register_notifier(bci->transceiver, &bci->usb_nb);
+	bci->usb_nb.notifier_call = twl4030_bci_usb_ncb;
+	if (bci->dev->of_node) {
+		struct device_node *phynode;
+
+		phynode = of_get_child_by_name(bci->dev->of_node->parent,
+					       "twl4030-usb");
+		if (phynode)
+			bci->transceiver = devm_usb_get_phy_by_node(
+				bci->dev, phynode, &bci->usb_nb);
 	}
 
 	/* Enable interrupts now. */
@@ -662,10 +667,6 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 	return 0;
 
 fail_unmask_interrupts:
-	if (!IS_ERR_OR_NULL(bci->transceiver)) {
-		usb_unregister_notifier(bci->transceiver, &bci->usb_nb);
-		usb_put_phy(bci->transceiver);
-	}
 	free_irq(bci->irq_bci, bci);
 fail_bci_irq:
 	free_irq(bci->irq_chg, bci);
@@ -694,10 +695,6 @@ static int __exit twl4030_bci_remove(struct platform_device *pdev)
 	twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xff,
 			 TWL4030_INTERRUPTS_BCIIMR2A);
 
-	if (!IS_ERR_OR_NULL(bci->transceiver)) {
-		usb_unregister_notifier(bci->transceiver, &bci->usb_nb);
-		usb_put_phy(bci->transceiver);
-	}
 	free_irq(bci->irq_bci, bci);
 	free_irq(bci->irq_chg, bci);
 	power_supply_unregister(&bci->usb);

From: NeilBrown <neil@brown.name>
Subject: [PATCH 2/2] twl4030_charger: find associated phy by more reliable
 means.
Date: Mon, 23 Mar 2015 09:52:48 +1100
Message-ID: <20150322225248.22311.50385.stgit@notabene.brown>
References: <20150322225053.22311.45510.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150322225053.22311.45510.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Sebastian Reichel <sre@kernel.org>, Felipe Balbi <balbi@ti.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, NeilBrown <neilb@suse.de>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

From: NeilBrown <neilb@suse.de>

twl4030_charger currently finds the associated phy
using usb_get_phy() which will return the first USB2 phy.
If your platform has multiple such phys (as mine does),
this is not reliable (and reliably fails on the GTA04).

Change to use devm_usb_get_phy_by_node(), having found the
node by looking for an appropriately named sibling in
device-tree.

This makes usb-charging dependent on correct device-tree
configuration.

Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 .../devicetree/bindings/power/twl-charger.txt      |   10 ++++++++++
 .../devicetree/bindings/usb/twlxxxx-usb.txt        |    3 +++
 drivers/power/twl4030_charger.c                    |   21 +++++++++-----------
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/twl-charger.txt b/Documentation/devicetree/bindings/power/twl-charger.txt
index d5c706216df5..3b4ea1b73b38 100644
--- a/Documentation/devicetree/bindings/power/twl-charger.txt
+++ b/Documentation/devicetree/bindings/power/twl-charger.txt
@@ -1,5 +1,15 @@
 TWL BCI (Battery Charger Interface)
 
+The battery charger needs to interact with the USB phy in order
+to know when charging is permissible, and when there is a connection
+or disconnection.
+
+The choice of phy cannot be configured at a hardware level, so there
+is no value in explicit configuration in device-tree.  Rather
+if there is a sibling of the BCI node which is compatible with
+"ti,twl4030-usb", then that is used to determine when and how
+use USB power for charging.
+
 Required properties:
 - compatible:
   - "ti,twl4030-bci"
diff --git a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt b/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
index 0aee0ad3f035..17327a296110 100644
--- a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
@@ -30,6 +30,9 @@ TWL4030 USB PHY AND COMPARATOR
  - usb_mode : The mode used by the phy to connect to the controller. "1"
    specifies "ULPI" mode and "2" specifies "CEA2011_3PIN" mode.
 
+If a sibling node is compatible "ti,twl4030-bci", then it will find
+this device and query it for USB power status.
+
 twl4030-usb {
 	compatible = "ti,twl4030-usb";
 	interrupts = < 10 4 >;
diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index d35b83e635b5..b07f4e2f2dde 100644
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
+		phynode = of_find_compatible_node(bci->dev->of_node->parent,
+						  NULL, "ti,twl4030-usb");
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

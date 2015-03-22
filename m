From: NeilBrown <neil@brown.name>
Subject: [PATCH 1/2] usb: phy: Add interface to get phy give of device_node.
Date: Mon, 23 Mar 2015 09:52:48 +1100
Message-ID: <20150322225248.22311.64774.stgit@notabene.brown>
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

Split the "get phy from device_node" functionality out of
"get phy by phandle" so it can be used directly.

This is useful when a battery-charger is intimately associated with a
particular phy but handled by a separate driver.  The charger
can find the device_node based on sibling relationships
without the need for a redundant declaration in the devicetree
description.

As a peripheral that gets a phy will often want to register a
notifier block, and de-register it later, that functionality
is included so the de-registration is automatic.

Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/usb/phy/phy.c   |   97 ++++++++++++++++++++++++++++++++++-------------
 include/linux/usb/phy.h |    2 +
 2 files changed, 72 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index 2f9735b35338..6b089e19e8db 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -22,6 +22,11 @@ static LIST_HEAD(phy_list);
 static LIST_HEAD(phy_bind_list);
 static DEFINE_SPINLOCK(phy_lock);
 
+struct phy_devm {
+	struct usb_phy *phy;
+	struct notifier_block *nb;
+};
+
 static struct usb_phy *__usb_find_phy(struct list_head *list,
 	enum usb_phy_type type)
 {
@@ -79,6 +84,15 @@ static void devm_usb_phy_release(struct device *dev, void *res)
 	usb_put_phy(phy);
 }
 
+static void devm_usb_phy_release2(struct device *dev, void *_res)
+{
+	struct phy_devm *res = _res;
+
+	if (res->nb)
+		usb_unregister_notifier(res->phy, res->nb);
+	usb_put_phy(res->phy);
+}
+
 static int devm_usb_phy_match(struct device *dev, void *res, void *match_data)
 {
 	return res == match_data;
@@ -151,40 +165,30 @@ err0:
 EXPORT_SYMBOL_GPL(usb_get_phy);
 
 /**
- * devm_usb_get_phy_by_phandle - find the USB PHY by phandle
+ * devm_usb_get_phy_by_node - find the USB PHY by device_node
  * @dev - device that requests this phy
- * @phandle - name of the property holding the phy phandle value
- * @index - the index of the phy
+ * @node - the device_node for the phy device.
+ * @nb - a notifier_block to register with the phy.
  *
- * Returns the phy driver associated with the given phandle value,
+ * Returns the phy driver associated with the given device_node,
  * after getting a refcount to it, -ENODEV if there is no such phy or
- * -EPROBE_DEFER if there is a phandle to the phy, but the device is
- * not yet loaded. While at that, it also associates the device with
+ * -EPROBE_DEFER if the device is not yet loaded. While at that, it
+ * also associates the device with
  * the phy using devres. On driver detach, release function is invoked
  * on the devres data, then, devres data is freed.
  *
- * For use by USB host and peripheral drivers.
+ * For use by peripheral drivers for devices related to a phy,
+ * such as a charger.
  */
-struct usb_phy *devm_usb_get_phy_by_phandle(struct device *dev,
-	const char *phandle, u8 index)
+struct  usb_phy *devm_usb_get_phy_by_node(struct device *dev,
+					  struct device_node *node,
+					  struct notifier_block *nb)
 {
-	struct usb_phy	*phy = ERR_PTR(-ENOMEM), **ptr;
+	struct usb_phy	*phy = ERR_PTR(-ENOMEM);
+	struct phy_devm	*ptr;
 	unsigned long	flags;
-	struct device_node *node;
 
-	if (!dev->of_node) {
-		dev_dbg(dev, "device does not have a device node entry\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	node = of_parse_phandle(dev->of_node, phandle, index);
-	if (!node) {
-		dev_dbg(dev, "failed to get %s phandle in %s node\n", phandle,
-			dev->of_node->full_name);
-		return ERR_PTR(-ENODEV);
-	}
-
-	ptr = devres_alloc(devm_usb_phy_release, sizeof(*ptr), GFP_KERNEL);
+	ptr = devres_alloc(devm_usb_phy_release2, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr) {
 		dev_dbg(dev, "failed to allocate memory for devres\n");
 		goto err0;
@@ -203,8 +207,10 @@ struct usb_phy *devm_usb_get_phy_by_phandle(struct device *dev,
 		devres_free(ptr);
 		goto err1;
 	}
-
-	*ptr = phy;
+	if (nb)
+		usb_register_notifier(phy, nb);
+	ptr->phy = phy;
+	ptr->nb = nb;
 	devres_add(dev, ptr);
 
 	get_device(phy->dev);
@@ -213,10 +219,47 @@ err1:
 	spin_unlock_irqrestore(&phy_lock, flags);
 
 err0:
-	of_node_put(node);
 
 	return phy;
 }
+EXPORT_SYMBOL_GPL(devm_usb_get_phy_by_node);
+
+/**
+ * devm_usb_get_phy_by_phandle - find the USB PHY by phandle
+ * @dev - device that requests this phy
+ * @phandle - name of the property holding the phy phandle value
+ * @index - the index of the phy
+ *
+ * Returns the phy driver associated with the given phandle value,
+ * after getting a refcount to it, -ENODEV if there is no such phy or
+ * -EPROBE_DEFER if there is a phandle to the phy, but the device is
+ * not yet loaded. While at that, it also associates the device with
+ * the phy using devres. On driver detach, release function is invoked
+ * on the devres data, then, devres data is freed.
+ *
+ * For use by USB host and peripheral drivers.
+ */
+struct usb_phy *devm_usb_get_phy_by_phandle(struct device *dev,
+	const char *phandle, u8 index)
+{
+	struct device_node *node;
+	struct usb_phy	*phy;
+
+	if (!dev->of_node) {
+		dev_dbg(dev, "device does not have a device node entry\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	node = of_parse_phandle(dev->of_node, phandle, index);
+	if (!node) {
+		dev_dbg(dev, "failed to get %s phandle in %s node\n", phandle,
+			dev->of_node->full_name);
+		return ERR_PTR(-ENODEV);
+	}
+	phy = devm_usb_get_phy_by_node(dev, node, NULL);
+	of_node_put(node);
+	return phy;
+}
 EXPORT_SYMBOL_GPL(devm_usb_get_phy_by_phandle);
 
 /**
diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index bc91b5d380fd..8ed1e29ef329 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -205,6 +205,8 @@ extern struct usb_phy *usb_get_phy_dev(struct device *dev, u8 index);
 extern struct usb_phy *devm_usb_get_phy_dev(struct device *dev, u8 index);
 extern struct usb_phy *devm_usb_get_phy_by_phandle(struct device *dev,
 	const char *phandle, u8 index);
+extern struct usb_phy *devm_usb_get_phy_by_node(struct device *dev,
+	struct device_node *node, struct notifier_block *nb);
 extern void usb_put_phy(struct usb_phy *);
 extern void devm_usb_put_phy(struct device *dev, struct usb_phy *x);
 extern int usb_bind_phy(const char *dev_name, u8 index,

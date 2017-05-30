From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/7] driver core: add helper to reuse a device-tree node
Date: Tue, 30 May 2017 18:25:50 +0200
Message-ID: <20170530162554.26159-4-johan@kernel.org>
References: <20170530162554.26159-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170530162554.26159-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Chen <peter.chen@freescale.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sricharan R <sricharan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-pm@vger.kernel.org

Add a helper function to be used when reusing the device-tree node of
another device.

It is fairly common for drivers to reuse the device-tree node of a
parent (or other ancestor) device when creating class or bus devices
(e.g. gpio chips, i2c adapters, iio chips, spi masters, serdev, phys,
usb root hubs). But reusing a device-tree node may cause problems if the
new device is later probed as for example driver core would currently
attempt to reinitialise an already active associated pinmux
configuration.

Other potential issues include the platform-bus code unconditionally
dropping the device-tree node reference in its device destructor,
reinitialisation of other bus-managed resources such as clocks, and the
recently added DMA-setup in driver core.

Note that for most examples above this is currently not an issue as the
devices are never probed, but this is a problem for the USB bus which
has recently gained device-tree support. This was discovered and
worked-around in a rather ad-hoc fashion by commit dc5878abf49c ("usb:
core: move root hub's device node assignment after it is added to bus")
by not setting the of_node pointer until after the root-hub device has
been registered.

Instead we can allow devices to reuse a device-tree node by setting a
flag in their struct device that can be used by core, bus and driver
code to avoid resources from being over-allocated.

Note that the helper also grabs an extra reference to the device node,
which specifically balances the unconditional put in the platform-device
destructor.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/core.c    | 16 ++++++++++++++++
 include/linux/device.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index bbecaf9293be..c3064ff09af5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2884,3 +2884,19 @@ void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
 	else
 		dev->fwnode = fwnode;
 }
+
+/**
+ * device_set_of_node_from_dev - reuse device-tree node of another device
+ * @dev: device whose device-tree node is being set
+ * @dev2: device whose device-tree node is being reused
+ *
+ * Takes another reference to the new device-tree node after first dropping
+ * any reference held to the old node.
+ */
+void device_set_of_node_from_dev(struct device *dev, const struct device *dev2)
+{
+	of_node_put(dev->of_node);
+	dev->of_node = of_node_get(dev2->of_node);
+	dev->of_node_reused = true;
+}
+EXPORT_SYMBOL_GPL(device_set_of_node_from_dev);
diff --git a/include/linux/device.h b/include/linux/device.h
index 9ef518af5515..d7544bb558c3 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -966,6 +966,7 @@ struct device {
 
 	bool			offline_disabled:1;
 	bool			offline:1;
+	bool			of_node_reused:1;
 };
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)
@@ -1144,6 +1145,7 @@ extern int device_offline(struct device *dev);
 extern int device_online(struct device *dev);
 extern void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 extern void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
+void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
 
 static inline int dev_num_vf(struct device *dev)
 {
-- 
2.13.0

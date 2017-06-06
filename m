From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 5/7] USB: of: fix root-hub device-tree node handling
Date: Tue,  6 Jun 2017 17:59:02 +0200
Message-ID: <20170606155904.26819-6-johan@kernel.org>
References: <20170606155904.26819-1-johan@kernel.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170606155904.26819-1-johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

In an attempt to work around a pinmux over-allocation issue in driver
core, commit dc5878abf49c ("usb: core: move root hub's device node
assignment after it is added to bus") moved the device-tree node
assignment until after the root hub had been registered.

This not only makes the device-tree node unavailable to the usb driver
during probe, but also prevents the of_node from being linked to in
sysfs and causes a race with user-space for the (recently added) devspec
attribute.

Use the new device_set_of_node_from_dev() helper to reuse the node of
the sysdev device, something which now prevents driver core from trying
to reclaim any pinctrl pins during probe.

Fixes: dc5878abf49c ("usb: core: move root hub's device node assignment after it is added to bus")
Fixes: 51fa91475e43 ("usb/core: Added devspec sysfs entry for devices behind the usb hub")
Signed-off-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/usb/core/hcd.c | 2 --
 drivers/usb/core/usb.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 5dea98358c05..2cff59e9c268 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1076,7 +1076,6 @@ static void usb_deregister_bus (struct usb_bus *bus)
 static int register_root_hub(struct usb_hcd *hcd)
 {
 	struct device *parent_dev = hcd->self.controller;
-	struct device *sysdev = hcd->self.sysdev;
 	struct usb_device *usb_dev = hcd->self.root_hub;
 	const int devnum = 1;
 	int retval;
@@ -1123,7 +1122,6 @@ static int register_root_hub(struct usb_hcd *hcd)
 		/* Did the HC die before the root hub was registered? */
 		if (HCD_DEAD(hcd))
 			usb_hc_died (hcd);	/* This time clean up */
-		usb_dev->dev.of_node = sysdev->of_node;
 	}
 	mutex_unlock(&usb_bus_idr_lock);
 
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 62e1906bb2f3..17681d5638ac 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -416,8 +416,7 @@ static void usb_release_dev(struct device *dev)
 
 	usb_destroy_configuration(udev);
 	usb_release_bos_descriptor(udev);
-	if (udev->parent)
-		of_node_put(dev->of_node);
+	of_node_put(dev->of_node);
 	usb_put_hcd(hcd);
 	kfree(udev->product);
 	kfree(udev->manufacturer);
@@ -616,6 +615,7 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 		dev->route = 0;
 
 		dev->dev.parent = bus->controller;
+		device_set_of_node_from_dev(&dev->dev, bus->sysdev);
 		dev_set_name(&dev->dev, "usb%d", bus->busnum);
 		root_hub = 1;
 	} else {
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

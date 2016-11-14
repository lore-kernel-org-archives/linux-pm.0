From: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v10 4/8] usb: core: add power sequence handling for USB devices
Date: Mon, 14 Nov 2016 09:35:55 +0800
Message-ID: <1479087359-7547-5-git-send-email-peter.chen@nxp.com>
References: <1479087359-7547-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479087359-7547-1-git-send-email-peter.chen-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Some hard-wired USB devices need to do power sequence to let the
device work normally, the typical power sequence like: enable USB
PHY clock, toggle reset pin, etc. But current Linux USB driver
lacks of such code to do it, it may cause some hard-wired USB devices
works abnormal or can't be recognized by controller at all.

In this patch, it calls power sequence library APIs to finish
the power sequence events. It will do power on sequence at hub's
probe for all devices under this hub (includes root hub).
At hub_disconnect, it will do power off sequence which is at powered
on list.

Signed-off-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
Tested-by Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Tested-by: Maciej S. Szmigiero <mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org>
Reviewed-by: Vaibhav Hiremath <hvaibhav.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/Kconfig    |  1 +
 drivers/usb/core/hub.c | 41 ++++++++++++++++++++++++++++++++++++++---
 drivers/usb/core/hub.h |  1 +
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index fbe493d..706f261 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -40,6 +40,7 @@ config USB
 	tristate "Support for Host-side USB"
 	depends on USB_ARCH_HAS_HCD
 	select USB_COMMON
+	select POWER_SEQUENCE
 	select NLS  # for UTF-8 strings
 	---help---
 	  Universal Serial Bus (USB) is a specification for a serial bus
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 76e80d8..991340f 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/pm_qos.h>
+#include <linux/power/pwrseq.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -1697,6 +1698,7 @@ static void hub_disconnect(struct usb_interface *intf)
 	hub->error = 0;
 	hub_quiesce(hub, HUB_DISCONNECT);
 
+	of_pwrseq_off_list(&hub->pwrseq_on_list);
 	mutex_lock(&usb_port_peer_mutex);
 
 	/* Avoid races with recursively_mark_NOTATTACHED() */
@@ -1724,12 +1726,41 @@ static void hub_disconnect(struct usb_interface *intf)
 	kref_put(&hub->kref, hub_release);
 }
 
+#ifdef CONFIG_OF
+static int hub_of_pwrseq_on(struct usb_hub *hub)
+{
+	struct device *parent;
+	struct usb_device *hdev = hub->hdev;
+	struct device_node *np;
+	int ret;
+
+	if (hdev->parent)
+		parent = &hdev->dev;
+	else
+		parent = bus_to_hcd(hdev->bus)->self.controller;
+
+	for_each_child_of_node(parent->of_node, np) {
+		ret = of_pwrseq_on_list(np, &hub->pwrseq_on_list);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+#else
+static int hub_of_pwrseq_on(struct usb_hub *hub)
+{
+	return 0;
+}
+#endif
+
 static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_host_interface *desc;
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+	int ret = -ENODEV;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
@@ -1834,6 +1865,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	INIT_DELAYED_WORK(&hub->leds, led_work);
 	INIT_DELAYED_WORK(&hub->init_work, NULL);
 	INIT_WORK(&hub->events, hub_event);
+	INIT_LIST_HEAD(&hub->pwrseq_on_list);
 	usb_get_intf(intf);
 	usb_get_dev(hdev);
 
@@ -1847,11 +1879,14 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	if (id->driver_info & HUB_QUIRK_CHECK_PORT_AUTOSUSPEND)
 		hub->quirk_check_port_auto_suspend = 1;
 
-	if (hub_configure(hub, endpoint) >= 0)
-		return 0;
+	if (hub_configure(hub, endpoint) >= 0) {
+		ret = hub_of_pwrseq_on(hub);
+		if (!ret)
+			return 0;
+	}
 
 	hub_disconnect(intf);
-	return -ENODEV;
+	return ret;
 }
 
 static int
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 34c1a7e..cd86f91 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -78,6 +78,7 @@ struct usb_hub {
 	struct delayed_work	init_work;
 	struct work_struct      events;
 	struct usb_port		**ports;
+	struct list_head	pwrseq_on_list; /* powered pwrseq node list */
 };
 
 /**
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

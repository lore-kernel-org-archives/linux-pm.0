From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v12 9/9] usb: core: add power sequence handling for USB devices
Date: Mon, 6 Feb 2017 17:13:41 +0800
Message-ID: <1486372421-29073-10-git-send-email-peter.chen@nxp.com>
References: <1486372421-29073-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam03on0078.outbound.protection.outlook.com ([104.47.42.78]:2369
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751850AbdBFJP3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Feb 2017 04:15:29 -0500
In-Reply-To: <1486372421-29073-1-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, rjw@rjwysocki.net, dbaryshkov@gmail.com
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, vaibhav.hiremath@linaro.org, gary.bisson@boundarydevices.com, hverkuil@xs4all.nl, krzk@kernel.org, Peter Chen <peter.chen@nxp.com>

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

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Tested-by Joshua Clayton <stillcompiling@gmail.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Vaibhav Hiremath <hvaibhav.linux@gmail.com>
---
 drivers/usb/Kconfig    |  1 +
 drivers/usb/core/hub.c | 49 +++++++++++++++++++++++++++++++++++++++++++++----
 drivers/usb/core/hub.h |  1 +
 3 files changed, 47 insertions(+), 4 deletions(-)

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
index a56c75e..5b40c48 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/pm_qos.h>
+#include <linux/power/pwrseq.h>
 
 #include <linux/uaccess.h>
 #include <asm/byteorder.h>
@@ -1616,6 +1617,7 @@ static void hub_disconnect(struct usb_interface *intf)
 	hub->error = 0;
 	hub_quiesce(hub, HUB_DISCONNECT);
 
+	of_pwrseq_off_list(&hub->pwrseq_on_list);
 	mutex_lock(&usb_port_peer_mutex);
 
 	/* Avoid races with recursively_mark_NOTATTACHED() */
@@ -1643,12 +1645,42 @@ static void hub_disconnect(struct usb_interface *intf)
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
+		parent = bus_to_hcd(hdev->bus)->self.sysdev;
+
+	for_each_child_of_node(parent->of_node, np) {
+		ret = of_pwrseq_on_list(np, &hub->pwrseq_on_list);
+		/* Maybe no power sequence library is chosen */
+		if (ret && ret != -ENOENT)
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
@@ -1753,6 +1785,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	INIT_DELAYED_WORK(&hub->leds, led_work);
 	INIT_DELAYED_WORK(&hub->init_work, NULL);
 	INIT_WORK(&hub->events, hub_event);
+	INIT_LIST_HEAD(&hub->pwrseq_on_list);
 	usb_get_intf(intf);
 	usb_get_dev(hdev);
 
@@ -1766,11 +1799,14 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
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
@@ -3584,14 +3620,19 @@ static int hub_suspend(struct usb_interface *intf, pm_message_t msg)
 
 	/* stop hub_wq and related activity */
 	hub_quiesce(hub, HUB_SUSPEND);
-	return 0;
+	return pwrseq_suspend_list(&hub->pwrseq_on_list);
 }
 
 static int hub_resume(struct usb_interface *intf)
 {
 	struct usb_hub *hub = usb_get_intfdata(intf);
+	int ret;
 
 	dev_dbg(&intf->dev, "%s\n", __func__);
+	ret = pwrseq_resume_list(&hub->pwrseq_on_list);
+	if (ret)
+		return ret;
+
 	hub_activate(hub, HUB_RESUME);
 	return 0;
 }
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


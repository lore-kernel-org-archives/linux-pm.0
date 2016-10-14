From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v8 4/8] usb: core: add power sequence handling for USB devices
Date: Fri, 14 Oct 2016 10:59:51 +0800
Message-ID: <1476413995-20361-5-git-send-email-peter.chen@nxp.com>
References: <1476413995-20361-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476413995-20361-1-git-send-email-peter.chen@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, stephen.boyd@linaro.org, oscar@naiandei.net, heiko@sntech.de, pawel.moll@arm.com, linux-pm@vger.kernel.org, Peter Chen <peter.chen@nxp.com>, s.hauer@pengutronix.de, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, troy.kisky@boundarydevices.com, vaibhav.hiremath@linaro.org, stillcompiling@gmail.com, arnd@arndb.de, p.zabel@pengutronix.de, festevam@gmail.com, mka@chromium.org, linux-arm-kernel@lists.infradead.org
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

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Tested-by Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/usb/core/hub.c | 41 ++++++++++++++++++++++++++++++++++++++---
 drivers/usb/core/hub.h |  1 +
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index cbb1467..acbbf0a 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/pm_qos.h>
+#include <linux/power/pwrseq.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -1695,6 +1696,7 @@ static void hub_disconnect(struct usb_interface *intf)
 	hub->error = 0;
 	hub_quiesce(hub, HUB_DISCONNECT);
 
+	of_pwrseq_off_list(&hub->pwrseq_on_list);
 	mutex_lock(&usb_port_peer_mutex);
 
 	/* Avoid races with recursively_mark_NOTATTACHED() */
@@ -1722,12 +1724,41 @@ static void hub_disconnect(struct usb_interface *intf)
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
@@ -1832,6 +1863,7 @@ descriptor_error:
 	INIT_DELAYED_WORK(&hub->leds, led_work);
 	INIT_DELAYED_WORK(&hub->init_work, NULL);
 	INIT_WORK(&hub->events, hub_event);
+	INIT_LIST_HEAD(&hub->pwrseq_on_list);
 	usb_get_intf(intf);
 	usb_get_dev(hdev);
 
@@ -1845,11 +1877,14 @@ descriptor_error:
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

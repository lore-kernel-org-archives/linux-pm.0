From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v2 4/6] usb: core: add power sequence handling for USB devices
Date: Wed, 13 Jul 2016 10:06:48 +0800
Message-ID: <1468375610-18625-5-git-send-email-peter.chen@nxp.com>
References: <1468375610-18625-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1468375610-18625-1-git-send-email-peter.chen@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, k.kozlowski@samsung.com, stephen.boyd@linaro.org, oscar@naiandei.net, arnd@arndb.de, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, linux-usb@vger.kernel.org, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, stillcompiling@gmail.com, Peter Chen <peter.chen@nxp.com>, p.zabel@pengutronix.de, festevam@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Some hard-wired USB devices need to do power sequence to let the
device work normally, the typical power sequence like: enable USB
PHY clock, toggle reset pin, etc. But current Linux USB driver
lacks of such code to do it, it may cause some hard-wired USB devices
works abnormal or can't be recognized by controller at all.

In this patch, it calls power sequence library APIs to finish
the power sequence events. At first, it calls pwrseq_alloc_generic
to create a generic power sequence instance, then it will do power
on sequence at hub's probe for all devices under this hub
(includes root hub) if this device is described at dts and there
is a property "power-sequence" for it.

At hub_disconnect, it will do power off sequence which is at powered
on list.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/usb/core/Makefile |   1 +
 drivers/usb/core/hub.c    |  12 ++++--
 drivers/usb/core/hub.h    |  12 ++++++
 drivers/usb/core/pwrseq.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+), 3 deletions(-)
 create mode 100644 drivers/usb/core/pwrseq.c

diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
index 9780877..39f2149 100644
--- a/drivers/usb/core/Makefile
+++ b/drivers/usb/core/Makefile
@@ -9,5 +9,6 @@ usbcore-y += port.o of.o
 
 usbcore-$(CONFIG_PCI)		+= hcd-pci.o
 usbcore-$(CONFIG_ACPI)		+= usb-acpi.o
+usbcore-$(CONFIG_PWRSEQ_GENERIC) += pwrseq.o
 
 obj-$(CONFIG_USB)		+= usbcore.o
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index bee1351..a346a8b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1700,6 +1700,7 @@ static void hub_disconnect(struct usb_interface *intf)
 	hub->error = 0;
 	hub_quiesce(hub, HUB_DISCONNECT);
 
+	hub_pwrseq_off(hub);
 	mutex_lock(&usb_port_peer_mutex);
 
 	/* Avoid races with recursively_mark_NOTATTACHED() */
@@ -1733,6 +1734,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+	int ret = -ENODEV;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
@@ -1839,6 +1841,7 @@ descriptor_error:
 	INIT_DELAYED_WORK(&hub->leds, led_work);
 	INIT_DELAYED_WORK(&hub->init_work, NULL);
 	INIT_WORK(&hub->events, hub_event);
+	INIT_LIST_HEAD(&hub->pwrseq_on_list);
 	usb_get_intf(intf);
 	usb_get_dev(hdev);
 
@@ -1852,11 +1855,14 @@ descriptor_error:
 	if (id->driver_info & HUB_QUIRK_CHECK_PORT_AUTOSUSPEND)
 		hub->quirk_check_port_auto_suspend = 1;
 
-	if (hub_configure(hub, endpoint) >= 0)
-		return 0;
+	if (hub_configure(hub, endpoint) >= 0) {
+		ret = hub_pwrseq_on(hub);
+		if (!ret)
+			return 0;
+	}
 
 	hub_disconnect(intf);
-	return -ENODEV;
+	return ret;
 }
 
 static int
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 34c1a7e..9473f6f 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -78,6 +78,7 @@ struct usb_hub {
 	struct delayed_work	init_work;
 	struct work_struct      events;
 	struct usb_port		**ports;
+	struct list_head	pwrseq_on_list; /* powered pwrseq node list */
 };
 
 /**
@@ -166,3 +167,14 @@ static inline int hub_port_debounce_be_stable(struct usb_hub *hub,
 {
 	return hub_port_debounce(hub, port1, false);
 }
+
+#if IS_ENABLED(CONFIG_PWRSEQ_GENERIC)
+int hub_pwrseq_on(struct usb_hub *hub);
+void hub_pwrseq_off(struct usb_hub *hub);
+#else
+static inline int hub_pwrseq_on(struct usb_hub *hub)
+{
+	return 0;
+}
+static inline void hub_pwrseq_off(struct usb_hub *hub) {}
+#endif /* CONFIG_PWRSEQ_GENERIC */
diff --git a/drivers/usb/core/pwrseq.c b/drivers/usb/core/pwrseq.c
new file mode 100644
index 0000000..df171ed
--- /dev/null
+++ b/drivers/usb/core/pwrseq.c
@@ -0,0 +1,102 @@
+/*
+ * pwrseq.c	USB device power sequence management
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Author: Peter Chen <peter.chen@nxp.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/power/pwrseq.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "hub.h"
+
+struct usb_pwrseq_node {
+	struct pwrseq *pwrseq;
+	struct list_head list;
+};
+
+static int hub_of_pwrseq_on(struct device_node *np, struct usb_hub *hub)
+{
+	struct pwrseq *pwrseq;
+	struct usb_pwrseq_node *pwrseq_node;
+	int ret;
+
+	pwrseq = pwrseq_alloc_generic();
+	if (IS_ERR(pwrseq))
+		return PTR_ERR(pwrseq);
+
+	ret = pwrseq_get(np, pwrseq);
+	if (ret)
+		goto pwr_free;
+
+	ret = pwrseq_on(np, pwrseq);
+	if (ret)
+		goto pwr_put;
+
+	pwrseq_node = kzalloc(sizeof(*pwrseq_node), GFP_KERNEL);
+	pwrseq_node->pwrseq = pwrseq;
+	list_add(&pwrseq_node->list, &hub->pwrseq_on_list);
+
+	return 0;
+
+pwr_put:
+	pwrseq_put(pwrseq);
+pwr_free:
+	pwrseq_free(pwrseq);
+	return ret;
+}
+
+int hub_pwrseq_on(struct usb_hub *hub)
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
+		if (is_pwrseq_supported(np)) {
+			ret = hub_of_pwrseq_on(np, hub);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+void hub_pwrseq_off(struct usb_hub *hub)
+{
+	struct pwrseq *pwrseq;
+	struct usb_pwrseq_node *pwrseq_node, *tmp_node;
+
+	list_for_each_entry_safe(pwrseq_node, tmp_node,
+			&hub->pwrseq_on_list, list) {
+		pwrseq = pwrseq_node->pwrseq;
+		pwrseq_off(pwrseq);
+		pwrseq_put(pwrseq);
+		pwrseq_free(pwrseq);
+		list_del(&pwrseq_node->list);
+		kfree(pwrseq_node);
+	}
+}
-- 
1.9.1

From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 6/6] USB / PM: Allow USB devices to remain runtime-suspended when sleeping
Date: Tue, 31 Mar 2015 18:14:50 +0200
Message-ID: <1427818501-10201-7-git-send-email-tomeu.vizoso@collabora.com>
References: <1427818501-10201-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427818501-10201-1-git-send-email-tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Scot Doyle <lkml14-enLWO88E2pdl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Julius Werner <jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pratyush Anand <pratyush.anand-qxv4g6HH51o@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Have dev_pm_ops.prepare return 1 for USB devices, interfaces, endpoints
and ports so that USB devices can remain runtime-suspended when the
system goes to a sleep state.

Also enable runtime PM for endpoints, which is another requirement for
the above to work.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
---
 drivers/usb/core/endpoint.c | 17 +++++++++++++++++
 drivers/usb/core/message.c  | 16 ++++++++++++++++
 drivers/usb/core/port.c     |  6 ++++++
 drivers/usb/core/usb.c      |  2 +-
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/endpoint.c b/drivers/usb/core/endpoint.c
index 39a2402..7c82bb7 100644
--- a/drivers/usb/core/endpoint.c
+++ b/drivers/usb/core/endpoint.c
@@ -160,6 +160,19 @@ static const struct attribute_group *ep_dev_groups[] = {
 	NULL
 };
 
+#ifdef	CONFIG_PM
+
+static int usb_ep_device_prepare(struct device *dev)
+{
+	return 1;
+}
+
+static const struct dev_pm_ops usb_ep_device_pm_ops = {
+	.prepare =	usb_ep_device_prepare,
+};
+
+#endif	/* CONFIG_PM */
+
 static void ep_device_release(struct device *dev)
 {
 	struct ep_device *ep_dev = to_ep_device(dev);
@@ -170,6 +183,9 @@ static void ep_device_release(struct device *dev)
 struct device_type usb_ep_device_type = {
 	.name =		"usb_endpoint",
 	.release = ep_device_release,
+#ifdef CONFIG_PM
+	.pm =		&usb_ep_device_pm_ops,
+#endif
 };
 
 int usb_create_ep_devs(struct device *parent,
@@ -197,6 +213,7 @@ int usb_create_ep_devs(struct device *parent,
 		goto error_register;
 
 	device_enable_async_suspend(&ep_dev->dev);
+	pm_runtime_enable(&ep_dev->dev);
 	endpoint->ep_dev = ep_dev;
 	return retval;
 
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index f368d20..9041aee 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1589,10 +1589,26 @@ static int usb_if_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+#ifdef	CONFIG_PM
+
+static int usb_if_prepare(struct device *dev)
+{
+	return 1;
+}
+
+static const struct dev_pm_ops usb_if_pm_ops = {
+	.prepare =	usb_if_prepare,
+};
+
+#endif	/* CONFIG_PM */
+
 struct device_type usb_if_device_type = {
 	.name =		"usb_interface",
 	.release =	usb_release_interface,
 	.uevent =	usb_if_uevent,
+#ifdef CONFIG_PM
+	.pm =		&usb_if_pm_ops,
+#endif
 };
 
 static struct usb_interface_assoc_descriptor *find_iad(struct usb_device *dev,
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 2106183..f49707d 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -168,12 +168,18 @@ static int usb_port_runtime_suspend(struct device *dev)
 
 	return retval;
 }
+
+static int usb_port_prepare(struct device *dev)
+{
+	return 1;
+}
 #endif
 
 static const struct dev_pm_ops usb_port_pm_ops = {
 #ifdef CONFIG_PM
 	.runtime_suspend =	usb_port_runtime_suspend,
 	.runtime_resume =	usb_port_runtime_resume,
+	.prepare =		usb_port_prepare,
 #endif
 };
 
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index b1fb9ae..1498faa 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -300,7 +300,7 @@ static int usb_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
 
 static int usb_dev_prepare(struct device *dev)
 {
-	return 0;		/* Implement eventually? */
+	return 1;		/* Implement eventually? */
 }
 
 static void usb_dev_complete(struct device *dev)
-- 
2.3.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

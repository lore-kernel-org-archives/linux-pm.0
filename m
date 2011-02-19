From: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Subject: [PATCH 1/3] xen: xenbus PM events support
Date: Sat, 19 Feb 2011 15:12:36 -0800
Message-ID: <1298157158-5421-2-git-send-email-rshriram__29444.6691907526$1298158071$gmane$org@cs.ubc.ca>
References: <1298157158-5421-1-git-send-email-rshriram@cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1298157158-5421-1-git-send-email-rshriram@cs.ubc.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: xen-devel@lists.xensource.com
Cc: Iam Campbell <ian.campbell@citrix.com>, Shriram Rajagopalan <rshriram@cs.ubc.ca>, linux-pm@lists.linux-foundation.org, Kazuhiro SUZUKI <kaz@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

From: Kazuhiro SUZUKI <kaz@jp.fujitsu.com>

Make xenbus frontend device subscribe to PM events
to receive suspend/resume/freeze/thaw/restore
notifications.

Signed-off-by: Kenji Wakamiya <wkenji@jp.fujitsu.com>
Signed-off-by: Kazuhiro Suzuki <kaz@jp.fujitsu.com>
Signed-off-by: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Acked-by: Ian Campbell <ian.campbell@citrix.com>
[shriram--minor mods and improved commit message]
---
 drivers/xen/xenbus/xenbus_probe.c          |   12 ++++++++++--
 drivers/xen/xenbus/xenbus_probe.h          |    3 ++-
 drivers/xen/xenbus/xenbus_probe_frontend.c |    9 +++++++--
 include/xen/xenbus.h                       |    2 +-
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index baa65e7..7397695 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -577,7 +577,7 @@ void xenbus_dev_changed(const char *node, struct xen_bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(xenbus_dev_changed);
 
-int xenbus_dev_suspend(struct device *dev, pm_message_t state)
+int xenbus_dev_suspend(struct device *dev)
 {
 	int err = 0;
 	struct xenbus_driver *drv;
@@ -590,7 +590,7 @@ int xenbus_dev_suspend(struct device *dev, pm_message_t state)
 		return 0;
 	drv = to_xenbus_driver(dev->driver);
 	if (drv->suspend)
-		err = drv->suspend(xdev, state);
+		err = drv->suspend(xdev);
 	if (err)
 		printk(KERN_WARNING
 		       "xenbus: suspend %s failed: %i\n", dev_name(dev), err);
@@ -642,6 +642,14 @@ int xenbus_dev_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(xenbus_dev_resume);
 
+int xenbus_dev_cancel(struct device *dev)
+{
+	/* Do nothing */
+	DPRINTK("cancel");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xenbus_dev_cancel);
+
 /* A flag to determine if xenstored is 'ready' (i.e. has started) */
 int xenstored_ready = 0;
 
diff --git a/drivers/xen/xenbus/xenbus_probe.h b/drivers/xen/xenbus/xenbus_probe.h
index 2466581..888b990 100644
--- a/drivers/xen/xenbus/xenbus_probe.h
+++ b/drivers/xen/xenbus/xenbus_probe.h
@@ -64,8 +64,9 @@ extern void xenbus_dev_changed(const char *node, struct xen_bus_type *bus);
 
 extern void xenbus_dev_shutdown(struct device *_dev);
 
-extern int xenbus_dev_suspend(struct device *dev, pm_message_t state);
+extern int xenbus_dev_suspend(struct device *dev);
 extern int xenbus_dev_resume(struct device *dev);
+extern int xenbus_dev_cancel(struct device *dev);
 
 extern void xenbus_otherend_changed(struct xenbus_watch *watch,
 				    const char **vec, unsigned int len,
diff --git a/drivers/xen/xenbus/xenbus_probe_frontend.c b/drivers/xen/xenbus/xenbus_probe_frontend.c
index 5bcc2d6..ea83999 100644
--- a/drivers/xen/xenbus/xenbus_probe_frontend.c
+++ b/drivers/xen/xenbus/xenbus_probe_frontend.c
@@ -85,6 +85,12 @@ static struct device_attribute xenbus_frontend_dev_attrs[] = {
 	__ATTR_NULL
 };
 
+static const struct dev_pm_ops xenbus_pm_ops = {
+	.suspend = xenbus_dev_suspend,
+	.resume  = xenbus_dev_resume,
+	.thaw  = xenbus_dev_cancel,
+};
+
 static struct xen_bus_type xenbus_frontend = {
 	.root = "device",
 	.levels = 2,		/* device/type/<id> */
@@ -100,8 +106,7 @@ static struct xen_bus_type xenbus_frontend = {
 		.shutdown	= xenbus_dev_shutdown,
 		.dev_attrs	= xenbus_frontend_dev_attrs,
 
-		.suspend	= xenbus_dev_suspend,
-		.resume		= xenbus_dev_resume,
+		.pm		= &xenbus_pm_ops,
 	},
 };
 
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 7a1d15f..5467369 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -92,7 +92,7 @@ struct xenbus_driver {
 	void (*otherend_changed)(struct xenbus_device *dev,
 				 enum xenbus_state backend_state);
 	int (*remove)(struct xenbus_device *dev);
-	int (*suspend)(struct xenbus_device *dev, pm_message_t state);
+	int (*suspend)(struct xenbus_device *dev);
 	int (*resume)(struct xenbus_device *dev);
 	int (*uevent)(struct xenbus_device *, struct kobj_uevent_env *);
 	struct device_driver driver;
-- 
1.7.0.4

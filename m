From: "SUZUKI, Kazuhiro" <kaz@jp.fujitsu.com>
Subject: [PATCH 2/2] Fix hangup after creating checkpoint on Xen.
Date: Mon, 07 Feb 2011 18:08:46 +0900 (JST)
Message-ID: <20110207.180846.2292930419738556212.kaz__14710.9331599951$1297097885$gmane$org@jp.fujitsu.com>
References: <20110207.180718.885783824287845425.kaz@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110207.180718.885783824287845425.kaz@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl, linux-pm@lists.linux-foundation.org
Cc: xen-devel@lists.xensource.com
List-Id: linux-pm@vger.kernel.org

Hi,

This is a Xen part patch.

Thanks,
KAZ

Signed-off-by: Kenji Wakamiya <wkenji@jp.fujitsu.com>
Signed-off-by: Kazuhiro Suzuki <kaz@jp.fujitsu.com>
---
 drivers/net/xen-netfront.c                 |    2 +-
 drivers/xen/manage.c                       |    7 ++++---
 drivers/xen/xenbus/xenbus_probe.c          |   12 ++++++++++--
 drivers/xen/xenbus/xenbus_probe.h          |    3 ++-
 drivers/xen/xenbus/xenbus_probe_frontend.c |    8 ++++++--
 include/xen/xenbus.h                       |    2 +-
 6 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 3f71199..22c6288 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1293,7 +1293,7 @@ static void xennet_disconnect_backend(struct netfront_info *info)
 	info->rx.sring = NULL;
 }
 
-static int netfront_suspend(struct xenbus_device *dev, pm_message_t state)
+static int netfront_suspend(struct xenbus_device *dev)
 {
 	struct netfront_info *info = dev_get_drvdata(&dev->dev);
 	struct hrtimer *timer = &info->smart_poll.timer;
diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index 0b50906..845afb8 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -148,10 +148,11 @@ out_resume:
 	if (!cancelled) {
 		xen_arch_resume();
 		xs_resume();
-	} else
+		dpm_resume_end(PMSG_RESUME);
+	} else {
 		xs_suspend_cancel();
-
-	dpm_resume_end(PMSG_RESUME);
+		dpm_resume_end(PMSG_CANCEL);
+	}
 
 	/* Make sure timer events get retriggered on all CPUs */
 	clock_was_set();
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 3a83ba2..02dbb8b 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -575,7 +575,7 @@ void xenbus_dev_changed(const char *node, struct xen_bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(xenbus_dev_changed);
 
-int xenbus_dev_suspend(struct device *dev, pm_message_t state)
+int xenbus_dev_suspend(struct device *dev)
 {
 	int err = 0;
 	struct xenbus_driver *drv;
@@ -587,7 +587,7 @@ int xenbus_dev_suspend(struct device *dev, pm_message_t state)
 		return 0;
 	drv = to_xenbus_driver(dev->driver);
 	if (drv->suspend)
-		err = drv->suspend(xdev, state);
+		err = drv->suspend(xdev);
 	if (err)
 		printk(KERN_WARNING
 		       "xenbus: suspend %s failed: %i\n", dev_name(dev), err);
@@ -638,6 +638,14 @@ int xenbus_dev_resume(struct device *dev)
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
index 0e5fc4c..4019187 100644
--- a/drivers/xen/xenbus/xenbus_probe.h
+++ b/drivers/xen/xenbus/xenbus_probe.h
@@ -62,8 +62,9 @@ extern void xenbus_dev_changed(const char *node, struct xen_bus_type *bus);
 
 extern void xenbus_dev_shutdown(struct device *_dev);
 
-extern int xenbus_dev_suspend(struct device *dev, pm_message_t state);
+extern int xenbus_dev_suspend(struct device *dev);
 extern int xenbus_dev_resume(struct device *dev);
+extern int xenbus_dev_cancel(struct device *dev);
 
 extern void xenbus_otherend_changed(struct xenbus_watch *watch,
 				    const char **vec, unsigned int len,
diff --git a/drivers/xen/xenbus/xenbus_probe_frontend.c b/drivers/xen/xenbus/xenbus_probe_frontend.c
index 5413248..6dfc588 100644
--- a/drivers/xen/xenbus/xenbus_probe_frontend.c
+++ b/drivers/xen/xenbus/xenbus_probe_frontend.c
@@ -82,6 +82,11 @@ static struct device_attribute xenbus_frontend_dev_attrs[] = {
 	__ATTR_NULL
 };
 
+static struct dev_pm_ops xenbus_pm_ops = {
+	.suspend = xenbus_dev_suspend,
+	.resume  = xenbus_dev_resume,
+	.cancel  = xenbus_dev_cancel,
+};
 
 static struct xen_bus_type xenbus_frontend = {
 	.root = "device",
@@ -98,8 +103,7 @@ static struct xen_bus_type xenbus_frontend = {
 		.shutdown = xenbus_dev_shutdown,
 		.dev_attrs= xenbus_frontend_dev_attrs,
 
-		.suspend  = xenbus_dev_suspend,
-		.resume   = xenbus_dev_resume,
+		.pm       = &xenbus_pm_ops,
 	},
 };
 
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 542ca7c..23e7f25 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -91,7 +91,7 @@ struct xenbus_driver {
 	void (*otherend_changed)(struct xenbus_device *dev,
 				 enum xenbus_state backend_state);
 	int (*remove)(struct xenbus_device *dev);
-	int (*suspend)(struct xenbus_device *dev, pm_message_t state);
+	int (*suspend)(struct xenbus_device *dev);
 	int (*resume)(struct xenbus_device *dev);
 	int (*uevent)(struct xenbus_device *, struct kobj_uevent_env *);
 	struct device_driver driver;
-- 
1.7.3.1

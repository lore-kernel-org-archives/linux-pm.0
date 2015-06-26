From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] bus: subsys: propagate errors from subsys interface's ->add_dev()
Date: Fri, 26 Jun 2015 14:32:47 +0530
Message-ID: <aff842c23841a8e61ac17e58fc27c99e052e338b.1435308918.git.viresh.kumar@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, pi-cheng.chen@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, "3.3+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

->add_dev() may fail and the error returned from it can be useful for
the caller.

For example, if some of the resources aren't ready yet and -EPROBE_DEFER
is returned from ->add_dev(), then the owner of 'struct
subsys_interface' may want to try probing again at a later point of
time. And that requires a proper return value from ->add_dev().

Also, if we hit an error while registering subsys_interface, then we
should stop proceeding further and rollback whatever has been done until
then. Break part of subsys_interface_unregister() into another routine,
which lets us call ->remove_dev() for all devices for which ->add_dev()
is already called.

Cc: 3.3+ <stable@vger.kernel.org> # 3.3+
Fixes: ca22e56debc5 ("driver-core: implement 'sysdev' functionality for regular devices and buses")
Reported-and-tested-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---

 drivers/base/bus.c | 55 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 79bc203f51ef..d92dc109ba51 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -1112,11 +1112,36 @@ void subsys_dev_iter_exit(struct subsys_dev_iter *iter)
 }
 EXPORT_SYMBOL_GPL(subsys_dev_iter_exit);
 
+static void __subsys_interface_unregister(struct subsys_interface *sif,
+					  struct device *lastdev)
+{
+	struct bus_type *subsys = sif->subsys;
+	struct subsys_dev_iter iter;
+	struct device *dev;
+
+	mutex_lock(&subsys->p->mutex);
+	list_del_init(&sif->node);
+	if (sif->remove_dev) {
+		subsys_dev_iter_init(&iter, subsys, NULL, NULL);
+		while ((dev = subsys_dev_iter_next(&iter))) {
+			if (dev == lastdev)
+				break;
+
+			sif->remove_dev(dev, sif);
+		}
+		subsys_dev_iter_exit(&iter);
+	}
+	mutex_unlock(&subsys->p->mutex);
+
+	bus_put(subsys);
+}
+
 int subsys_interface_register(struct subsys_interface *sif)
 {
 	struct bus_type *subsys;
 	struct subsys_dev_iter iter;
 	struct device *dev;
+	int ret = 0;
 
 	if (!sif || !sif->subsys)
 		return -ENODEV;
@@ -1129,38 +1154,28 @@ int subsys_interface_register(struct subsys_interface *sif)
 	list_add_tail(&sif->node, &subsys->p->interfaces);
 	if (sif->add_dev) {
 		subsys_dev_iter_init(&iter, subsys, NULL, NULL);
-		while ((dev = subsys_dev_iter_next(&iter)))
-			sif->add_dev(dev, sif);
+		while ((dev = subsys_dev_iter_next(&iter))) {
+			ret = sif->add_dev(dev, sif);
+			if (ret)
+				break;
+		}
 		subsys_dev_iter_exit(&iter);
 	}
 	mutex_unlock(&subsys->p->mutex);
 
-	return 0;
+	if (ret)
+		__subsys_interface_unregister(sif, dev);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(subsys_interface_register);
 
 void subsys_interface_unregister(struct subsys_interface *sif)
 {
-	struct bus_type *subsys;
-	struct subsys_dev_iter iter;
-	struct device *dev;
-
 	if (!sif || !sif->subsys)
 		return;
 
-	subsys = sif->subsys;
-
-	mutex_lock(&subsys->p->mutex);
-	list_del_init(&sif->node);
-	if (sif->remove_dev) {
-		subsys_dev_iter_init(&iter, subsys, NULL, NULL);
-		while ((dev = subsys_dev_iter_next(&iter)))
-			sif->remove_dev(dev, sif);
-		subsys_dev_iter_exit(&iter);
-	}
-	mutex_unlock(&subsys->p->mutex);
-
-	bus_put(subsys);
+	__subsys_interface_unregister(sif, NULL);
 }
 EXPORT_SYMBOL_GPL(subsys_interface_unregister);
 
-- 
2.4.0

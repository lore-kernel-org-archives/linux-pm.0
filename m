From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/6] driver core: Fix DL_FLAG_AUTOREMOVE_SUPPLIER device link flag handling
Date: Thu, 24 Jan 2019 12:15:48 +0100
Message-ID: <1741656.2uuZd5Vlsj@aspire.rjw.lan>
References: <2493187.oiOpCWJBV7@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2493187.oiOpCWJBV7@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

First, if the kref_put() in device_links_driver_cleanup() added by
commit 1689cac5b32a ("driver core: Add flag to autoremove device
link on supplier unbind") actually causes the link object to be
freed, the subsequent attempt to change the state of the link
can crash the kernel, so avoid it by changing the state of the link
before attempting to drop it.  Use the observation that the original
state of the link can be changed to "dormant" whatever it is, because
the link becomes, in fact, dormant at that point.

Second, change the list walk in device_links_driver_cleanup() to
a safe one to avoid use-after-free when dropping a link from the list
during the walk.

Finally, while at it, fix device_link_add() to refuse to create
stateless device links with DL_FLAG_AUTOREMOVE_SUPPLIER set, which is
an invalid combination (setting that flag means that the driver core
should manage the link, so it cannot be stateless), and extend the
kerneldoc comment of device_link_add() to cover the
DL_FLAG_AUTOREMOVE_SUPPLIER flag properly too.

Fixes: 1689cac5b32a ("driver core: Add flag to autoremove device link on supplier unbind")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c |   33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -179,10 +179,15 @@ void device_pm_move_to_tail(struct devic
  * of the link.  If DL_FLAG_PM_RUNTIME is not set, DL_FLAG_RPM_ACTIVE will be
  * ignored.
  *
- * If the DL_FLAG_AUTOREMOVE_CONSUMER is set, the link will be removed
- * automatically when the consumer device driver unbinds from it.
- * The combination of both DL_FLAG_AUTOREMOVE_CONSUMER and DL_FLAG_STATELESS
- * set is invalid and will cause NULL to be returned.
+ * If the DL_FLAG_AUTOREMOVE_CONSUMER flag is set, the reference to the link
+ * acquired by this function will be dropped automatically when the consumer
+ * device driver unbinds from it.  Analogously, if DL_FLAG_AUTOREMOVE_SUPPLIER
+ * is set in @flags, the reference to the link acquired by this function will
+ * be dropped automatically when the supplier device driver unbinds from it.
+ *
+ * The combination of DL_FLAG_STATELESS and either DL_FLAG_AUTOREMOVE_CONSUMER
+ * or DL_FLAG_AUTOREMOVE_SUPPLIER set in @flags at the same time is invalid and
+ * will cause NULL to be returned upfront.
  *
  * A side effect of the link creation is re-ordering of dpm_list and the
  * devices_kset list by moving the consumer device and all devices depending
@@ -199,8 +204,8 @@ struct device_link *device_link_add(stru
 	struct device_link *link;
 
 	if (!consumer || !supplier ||
-	    ((flags & DL_FLAG_STATELESS) &&
-	     (flags & DL_FLAG_AUTOREMOVE_CONSUMER)))
+	    (flags & DL_FLAG_STATELESS &&
+	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER | DL_FLAG_AUTOREMOVE_SUPPLIER)))
 		return NULL;
 
 	device_links_write_lock();
@@ -539,27 +544,21 @@ void device_links_no_driver(struct devic
  */
 void device_links_driver_cleanup(struct device *dev)
 {
-	struct device_link *link;
+	struct device_link *link, *ln;
 
 	device_links_write_lock();
 
-	list_for_each_entry(link, &dev->links.consumers, s_node) {
+	list_for_each_entry_safe(link, ln, &dev->links.consumers, s_node) {
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 
 		WARN_ON(link->flags & DL_FLAG_AUTOREMOVE_CONSUMER);
 		WARN_ON(link->status != DL_STATE_SUPPLIER_UNBIND);
 
-		/*
-		 * autoremove the links between this @dev and its consumer
-		 * devices that are not active, i.e. where the link state
-		 * has moved to DL_STATE_SUPPLIER_UNBIND.
-		 */
-		if (link->status == DL_STATE_SUPPLIER_UNBIND &&
-		    link->flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
-			kref_put(&link->kref, __device_link_del);
-
 		WRITE_ONCE(link->status, DL_STATE_DORMANT);
+
+		if (link->flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
+			kref_put(&link->kref, __device_link_del);
 	}
 
 	__device_links_no_driver(dev);

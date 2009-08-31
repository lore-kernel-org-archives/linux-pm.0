From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH update] ACPI / PM: Allow PCI root bridges to
	wake up the system
Date: Mon, 31 Aug 2009 23:24:20 +0200
Message-ID: <200908312324.20850.rjw__19074.2882936776$1251753934$gmane$org@sisk.pl>
References: <200908300041.14541.rjw@sisk.pl> <200908312141.00737.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908312141.00737.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 31 August 2009, Rafael J. Wysocki wrote:
> On Sunday 30 August 2009, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > If PCI root bridge is declared in the ACPI tables as a wake-up
> > device, allow it to wake up the system by default.
> > 
> > This allows add-on PCI devices to work as wake-up devices on some
> > systems, where PME# asserted by an add-on device causes the root
> > bridge GPE to generate a wake-up event, without using
> > /proc/acpi/wakeup to change the root bridge wake-up setting.

Updated patch is appended, but there's a problem with it.  Namely, when the
root bridge GPE is shared with other devices, those devices are also enabled
to wake up and they may be kind of "interesting" (on one of my test boxes they
include the ethernet and audio adapters).  I'm not sure what to do about that.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: ACPI / PM: Allow PCI root bridges to wake up the system

If PCI root bridge is declared in the ACPI tables as a wake-up
device, allow it to wake up the system by default.

This allows add-on PCI devices to work as wake-up devices on some
systems, where PME# asserted by an add-on device causes the root
bridge GPE to generate a wake-up event, without using
/proc/acpi/wakeup to change the root bridge wake-up setting.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/glue.c     |    9 +++++++++
 drivers/acpi/pci_root.c |   25 +++++++++++++------------
 drivers/acpi/proc.c     |   29 +----------------------------
 drivers/acpi/sleep.h    |    2 ++
 drivers/acpi/wakeup.c   |   35 +++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |    1 +
 6 files changed, 61 insertions(+), 40 deletions(-)

Index: linux-2.6/drivers/acpi/glue.c
===================================================================
--- linux-2.6.orig/drivers/acpi/glue.c
+++ linux-2.6/drivers/acpi/glue.c
@@ -13,6 +13,8 @@
 #include <linux/acpi.h>
 #include <linux/pm_link.h>
 
+#include "sleep.h"
+
 #define ACPI_GLUE_DEBUG	0
 #if ACPI_GLUE_DEBUG
 #define DBG(x...) printk(PREFIX x)
@@ -168,6 +170,13 @@ static int acpi_bind_one(struct device *
 				"physical_node");
 		if (acpi_dev->wakeup.flags.valid) {
 			device_set_wakeup_capable(dev, true);
+			/* Allow PCI root bridges to wake up the system. */
+			if (acpi_dev_is_root_bridge(acpi_dev)) {
+				mutex_lock(&acpi_device_lock);
+				acpi_dev->wakeup.state.enabled = true;
+				propagate_enable_wakeup(acpi_dev);
+				mutex_unlock(&acpi_device_lock);
+			}
 			device_set_wakeup_enable(dev,
 						acpi_dev->wakeup.state.enabled);
 		}
Index: linux-2.6/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_root.c
+++ linux-2.6/drivers/acpi/pci_root.c
@@ -138,26 +138,27 @@ acpi_handle acpi_get_pci_rootbridge_hand
 EXPORT_SYMBOL_GPL(acpi_get_pci_rootbridge_handle);
 
 /**
+ * acpi_dev_is_root_bridge - determine if an ACPI device is a PCI root bridge
+ * @device: ACPI device to check.
+ */
+bool acpi_dev_is_root_bridge(struct acpi_device *device)
+{
+	return !acpi_match_device_ids(device, root_device_ids);
+}
+
+/**
  * acpi_is_root_bridge - determine whether an ACPI CA node is a PCI root bridge
- * @handle - the ACPI CA node in question.
- *
- * Note: we could make this API take a struct acpi_device * instead, but
- * for now, it's more convenient to operate on an acpi_handle.
+ * @handle: the ACPI CA node in question.
  */
 int acpi_is_root_bridge(acpi_handle handle)
 {
 	int ret;
 	struct acpi_device *device;
 
-	ret = acpi_bus_get_device(handle, &device);
+	ret = !acpi_bus_get_device(handle, &device);
 	if (ret)
-		return 0;
-
-	ret = acpi_match_device_ids(device, root_device_ids);
-	if (ret)
-		return 0;
-	else
-		return 1;
+		ret = acpi_dev_is_root_bridge(device);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(acpi_is_root_bridge);
 
Index: linux-2.6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_bus.h
+++ linux-2.6/include/acpi/acpi_bus.h
@@ -371,6 +371,7 @@ struct device *acpi_get_physical_device(
 
 /* helper */
 acpi_handle acpi_get_child(acpi_handle, acpi_integer);
+bool acpi_dev_is_root_bridge(struct acpi_device *);
 int acpi_is_root_bridge(acpi_handle);
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
 #define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->archdata.acpi_handle))
Index: linux-2.6/drivers/acpi/proc.c
===================================================================
--- linux-2.6.orig/drivers/acpi/proc.c
+++ linux-2.6/drivers/acpi/proc.c
@@ -377,14 +377,6 @@ acpi_system_wakeup_device_seq_show(struc
 	return 0;
 }
 
-static void physical_device_enable_wakeup(struct acpi_device *adev)
-{
-	struct device *dev = acpi_get_physical_device(adev->handle);
-
-	if (dev && device_can_wakeup(dev))
-		device_set_wakeup_enable(dev, adev->wakeup.state.enabled);
-}
-
 static ssize_t
 acpi_system_write_wakeup_device(struct file *file,
 				const char __user * buffer,
@@ -420,26 +412,7 @@ acpi_system_write_wakeup_device(struct f
 	}
 	if (found_dev) {
 		physical_device_enable_wakeup(found_dev);
-		list_for_each_safe(node, next, &acpi_wakeup_device_list) {
-			struct acpi_device *dev = container_of(node,
-							       struct
-							       acpi_device,
-							       wakeup_list);
-
-			if ((dev != found_dev) &&
-			    (dev->wakeup.gpe_number ==
-			     found_dev->wakeup.gpe_number)
-			    && (dev->wakeup.gpe_device ==
-				found_dev->wakeup.gpe_device)) {
-				printk(KERN_WARNING
-				       "ACPI: '%s' and '%s' have the same GPE, "
-				       "can't disable/enable one seperately\n",
-				       dev->pnp.bus_id, found_dev->pnp.bus_id);
-				dev->wakeup.state.enabled =
-				    found_dev->wakeup.state.enabled;
-				physical_device_enable_wakeup(dev);
-			}
-		}
+		propagate_enable_wakeup(found_dev);
 	}
 	mutex_unlock(&acpi_device_lock);
 	return count;
Index: linux-2.6/drivers/acpi/wakeup.c
===================================================================
--- linux-2.6.orig/drivers/acpi/wakeup.c
+++ linux-2.6/drivers/acpi/wakeup.c
@@ -124,6 +124,41 @@ void acpi_disable_wakeup_device(u8 sleep
 	}
 }
 
+void physical_device_enable_wakeup(struct acpi_device *adev)
+{
+	struct device *dev = acpi_get_physical_device(adev->handle);
+
+	if (dev && device_can_wakeup(dev))
+		device_set_wakeup_enable(dev, adev->wakeup.state.enabled);
+}
+
+void propagate_enable_wakeup(struct acpi_device *wakeup_dev)
+{
+	struct list_head *node, *next;
+
+	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
+		struct acpi_device *dev =
+			container_of(node, struct acpi_device, wakeup_list);
+
+		if (!dev->wakeup.flags.valid)
+			continue;
+
+		if (dev == wakeup_dev)
+			continue;
+
+		if (dev->wakeup.gpe_number != wakeup_dev->wakeup.gpe_number
+		    || dev->wakeup.gpe_device != wakeup_dev->wakeup.gpe_device)
+			continue;
+
+		printk(KERN_WARNING "ACPI: '%s' and '%s' share a GPE, "
+			"unable to disable/enable one seperately\n",
+			dev->pnp.bus_id, wakeup_dev->pnp.bus_id);
+
+		dev->wakeup.state.enabled = wakeup_dev->wakeup.state.enabled;
+		physical_device_enable_wakeup(dev);
+	}
+}
+
 int __init acpi_wakeup_device_init(void)
 {
 	struct list_head *node, *next;
Index: linux-2.6/drivers/acpi/sleep.h
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.h
+++ linux-2.6/drivers/acpi/sleep.h
@@ -5,6 +5,8 @@ extern int acpi_suspend (u32 state);
 extern void acpi_enable_wakeup_device_prep(u8 sleep_state);
 extern void acpi_enable_wakeup_device(u8 sleep_state);
 extern void acpi_disable_wakeup_device(u8 sleep_state);
+extern void physical_device_enable_wakeup(struct acpi_device *adev);
+extern void propagate_enable_wakeup(struct acpi_device *wakeup_dev);
 
 extern struct list_head acpi_wakeup_device_list;
 extern struct mutex acpi_device_lock;

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PM: Allow PCI root bridges to wake up the
	system
Date: Sun, 30 Aug 2009 00:41:14 +0200
Message-ID: <200908300041.14541.rjw__48375.5699512132$1251585678$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

If PCI root bridge is declared in the ACPI tables as a wake-up
device, allow it to wake up the system by default.

This allows add-on PCI devices to work as wake-up devices on some
systems, where PME# asserted by an add-on device causes the root
bridge GPE to generate a wake-up event, without using
/proc/acpi/wakeup to change the root bridge wake-up setting.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/glue.c     |    3 +++
 drivers/acpi/pci_root.c |   25 +++++++++++++------------
 include/acpi/acpi_bus.h |    1 +
 3 files changed, 17 insertions(+), 12 deletions(-)

Index: linux-2.6/drivers/acpi/glue.c
===================================================================
--- linux-2.6.orig/drivers/acpi/glue.c
+++ linux-2.6/drivers/acpi/glue.c
@@ -168,6 +168,9 @@ static int acpi_bind_one(struct device *
 				"physical_node");
 		if (acpi_dev->wakeup.flags.valid) {
 			device_set_wakeup_capable(dev, true);
+			/* Allow PCI root bridges to wake up the system. */
+			if (acpi_dev_is_root_bridge(acpi_dev))
+				acpi_dev->wakeup.state.enabled = true;
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

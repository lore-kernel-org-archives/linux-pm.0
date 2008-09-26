From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: ACPI: Make /proc/acpi/wakeup interface handle PCI
	devices (again)
Date: Fri, 26 Sep 2008 22:21:47 +0200
Message-ID: <200809262221.48040.rjw__28958.3004582257$1222460323$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

Len,

I think we should do this in .27.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

ACPI: Make /proc/acpi/wakeup interface handle PCI devices (again)

Make the ACPI /proc/acpi/wakeup interface set the appropriate
wake-up bits of physical devices corresponding to the ACPI
devices and make those bits be set initially for devices that are
enabled to wake up by default.  This is needed to restore the
previous behavior for the PCI devices that were previously handled
correctly with the help of the /proc/acpi/wakeup interface.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/glue.c       |    5 ++++-
 drivers/acpi/sleep/proc.c |   10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/sleep/proc.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/proc.c
+++ linux-2.6/drivers/acpi/sleep/proc.c
@@ -377,6 +377,14 @@ acpi_system_wakeup_device_seq_show(struc
 	return 0;
 }
 
+static void physical_device_enable_wakeup(struct acpi_device *adev)
+{
+	struct device *dev = acpi_get_physical_device(adev->handle);
+
+	if (dev && device_can_wakeup(dev))
+		device_set_wakeup_enable(dev, adev->wakeup.state.enabled);
+}
+
 static ssize_t
 acpi_system_write_wakeup_device(struct file *file,
 				const char __user * buffer,
@@ -411,6 +419,7 @@ acpi_system_write_wakeup_device(struct f
 		}
 	}
 	if (found_dev) {
+		physical_device_enable_wakeup(found_dev);
 		list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 			struct acpi_device *dev = container_of(node,
 							       struct
@@ -428,6 +437,7 @@ acpi_system_write_wakeup_device(struct f
 				       dev->pnp.bus_id, found_dev->pnp.bus_id);
 				dev->wakeup.state.enabled =
 				    found_dev->wakeup.state.enabled;
+				physical_device_enable_wakeup(dev);
 			}
 		}
 	}
Index: linux-2.6/drivers/acpi/glue.c
===================================================================
--- linux-2.6.orig/drivers/acpi/glue.c
+++ linux-2.6/drivers/acpi/glue.c
@@ -165,8 +165,11 @@ static int acpi_bind_one(struct device *
 				"firmware_node");
 		ret = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
 				"physical_node");
-		if (acpi_dev->wakeup.flags.valid)
+		if (acpi_dev->wakeup.flags.valid) {
 			device_set_wakeup_capable(dev, true);
+			device_set_wakeup_enable(dev,
+						acpi_dev->wakeup.state.enabled);
+		}
 	}
 
 	return 0;

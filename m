From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 7/8] ACPI battery: support device async resume
Date: Wed, 15 Jul 2009 15:38:42 +0800
Message-ID: <1247643522.26272.82.camel__17784.8197090954$1247643830$gmane$org@rzhang-dt>
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
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>
Cc: Pavel Machek <pavel@suse.cz>, "Van De Ven,
	Arjan" <arjan.van.de.ven@intel.com>
List-Id: linux-pm@vger.kernel.org


ACPI battery supports device async actions.

Create an async domain for every ACPI battery device,
so that ACPI battery can be suspended/resumed/shutdown asynchronously.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/battery.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: linux-2.6/drivers/acpi/battery.c
===================================================================
--- linux-2.6.orig/drivers/acpi/battery.c
+++ linux-2.6/drivers/acpi/battery.c
@@ -829,6 +829,17 @@ static int acpi_battery_add(struct acpi_
 	strcpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 	device->driver_data = battery;
 	mutex_init(&battery->lock);
+
+	/*
+	 * dev_async_register must be called before any of its child
+	 * device being registered, i.e. power supply sysfs class device.
+	 */
+	result = dev_async_register(&device->dev, DEV_ASYNC_RESUME);
+	if (result) {
+		kfree(battery);
+		return result;
+	}
+
 	acpi_battery_update(battery);
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	result = acpi_battery_add_fs(device);
@@ -841,6 +852,7 @@ static int acpi_battery_add(struct acpi_
 #ifdef CONFIG_ACPI_PROCFS_POWER
 		acpi_battery_remove_fs(device);
 #endif
+		dev_async_unregister(&device->dev);
 		kfree(battery);
 	}
 	return result;
@@ -859,6 +871,7 @@ static int acpi_battery_remove(struct ac
 #ifdef CONFIG_ACPI_SYSFS_POWER
 	sysfs_remove_battery(battery);
 #endif
+	dev_async_unregister(&device->dev);
 	mutex_destroy(&battery->lock);
 	kfree(battery);
 	return 0;

From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.25-rc6 5/7] ACPI sets up
	device.power.can_wakeup flags
Date: Thu, 20 Mar 2008 14:20:40 -0700
Message-ID: <200803201420.40660.david-b__35657.4337035001$1206049158$gmane$org@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803201408.33466.david-b@pacbell.net>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This exports the "acpi_device.wakeup.flags.valid" flag to the driver
model as "device.power.can_wakeup".  That is, each "ACPI device" in
the /proc/acpi/wakeup file that corresponds to a "real" device will
initialize the can_wakeup flag to true.

A separate patch is needed to make ACPI pay attention to the userspace
input:  devices that can_wakeup have a should_wakeup flag, initially
true, which is settable via sysfs and tested using device_may_wakeup().
That's intended to be the primary policy input to the system, not the
ACPI-specific /proc/acpi/wakeup file.

Note also that the ACPI tables list only motherboard devices, but many
systems include more peripherals than those.  While the USB framework
handles USB peripherals, nothing in Linux currently sets those flags
for wakeup-capable devices on other expansion busses (like PCI).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/acpi/button.c |    3 +++
 drivers/acpi/glue.c   |    1 +
 drivers/acpi/power.c  |    4 ++++
 3 files changed, 8 insertions(+)

--- g26.orig/drivers/acpi/button.c	2008-03-20 03:02:45.000000000 -0700
+++ g26/drivers/acpi/button.c	2008-03-20 03:27:24.000000000 -0700
@@ -476,6 +476,9 @@ static int acpi_button_add(struct acpi_d
 	if (button->type == ACPI_BUTTON_TYPE_LID)
 		acpi_lid_send_state(button);
 
+	/* for these devices the ACPI node *IS* the "physical" device */
+	device_init_wakeup(&device->dev, device->wakeup.flags.valid);
+
 	if (device->wakeup.flags.valid) {
 		/* Button's GPE is run-wake GPE */
 		acpi_set_gpe_type(device->wakeup.gpe_device,
--- g26.orig/drivers/acpi/glue.c	2008-03-20 03:27:11.000000000 -0700
+++ g26/drivers/acpi/glue.c	2008-03-20 03:27:25.000000000 -0700
@@ -162,6 +162,7 @@ static int acpi_bind_one(struct device *
 	if (!ACPI_FAILURE(status)) {
 		int ret;
 
+		device_init_wakeup(dev, acpi_dev->wakeup.flags.valid);
 		ret = sysfs_create_link(&dev->kobj, &acpi_dev->dev.kobj,
 				"firmware_node");
 		if (ret != 0)
--- g26.orig/drivers/acpi/power.c	2008-03-20 03:02:45.000000000 -0700
+++ g26/drivers/acpi/power.c	2008-03-20 03:27:25.000000000 -0700
@@ -313,6 +313,7 @@ int acpi_enable_wakeup_device_power(stru
 		ret = acpi_power_on(dev->wakeup.resources.handles[i], dev);
 		if (ret) {
 			printk(KERN_ERR PREFIX "Transition power state\n");
+			device_init_wakeup(&dev->dev, 0);
 			dev->wakeup.flags.valid = 0;
 			return -1;
 		}
@@ -322,6 +323,7 @@ int acpi_enable_wakeup_device_power(stru
 	status = acpi_evaluate_object(dev->handle, "_PSW", &arg_list, NULL);
 	if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
 		printk(KERN_ERR PREFIX "Evaluate _PSW\n");
+		device_init_wakeup(&dev->dev, 0);
 		dev->wakeup.flags.valid = 0;
 		ret = -1;
 	}
@@ -351,6 +353,7 @@ int acpi_disable_wakeup_device_power(str
 	status = acpi_evaluate_object(dev->handle, "_PSW", &arg_list, NULL);
 	if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
 		printk(KERN_ERR PREFIX "Evaluate _PSW\n");
+		device_init_wakeup(&dev->dev, 0);
 		dev->wakeup.flags.valid = 0;
 		return -1;
 	}
@@ -360,6 +363,7 @@ int acpi_disable_wakeup_device_power(str
 		ret = acpi_power_off_device(dev->wakeup.resources.handles[i], dev);
 		if (ret) {
 			printk(KERN_ERR PREFIX "Transition power state\n");
+			device_init_wakeup(&dev->dev, 0);
 			dev->wakeup.flags.valid = 0;
 			return -1;
 		}

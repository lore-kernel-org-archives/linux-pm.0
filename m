From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 3/3] ACPI: parallel resume for ACPI battery
Date: Fri, 19 Dec 2008 14:34:11 +0800
Message-ID: <1229668453.562.91.camel__9694.72313668138$1229669031$gmane$org@rzhang-dt>
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
To: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org
Cc: "Barnes, Jesse" <jesse.barnes@intel.com>
List-Id: linux-pm@vger.kernel.org

Allow battery resume in parallel.

Signed-off-by: Zhang Rui <rui.zhang>
---
 drivers/acpi/battery.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/drivers/acpi/battery.c
===================================================================
--- linux-2.6.orig/drivers/acpi/battery.c
+++ linux-2.6/drivers/acpi/battery.c
@@ -819,6 +819,7 @@ static int acpi_battery_add(struct acpi_
 		result = -ENODEV;
 		goto end;
 	}
+	device_parallel_resume_register(&device->dev, 0);
 	printk(KERN_INFO PREFIX "%s Slot [%s] (battery %s)\n",
 	       ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
 	       device->status.battery_present ? "present" : "absent");
@@ -839,6 +840,8 @@ static int acpi_battery_remove(struct ac
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
+
+	device_parallel_resume_unregister(&device->dev);
 	battery = acpi_driver_data(device);
 	status = acpi_remove_notify_handler(device->handle,
 					    ACPI_ALL_NOTIFY,

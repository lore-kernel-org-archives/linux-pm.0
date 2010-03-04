From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PM: Move ACPI video resume to a PM
	notifier
Date: Thu, 4 Mar 2010 01:25:30 +0100
Message-ID: <201003040125.30091.rjw__27171.2813912474$1267662329$gmane$org@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

There is a problem with the ACPI video resume routine that it's
executed before the GPU that may be accessed by it.  To fix this
issue, move the ACPI video resume to a power management notifier,
so that it's executed after resuming all devices, including the GPU.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/video.c |   31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -43,6 +43,7 @@
 #include <linux/dmi.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <linux/suspend.h>
 
 #define PREFIX "ACPI: "
 
@@ -88,7 +89,6 @@ module_param(allow_duplicates, bool, 064
 static int register_count = 0;
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
-static int acpi_video_resume(struct acpi_device *device);
 static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id video_device_ids[] = {
@@ -104,7 +104,6 @@ static struct acpi_driver acpi_video_bus
 	.ops = {
 		.add = acpi_video_bus_add,
 		.remove = acpi_video_bus_remove,
-		.resume = acpi_video_resume,
 		.notify = acpi_video_bus_notify,
 		},
 };
@@ -159,6 +158,7 @@ struct acpi_video_bus {
 	struct proc_dir_entry *dir;
 	struct input_dev *input;
 	char phys[32];	/* for input device */
+	struct notifier_block pm_nb;
 };
 
 struct acpi_video_device_flags {
@@ -2226,24 +2226,31 @@ static void acpi_video_device_notify(acp
 	return;
 }
 
-static int instance;
-static int acpi_video_resume(struct acpi_device *device)
+static int acpi_video_resume(struct notifier_block *nb,
+				unsigned long val, void *ign)
 {
 	struct acpi_video_bus *video;
 	struct acpi_video_device *video_device;
 	int i;
 
-	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
+	switch (val) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
+	case PM_RESTORE_PREPARE:
+		return NOTIFY_DONE;
+	}
 
-	video = acpi_driver_data(device);
+	video = container_of(nb, struct acpi_video_bus, pm_nb);
+
+	dev_info(&video->device->dev, "Restoring backlight state\n");
 
 	for (i = 0; i < video->attached_count; i++) {
 		video_device = video->attached_array[i].bind_info;
 		if (video_device && video_device->backlight)
 			acpi_video_set_brightness(video_device->backlight);
 	}
-	return AE_OK;
+
+	return NOTIFY_OK;
 }
 
 static acpi_status
@@ -2267,6 +2274,8 @@ acpi_video_bus_match(acpi_handle handle,
 	return AE_OK;
 }
 
+static int instance;
+
 static int acpi_video_bus_add(struct acpi_device *device)
 {
 	struct acpi_video_bus *video;
@@ -2360,6 +2369,10 @@ static int acpi_video_bus_add(struct acp
 	       video->flags.rom ? "yes" : "no",
 	       video->flags.post ? "yes" : "no");
 
+	video->pm_nb.notifier_call = acpi_video_resume;
+	video->pm_nb.priority = 0;
+	register_pm_notifier(&video->pm_nb);
+
 	return 0;
 
  err_free_input_dev:
@@ -2386,6 +2399,8 @@ static int acpi_video_bus_remove(struct 
 
 	video = acpi_driver_data(device);
 
+	unregister_pm_notifier(&video->pm_nb);
+
 	acpi_video_bus_stop_devices(video);
 	acpi_video_bus_put_devices(video);
 	acpi_video_bus_remove_fs(device);

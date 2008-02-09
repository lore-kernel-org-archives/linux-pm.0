From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.25-rc0
Date: Sat, 9 Feb 2008 07:36:19 +0100
Message-ID: <20080209063619.GA20225__11330.3038677715$1202540760$gmane$org@elte.hu>
References: <200802070450.09098.lenb@kernel.org>
	<20080209063439.GA19995@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080209063439.GA19995@elte.hu>
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
Cc: Thomas Sujith <sujith.thomas@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> one of these caused a build failure in x86.git overnight randconfig 
> testing:
> 
> drivers/built-in.o: In function `acpi_fan_remove':
> fan.c:(.text+0x361d5): undefined reference to `thermal_cooling_device_unregister'
> drivers/built-in.o: In function `acpi_fan_add':
> fan.c:(.text+0x3625e): undefined reference to `thermal_cooling_device_register'
> 
> i suspect it might be this one:
> 
> >       ACPI: register ACPI thermal zone as generic thermal zone devices
> 
> config attached.

yep, reverting 05a83d972293f3 fixes the build failure.

	Ingo

-------------->
commit 05a83d972293f39a66bc2aa409a5e7996bba585d
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Thu Jan 17 15:51:24 2008 +0800

    ACPI: register ACPI Fan as generic thermal cooling device
    
    Register ACPI Fan as thermal cooling device.
    
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index a6e149d..f6e8165 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -30,7 +30,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
-
+#include <linux/thermal.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -68,9 +68,55 @@ static struct acpi_driver acpi_fan_driver = {
 		},
 };
 
+/* thermal cooling device callbacks */
+static int fan_get_max_state(struct thermal_cooling_device *cdev, char *buf)
+{
+	/* ACPI fan device only support two states: ON/OFF */
+	return sprintf(buf, "1\n");
+}
+
+static int fan_get_cur_state(struct thermal_cooling_device *cdev, char *buf)
+{
+	struct acpi_device *device = cdev->devdata;
+	int state;
+	int result;
+
+	if (!device)
+		return -EINVAL;
+
+	result = acpi_bus_get_power(device->handle, &state);
+	if (result)
+		return result;
+
+	return sprintf(buf, "%s\n", state == ACPI_STATE_D3 ? "0" :
+			 (state == ACPI_STATE_D0 ? "1" : "unknown"));
+}
+
+static int
+fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned int state)
+{
+	struct acpi_device *device = cdev->devdata;
+	int result;
+
+	if (!device || (state != 0 && state != 1))
+		return -EINVAL;
+
+	result = acpi_bus_set_power(device->handle,
+				state ? ACPI_STATE_D0 : ACPI_STATE_D3);
+
+	return result;
+}
+
+static struct thermal_cooling_device_ops fan_cooling_ops = {
+	.get_max_state = fan_get_max_state,
+	.get_cur_state = fan_get_cur_state,
+	.set_cur_state = fan_set_cur_state,
+};
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
+#ifdef CONFIG_ACPI_PROCFS
 
 static struct proc_dir_entry *acpi_fan_dir;
 
@@ -171,7 +217,17 @@ static int acpi_fan_remove_fs(struct acpi_device *device)
 
 	return 0;
 }
+#else
+static int acpi_fan_add_fs(struct acpi_device *device)
+{
+	return 0;
+}
 
+static int acpi_fan_remove_fs(struct acpi_device *device)
+{
+	return 0;
+}
+#endif
 /* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
@@ -179,9 +235,8 @@ static int acpi_fan_remove_fs(struct acpi_device *device)
 static int acpi_fan_add(struct acpi_device *device)
 {
 	int result = 0;
-	struct acpi_fan *fan = NULL;
 	int state = 0;
-
+	struct thermal_cooling_device *cdev;
 
 	if (!device)
 		return -EINVAL;
@@ -199,6 +254,25 @@ static int acpi_fan_add(struct acpi_device *device)
 	acpi_bus_set_power(device->handle, state);
 	device->flags.force_power_state = 0;
 
+	cdev = thermal_cooling_device_register("Fan", device,
+						&fan_cooling_ops);
+	if (cdev)
+		printk(KERN_INFO PREFIX
+			"%s is registered as cooling_device%d\n",
+			device->dev.bus_id, cdev->id);
+	else
+		goto end;
+	acpi_driver_data(device) = cdev;
+	result = sysfs_create_link(&device->dev.kobj, &cdev->device.kobj,
+					"thermal_cooling");
+	if (result)
+		return result;
+
+	result = sysfs_create_link(&cdev->device.kobj, &device->dev.kobj,
+                                       "device");
+        if (result)
+                return result;
+
 	result = acpi_fan_add_fs(device);
 	if (result)
 		goto end;
@@ -208,18 +282,20 @@ static int acpi_fan_add(struct acpi_device *device)
 	       !device->power.state ? "on" : "off");
 
       end:
-	if (result)
-		kfree(fan);
-
 	return result;
 }
 
 static int acpi_fan_remove(struct acpi_device *device, int type)
 {
-	if (!device || !acpi_driver_data(device))
+	struct thermal_cooling_device *cdev = acpi_driver_data(device);
+
+	if (!device || !cdev)
 		return -EINVAL;
 
 	acpi_fan_remove_fs(device);
+	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+	sysfs_remove_link(&cdev->device.kobj, "device");
+	thermal_cooling_device_unregister(cdev);
 
 	return 0;
 }

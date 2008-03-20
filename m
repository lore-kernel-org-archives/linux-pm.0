From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.25-rc6 6/7] ACPI uses device_may_wakeup()
	policy inputs
Date: Thu, 20 Mar 2008 14:22:54 -0700
Message-ID: <200803201422.55014.david-b__2788.91653656519$1206049397$gmane$org@pacbell.net>
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

This imports the driver model device.power.may_wakeup flags to ACPI,
using it to *REPLACE* the /proc/acpi/wakeup flags for some devices.
It depends on the previous patch making device.power.can_wakeup behave.
It does that by:

 - Implementing platform_enable_wakeup(), which is currently invoked only
   by pci_enable_wake().  When that's called -- probably in the driver
   suspend() call -- it updates acpi_device.wakeup.state.enabled flag in
   the same way writing to /proc/acpi/wakeup updates it.
   
 - Updating the usage of the corresponding ACPI flags when turning on
   wakeup power domains and GPEs.

THIS PATCH NEEDS MORE ATTENTION because of the way the ACPI method
invocations have been changing, e.g. the 1.0 vs 2.0 sequencing.

Right now it's not clear to me whether the GPEs are always enabled at
the right time, and for that matter whether the rules haven't changed
so that drivers can no longer effectively control those settings from
suspend() unless acpi_new_pts_ordering is in effect...

---
 drivers/acpi/sleep/main.c   |    2 +-
 drivers/acpi/sleep/wakeup.c |   44 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 3 deletions(-)

--- g26.orig/drivers/acpi/sleep/main.c	2008-02-24 02:07:57.000000000 -0800
+++ g26/drivers/acpi/sleep/main.c	2008-02-24 02:08:04.000000000 -0800
@@ -470,7 +470,7 @@ int acpi_pm_device_sleep_state(struct de
 	 * can wake the system.  _S0W may be valid, too.
 	 */
 	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
-	    (device_may_wakeup(dev) && adev->wakeup.state.enabled &&
+	    (device_may_wakeup(dev) &&
 	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
 		acpi_status status;
 
--- g26.orig/drivers/acpi/sleep/wakeup.c	2008-02-24 02:03:27.000000000 -0800
+++ g26/drivers/acpi/sleep/wakeup.c	2008-02-24 02:08:04.000000000 -0800
@@ -35,12 +35,22 @@ void acpi_enable_wakeup_device_prep(u8 s
 		struct acpi_device *dev = container_of(node,
 						       struct acpi_device,
 						       wakeup_list);
+		struct device *ldev;
 
 		if (!dev->wakeup.flags.valid ||
 		    !dev->wakeup.state.enabled ||
 		    (sleep_state > (u32) dev->wakeup.sleep_state))
 			continue;
 
+		ldev = acpi_get_physical_device(dev->handle);
+		if (ldev) {
+			int flag = device_may_wakeup(ldev);
+
+			put_device(ldev);
+			if (!flag)
+				continue;
+		}
+
 		spin_unlock(&acpi_device_lock);
 		acpi_enable_wakeup_device_power(dev);
 		spin_lock(&acpi_device_lock);
@@ -57,8 +67,8 @@ void acpi_enable_wakeup_device(u8 sleep_
 {
 	struct list_head *node, *next;
 
-	/* 
-	 * Caution: this routine must be invoked when interrupt is disabled 
+	/*
+	 * Caution: this routine must be invoked when interrupt is disabled
 	 * Refer ACPI2.0: P212
 	 */
 	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device");
@@ -107,6 +117,7 @@ void acpi_disable_wakeup_device(u8 sleep
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
 			container_of(node, struct acpi_device, wakeup_list);
+		struct device *ldev;
 
 		if (!dev->wakeup.flags.valid)
 			continue;
@@ -125,6 +136,15 @@ void acpi_disable_wakeup_device(u8 sleep
 			continue;
 		}
 
+		ldev = acpi_get_physical_device(dev->handle);
+		if (ldev) {
+			int flag = device_may_wakeup(ldev);
+
+			put_device(ldev);
+			if (!flag)
+				continue;
+		}
+
 		spin_unlock(&acpi_device_lock);
 		acpi_disable_wakeup_device_power(dev);
 		/* Never disable run-wake GPE */
@@ -139,6 +159,24 @@ void acpi_disable_wakeup_device(u8 sleep
 	spin_unlock(&acpi_device_lock);
 }
 
+static int acpi_platform_enable_wakeup(struct device *dev, int is_on)
+{
+	struct acpi_device	*adev;
+	int			status;
+
+	if (!device_can_wakeup(dev))
+		return -EINVAL;
+	if (is_on && !device_may_wakeup(dev))
+		return -EINVAL;
+
+	status = acpi_bus_get_device(DEVICE_ACPI_HANDLE(dev), &adev);
+	if (status < 0)
+		return status;
+
+	adev->wakeup.state.enabled = !!is_on;
+	return 0;
+}
+
 static int __init acpi_wakeup_device_init(void)
 {
 	struct list_head *node, *next;
@@ -146,6 +184,8 @@ static int __init acpi_wakeup_device_ini
 	if (acpi_disabled)
 		return 0;
 
+	platform_enable_wakeup = acpi_platform_enable_wakeup;
+
 	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev = container_of(node,

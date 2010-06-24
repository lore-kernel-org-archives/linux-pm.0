From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/6] ACPI: Introduce acpi_gpe_wakeup()
Date: Fri, 25 Jun 2010 01:18:39 +0200
Message-ID: <201006250118.39553.rjw__44695.4833380461$1277422343$gmane$org@sisk.pl>
References: <201006250117.45148.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006250117.45148.rjw@sisk.pl>
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
Cc: len.brown@intel.com, "Lin, Ming M" <ming.m.lin@intel.com>, "Moore,
	Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

ACPICA uses reference counters to avoid disabling GPEs too early in
case they have been enabled for many times.  This is done separately
for runtime and for wakeup, but the wakeup GPE reference counter is
not really necessary, because GPEs are only enabled to wake up the
system at the hardware level by acpi_enter_sleep_state().  Thus it
only is necessary to set the corresponding bits in the wakeup enable
masks of these GPEs' registers right before the system enters a sleep
state.  Moreover, the GPE wakeup enable bits can only be set when the
target sleep state of the system is known and they need to be cleared
immediately after wakeup regardless of how many wakeup devices are
associated with a given GPE.

On the basis of the above observations, introduce function
acpi_gpe_wakeup() to be used for setting or clearing the enable bit
corresponding to a given GPE in its enable register's enable_for_wake
mask.  Modify the ACPI suspend and wakeup code the use
acpi_gpe_wakeup() instead of acpi_{enable|disable}_gpe() to set
and clear GPE enable bits in their registers' enable_for_wake masks
during system transitions to a sleep state and back to the working
state, respectively.  [This will allow us to drop the third
argument of acpi_{enable|disable}_gpe() and simplify the GPE
handling code.]

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/evxfevnt.c |   61 +++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/sleep.c           |   15 ++--------
 drivers/acpi/wakeup.c          |   18 +++++++-----
 include/acpi/acpixf.h          |    2 +
 include/acpi/actypes.h         |    2 -
 5 files changed, 78 insertions(+), 20 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/evxfevnt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-2.6/drivers/acpi/acpica/evxfevnt.c
@@ -208,6 +208,67 @@ acpi_status acpi_enable_event(u32 event,
 
 ACPI_EXPORT_SYMBOL(acpi_enable_event)
 
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_gpe_wakeup
+ *
+ * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number      - GPE level within the GPE block
+ *              action          - Disable or enable
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Set or clear the GPE's wakeup enable mask bit.
+ *
+ ******************************************************************************/
+acpi_status acpi_gpe_wakeup(acpi_handle gpe_device, u32 gpe_number, u8 action)
+{
+	acpi_status status = AE_OK;
+	struct acpi_gpe_event_info *gpe_event_info;
+	struct acpi_gpe_register_info *gpe_register_info;
+	u32 register_bit;
+	acpi_cpu_flags flags;
+
+	ACPI_FUNCTION_TRACE(acpi_gpe_wakeup);
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	/* Ensure that we have a valid GPE number */
+
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (!gpe_event_info) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+
+	gpe_register_info = gpe_event_info->register_info;
+	if (!gpe_register_info) {
+		status = AE_NOT_EXIST;
+		goto unlock_and_exit;
+	}
+
+	register_bit = acpi_hw_gpe_register_bit(gpe_event_info,
+						gpe_register_info);
+	switch (action) {
+	case ACPI_GPE_ENABLE:
+		ACPI_SET_BIT(gpe_register_info->enable_for_wake, register_bit);
+		break;
+
+	case ACPI_GPE_DISABLE:
+		ACPI_CLEAR_BIT(gpe_register_info->enable_for_wake, register_bit);
+		break;
+
+	default:
+		ACPI_ERROR((AE_INFO, "Invalid action\n"));
+		status = AE_BAD_PARAMETER;
+	}
+
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+ACPI_EXPORT_SYMBOL(acpi_gpe_wakeup)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_clear_and_enable_gpe
Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h
+++ linux-2.6/include/acpi/acpixf.h
@@ -281,6 +281,8 @@ acpi_status acpi_get_event_status(u32 ev
 /*
  * GPE Interfaces
  */
+acpi_status acpi_gpe_wakeup(acpi_handle gpe_device, u32 gpe_number, u8 action);
+
 acpi_status acpi_set_gpe(acpi_handle gpe_device, u32 gpe_number, u8 action);
 
 acpi_status
Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -664,18 +664,9 @@ int acpi_pm_device_sleep_wake(struct dev
 		return -ENODEV;
 	}
 
-	if (enable) {
-		error = acpi_enable_wakeup_device_power(adev,
-						acpi_target_sleep_state);
-		if (!error)
-			acpi_enable_gpe(adev->wakeup.gpe_device,
-					adev->wakeup.gpe_number,
-					ACPI_GPE_TYPE_WAKE);
-	} else {
-		acpi_disable_gpe(adev->wakeup.gpe_device, adev->wakeup.gpe_number,
-				ACPI_GPE_TYPE_WAKE);
-		error = acpi_disable_wakeup_device_power(adev);
-	}
+	error = enable ?
+		acpi_enable_wakeup_device_power(adev, acpi_target_sleep_state) :
+		acpi_disable_wakeup_device_power(adev);
 	if (!error)
 		dev_info(dev, "wake-up capability %s by ACPI\n",
 				enable ? "enabled" : "disabled");
Index: linux-2.6/drivers/acpi/wakeup.c
===================================================================
--- linux-2.6.orig/drivers/acpi/wakeup.c
+++ linux-2.6/drivers/acpi/wakeup.c
@@ -64,13 +64,14 @@ void acpi_enable_wakeup_device(u8 sleep_
 		struct acpi_device *dev =
 			container_of(node, struct acpi_device, wakeup_list);
 
-		if (!dev->wakeup.flags.valid || !dev->wakeup.state.enabled
+		if (!dev->wakeup.flags.valid
+		    || !(dev->wakeup.state.enabled || dev->wakeup.prepare_count)
 		    || sleep_state > (u32) dev->wakeup.sleep_state)
 			continue;
 
 		/* The wake-up power should have been enabled already. */
-		acpi_enable_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
-				ACPI_GPE_TYPE_WAKE);
+		acpi_gpe_wakeup(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
+				ACPI_GPE_ENABLE);
 	}
 }
 
@@ -89,13 +90,16 @@ void acpi_disable_wakeup_device(u8 sleep
 		struct acpi_device *dev =
 			container_of(node, struct acpi_device, wakeup_list);
 
-		if (!dev->wakeup.flags.valid || !dev->wakeup.state.enabled
+		if (!dev->wakeup.flags.valid
+		    || !(dev->wakeup.state.enabled || dev->wakeup.prepare_count)
 		    || (sleep_state > (u32) dev->wakeup.sleep_state))
 			continue;
 
-		acpi_disable_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
-				ACPI_GPE_TYPE_WAKE);
-		acpi_disable_wakeup_device_power(dev);
+		acpi_gpe_wakeup(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
+				ACPI_GPE_DISABLE);
+
+		if (dev->wakeup.state.enabled)
+			acpi_disable_wakeup_device_power(dev);
 	}
 }
 
Index: linux-2.6/include/acpi/actypes.h
===================================================================
--- linux-2.6.orig/include/acpi/actypes.h
+++ linux-2.6/include/acpi/actypes.h
@@ -663,7 +663,7 @@ typedef u32 acpi_event_status;
 #define ACPI_GPE_MAX                    0xFF
 #define ACPI_NUM_GPE                    256
 
-/* Actions for acpi_set_gpe and acpi_hw_low_set_gpe */
+/* Actions for acpi_set_gpe, acpi_hw_low_set_gpe and acpi_gpe_wakeup */
 
 #define ACPI_GPE_ENABLE                 0
 #define ACPI_GPE_DISABLE                1

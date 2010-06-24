From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/6] ACPI: Remove wakeup GPE reference counting
	which is not used
Date: Fri, 25 Jun 2010 01:19:35 +0200
Message-ID: <201006250119.35566.rjw__30560.9326497235$1277422592$gmane$org@sisk.pl>
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

After the previous patch that introduced acpi_gpe_wakeup() and
modified the ACPI suspend and wakeup code to use it, the third
argument of acpi_{enable|disable}_gpe() and the GPE wakeup
reference counter are not necessary any more.  Remove them and
modify all of the users of acpi_{enable|disable}_gpe()
accordingly.  Also drop GPE type constants that aren't used
any more.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/acevents.h  |    2 
 drivers/acpi/acpica/aclocal.h   |    1 
 drivers/acpi/acpica/evgpe.c     |   13 +---
 drivers/acpi/acpica/evgpeblk.c  |    3 -
 drivers/acpi/acpica/evgpeinit.c |    3 -
 drivers/acpi/acpica/evxfevnt.c  |  114 ++++++++--------------------------------
 drivers/acpi/button.c           |    6 --
 drivers/acpi/ec.c               |    6 +-
 drivers/acpi/system.c           |    6 --
 drivers/pci/pci-acpi.c          |    6 --
 include/acpi/acpixf.h           |    6 --
 include/acpi/actypes.h          |    6 --
 12 files changed, 43 insertions(+), 129 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/acevents.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/acevents.h
+++ linux-2.6/drivers/acpi/acpica/acevents.h
@@ -78,7 +78,7 @@ acpi_ev_queue_notify_request(struct acpi
 u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info *gpe_xrupt_list);
 
 acpi_status
-acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info);
+acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info);
 
 struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 						       u32 gpe_number);
Index: linux-2.6/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpe.c
+++ linux-2.6/drivers/acpi/acpica/evgpe.c
@@ -54,7 +54,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_as
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ev_update_gpe_enable_masks
+ * FUNCTION:    acpi_ev_update_gpe_enable_mask
  *
  * PARAMETERS:  gpe_event_info          - GPE to update
  *
@@ -66,7 +66,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_as
  ******************************************************************************/
 
 acpi_status
-acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info)
+acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info)
 {
 	struct acpi_gpe_register_info *gpe_register_info;
 	u32 register_bit;
@@ -81,21 +81,16 @@ acpi_ev_update_gpe_enable_masks(struct a
 	register_bit = acpi_hw_gpe_register_bit(gpe_event_info,
 						gpe_register_info);
 
-	/* Clear the wake/run bits up front */
+	/* Clear the run bit up front */
 
-	ACPI_CLEAR_BIT(gpe_register_info->enable_for_wake, register_bit);
 	ACPI_CLEAR_BIT(gpe_register_info->enable_for_run, register_bit);
 
-	/* Set the mask bits only if there are references to this GPE */
+	/* Set the mask bit only if there are references to this GPE */
 
 	if (gpe_event_info->runtime_count) {
 		ACPI_SET_BIT(gpe_register_info->enable_for_run, register_bit);
 	}
 
-	if (gpe_event_info->wakeup_count) {
-		ACPI_SET_BIT(gpe_register_info->enable_for_wake, register_bit);
-	}
-
 	return_ACPI_STATUS(AE_OK);
 }
 
Index: linux-2.6/drivers/acpi/acpica/evxfevnt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-2.6/drivers/acpi/acpica/evxfevnt.c
@@ -373,17 +373,14 @@ ACPI_EXPORT_SYMBOL(acpi_set_gpe)
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number      - GPE level within the GPE block
- *              gpe_type        - ACPI_GPE_TYPE_RUNTIME or ACPI_GPE_TYPE_WAKE
- *                                or both
  *
  * RETURN:      Status
  *
  * DESCRIPTION: Add a reference to a GPE. On the first reference, the GPE is
- *              hardware-enabled (for runtime GPEs), or the GPE register mask
- *              is updated (for wake GPEs).
+ *              hardware-enabled.
  *
  ******************************************************************************/
-acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type)
+acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
 {
 	acpi_status status = AE_OK;
 	struct acpi_gpe_event_info *gpe_event_info;
@@ -391,12 +388,6 @@ acpi_status acpi_enable_gpe(acpi_handle 
 
 	ACPI_FUNCTION_TRACE(acpi_enable_gpe);
 
-	/* Parameter validation */
-
-	if (!gpe_type || (gpe_type & ~ACPI_GPE_TYPE_WAKE_RUN)) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
-
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/* Ensure that we have a valid GPE number */
@@ -407,46 +398,20 @@ acpi_status acpi_enable_gpe(acpi_handle 
 		goto unlock_and_exit;
 	}
 
-	if (gpe_type & ACPI_GPE_TYPE_RUNTIME) {
-		if (gpe_event_info->runtime_count == ACPI_UINT8_MAX) {
-			status = AE_LIMIT;	/* Too many references */
-			goto unlock_and_exit;
-		}
-
-		gpe_event_info->runtime_count++;
-		if (gpe_event_info->runtime_count == 1) {
-			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
-			if (ACPI_SUCCESS(status)) {
-				status = acpi_clear_and_enable_gpe(gpe_event_info);
-			}
-
-			if (ACPI_FAILURE(status)) {
-				gpe_event_info->runtime_count--;
-				goto unlock_and_exit;
-			}
-		}
+	if (gpe_event_info->runtime_count == ACPI_UINT8_MAX) {
+		status = AE_LIMIT;	/* Too many references */
+		goto unlock_and_exit;
 	}
 
-	if (gpe_type & ACPI_GPE_TYPE_WAKE) {
-		/* The GPE must have the ability to wake the system */
-
-		if (!(gpe_event_info->flags & ACPI_GPE_CAN_WAKE)) {
-			status = AE_TYPE;
-			goto unlock_and_exit;
+	gpe_event_info->runtime_count++;
+	if (gpe_event_info->runtime_count == 1) {
+		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
+		if (ACPI_SUCCESS(status)) {
+			status = acpi_clear_and_enable_gpe(gpe_event_info);
 		}
 
-		if (gpe_event_info->wakeup_count == ACPI_UINT8_MAX) {
-			status = AE_LIMIT;	/* Too many references */
-			goto unlock_and_exit;
-		}
-
-		/*
-		 * Update the enable mask on the first wakeup reference. Wake GPEs
-		 * are only hardware-enabled just before sleeping.
-		 */
-		gpe_event_info->wakeup_count++;
-		if (gpe_event_info->wakeup_count == 1) {
-			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
+		if (ACPI_FAILURE(status)) {
+			gpe_event_info->runtime_count--;
 		}
 	}
 
@@ -462,17 +427,14 @@ ACPI_EXPORT_SYMBOL(acpi_enable_gpe)
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number      - GPE level within the GPE block
- *              gpe_type        - ACPI_GPE_TYPE_RUNTIME or ACPI_GPE_TYPE_WAKE
- *                                or both
  *
  * RETURN:      Status
  *
  * DESCRIPTION: Remove a reference to a GPE. When the last reference is
- *              removed, only then is the GPE disabled (for runtime GPEs), or
- *              the GPE mask bit disabled (for wake GPEs)
+ *              removed, only then is the GPE disabled.
  *
  ******************************************************************************/
-acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type)
+acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number)
 {
 	acpi_status status = AE_OK;
 	struct acpi_gpe_event_info *gpe_event_info;
@@ -480,12 +442,6 @@ acpi_status acpi_disable_gpe(acpi_handle
 
 	ACPI_FUNCTION_TRACE(acpi_disable_gpe);
 
-	/* Parameter validation */
-
-	if (!gpe_type || (gpe_type & ~ACPI_GPE_TYPE_WAKE_RUN)) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
-
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/* Ensure that we have a valid GPE number */
@@ -498,41 +454,21 @@ acpi_status acpi_disable_gpe(acpi_handle
 
 	/* Hardware-disable a runtime GPE on removal of the last reference */
 
-	if (gpe_type & ACPI_GPE_TYPE_RUNTIME) {
-		if (!gpe_event_info->runtime_count) {
-			status = AE_LIMIT;	/* There are no references to remove */
-			goto unlock_and_exit;
-		}
-
-		gpe_event_info->runtime_count--;
-		if (!gpe_event_info->runtime_count) {
-			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
-			if (ACPI_SUCCESS(status)) {
-				status = acpi_hw_low_set_gpe(gpe_event_info,
-							     ACPI_GPE_DISABLE);
-			}
-
-			if (ACPI_FAILURE(status)) {
-				gpe_event_info->runtime_count++;
-				goto unlock_and_exit;
-			}
-		}
+	if (!gpe_event_info->runtime_count) {
+		status = AE_LIMIT;	/* There are no references to remove */
+		goto unlock_and_exit;
 	}
 
-	/*
-	 * Update masks for wake GPE on removal of the last reference.
-	 * No need to hardware-disable wake GPEs here, they are not currently
-	 * enabled.
-	 */
-	if (gpe_type & ACPI_GPE_TYPE_WAKE) {
-		if (!gpe_event_info->wakeup_count) {
-			status = AE_LIMIT;	/* There are no references to remove */
-			goto unlock_and_exit;
+	gpe_event_info->runtime_count--;
+	if (!gpe_event_info->runtime_count) {
+		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
+		if (ACPI_SUCCESS(status)) {
+			status = acpi_hw_low_set_gpe(gpe_event_info,
+						     ACPI_GPE_DISABLE);
 		}
 
-		gpe_event_info->wakeup_count--;
-		if (!gpe_event_info->wakeup_count) {
-			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
+		if (ACPI_FAILURE(status)) {
+			gpe_event_info->runtime_count++;
 		}
 	}
 
Index: linux-2.6/include/acpi/actypes.h
===================================================================
--- linux-2.6.orig/include/acpi/actypes.h
+++ linux-2.6/include/acpi/actypes.h
@@ -669,12 +669,6 @@ typedef u32 acpi_event_status;
 #define ACPI_GPE_DISABLE                1
 #define ACPI_GPE_COND_ENABLE            2
 
-/* gpe_types for acpi_enable_gpe and acpi_disable_gpe */
-
-#define ACPI_GPE_TYPE_WAKE              (u8) 0x01
-#define ACPI_GPE_TYPE_RUNTIME           (u8) 0x02
-#define ACPI_GPE_TYPE_WAKE_RUN          (u8) 0x03
-
 /*
  * GPE info flags - Per GPE
  * +-------+---+-+-+
Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -822,7 +822,7 @@ static int ec_install_handlers(struct ac
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	acpi_enable_gpe(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
+	acpi_enable_gpe(NULL, ec->gpe);
 	status = acpi_install_address_space_handler(ec->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_ec_space_handler,
@@ -839,7 +839,7 @@ static int ec_install_handlers(struct ac
 		} else {
 			acpi_remove_gpe_handler(NULL, ec->gpe,
 				&acpi_ec_gpe_handler);
-			acpi_disable_gpe(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
+			acpi_disable_gpe(NULL, ec->gpe);
 			return -ENODEV;
 		}
 	}
@@ -850,7 +850,7 @@ static int ec_install_handlers(struct ac
 
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
-	acpi_disable_gpe(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
+	acpi_disable_gpe(NULL, ec->gpe);
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
 				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
 		pr_err(PREFIX "failed to remove space handler\n");
Index: linux-2.6/drivers/acpi/system.c
===================================================================
--- linux-2.6.orig/drivers/acpi/system.c
+++ linux-2.6/drivers/acpi/system.c
@@ -388,12 +388,10 @@ static ssize_t counter_set(struct kobjec
 	if (index < num_gpes) {
 		if (!strcmp(buf, "disable\n") &&
 				(status & ACPI_EVENT_FLAG_ENABLED))
-			result = acpi_disable_gpe(handle, index,
-						ACPI_GPE_TYPE_RUNTIME);
+			result = acpi_disable_gpe(handle, index);
 		else if (!strcmp(buf, "enable\n") &&
 				!(status & ACPI_EVENT_FLAG_ENABLED))
-			result = acpi_enable_gpe(handle, index,
-						ACPI_GPE_TYPE_RUNTIME);
+			result = acpi_enable_gpe(handle, index);
 		else if (!strcmp(buf, "clear\n") &&
 				(status & ACPI_EVENT_FLAG_SET))
 			result = acpi_clear_gpe(handle, index);
Index: linux-2.6/drivers/acpi/acpica/evgpeinit.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpeinit.c
+++ linux-2.6/drivers/acpi/acpica/evgpeinit.c
@@ -482,8 +482,7 @@ acpi_ev_match_gpe_method(acpi_handle obj
 				gpe_device = NULL;
 			}
 
-			status = acpi_enable_gpe(gpe_device, gpe_number,
-						 ACPI_GPE_TYPE_RUNTIME);
+			status = acpi_enable_gpe(gpe_device, gpe_number);
 			if (ACPI_FAILURE(status)) {
 				ACPI_EXCEPTION((AE_INFO, status,
 						"Could not enable GPE 0x%02X",
Index: linux-2.6/drivers/acpi/acpica/evgpeblk.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpeblk.c
+++ linux-2.6/drivers/acpi/acpica/evgpeblk.c
@@ -529,8 +529,7 @@ acpi_ev_initialize_gpe_block(struct acpi
 
 			/* Enable this GPE */
 
-			status = acpi_enable_gpe(gpe_device, gpe_number,
-						 ACPI_GPE_TYPE_RUNTIME);
+			status = acpi_enable_gpe(gpe_device, gpe_number);
 			if (ACPI_FAILURE(status)) {
 				ACPI_EXCEPTION((AE_INFO, status,
 						"Could not enable GPE 0x%02X",
Index: linux-2.6/drivers/acpi/button.c
===================================================================
--- linux-2.6.orig/drivers/acpi/button.c
+++ linux-2.6/drivers/acpi/button.c
@@ -424,8 +424,7 @@ static int acpi_button_add(struct acpi_d
 	if (device->wakeup.flags.valid) {
 		/* Button's GPE is run-wake GPE */
 		acpi_enable_gpe(device->wakeup.gpe_device,
-				device->wakeup.gpe_number,
-				ACPI_GPE_TYPE_RUNTIME);
+				device->wakeup.gpe_number);
 		device->wakeup.run_wake_count++;
 		device->wakeup.state.enabled = 1;
 	}
@@ -448,8 +447,7 @@ static int acpi_button_remove(struct acp
 
 	if (device->wakeup.flags.valid) {
 		acpi_disable_gpe(device->wakeup.gpe_device,
-				device->wakeup.gpe_number,
-				ACPI_GPE_TYPE_RUNTIME);
+				device->wakeup.gpe_number);
 		device->wakeup.run_wake_count--;
 		device->wakeup.state.enabled = 0;
 	}
Index: linux-2.6/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-acpi.c
+++ linux-2.6/drivers/pci/pci-acpi.c
@@ -295,14 +295,12 @@ static int acpi_dev_run_wake(struct devi
 		if (!dev->wakeup.run_wake_count++) {
 			acpi_enable_wakeup_device_power(dev, ACPI_STATE_S0);
 			acpi_enable_gpe(dev->wakeup.gpe_device,
-					dev->wakeup.gpe_number,
-					ACPI_GPE_TYPE_RUNTIME);
+					dev->wakeup.gpe_number);
 		}
 	} else if (dev->wakeup.run_wake_count > 0) {
 		if (!--dev->wakeup.run_wake_count) {
 			acpi_disable_gpe(dev->wakeup.gpe_device,
-					 dev->wakeup.gpe_number,
-					 ACPI_GPE_TYPE_RUNTIME);
+					 dev->wakeup.gpe_number);
 			acpi_disable_wakeup_device_power(dev);
 		}
 	} else {
Index: linux-2.6/drivers/acpi/acpica/aclocal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/aclocal.h
+++ linux-2.6/drivers/acpi/acpica/aclocal.h
@@ -428,7 +428,6 @@ struct acpi_gpe_event_info {
 	u8 flags;		/* Misc info about this GPE */
 	u8 gpe_number;		/* This GPE */
 	u8 runtime_count;	/* References to a run GPE */
-	u8 wakeup_count;	/* References to a wake GPE */
 };
 
 /* Information about a GPE register pair, one per each status/enable pair in an array */
Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h
+++ linux-2.6/include/acpi/acpixf.h
@@ -285,11 +285,9 @@ acpi_status acpi_gpe_wakeup(acpi_handle 
 
 acpi_status acpi_set_gpe(acpi_handle gpe_device, u32 gpe_number, u8 action);
 
-acpi_status
-acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type);
+acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number);
 
-acpi_status
-acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type);
+acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number);
 
 acpi_status acpi_clear_gpe(acpi_handle gpe_device, u32 gpe_number);
 

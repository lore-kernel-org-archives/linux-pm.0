From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/5] ACPI / ACPICA: Fix low-level GPE
	manipulation code
Date: Tue, 8 Jun 2010 10:49:08 +0200
Message-ID: <201006081049.09119.rjw__18918.2726237506$1275988141$gmane$org@sisk.pl>
References: <201006080024.46142.rjw@sisk.pl> <201006081046.48488.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006081046.48488.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

ACPICA uses acpi_ev_enable_gpe() for enabling GPEs at the low level,
which is incorrect, because this function only enables the GPE if the
corresponding bit in its enable register's enable_for_run mask is set.
This causes acpi_set_gpe() to work incorrectly if used for enabling
GPEs that were not previously enabled with acpi_enable_gpe().  As a
result, among other things, wakeup-only GPEs are never enabled by
acpi_enable_wakeup_device(), so the devices that use them are unable
to wake up the system.

To fix this issue remove acpi_ev_enable_gpe() and its counterpart
acpi_ev_disable_gpe() and replace acpi_hw_low_disable_gpe() with
acpi_hw_low_set_gpe() that will be used instead to manipulate GPE
enable bits at the low level.  Make the users of acpi_ev_enable_gpe()
and acpi_ev_disable_gpe() call acpi_hw_low_set_gpe() instead and
make sure that GPE enable masks are only updated by acpi_enable_gpe()
and acpi_disable_gpe() when GPE reference counters change from 0
to 1 and from 1 to 0, respectively.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/acevents.h |    4 -
 drivers/acpi/acpica/achware.h  |    3 -
 drivers/acpi/acpica/evgpe.c    |  108 -----------------------------------------
 drivers/acpi/acpica/evxface.c  |    2 
 drivers/acpi/acpica/evxfevnt.c |   59 ++++++++++++++++++++--
 drivers/acpi/acpica/hwgpe.c    |   26 +++++++--
 include/acpi/actypes.h         |    2 
 7 files changed, 80 insertions(+), 124 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/hwgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/hwgpe.c
+++ linux-2.6/drivers/acpi/acpica/hwgpe.c
@@ -78,23 +78,27 @@ u32 acpi_hw_gpe_register_bit(struct acpi
 
 /******************************************************************************
  *
- * FUNCTION:	acpi_hw_low_disable_gpe
+ * FUNCTION:	acpi_hw_low_set_gpe
  *
  * PARAMETERS:	gpe_event_info	    - Info block for the GPE to be disabled
+ *		action		    - Enable or disable
  *
  * RETURN:	Status
  *
- * DESCRIPTION: Disable a single GPE in the enable register.
+ * DESCRIPTION: Enable or disable a single GPE in its enable register.
  *
  ******************************************************************************/
 
-acpi_status acpi_hw_low_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
+acpi_status
+acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 action)
 {
 	struct acpi_gpe_register_info *gpe_register_info;
 	acpi_status status;
 	u32 enable_mask;
 	u32 register_bit;
 
+	ACPI_FUNCTION_ENTRY();
+
 	/* Get the info block for the entire GPE register */
 
 	gpe_register_info = gpe_event_info->register_info;
@@ -109,11 +113,23 @@ acpi_status acpi_hw_low_disable_gpe(stru
 		return (status);
 	}
 
-	/* Clear just the bit that corresponds to this GPE */
+	/* Set ot clear just the bit that corresponds to this GPE */
 
 	register_bit = acpi_hw_gpe_register_bit(gpe_event_info,
 						gpe_register_info);
-	ACPI_CLEAR_BIT(enable_mask, register_bit);
+	switch (action) {
+	case ACPI_GPE_ENABLE:
+		ACPI_SET_BIT(enable_mask, register_bit);
+		break;
+
+	case ACPI_GPE_DISABLE:
+		ACPI_CLEAR_BIT(enable_mask, register_bit);
+		break;
+
+	default:
+		ACPI_ERROR((AE_INFO, "Invalid action\n"));
+		return (AE_BAD_PARAMETER);
+	}
 
 	/* Write the updated enable mask */
 
Index: linux-2.6/drivers/acpi/acpica/achware.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/achware.h
+++ linux-2.6/drivers/acpi/acpica/achware.h
@@ -93,7 +93,8 @@ acpi_status acpi_hw_write_port(acpi_io_a
 u32 acpi_hw_gpe_register_bit(struct acpi_gpe_event_info *gpe_event_info,
 			     struct acpi_gpe_register_info *gpe_register_info);
 
-acpi_status acpi_hw_low_disable_gpe(struct acpi_gpe_event_info *gpe_event_info);
+acpi_status
+acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 action);
 
 acpi_status
 acpi_hw_write_gpe_enable_reg(struct acpi_gpe_event_info *gpe_event_info);
Index: linux-2.6/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpe.c
+++ linux-2.6/drivers/acpi/acpica/evgpe.c
@@ -99,106 +99,6 @@ acpi_ev_update_gpe_enable_masks(struct a
 	return_ACPI_STATUS(AE_OK);
 }
 
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ev_enable_gpe
- *
- * PARAMETERS:  gpe_event_info          - GPE to enable
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Hardware-enable a GPE. Always enables the GPE, regardless
- *              of type or number of references.
- *
- * Note: The GPE lock should be already acquired when this function is called.
- *
- ******************************************************************************/
-
-acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
-{
-	acpi_status status;
-
-
-	ACPI_FUNCTION_TRACE(ev_enable_gpe);
-
-
-	/*
-	 * We will only allow a GPE to be enabled if it has either an
-	 * associated method (_Lxx/_Exx) or a handler. Otherwise, the
-	 * GPE will be immediately disabled by acpi_ev_gpe_dispatch the
-	 * first time it fires.
-	 */
-	if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK)) {
-		return_ACPI_STATUS(AE_NO_HANDLER);
-	}
-
-	/* Ensure the HW enable masks are current */
-
-	status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Clear the GPE (of stale events) */
-
-	status = acpi_hw_clear_gpe(gpe_event_info);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Enable the requested GPE */
-
-	status = acpi_hw_write_gpe_enable_reg(gpe_event_info);
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ev_disable_gpe
- *
- * PARAMETERS:  gpe_event_info          - GPE to disable
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Hardware-disable a GPE. Always disables the requested GPE,
- *              regardless of the type or number of references.
- *
- * Note: The GPE lock should be already acquired when this function is called.
- *
- ******************************************************************************/
-
-acpi_status acpi_ev_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
-{
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(ev_disable_gpe);
-
-
-	/*
-	 * Note: Always disable the GPE, even if we think that that it is already
-	 * disabled. It is possible that the AML or some other code has enabled
-	 * the GPE behind our back.
-	 */
-
-	/* Ensure the HW enable masks are current */
-
-	status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/*
-	 * Always H/W disable this GPE, even if we don't know the GPE type.
-	 * Simply clear the enable bit for this particular GPE, but do not
-	 * write out the current GPE enable mask since this may inadvertently
-	 * enable GPEs too early. An example is a rogue GPE that has arrived
-	 * during ACPICA initialization - possibly because AML or other code
-	 * has enabled the GPE.
-	 */
-	status = acpi_hw_low_disable_gpe(gpe_event_info);
-	return_ACPI_STATUS(status);
-}
-
 
 /*******************************************************************************
  *
@@ -450,10 +350,6 @@ static void ACPI_SYSTEM_XFACE acpi_ev_as
 		return_VOID;
 	}
 
-	/* Update the GPE register masks for return to enabled state */
-
-	(void)acpi_ev_update_gpe_enable_masks(gpe_event_info);
-
 	/*
 	 * Take a snapshot of the GPE info for this level - we copy the info to
 	 * prevent a race condition with remove_handler/remove_block.
@@ -606,7 +502,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
 		 * Disable the GPE, so it doesn't keep firing before the method has a
 		 * chance to run (it runs asynchronously with interrupts enabled).
 		 */
-		status = acpi_ev_disable_gpe(gpe_event_info);
+		status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"Unable to disable GPE[0x%2X]",
@@ -643,7 +539,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
 		 * Disable the GPE. The GPE will remain disabled a handler
 		 * is installed or ACPICA is restarted.
 		 */
-		status = acpi_ev_disable_gpe(gpe_event_info);
+		status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"Unable to disable GPE[0x%2X]",
Index: linux-2.6/drivers/acpi/acpica/evxfevnt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-2.6/drivers/acpi/acpica/evxfevnt.c
@@ -210,6 +210,44 @@ ACPI_EXPORT_SYMBOL(acpi_enable_event)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_clear_and_enable_gpe
+ *
+ * PARAMETERS:  gpe_event_info  - GPE to enable
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Clear the given GPE from stale events and enable it.
+ *
+ ******************************************************************************/
+static acpi_status
+acpi_clear_and_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
+{
+	acpi_status status;
+
+	/*
+	 * We will only allow a GPE to be enabled if it has either an
+	 * associated method (_Lxx/_Exx) or a handler. Otherwise, the
+	 * GPE will be immediately disabled by acpi_ev_gpe_dispatch the
+	 * first time it fires.
+	 */
+	if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK)) {
+		return_ACPI_STATUS(AE_NO_HANDLER);
+	}
+
+	/* Clear the GPE (of stale events) */
+	status = acpi_hw_clear_gpe(gpe_event_info);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Enable the requested GPE */
+	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
+
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_set_gpe
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
@@ -249,11 +287,11 @@ acpi_status acpi_set_gpe(acpi_handle gpe
 
 	switch (action) {
 	case ACPI_GPE_ENABLE:
-		status = acpi_ev_enable_gpe(gpe_event_info);
+		status = acpi_clear_and_enable_gpe(gpe_event_info);
 		break;
 
 	case ACPI_GPE_DISABLE:
-		status = acpi_ev_disable_gpe(gpe_event_info);
+		status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
 		break;
 
 	default:
@@ -316,7 +354,11 @@ acpi_status acpi_enable_gpe(acpi_handle 
 
 		gpe_event_info->runtime_count++;
 		if (gpe_event_info->runtime_count == 1) {
-			status = acpi_ev_enable_gpe(gpe_event_info);
+			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
+			if (ACPI_SUCCESS(status)) {
+				status = acpi_clear_and_enable_gpe(gpe_event_info);
+			}
+
 			if (ACPI_FAILURE(status)) {
 				gpe_event_info->runtime_count--;
 				goto unlock_and_exit;
@@ -343,7 +385,7 @@ acpi_status acpi_enable_gpe(acpi_handle 
 		 */
 		gpe_event_info->wakeup_count++;
 		if (gpe_event_info->wakeup_count == 1) {
-			(void)acpi_ev_update_gpe_enable_masks(gpe_event_info);
+			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
 		}
 	}
 
@@ -403,7 +445,12 @@ acpi_status acpi_disable_gpe(acpi_handle
 
 		gpe_event_info->runtime_count--;
 		if (!gpe_event_info->runtime_count) {
-			status = acpi_ev_disable_gpe(gpe_event_info);
+			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
+			if (ACPI_SUCCESS(status)) {
+				status = acpi_hw_low_set_gpe(gpe_event_info,
+							     ACPI_GPE_DISABLE);
+			}
+
 			if (ACPI_FAILURE(status)) {
 				gpe_event_info->runtime_count++;
 				goto unlock_and_exit;
@@ -424,7 +471,7 @@ acpi_status acpi_disable_gpe(acpi_handle
 
 		gpe_event_info->wakeup_count--;
 		if (!gpe_event_info->wakeup_count) {
-			(void)acpi_ev_update_gpe_enable_masks(gpe_event_info);
+			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
 		}
 	}
 
Index: linux-2.6/include/acpi/actypes.h
===================================================================
--- linux-2.6.orig/include/acpi/actypes.h
+++ linux-2.6/include/acpi/actypes.h
@@ -663,7 +663,7 @@ typedef u32 acpi_event_status;
 #define ACPI_GPE_MAX                    0xFF
 #define ACPI_NUM_GPE                    256
 
-/* Actions for acpi_set_gpe */
+/* Actions for acpi_set_gpe and acpi_hw_low_set_gpe */
 
 #define ACPI_GPE_ENABLE                 0
 #define ACPI_GPE_DISABLE                1
Index: linux-2.6/drivers/acpi/acpica/acevents.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/acevents.h
+++ linux-2.6/drivers/acpi/acpica/acevents.h
@@ -80,10 +80,6 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_x
 acpi_status
 acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info);
 
-acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info);
-
-acpi_status acpi_ev_disable_gpe(struct acpi_gpe_event_info *gpe_event_info);
-
 struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 						       u32 gpe_number);
 
Index: linux-2.6/drivers/acpi/acpica/evxface.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxface.c
+++ linux-2.6/drivers/acpi/acpica/evxface.c
@@ -721,7 +721,7 @@ acpi_install_gpe_handler(acpi_handle gpe
 
 	/* Disable the GPE before installing the handler */
 
-	status = acpi_ev_disable_gpe(gpe_event_info);
+	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
 	if (ACPI_FAILURE (status)) {
 		goto unlock_and_exit;
 	}

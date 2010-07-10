From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / ACPICA: Fix reference counting problems
	with GPE handlers
Date: Sun, 11 Jul 2010 01:52:07 +0200
Message-ID: <201007110152.07503.rjw__9931.80303271419$1278807383$gmane$org@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>, "Moore,
	Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

If a handler is installed for a GPE associated with an AML method and
such that it cannot wake up the system from sleep states, the GPE
remains enabled after the handler has been installed, although it
should be disabled in that case to avoid spurious execution of the
handler.

Fix this issue by making acpi_install_gpe_handler() disable GPEs
that were previously associated with AML methods and cannot wake up
the system from sleep states.

Analogously, make acpi_remove_gpe_handler() enable the GPEs that
are associated with AML methods after their handlers have been
removed and cannot wake up the system from sleep states.  In addition
to that, fix a code ordering issue in acpi_remove_gpe_handler() that
renders the locking ineffective (ACPI_MTX_EVENTS is released
temporarily in the middle of the routine to wait for the completion
of events already in progress).

For this purpose introduce acpi_raw_disable_gpe() and
acpi_raw_enable_gpe() to be called with acpi_gbl_gpe_lock held
and rework acpi_disable_gpe() and acpi_enable_gpe(), respectively, to
use them.  Also rework acpi_gpe_can_wake() to use
acpi_raw_disable_gpe() instead of calling acpi_disable_gpe() after
releasing the lock to avoid the possible theoretical race with
acpi_install_gpe_handler().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

Hi Len,

This patch is on top of the series I sent recently:

https://patchwork.kernel.org/patch/110747/
https://patchwork.kernel.org/patch/110750/
https://patchwork.kernel.org/patch/110749/
https://patchwork.kernel.org/patch/110748/

Please apply along with that patches.

Rafael

---
 drivers/acpi/acpica/acevents.h |    4 ++
 drivers/acpi/acpica/aclocal.h  |    1 
 drivers/acpi/acpica/evgpe.c    |   73 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/evxface.c  |   77 +++++++++++++++++++++++++++--------------
 drivers/acpi/acpica/evxfevnt.c |   63 ++++-----------------------------
 5 files changed, 139 insertions(+), 79 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/evxface.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxface.c
+++ linux-2.6/drivers/acpi/acpica/evxface.c
@@ -691,12 +691,22 @@ acpi_install_gpe_handler(acpi_handle gpe
 		return_ACPI_STATUS(status);
 	}
 
+	/* Allocate memory for the handler object */
+
+	handler = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_handler_info));
+	if (!handler) {
+		status = AE_NO_MEMORY;
+		goto unlock_and_exit;
+	}
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
 	if (!gpe_event_info) {
 		status = AE_BAD_PARAMETER;
-		goto unlock_and_exit;
+		goto free_and_exit;
 	}
 
 	/* Make sure that there isn't a handler there already */
@@ -704,24 +714,30 @@ acpi_install_gpe_handler(acpi_handle gpe
 	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
 	    ACPI_GPE_DISPATCH_HANDLER) {
 		status = AE_ALREADY_EXISTS;
-		goto unlock_and_exit;
+		goto free_and_exit;
 	}
 
 	/* Allocate and init handler object */
 
-	handler = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_handler_info));
-	if (!handler) {
-		status = AE_NO_MEMORY;
-		goto unlock_and_exit;
-	}
-
 	handler->address = address;
 	handler->context = context;
 	handler->method_node = gpe_event_info->dispatch.method_node;
+	handler->orig_flags = gpe_event_info->flags &
+			(ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK);
+
+	/*
+	 * If the GPE is associated with a method and it cannot wake up the
+	 * system from sleep states, it was enabled automatically during
+	 * initialization, so it has to be disabled now to avoid spurious
+	 * execution of the handler.
+	 */
+
+	if ((handler->orig_flags & ACPI_GPE_DISPATCH_METHOD)
+	    && !(gpe_event_info->flags & ACPI_GPE_CAN_WAKE))
+		(void)acpi_raw_disable_gpe(gpe_event_info);
 
 	/* Install the handler */
 
-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 	gpe_event_info->dispatch.handler = handler;
 
 	/* Setup up dispatch flags to indicate handler (vs. method) */
@@ -735,6 +751,11 @@ acpi_install_gpe_handler(acpi_handle gpe
 unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
+
+free_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	ACPI_FREE(handler);
+	goto unlock_and_exit;
 }
 
 ACPI_EXPORT_SYMBOL(acpi_install_gpe_handler)
@@ -770,11 +791,17 @@ acpi_remove_gpe_handler(acpi_handle gpe_
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
+	/* Make sure all deferred tasks are completed */
+
+	acpi_os_wait_events_complete(NULL);
+
 	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
 
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
@@ -798,34 +825,34 @@ acpi_remove_gpe_handler(acpi_handle gpe_
 		goto unlock_and_exit;
 	}
 
-	/* Make sure all deferred tasks are completed */
-
-	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
-	acpi_os_wait_events_complete(NULL);
-	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
 	/* Remove the handler */
 
-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 	handler = gpe_event_info->dispatch.handler;
 
 	/* Restore Method node (if any), set dispatch flags */
 
 	gpe_event_info->dispatch.method_node = handler->method_node;
-	gpe_event_info->flags &= ~ACPI_GPE_DISPATCH_MASK;	/* Clear bits */
-	if (handler->method_node) {
-		gpe_event_info->flags |= ACPI_GPE_DISPATCH_METHOD;
-	}
-	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	gpe_event_info->flags &=
+		~(ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK);
+	gpe_event_info->flags |= handler->orig_flags;
+
+	/*
+	 * If the GPE was previously associated with a method and it cannot wake
+	 * up the system from sleep states, it should be enabled at this point
+	 * to restore the post-initialization configuration.
+	 */
+
+	if ((handler->orig_flags & ACPI_GPE_DISPATCH_METHOD)
+	    && !(gpe_event_info->flags & ACPI_GPE_CAN_WAKE))
+		(void)acpi_raw_enable_gpe(gpe_event_info);
 
 	/* Now we can free the handler object */
 
 	ACPI_FREE(handler);
 
-      unlock_and_exit:
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
 }
Index: linux-2.6/drivers/acpi/acpica/aclocal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/aclocal.h
+++ linux-2.6/drivers/acpi/acpica/aclocal.h
@@ -411,6 +411,7 @@ struct acpi_handler_info {
 	acpi_event_handler address;	/* Address of handler, if any */
 	void *context;		/* Context to be passed to handler */
 	struct acpi_namespace_node *method_node;	/* Method node for this GPE level (saved) */
+	u8 orig_flags;		/* Original misc info about this GPE */
 };
 
 union acpi_gpe_dispatch_info {
Index: linux-2.6/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpe.c
+++ linux-2.6/drivers/acpi/acpica/evgpe.c
@@ -134,6 +134,79 @@ acpi_status acpi_ev_enable_gpe(struct ac
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_raw_enable_gpe
+ *
+ * PARAMETERS:  gpe_event_info  - GPE to enable
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Add a reference to a GPE. On the first reference, the GPE is
+ *              hardware-enabled.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_raw_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
+{
+	acpi_status status = AE_OK;
+
+	if (gpe_event_info->runtime_count == ACPI_UINT8_MAX) {
+		return_ACPI_STATUS(AE_LIMIT);
+	}
+
+	gpe_event_info->runtime_count++;
+	if (gpe_event_info->runtime_count == 1) {
+		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
+		if (ACPI_SUCCESS(status)) {
+			status = acpi_ev_enable_gpe(gpe_event_info);
+		}
+
+		if (ACPI_FAILURE(status)) {
+			gpe_event_info->runtime_count--;
+		}
+	}
+
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_raw_disable_gpe
+ *
+ * PARAMETERS:  gpe_event_info  - GPE to disable
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Remove a reference to a GPE. When the last reference is
+ *              removed, the GPE is hardware-disabled.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_raw_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
+{
+	acpi_status status = AE_OK;
+
+	if (!gpe_event_info->runtime_count) {
+		return_ACPI_STATUS(AE_LIMIT);
+	}
+
+	gpe_event_info->runtime_count--;
+	if (!gpe_event_info->runtime_count) {
+		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
+		if (ACPI_SUCCESS(status)) {
+			status = acpi_hw_low_set_gpe(gpe_event_info,
+						     ACPI_GPE_DISABLE);
+		}
+
+		if (ACPI_FAILURE(status)) {
+			gpe_event_info->runtime_count++;
+		}
+	}
+
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ev_low_get_gpe_info
  *
  * PARAMETERS:  gpe_number          - Raw GPE number
Index: linux-2.6/drivers/acpi/acpica/acevents.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/acevents.h
+++ linux-2.6/drivers/acpi/acpica/acevents.h
@@ -82,6 +82,10 @@ acpi_ev_update_gpe_enable_mask(struct ac
 
 acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info);
 
+acpi_status acpi_raw_enable_gpe(struct acpi_gpe_event_info *gpe_event_info);
+
+acpi_status acpi_raw_disable_gpe(struct acpi_gpe_event_info *gpe_event_info);
+
 struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 						       u32 gpe_number);
 
Index: linux-2.6/drivers/acpi/acpica/evxfevnt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-2.6/drivers/acpi/acpica/evxfevnt.c
@@ -284,7 +284,7 @@ ACPI_EXPORT_SYMBOL(acpi_gpe_wakeup)
  ******************************************************************************/
 acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
 {
-	acpi_status status = AE_OK;
+	acpi_status status = AE_BAD_PARAMETER;
 	struct acpi_gpe_event_info *gpe_event_info;
 	acpi_cpu_flags flags;
 
@@ -295,29 +295,10 @@ acpi_status acpi_enable_gpe(acpi_handle 
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
-	if (!gpe_event_info) {
-		status = AE_BAD_PARAMETER;
-		goto unlock_and_exit;
-	}
-
-	if (gpe_event_info->runtime_count == ACPI_UINT8_MAX) {
-		status = AE_LIMIT;	/* Too many references */
-		goto unlock_and_exit;
-	}
-
-	gpe_event_info->runtime_count++;
-	if (gpe_event_info->runtime_count == 1) {
-		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
-		if (ACPI_SUCCESS(status)) {
-			status = acpi_ev_enable_gpe(gpe_event_info);
-		}
-
-		if (ACPI_FAILURE(status)) {
-			gpe_event_info->runtime_count--;
-		}
+	if (gpe_event_info) {
+		status = acpi_raw_enable_gpe(gpe_event_info);
 	}
 
-unlock_and_exit:
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
@@ -338,7 +319,7 @@ ACPI_EXPORT_SYMBOL(acpi_enable_gpe)
  ******************************************************************************/
 acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number)
 {
-	acpi_status status = AE_OK;
+	acpi_status status = AE_BAD_PARAMETER;
 	struct acpi_gpe_event_info *gpe_event_info;
 	acpi_cpu_flags flags;
 
@@ -349,32 +330,10 @@ acpi_status acpi_disable_gpe(acpi_handle
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
-	if (!gpe_event_info) {
-		status = AE_BAD_PARAMETER;
-		goto unlock_and_exit;
-	}
-
-	/* Hardware-disable a runtime GPE on removal of the last reference */
-
-	if (!gpe_event_info->runtime_count) {
-		status = AE_LIMIT;	/* There are no references to remove */
-		goto unlock_and_exit;
-	}
-
-	gpe_event_info->runtime_count--;
-	if (!gpe_event_info->runtime_count) {
-		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
-		if (ACPI_SUCCESS(status)) {
-			status = acpi_hw_low_set_gpe(gpe_event_info,
-						     ACPI_GPE_DISABLE);
-		}
-
-		if (ACPI_FAILURE(status)) {
-			gpe_event_info->runtime_count++;
-		}
+	if (gpe_event_info) {
+		status = acpi_raw_disable_gpe(gpe_event_info) ;
 	}
 
-unlock_and_exit:
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
@@ -401,7 +360,6 @@ acpi_status acpi_gpe_can_wake(acpi_handl
 	acpi_status status = AE_OK;
 	struct acpi_gpe_event_info *gpe_event_info;
 	acpi_cpu_flags flags;
-	u8 disable = 0;
 
 	ACPI_FUNCTION_TRACE(acpi_gpe_can_wake);
 
@@ -420,15 +378,12 @@ acpi_status acpi_gpe_can_wake(acpi_handl
 	}
 
 	gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
-	disable = (gpe_event_info->flags & ACPI_GPE_DISPATCH_METHOD)
-		&& gpe_event_info->runtime_count;
+	if (gpe_event_info->flags & ACPI_GPE_DISPATCH_METHOD) {
+		(void)acpi_raw_disable_gpe(gpe_event_info);
+	}
 
 unlock_and_exit:
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
-
-	if (disable)
-		status = acpi_disable_gpe(gpe_device, gpe_number);
-
 	return_ACPI_STATUS(status);
 }
 ACPI_EXPORT_SYMBOL(acpi_gpe_can_wake)

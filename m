From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/3] ACPI / ACPICA: Do not execute _PRW methods
	during initialization
Date: Mon, 5 Jul 2010 00:59:12 +0200
Message-ID: <201007050059.12517.rjw__22716.8149351657$1278284723$gmane$org@sisk.pl>
References: <201007050056.22705.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007050056.22705.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, "Moore,
	Robert" <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Currently, during initialization ACPICA walks the entire ACPI
namespace in search of any device objects with associated _PRW
methods.  All of the _PRW methods found are executed in the process
to extract the GPE information returned by them, so that the GPEs in
question can be marked as "able to wakeup" (more precisely, the
ACPI_GPE_CAN_WAKE flag is set for them).  The only purpose of this
exercise is to avoid enabling the CAN_WAKE GPEs automatically, even
if there are _Lxx/_Exx methods associated with them.  However, it is
both costly and unnecessary, because the host OS has to execute the
_PRW methods anyway to check which devices can wake up the system
from sleep states.  Moreover, it then uses full information
returned by _PRW, including the GPE information, so it can take care
of disabling the GPEs if necessary.

Remove the code that walks the namespace and executes _PRW from
ACPICA and modify comments to reflect that change.  Make
acpi_bus_set_run_wake_flags() disable GPEs for wakeup devices
so that they don't cause spurious wakeup events to be signaled.
This not only reduces the complexity of the ACPICA initialization
code, but in some cases it should reduce the kernel boot time as
well.

Unfortunately, for this purpose we need a new ACPICA function,
acpi_gpe_can_wake(), to be called by the host OS in order to disable
the GPEs that can wake up the system and were previously enabled by
acpi_ev_initialize_gpe_block() or acpi_ev_update_gpes() (such a GPE
should be disabled only once, because the initialization code enables
it only once, but it may be pointed to by _PRW for multiple devices
and that's why the additional function is necessary).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/acglobal.h  |    7 -
 drivers/acpi/acpica/evevent.c   |    5 
 drivers/acpi/acpica/evgpeblk.c  |   47 --------
 drivers/acpi/acpica/evgpeinit.c |  235 ++--------------------------------------
 drivers/acpi/acpica/evxfevnt.c  |   55 +++++++++
 drivers/acpi/acpica/exconfig.c  |    2 
 drivers/acpi/acpica/utxface.c   |    8 -
 drivers/acpi/osl.c              |   20 ---
 drivers/acpi/scan.c             |    2 
 include/acpi/acpixf.h           |    3 
 10 files changed, 85 insertions(+), 299 deletions(-)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -740,6 +740,8 @@ acpi_bus_extract_wakeup_device_power_pac
 		device->wakeup.resources.handles[i] = element->reference.handle;
 	}
 
+	acpi_gpe_can_wake(device->wakeup.gpe_device, device->wakeup.gpe_number);
+
 	return AE_OK;
 }
 
Index: linux-2.6/drivers/acpi/acpica/evgpeinit.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpeinit.c
+++ linux-2.6/drivers/acpi/acpica/evgpeinit.c
@@ -211,9 +211,7 @@ acpi_status acpi_ev_gpe_initialize(void)
  * DESCRIPTION: Check for new GPE methods (_Lxx/_Exx) made available as a
  *              result of a Load() or load_table() operation. If new GPE
  *              methods have been installed, register the new methods and
- *              enable and runtime GPEs that are associated with them. Also,
- *              run any newly loaded _PRW methods in order to discover any
- *              new CAN_WAKE GPEs.
+ *              enable and runtime GPEs that are associated with them.
  *
  ******************************************************************************/
 
@@ -223,49 +221,12 @@ void acpi_ev_update_gpes(acpi_owner_id t
 	struct acpi_gpe_block_info *gpe_block;
 	struct acpi_gpe_walk_info walk_info;
 	acpi_status status = AE_OK;
-	u32 new_wake_gpe_count = 0;
-
-	/* We will examine only _PRW/_Lxx/_Exx methods owned by this table */
-
-	walk_info.owner_id = table_owner_id;
-	walk_info.execute_by_owner_id = TRUE;
-	walk_info.count = 0;
-
-	if (acpi_gbl_leave_wake_gpes_disabled) {
-		/*
-		 * 1) Run any newly-loaded _PRW methods to find any GPEs that
-		 * can now be marked as CAN_WAKE GPEs. Note: We must run the
-		 * _PRW methods before we process the _Lxx/_Exx methods because
-		 * we will enable all runtime GPEs associated with the new
-		 * _Lxx/_Exx methods at the time we process those methods.
-		 *
-		 * Unlock interpreter so that we can run the _PRW methods.
-		 */
-		walk_info.gpe_block = NULL;
-		walk_info.gpe_device = NULL;
-
-		acpi_ex_exit_interpreter();
-
-		status =
-		    acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-					   ACPI_UINT32_MAX,
-					   ACPI_NS_WALK_NO_UNLOCK,
-					   acpi_ev_match_prw_and_gpe, NULL,
-					   &walk_info, NULL);
-		if (ACPI_FAILURE(status)) {
-			ACPI_EXCEPTION((AE_INFO, status,
-					"While executing _PRW methods"));
-		}
-
-		acpi_ex_enter_interpreter();
-		new_wake_gpe_count = walk_info.count;
-	}
 
 	/*
 	 * 2) Find any _Lxx/_Exx GPE methods that have just been loaded.
 	 *
-	 * Any GPEs that correspond to new _Lxx/_Exx methods and are not
-	 * marked as CAN_WAKE are immediately enabled.
+	 * Any GPEs that correspond to new _Lxx/_Exx methods are immediately
+	 * enabled.
 	 *
 	 * Examine the namespace underneath each gpe_device within the
 	 * gpe_block lists.
@@ -275,6 +236,8 @@ void acpi_ev_update_gpes(acpi_owner_id t
 		return;
 	}
 
+	walk_info.owner_id = table_owner_id;
+	walk_info.execute_by_owner_id = TRUE;
 	walk_info.count = 0;
 	walk_info.enable_this_gpe = TRUE;
 
@@ -307,10 +270,8 @@ void acpi_ev_update_gpes(acpi_owner_id t
 		gpe_xrupt_info = gpe_xrupt_info->next;
 	}
 
-	if (walk_info.count || new_wake_gpe_count) {
-		ACPI_INFO((AE_INFO,
-			   "Enabled %u new runtime GPEs, added %u new wakeup GPEs",
-			   walk_info.count, new_wake_gpe_count));
+	if (walk_info.count) {
+		ACPI_INFO((AE_INFO, "Enabled %u new GPEs", walk_info.count));
 	}
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
@@ -386,9 +347,6 @@ acpi_ev_match_gpe_method(acpi_handle obj
 	/*
 	 * 3) Edge/Level determination is based on the 2nd character
 	 *    of the method name
-	 *
-	 * NOTE: Default GPE type is RUNTIME only. Later, if a _PRW object is
-	 * found that points to this GPE, the ACPI_GPE_CAN_WAKE flag is set.
 	 */
 	switch (name[1]) {
 	case 'L':
@@ -471,23 +429,18 @@ acpi_ev_match_gpe_method(acpi_handle obj
 	 */
 	if (walk_info->enable_this_gpe) {
 
-		/* Ignore GPEs that can wake the system */
-
-		if (!(gpe_event_info->flags & ACPI_GPE_CAN_WAKE) ||
-		    !acpi_gbl_leave_wake_gpes_disabled) {
-			walk_info->count++;
-			gpe_device = walk_info->gpe_device;
+		walk_info->count++;
+		gpe_device = walk_info->gpe_device;
 
-			if (gpe_device == acpi_gbl_fadt_gpe_device) {
-				gpe_device = NULL;
-			}
+		if (gpe_device == acpi_gbl_fadt_gpe_device) {
+			gpe_device = NULL;
+		}
 
-			status = acpi_enable_gpe(gpe_device, gpe_number);
-			if (ACPI_FAILURE(status)) {
-				ACPI_EXCEPTION((AE_INFO, status,
-						"Could not enable GPE 0x%02X",
-						gpe_number));
-			}
+		status = acpi_enable_gpe(gpe_device, gpe_number);
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status,
+					"Could not enable GPE 0x%02X",
+					gpe_number));
 		}
 	}
 
@@ -496,157 +449,3 @@ acpi_ev_match_gpe_method(acpi_handle obj
 			  name, gpe_number));
 	return_ACPI_STATUS(AE_OK);
 }
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ev_match_prw_and_gpe
- *
- * PARAMETERS:  Callback from walk_namespace
- *
- * RETURN:      Status. NOTE: We ignore errors so that the _PRW walk is
- *              not aborted on a single _PRW failure.
- *
- * DESCRIPTION: Called from acpi_walk_namespace. Expects each object to be a
- *              Device. Run the _PRW method. If present, extract the GPE
- *              number and mark the GPE as a CAN_WAKE GPE. Allows a
- *              per-owner_id execution if execute_by_owner_id is TRUE in the
- *              walk_info parameter block.
- *
- * If walk_info->execute_by_owner_id is TRUE, we only execute _PRWs with that
- *    owner.
- * If walk_info->gpe_device is NULL, we execute every _PRW found. Otherwise,
- *    we only execute _PRWs that refer to the input gpe_device.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
-			  u32 level, void *context, void **return_value)
-{
-	struct acpi_gpe_walk_info *walk_info =
-	    ACPI_CAST_PTR(struct acpi_gpe_walk_info, context);
-	struct acpi_namespace_node *gpe_device;
-	struct acpi_gpe_block_info *gpe_block;
-	struct acpi_namespace_node *target_gpe_device;
-	struct acpi_namespace_node *prw_node;
-	struct acpi_gpe_event_info *gpe_event_info;
-	union acpi_operand_object *pkg_desc;
-	union acpi_operand_object *obj_desc;
-	u32 gpe_number;
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(ev_match_prw_and_gpe);
-
-	/* Check for a _PRW method under this device */
-
-	status = acpi_ns_get_node(obj_handle, METHOD_NAME__PRW,
-				  ACPI_NS_NO_UPSEARCH, &prw_node);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(AE_OK);
-	}
-
-	/* Check if requested owner_id matches this owner_id */
-
-	if ((walk_info->execute_by_owner_id) &&
-	    (prw_node->owner_id != walk_info->owner_id)) {
-		return_ACPI_STATUS(AE_OK);
-	}
-
-	/* Execute the _PRW */
-
-	status = acpi_ut_evaluate_object(prw_node, NULL,
-					 ACPI_BTYPE_PACKAGE, &pkg_desc);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(AE_OK);
-	}
-
-	/* The returned _PRW package must have at least two elements */
-
-	if (pkg_desc->package.count < 2) {
-		goto cleanup;
-	}
-
-	/* Extract pointers from the input context */
-
-	gpe_device = walk_info->gpe_device;
-	gpe_block = walk_info->gpe_block;
-
-	/*
-	 * The _PRW object must return a package, we are only interested
-	 * in the first element
-	 */
-	obj_desc = pkg_desc->package.elements[0];
-
-	if (obj_desc->common.type == ACPI_TYPE_INTEGER) {
-
-		/* Use FADT-defined GPE device (from definition of _PRW) */
-
-		target_gpe_device = NULL;
-		if (gpe_device) {
-			target_gpe_device = acpi_gbl_fadt_gpe_device;
-		}
-
-		/* Integer is the GPE number in the FADT described GPE blocks */
-
-		gpe_number = (u32)obj_desc->integer.value;
-	} else if (obj_desc->common.type == ACPI_TYPE_PACKAGE) {
-
-		/* Package contains a GPE reference and GPE number within a GPE block */
-
-		if ((obj_desc->package.count < 2) ||
-		    ((obj_desc->package.elements[0])->common.type !=
-		     ACPI_TYPE_LOCAL_REFERENCE) ||
-		    ((obj_desc->package.elements[1])->common.type !=
-		     ACPI_TYPE_INTEGER)) {
-			goto cleanup;
-		}
-
-		/* Get GPE block reference and decode */
-
-		target_gpe_device =
-		    obj_desc->package.elements[0]->reference.node;
-		gpe_number = (u32)obj_desc->package.elements[1]->integer.value;
-	} else {
-		/* Unknown type, just ignore it */
-
-		goto cleanup;
-	}
-
-	/* Get the gpe_event_info for this GPE */
-
-	if (gpe_device) {
-		/*
-		 * Is this GPE within this block?
-		 *
-		 * TRUE if and only if these conditions are true:
-		 *     1) The GPE devices match.
-		 *     2) The GPE index(number) is within the range of the Gpe Block
-		 *          associated with the GPE device.
-		 */
-		if (gpe_device != target_gpe_device) {
-			goto cleanup;
-		}
-
-		gpe_event_info =
-		    acpi_ev_low_get_gpe_info(gpe_number, gpe_block);
-	} else {
-		/* gpe_device is NULL, just match the target_device and gpe_number */
-
-		gpe_event_info =
-		    acpi_ev_get_gpe_event_info(target_gpe_device, gpe_number);
-	}
-
-	if (gpe_event_info) {
-		if (!(gpe_event_info->flags & ACPI_GPE_CAN_WAKE)) {
-
-			/* This GPE can wake the system */
-
-			gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
-			walk_info->count++;
-		}
-	}
-
-      cleanup:
-	acpi_ut_remove_reference(pkg_desc);
-	return_ACPI_STATUS(AE_OK);
-}
Index: linux-2.6/drivers/acpi/acpica/evgpeblk.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpeblk.c
+++ linux-2.6/drivers/acpi/acpica/evgpeblk.c
@@ -439,8 +439,6 @@ acpi_ev_initialize_gpe_block(struct acpi
 {
 	acpi_status status;
 	struct acpi_gpe_event_info *gpe_event_info;
-	struct acpi_gpe_walk_info walk_info;
-	u32 wake_gpe_count;
 	u32 gpe_enabled_count;
 	u32 gpe_index;
 	u32 gpe_number;
@@ -456,37 +454,9 @@ acpi_ev_initialize_gpe_block(struct acpi
 	}
 
 	/*
-	 * Runtime option: Should wake GPEs be enabled at runtime?  The default
-	 * is no, they should only be enabled just as the machine goes to sleep.
+	 * Enable all GPEs that have a corresponding method.  Any other GPEs
+	 * within this block must be enabled via the acpi_enable_gpe interface.
 	 */
-	if (acpi_gbl_leave_wake_gpes_disabled) {
-		/*
-		 * Differentiate runtime vs wake GPEs, via the _PRW control methods.
-		 * Each GPE that has one or more _PRWs that reference it is by
-		 * definition a wake GPE and will not be enabled while the machine
-		 * is running.
-		 */
-		walk_info.gpe_block = gpe_block;
-		walk_info.gpe_device = gpe_device;
-		walk_info.execute_by_owner_id = FALSE;
-
-		status =
-		    acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-					   ACPI_UINT32_MAX, ACPI_NS_WALK_UNLOCK,
-					   acpi_ev_match_prw_and_gpe, NULL,
-					   &walk_info, NULL);
-		if (ACPI_FAILURE(status)) {
-			ACPI_EXCEPTION((AE_INFO, status,
-					"While executing _PRW methods"));
-		}
-	}
-
-	/*
-	 * Enable all GPEs that have a corresponding method and are not
-	 * capable of generating wakeups. Any other GPEs within this block
-	 * must be enabled via the acpi_enable_gpe interface.
-	 */
-	wake_gpe_count = 0;
 	gpe_enabled_count = 0;
 
 	if (gpe_device == acpi_gbl_fadt_gpe_device) {
@@ -512,13 +482,6 @@ acpi_ev_initialize_gpe_block(struct acpi
 				goto enabled;
 			}
 
-			if (gpe_event_info->flags & ACPI_GPE_CAN_WAKE) {
-				wake_gpe_count++;
-				if (acpi_gbl_leave_wake_gpes_disabled) {
-					continue;
-				}
-			}
-
 			/* Ignore GPEs that have no corresponding _Lxx/_Exx method */
 
 			if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_METHOD)) {
@@ -540,10 +503,10 @@ acpi_ev_initialize_gpe_block(struct acpi
 		}
 	}
 
-	if (gpe_enabled_count || wake_gpe_count) {
+	if (gpe_enabled_count) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INIT,
-				  "Enabled %u Runtime GPEs, added %u Wake GPEs in this block\n",
-				  gpe_enabled_count, wake_gpe_count));
+				  "Enabled %u GPEs in this block\n",
+				  gpe_enabled_count));
 	}
 
 	return_ACPI_STATUS(AE_OK);
Index: linux-2.6/drivers/acpi/acpica/evxfevnt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-2.6/drivers/acpi/acpica/evxfevnt.c
@@ -382,6 +382,59 @@ ACPI_EXPORT_SYMBOL(acpi_disable_gpe)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_gpe_can_wake
+ *
+ * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number      - GPE level within the GPE block
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Set the ACPI_GPE_CAN_WAKE flag for the given GPE.  If the GPE
+ *              has a corresponding method and is currently enabled, disable it
+ *              (GPEs with corresponding methods are enabled unconditionally
+ *              during initialization, but GPEs that can wake up are expected
+ *              to be initially disabled).
+ *
+ ******************************************************************************/
+acpi_status acpi_gpe_can_wake(acpi_handle gpe_device, u32 gpe_number)
+{
+	acpi_status status = AE_OK;
+	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_cpu_flags flags;
+	u8 disable = 0;
+
+	ACPI_FUNCTION_TRACE(acpi_gpe_can_wake);
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
+	if (gpe_event_info->flags & ACPI_GPE_CAN_WAKE) {
+		goto unlock_and_exit;
+	}
+
+	gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
+	disable = (gpe_event_info->flags & ACPI_GPE_DISPATCH_METHOD)
+		&& gpe_event_info->runtime_count;
+
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+
+	if (disable)
+		status = acpi_disable_gpe(gpe_device, gpe_number);
+
+	return_ACPI_STATUS(status);
+}
+ACPI_EXPORT_SYMBOL(acpi_gpe_can_wake)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_disable_event
  *
  * PARAMETERS:  Event           - The fixed eventto be enabled
@@ -696,7 +749,7 @@ acpi_install_gpe_block(acpi_handle gpe_d
 
 	obj_desc->device.gpe_block = gpe_block;
 
-	/* Run the _PRW methods and enable the runtime GPEs in the new block */
+	/* Enable the runtime GPEs in the new block */
 
 	status = acpi_ev_initialize_gpe_block(node, gpe_block);
 
Index: linux-2.6/drivers/acpi/acpica/utxface.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/utxface.c
+++ linux-2.6/drivers/acpi/acpica/utxface.c
@@ -293,12 +293,8 @@ acpi_status acpi_initialize_objects(u32 
 	 * Complete the GPE initialization for the GPE blocks defined in the FADT
 	 * (GPE block 0 and 1).
 	 *
-	 * Note1: This is where the _PRW methods are executed for the GPEs. These
-	 * methods can only be executed after the SCI and Global Lock handlers are
-	 * installed and initialized.
-	 *
-	 * Note2: Currently, there seems to be no need to run the _REG methods
-	 * before execution of the _PRW methods and enabling of the GPEs.
+	 * NOTE: Currently, there seems to be no need to run the _REG methods
+	 * before enabling the GPEs.
 	 */
 	if (!(flags & ACPI_NO_EVENT_INIT)) {
 		status = acpi_ev_install_fadt_gpes();
Index: linux-2.6/drivers/acpi/acpica/evevent.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evevent.c
+++ linux-2.6/drivers/acpi/acpica/evevent.c
@@ -102,9 +102,8 @@ acpi_status acpi_ev_initialize_events(vo
  * RETURN:      Status
  *
  * DESCRIPTION: Completes initialization of the FADT-defined GPE blocks
- *              (0 and 1). This causes the _PRW methods to be run, so the HW
- *              must be fully initialized at this point, including global lock
- *              support.
+ *              (0 and 1). The HW must be fully initialized at this point,
+ *              including global lock support.
  *
  ******************************************************************************/
 
Index: linux-2.6/drivers/acpi/acpica/exconfig.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/exconfig.c
+++ linux-2.6/drivers/acpi/acpica/exconfig.c
@@ -120,7 +120,7 @@ acpi_ex_add_table(u32 table_index,
 	acpi_ns_exec_module_code_list();
 	acpi_ex_enter_interpreter();
 
-	/* Update GPEs for any new _PRW or _Lxx/_Exx methods. Ignore errors */
+	/* Update GPEs for any new _Lxx/_Exx methods. Ignore errors */
 
 	status = acpi_tb_get_owner_id(table_index, &owner_id);
 	if (ACPI_SUCCESS(status)) {
Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h
+++ linux-2.6/include/acpi/acpixf.h
@@ -63,7 +63,6 @@ extern u32 acpi_dbg_layer;
 extern u8 acpi_gbl_enable_interpreter_slack;
 extern u8 acpi_gbl_all_methods_serialized;
 extern u8 acpi_gbl_create_osi_method;
-extern u8 acpi_gbl_leave_wake_gpes_disabled;
 extern u8 acpi_gbl_use_default_register_widths;
 extern acpi_name acpi_gbl_trace_method_name;
 extern u32 acpi_gbl_trace_flags;
@@ -288,6 +287,8 @@ acpi_status acpi_enable_gpe(acpi_handle 
 
 acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number);
 
+acpi_status acpi_gpe_can_wake(acpi_handle gpe_device, u32 gpe_number);
+
 acpi_status acpi_clear_gpe(acpi_handle gpe_device, u32 gpe_number);
 
 acpi_status
Index: linux-2.6/drivers/acpi/acpica/acglobal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/acglobal.h
+++ linux-2.6/drivers/acpi/acpica/acglobal.h
@@ -100,13 +100,6 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_all_methods
 u8 ACPI_INIT_GLOBAL(acpi_gbl_create_osi_method, TRUE);
 
 /*
- * Disable wakeup GPEs during runtime? Default is TRUE because WAKE and
- * RUNTIME GPEs should never be shared, and WAKE GPEs should typically only
- * be enabled just before going to sleep.
- */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_leave_wake_gpes_disabled, TRUE);
-
-/*
  * Optionally use default values for the ACPI register widths. Set this to
  * TRUE to use the defaults, if an FADT contains incorrect widths/lengths.
  */
Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c
+++ linux-2.6/drivers/acpi/osl.c
@@ -1064,26 +1064,6 @@ static int __init acpi_serialize_setup(c
 
 __setup("acpi_serialize", acpi_serialize_setup);
 
-/*
- * Wake and Run-Time GPES are expected to be separate.
- * We disable wake-GPEs at run-time to prevent spurious
- * interrupts.
- *
- * However, if a system exists that shares Wake and
- * Run-time events on the same GPE this flag is available
- * to tell Linux to keep the wake-time GPEs enabled at run-time.
- */
-static int __init acpi_wake_gpes_always_on_setup(char *str)
-{
-	printk(KERN_INFO PREFIX "wake GPEs not disabled\n");
-
-	acpi_gbl_leave_wake_gpes_disabled = FALSE;
-
-	return 1;
-}
-
-__setup("acpi_wake_gpes_always_on", acpi_wake_gpes_always_on_setup);
-
 /* Check of resource interference between native drivers and ACPI
  * OperationRegions (SystemIO and System Memory only).
  * IO ports and memory declared in ACPI might be used by the ACPI subsystem

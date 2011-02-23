From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFT][PATCH] ACPI / ACPICA: Implicit notify for multiple
	devices
Date: Wed, 23 Feb 2011 23:05:44 +0100
Message-ID: <201102232305.45005.rjw__26725.0272715048$1298500001$gmane$org@sisk.pl>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, "Moore, Robert" <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Commit bba63a2 (ACPICA: Implicit notify support) introduced a
mechanism that causes a notify request of type
ACPI_NOTIFY_DEVICE_WAKE to be queued automatically by
acpi_ev_asynch_execute_gpe_method() for the device whose _PRW points
to the GPE being handled if that GPE is not associated with an
_Lxx/_Exx method.  However, it turns out that on some systems there
are multiple devices with _PRW pointing to the same GPE without
_Lxx/_Exx and the mechanism introduced by commit bba63a2 needs to be
extended so that "implicit" notify requests of type
ACPI_NOTIFY_DEVICE_WAKE can be queued automatically for all those
devices at the same time.

Reported-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

Hi Matthew,

The patch below doesn't blow up my Toshiba test box, which is a good sign,
but please test it on the boxes where you see the problem.

Thanks,
Rafael

---
 drivers/acpi/acpica/aclocal.h |    7 ++++++-
 drivers/acpi/acpica/evgpe.c   |   17 +++++++++++++----
 drivers/acpi/acpica/evxfgpe.c |   42 +++++++++++++++++++++++++++++++++---------
 3 files changed, 52 insertions(+), 14 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/aclocal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/aclocal.h
+++ linux-2.6/drivers/acpi/acpica/aclocal.h
@@ -416,10 +416,15 @@ struct acpi_gpe_handler_info {
 	u8 originally_enabled;  /* True if GPE was originally enabled */
 };
 
+struct acpi_gpe_notify_object {
+	struct acpi_namespace_node *node;
+	struct acpi_gpe_notify_object *next;
+};
+
 union acpi_gpe_dispatch_info {
 	struct acpi_namespace_node *method_node;	/* Method node for this GPE level */
 	struct acpi_gpe_handler_info *handler;  /* Installed GPE handler */
-	struct acpi_namespace_node *device_node;        /* Parent _PRW device for implicit notify */
+	struct acpi_gpe_notify_object device;   /* List of _PRW devices for implicit notify */
 };
 
 /*
Index: linux-2.6/drivers/acpi/acpica/evxfgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfgpe.c
+++ linux-2.6/drivers/acpi/acpica/evxfgpe.c
@@ -198,7 +198,9 @@ acpi_setup_gpe_for_wake(acpi_handle wake
 	acpi_status status = AE_BAD_PARAMETER;
 	struct acpi_gpe_event_info *gpe_event_info;
 	struct acpi_namespace_node *device_node;
+	struct acpi_gpe_notify_object *notify_object;
 	acpi_cpu_flags flags;
+	u8 gpe_dispatch_mask;
 
 	ACPI_FUNCTION_TRACE(acpi_setup_gpe_for_wake);
 
@@ -221,27 +223,49 @@ acpi_setup_gpe_for_wake(acpi_handle wake
 		goto unlock_and_exit;
 	}
 
+	if (wake_device == ACPI_ROOT_OBJECT) {
+		goto out;
+	}
+
 	/*
 	 * If there is no method or handler for this GPE, then the
 	 * wake_device will be notified whenever this GPE fires (aka
 	 * "implicit notify") Note: The GPE is assumed to be
 	 * level-triggered (for windows compatibility).
 	 */
-	if (((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
-	      ACPI_GPE_DISPATCH_NONE) && (wake_device != ACPI_ROOT_OBJECT)) {
+	gpe_dispatch_mask = gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK;
+	if (gpe_dispatch_mask != ACPI_GPE_DISPATCH_NONE
+	    && gpe_dispatch_mask != ACPI_GPE_DISPATCH_NOTIFY) {
+		goto out;
+	}
 
-		/* Validate wake_device is of type Device */
+	/* Validate wake_device is of type Device */
 
-		device_node = ACPI_CAST_PTR(struct acpi_namespace_node,
-					    wake_device);
-		if (device_node->type != ACPI_TYPE_DEVICE) {
-			goto unlock_and_exit;
-		}
+	device_node = ACPI_CAST_PTR(struct acpi_namespace_node, wake_device);
+	if (device_node->type != ACPI_TYPE_DEVICE) {
+		goto unlock_and_exit;
+	}
+
+	if (gpe_dispatch_mask == ACPI_GPE_DISPATCH_NONE) {
 		gpe_event_info->flags = (ACPI_GPE_DISPATCH_NOTIFY |
 					 ACPI_GPE_LEVEL_TRIGGERED);
-		gpe_event_info->dispatch.device_node = device_node;
+		gpe_event_info->dispatch.device.node = device_node;
+		gpe_event_info->dispatch.device.next = NULL;
+	} else {
+		/* There are multiple devices to notify implicitly. */
+
+		notify_object = ACPI_ALLOCATE_ZEROED(sizeof(*notify_object));
+		if (!notify_object) {
+			status = AE_NO_MEMORY;
+			goto unlock_and_exit;
+		}
+
+		notify_object->node = device_node;
+		notify_object->next = gpe_event_info->dispatch.device.next;
+		gpe_event_info->dispatch.device.next = notify_object;
 	}
 
+ out:
 	gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
 	status = AE_OK;
 
Index: linux-2.6/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpe.c
+++ linux-2.6/drivers/acpi/acpica/evgpe.c
@@ -457,6 +457,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_as
 	acpi_status status;
 	struct acpi_gpe_event_info *local_gpe_event_info;
 	struct acpi_evaluate_info *info;
+	struct acpi_gpe_notify_object *notify_object;
 
 	ACPI_FUNCTION_TRACE(ev_asynch_execute_gpe_method);
 
@@ -508,10 +509,18 @@ static void ACPI_SYSTEM_XFACE acpi_ev_as
 		 * from this thread -- because handlers may in turn run other
 		 * control methods.
 		 */
-		status =
-		    acpi_ev_queue_notify_request(local_gpe_event_info->dispatch.
-						 device_node,
-						 ACPI_NOTIFY_DEVICE_WAKE);
+		status = acpi_ev_queue_notify_request(
+				local_gpe_event_info->dispatch.device.node,
+				ACPI_NOTIFY_DEVICE_WAKE);
+
+		notify_object = local_gpe_event_info->dispatch.device.next;
+		while (ACPI_SUCCESS(status) && notify_object) {
+			status = acpi_ev_queue_notify_request(
+					notify_object->node,
+					ACPI_NOTIFY_DEVICE_WAKE);
+			notify_object = notify_object->next;
+		}
+
 		break;
 
 	case ACPI_GPE_DISPATCH_METHOD:

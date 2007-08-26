From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 3/3] PM: Improve handling of ACPI system
	state indicator
Date: Sun, 26 Aug 2007 15:16:13 +0200
Message-ID: <200708261516.14268.rjw__20409.0061983608$1188133680$gmane$org@sisk.pl>
References: <200708261509.40118.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708261509.40118.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce a separate ACPI function for setting the system status indicator and
use it in the right places in the suspend and hibernation related ACPI callbacks
instead of setting the system status indicator implicitly in
acpi_enter_sleep_state_prep() and acpi_leave_sleep_state().

This allows us to avoid turning off the sleep state indicator during hibernation
on Thinkpads (currently, it is turned off before saving the image, because we
need to call finish() before unfreezing devices).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/hardware/hwsleep.c |   51 +++++++++++++++++++++++++++-------------
 drivers/acpi/sleep/main.c       |   15 ++++++++++-
 include/acpi/acpixf.h           |    2 +
 3 files changed, 50 insertions(+), 18 deletions(-)

Index: linux-2.6.23-rc3/drivers/acpi/hardware/hwsleep.c
===================================================================
--- linux-2.6.23-rc3.orig/drivers/acpi/hardware/hwsleep.c
+++ linux-2.6.23-rc3/drivers/acpi/hardware/hwsleep.c
@@ -199,15 +199,46 @@ acpi_status acpi_enter_sleep_state_prep(
 		return_ACPI_STATUS(status);
 	}
 
-	/* Setup the argument to _SST */
+	/* Disable/Clear all GPEs */
+
+	status = acpi_hw_disable_all_gpes();
+
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_set_sleep_state_indicator
+ *
+ * PARAMETERS:  sleep_state         - Which sleep state to enter
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Make the system status indicator reflect the sleep state being
+ *              entered.
+ *              This function must execute with interrupts enabled.
+ *
+ ******************************************************************************/
+acpi_status acpi_set_sleep_state_indicator(u8 sleep_state)
+{
+	acpi_status status;
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+
+	ACPI_FUNCTION_TRACE(acpi_set_sleep_state_indicator);
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+
+	arg.type = ACPI_TYPE_INTEGER;
 
+	/* Setup the argument to _SST */
 	switch (sleep_state) {
 	case ACPI_STATE_S0:
 		arg.integer.value = ACPI_SST_WORKING;
 		break;
 
 	case ACPI_STATE_S1:
-	case ACPI_STATE_S2:
 	case ACPI_STATE_S3:
 		arg.integer.value = ACPI_SST_SLEEPING;
 		break;
@@ -217,27 +248,21 @@ acpi_status acpi_enter_sleep_state_prep(
 		break;
 
 	default:
-		arg.integer.value = ACPI_SST_INDICATOR_OFF;	/* Default is off */
+		/* Default is off */
+		arg.integer.value = ACPI_SST_INDICATOR_OFF;
 		break;
 	}
 
 	/* Set the system indicators to show the desired sleep state. */
-
 	status = acpi_evaluate_object(NULL, METHOD_NAME__SST, &arg_list, NULL);
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		ACPI_EXCEPTION((AE_INFO, status,
 				"While executing method _SST"));
 	}
 
-	/* Disable/Clear all GPEs */
-
-	status = acpi_hw_disable_all_gpes();
-
 	return_ACPI_STATUS(status);
 }
 
-ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state_prep)
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_enter_sleep_state_prep_late
@@ -669,12 +694,6 @@ acpi_status acpi_leave_sleep_state(u8 sl
 	    acpi_set_register(acpi_gbl_fixed_event_info
 			      [ACPI_EVENT_POWER_BUTTON].status_register_id, 1);
 
-	arg.integer.value = ACPI_SST_WORKING;
-	status = acpi_evaluate_object(NULL, METHOD_NAME__SST, &arg_list, NULL);
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		ACPI_EXCEPTION((AE_INFO, status, "During Method _SST"));
-	}
-
 	return_ACPI_STATUS(status);
 }
 
Index: linux-2.6.23-rc3/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.23-rc3.orig/drivers/acpi/sleep/main.c
+++ linux-2.6.23-rc3/drivers/acpi/sleep/main.c
@@ -70,6 +70,8 @@ static int acpi_pm_prepare(void)
 
 	if (error)
 		acpi_target_sleep_state = ACPI_STATE_S0;
+	else
+		acpi_set_sleep_state_indicator(acpi_target_sleep_state);
 
 	return error;
 }
@@ -186,6 +188,7 @@ static void acpi_pm_finish(void)
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 
 	acpi_target_sleep_state = ACPI_STATE_S0;
+	acpi_set_sleep_state_indicator(ACPI_STATE_S0);
 
 #ifdef CONFIG_X86
 	if (init_8259A_after_S1) {
@@ -246,6 +249,8 @@ static struct dmi_system_id __initdata a
 static int acpi_hibernation_start(void)
 {
 	acpi_target_sleep_state = ACPI_STATE_S4;
+	acpi_set_sleep_state_indicator(ACPI_STATE_S4);
+
 	return 0;
 }
 
@@ -286,7 +291,7 @@ static void acpi_hibernation_finish_earl
 	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
 }
 
-static void acpi_hibernation_finish(void)
+static void acpi_hibernation_cleanup(void)
 {
 	acpi_leave_sleep_state(ACPI_STATE_S4);
 	acpi_disable_wakeup_device(ACPI_STATE_S4);
@@ -297,6 +302,12 @@ static void acpi_hibernation_finish(void
 	acpi_target_sleep_state = ACPI_STATE_S0;
 }
 
+static void acpi_hibernation_finish(void)
+{
+	acpi_hibernation_cleanup();
+	acpi_set_sleep_state_indicator(ACPI_STATE_S0);
+}
+
 static int acpi_hibernation_pre_restore(void)
 {
 	acpi_status status;
@@ -314,7 +325,7 @@ static void acpi_hibernation_restore_cle
 static struct platform_hibernation_ops acpi_hibernation_ops = {
 	.start = acpi_hibernation_start,
 	.pre_snapshot = acpi_hibernation_prepare,
-	.post_snapshot = acpi_hibernation_finish,
+	.post_snapshot = acpi_hibernation_cleanup,
 	.finish = acpi_hibernation_finish,
 	.finish_early = acpi_hibernation_finish_early,
 	.prepare_late = acpi_hibernation_prepare_late,
Index: linux-2.6.23-rc3/include/acpi/acpixf.h
===================================================================
--- linux-2.6.23-rc3.orig/include/acpi/acpixf.h
+++ linux-2.6.23-rc3/include/acpi/acpixf.h
@@ -327,6 +327,8 @@ acpi_get_firmware_waking_vector(acpi_phy
 acpi_status
 acpi_get_sleep_type_data(u8 sleep_state, u8 * slp_typ_a, u8 * slp_typ_b);
 
+acpi_status acpi_set_sleep_state_indicator(u8 sleep_state);
+
 acpi_status acpi_enter_sleep_state_prep(u8 sleep_state);
 
 acpi_status acpi_enter_sleep_state_prep_late(u8 sleep_state);

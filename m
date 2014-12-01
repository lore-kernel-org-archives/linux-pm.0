From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] ACPICA: Save current masks of enabled GPEs after enable register writes
Date: Mon, 01 Dec 2014 02:53:14 +0100
Message-ID: <5837035.VZ0lP2ZXdi@vostro.rjw.lan>
References: <2017469.J3BZteXtBu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57129 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751908AbaLABdz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 30 Nov 2014 20:33:55 -0500
In-Reply-To: <2017469.J3BZteXtBu@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a race condition between acpi_hw_disable_all_gpes() or
acpi_enable_all_wakeup_gpes() and acpi_ev_asynch_enable_gpe() such
that if the latter wins the race, it may mistakenly enable a GPE
disabled by the former.  This may lead to premature system wakeups
during system suspend and potentially to more serious consequences.

The source of the problem is how acpi_hw_low_set_gpe() works when
passed ACPI_GPE_CONDITIONAL_ENABLE as the second argument.  In that
case, the GPE will be enabled if the corresponding bit is set in the
enable_for_run mask of the GPE enable register containing that bit.
However, acpi_hw_disable_all_gpes() and acpi_enable_all_wakeup_gpes()
don't modify the enable_for_run masks of GPE registers when writing
to them.  In consequence, if acpi_ev_asynch_enable_gpe(), which
eventually calls acpi_hw_low_set_gpe() with the second argument
equal to ACPI_GPE_CONDITIONAL_ENABLE, is executed in parallel with
one of these functions, it may reverse changes made by them.

To fix the problem, introduce a new enable_mask field in struct
acpi_gpe_register_info in which to store the current mask of
enabled GPEs and modify acpi_hw_low_set_gpe() to take this
mask into account instead of enable_for_run when its second
argument is equal to ACPI_GPE_CONDITIONAL_ENABLE.  Also modify
the low-level routines called by acpi_hw_disable_all_gpes(),
acpi_enable_all_wakeup_gpes() and acpi_enable_all_runtime_gpes()
to update the enable_mask masks of GPE registers after all
(successful) writes to those registers.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    1 
 drivers/acpi/acpica/evgpe.c   |    6 ++--
 drivers/acpi/acpica/hwgpe.c   |   53 ++++++++++++++++++++++++++++++++++--------
 include/acpi/actypes.h        |    4 +++
 4 files changed, 51 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/acpi/acpica/aclocal.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/aclocal.h
+++ linux-pm/drivers/acpi/acpica/aclocal.h
@@ -454,6 +454,7 @@ struct acpi_gpe_register_info {
 	u16 base_gpe_number;	/* Base GPE number for this register */
 	u8 enable_for_wake;	/* GPEs to keep enabled when sleeping */
 	u8 enable_for_run;	/* GPEs to keep enabled when running */
+	u8 enable_mask;		/* Current mask of enabled GPEs */
 };
 
 /*
Index: linux-pm/drivers/acpi/acpica/hwgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwgpe.c
+++ linux-pm/drivers/acpi/acpica/hwgpe.c
@@ -115,12 +115,12 @@ acpi_hw_low_set_gpe(struct acpi_gpe_even
 	/* Set or clear just the bit that corresponds to this GPE */
 
 	register_bit = acpi_hw_get_gpe_register_bit(gpe_event_info);
-	switch (action) {
+	switch (action & ~ACPI_GPE_SAVE_MASK) {
 	case ACPI_GPE_CONDITIONAL_ENABLE:
 
-		/* Only enable if the enable_for_run bit is set */
+		/* Only enable if the corresponding enable_mask bit is set */
 
-		if (!(register_bit & gpe_register_info->enable_for_run)) {
+		if (!(register_bit & gpe_register_info->enable_mask)) {
 			return (AE_BAD_PARAMETER);
 		}
 
@@ -145,6 +145,9 @@ acpi_hw_low_set_gpe(struct acpi_gpe_even
 	/* Write the updated enable mask */
 
 	status = acpi_hw_write(enable_mask, &gpe_register_info->enable_address);
+	if (ACPI_SUCCESS(status) && (action & ACPI_GPE_SAVE_MASK)) {
+		gpe_register_info->enable_mask = enable_mask;
+	}
 	return (status);
 }
 
@@ -262,6 +265,32 @@ acpi_hw_get_gpe_status(struct acpi_gpe_e
 
 /******************************************************************************
  *
+ * FUNCTION:    acpi_hw_gpe_enable_write
+ *
+ * PARAMETERS:  enable_mask         - Bit mask to write to the GPE register
+ *              gpe_register_info   - Gpe Register info
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Write the enable mask byte to the given GPE register.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_hw_gpe_enable_write(u8 enable_mask,
+			 struct acpi_gpe_register_info *gpe_register_info)
+{
+	acpi_status status;
+
+	status = acpi_hw_write(enable_mask, &gpe_register_info->enable_address);
+	if (ACPI_SUCCESS(status)) {
+		gpe_register_info->enable_mask = enable_mask;
+	}
+	return (status);
+}
+
+/******************************************************************************
+ *
  * FUNCTION:    acpi_hw_disable_gpe_block
  *
  * PARAMETERS:  gpe_xrupt_info      - GPE Interrupt info
@@ -287,8 +316,8 @@ acpi_hw_disable_gpe_block(struct acpi_gp
 		/* Disable all GPEs in this register */
 
 		status =
-		    acpi_hw_write(0x00,
-				  &gpe_block->register_info[i].enable_address);
+		    acpi_hw_gpe_enable_write(0x00,
+					     &gpe_block->register_info[i]);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
@@ -355,21 +384,23 @@ acpi_hw_enable_runtime_gpe_block(struct
 {
 	u32 i;
 	acpi_status status;
+	struct acpi_gpe_register_info *gpe_register_info;
 
 	/* NOTE: assumes that all GPEs are currently disabled */
 
 	/* Examine each GPE Register within the block */
 
 	for (i = 0; i < gpe_block->register_count; i++) {
-		if (!gpe_block->register_info[i].enable_for_run) {
+		gpe_register_info = &gpe_block->register_info[i];
+		if (!gpe_register_info->enable_for_run) {
 			continue;
 		}
 
 		/* Enable all "runtime" GPEs in this register */
 
 		status =
-		    acpi_hw_write(gpe_block->register_info[i].enable_for_run,
-				  &gpe_block->register_info[i].enable_address);
+		    acpi_hw_gpe_enable_write(gpe_register_info->enable_for_run,
+					     gpe_register_info);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
@@ -399,10 +430,12 @@ acpi_hw_enable_wakeup_gpe_block(struct a
 {
 	u32 i;
 	acpi_status status;
+	struct acpi_gpe_register_info *gpe_register_info;
 
 	/* Examine each GPE Register within the block */
 
 	for (i = 0; i < gpe_block->register_count; i++) {
+		gpe_register_info = &gpe_block->register_info[i];
 
 		/*
 		 * Enable all "wake" GPEs in this register and disable the
@@ -410,8 +443,8 @@ acpi_hw_enable_wakeup_gpe_block(struct a
 		 */
 
 		status =
-		    acpi_hw_write(gpe_block->register_info[i].enable_for_wake,
-				  &gpe_block->register_info[i].enable_address);
+		    acpi_hw_gpe_enable_write(gpe_register_info->enable_for_wake,
+					     gpe_register_info);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
Index: linux-pm/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evgpe.c
+++ linux-pm/drivers/acpi/acpica/evgpe.c
@@ -134,7 +134,7 @@ acpi_status acpi_ev_enable_gpe(struct ac
 
 	/* Enable the requested GPE */
 
-	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
+	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE_SAVE);
 	return_ACPI_STATUS(status);
 }
 
@@ -213,7 +213,7 @@ acpi_ev_remove_gpe_reference(struct acpi
 		if (ACPI_SUCCESS(status)) {
 			status =
 			    acpi_hw_low_set_gpe(gpe_event_info,
-						ACPI_GPE_DISABLE);
+						ACPI_GPE_DISABLE_SAVE);
 		}
 
 		if (ACPI_FAILURE(status)) {
@@ -655,7 +655,7 @@ acpi_status acpi_ev_finish_gpe(struct ac
 
 	/*
 	 * Enable this GPE, conditionally. This means that the GPE will
-	 * only be physically enabled if the enable_for_run bit is set
+	 * only be physically enabled if the enable_mask bit is set
 	 * in the event_info.
 	 */
 	(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_CONDITIONAL_ENABLE);
Index: linux-pm/include/acpi/actypes.h
===================================================================
--- linux-pm.orig/include/acpi/actypes.h
+++ linux-pm/include/acpi/actypes.h
@@ -736,6 +736,10 @@ typedef u32 acpi_event_status;
 #define ACPI_GPE_ENABLE                 0
 #define ACPI_GPE_DISABLE                1
 #define ACPI_GPE_CONDITIONAL_ENABLE     2
+#define ACPI_GPE_SAVE_MASK              4
+
+#define ACPI_GPE_ENABLE_SAVE            (ACPI_GPE_ENABLE | ACPI_GPE_SAVE_MASK)
+#define ACPI_GPE_DISABLE_SAVE           (ACPI_GPE_DISABLE | ACPI_GPE_SAVE_MASK)
 
 /*
  * GPE info flags - Per GPE


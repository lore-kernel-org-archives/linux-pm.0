From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21 suspend-to-disk regression
Date: Thu, 3 May 2007 20:34:51 +0200
Message-ID: <200705032034.51921.rjw@sisk.pl>
References: <f129n6$mro$1@sea.gmane.org> <200705031506.28559.rjw@sisk.pl>
	<200705032008.16329.marcus@better.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705032008.16329.marcus@better.se>
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
To: Marcus Better <marcus@better.se>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 3 May 2007 20:08, Marcus Better wrote:
> Rafael J. Wysocki wrote:
> > Hmm, perhaps we should do something more, like the following:
> 
> No, almost same thing. Screen goes blank, but then there is disk activity 
> before poweroff. (That makes me a bit unsure as to whether there was disk 
> activity with the previous patch, I might have missed it...) At the next boot 
> it doesn't resume, just reboots from scratch.

Well, I wish I had your machine here!

If I may ask you to try some more patches, I'd like to check what exactly
makes it work when the code ordering is changed.

Could you please apply the appended patch and see what happens?

Rafael

---
 drivers/acpi/hardware/hwsleep.c |   60 ----------------------------------------
 kernel/power/disk.c             |    4 +-
 kernel/power/user.c             |    8 ++---
 3 files changed, 6 insertions(+), 66 deletions(-)

Index: linux-2.6.21-rc7/kernel/power/disk.c
===================================================================
--- linux-2.6.21-rc7.orig/kernel/power/disk.c
+++ linux-2.6.21-rc7/kernel/power/disk.c
@@ -170,9 +170,9 @@ int pm_suspend_disk(void)
 
 	if (in_suspend) {
 		enable_nonboot_cpus();
-		platform_finish();
 		device_resume();
 		resume_console();
+		platform_finish();
 		pr_debug("PM: writing image.\n");
 		error = swsusp_write();
 		if (!error)
@@ -189,9 +189,9 @@ int pm_suspend_disk(void)
  Enable_cpus:
 	enable_nonboot_cpus();
  Resume_devices:
-	platform_finish();
 	device_resume();
 	resume_console();
+	platform_finish();
  Thaw:
 	unprepare_processes();
  Finish:
Index: linux-2.6.21-rc7/kernel/power/user.c
===================================================================
--- linux-2.6.21-rc7.orig/kernel/power/user.c
+++ linux-2.6.21-rc7/kernel/power/user.c
@@ -170,11 +170,11 @@ static inline int snapshot_suspend(int p
 	}
 	enable_nonboot_cpus();
  Resume_devices:
+	device_resume();
+	resume_console();
 	if (platform_suspend)
 		platform_finish();
 
-	device_resume();
-	resume_console();
  Finish:
 	mutex_unlock(&pm_mutex);
 	return error;
@@ -202,11 +202,11 @@ static inline int snapshot_restore(int p
 
 	enable_nonboot_cpus();
  Resume_devices:
+	device_resume();
+	resume_console();
 	if (platform_suspend)
 		platform_finish();
 
-	device_resume();
-	resume_console();
  Finish:
 	pm_restore_console();
 	mutex_unlock(&pm_mutex);
Index: linux-2.6.21-rc7/drivers/acpi/hardware/hwsleep.c
===================================================================
--- linux-2.6.21-rc7.orig/drivers/acpi/hardware/hwsleep.c
+++ linux-2.6.21-rc7/drivers/acpi/hardware/hwsleep.c
@@ -505,54 +505,6 @@ acpi_status acpi_leave_sleep_state(u8 sl
 
 	ACPI_FUNCTION_TRACE(acpi_leave_sleep_state);
 
-	/*
-	 * Set SLP_TYPE and SLP_EN to state S0.
-	 * This is unclear from the ACPI Spec, but it is required
-	 * by some machines.
-	 */
-	status = acpi_get_sleep_type_data(ACPI_STATE_S0,
-					  &acpi_gbl_sleep_type_a,
-					  &acpi_gbl_sleep_type_b);
-	if (ACPI_SUCCESS(status)) {
-		sleep_type_reg_info =
-		    acpi_hw_get_bit_register_info(ACPI_BITREG_SLEEP_TYPE_A);
-		sleep_enable_reg_info =
-		    acpi_hw_get_bit_register_info(ACPI_BITREG_SLEEP_ENABLE);
-
-		/* Get current value of PM1A control */
-
-		status = acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK,
-					       ACPI_REGISTER_PM1_CONTROL,
-					       &PM1Acontrol);
-		if (ACPI_SUCCESS(status)) {
-
-			/* Clear SLP_EN and SLP_TYP fields */
-
-			PM1Acontrol &= ~(sleep_type_reg_info->access_bit_mask |
-					 sleep_enable_reg_info->
-					 access_bit_mask);
-			PM1Bcontrol = PM1Acontrol;
-
-			/* Insert SLP_TYP bits */
-
-			PM1Acontrol |=
-			    (acpi_gbl_sleep_type_a << sleep_type_reg_info->
-			     bit_position);
-			PM1Bcontrol |=
-			    (acpi_gbl_sleep_type_b << sleep_type_reg_info->
-			     bit_position);
-
-			/* Just ignore any errors */
-
-			(void)acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
-						     ACPI_REGISTER_PM1A_CONTROL,
-						     PM1Acontrol);
-			(void)acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
-						     ACPI_REGISTER_PM1B_CONTROL,
-						     PM1Bcontrol);
-		}
-	}
-
 	/* Ensure enter_sleep_state_prep -> enter_sleep_state ordering */
 
 	acpi_gbl_sleep_type_a = ACPI_SLEEP_TYPE_INVALID;
@@ -565,18 +517,6 @@ acpi_status acpi_leave_sleep_state(u8 sl
 
 	/* Ignore any errors from these methods */
 
-	arg.integer.value = ACPI_SST_WAKING;
-	status = acpi_evaluate_object(NULL, METHOD_NAME__SST, &arg_list, NULL);
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		ACPI_EXCEPTION((AE_INFO, status, "During Method _SST"));
-	}
-
-	arg.integer.value = sleep_state;
-	status = acpi_evaluate_object(NULL, METHOD_NAME__BFS, &arg_list, NULL);
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		ACPI_EXCEPTION((AE_INFO, status, "During Method _BFS"));
-	}
-
 	status = acpi_evaluate_object(NULL, METHOD_NAME__WAK, &arg_list, NULL);
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		ACPI_EXCEPTION((AE_INFO, status, "During Method _WAK"));

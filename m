From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/8] ACPI: Use GPE reference counting to
	support shared GPEs
Date: Wed, 24 Feb 2010 00:52:08 +0100
Message-ID: <201002240052.08098.rjw__6255.79004777155$1266969300$gmane$org@sisk.pl>
References: <4911F71203A09E4D9981D27F9D83085859958760@orsmsx503.amr.corp.intel.com>
	<201002200018.02700.rjw@sisk.pl>
	<20100222162622.3d9c684a@jbarnes-piketon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100222162622.3d9c684a@jbarnes-piketon>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, Linux PCI <linux-pci@vger.kernel.org>, "Moore,
	Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 23 February 2010, Jesse Barnes wrote:
> On Sat, 20 Feb 2010 00:18:02 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > [Sorry for resending, tried to restore the CC list.]
> > 
> > On Friday 19 February 2010, Moore, Robert wrote:
> > > 
> > > Here's some comments and questions on the GPE changes in ACPICA.
> > > Overall, looks good.
> > 
> > First of all, thanks a lot for the review.
> 
> I missed this one when applying the series, can you resend as an
> incremental patch on top of linux-next?

Sure, appended.

Please note that it also fixes a bug I found earlier today.

I added a changelog in case you want to apply it as a separate patch.

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: ACPI: GPE refrence counting clean-ups

To fix a bug and address the reviewers' comments regarding the ACPI
GPE refcounting patch, do the following additional changes:

o Remove the second argument of acpi_ev_enable_gpe(),
  'write_to_hardware', because it is not necessary any more.

o Add the "bad parameter" test against 'type' in
  acpi_enable_gpe() and acpi_disable_gpe().

o Make acpi_enable_gpe() only check 'status' for runtime GPEs if
  acpi_ev_enable_gpe() was actually called.

o Make acpi_disable_gpe() return 'status' returned by
  acpi_ev_disable_gpe() and fix a bug where ACPI_GPE_TYPE_WAKE
  and ACPI_GPE_TYPE_RUNTIME were exchanged by mistake.

o Add comments explaining why acpi_set_gpe() is used by the ACPI EC
  driver.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/acevents.h |    4 +---
 drivers/acpi/acpica/evgpe.c    |   10 +++-------
 drivers/acpi/acpica/evxfevnt.c |   24 +++++++++++++++---------
 drivers/acpi/ec.c              |   14 +++++++++++---
 4 files changed, 30 insertions(+), 22 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/acevents.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/acevents.h
+++ linux-2.6/drivers/acpi/acpica/acevents.h
@@ -78,9 +78,7 @@ acpi_ev_queue_notify_request(struct acpi
 acpi_status
 acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info);
 
-acpi_status
-acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info,
-		   u8 write_to_hardware);
+acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info);
 
 acpi_status acpi_ev_disable_gpe(struct acpi_gpe_event_info *gpe_event_info);
 
Index: linux-2.6/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpe.c
+++ linux-2.6/drivers/acpi/acpica/evgpe.c
@@ -98,8 +98,6 @@ acpi_ev_update_gpe_enable_masks(struct a
  * FUNCTION:    acpi_ev_enable_gpe
  *
  * PARAMETERS:  gpe_event_info          - GPE to enable
- *              write_to_hardware       - Enable now, or just mark data structs
- *                                        (WAKE GPEs should be deferred)
  *
  * RETURN:      Status
  *
@@ -107,9 +105,7 @@ acpi_ev_update_gpe_enable_masks(struct a
  *
  ******************************************************************************/
 
-acpi_status
-acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info,
-		   u8 write_to_hardware)
+acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 {
 	acpi_status status;
 
@@ -123,7 +119,7 @@ acpi_ev_enable_gpe(struct acpi_gpe_event
 
 	/* Mark wake-enabled or HW enable, or both */
 
-	if (gpe_event_info->runtime_count && write_to_hardware) {
+	if (gpe_event_info->runtime_count) {
 		/* Clear the GPE (of stale events), then enable it */
 		status = acpi_hw_clear_gpe(gpe_event_info);
 		if (ACPI_FAILURE(status))
@@ -400,7 +396,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_as
 
 	/* Set the GPE flags for return to enabled state */
 
-	(void)acpi_ev_enable_gpe(gpe_event_info, FALSE);
+	(void)acpi_ev_update_gpe_enable_masks(gpe_event_info);
 
 	/*
 	 * Take a snapshot of the GPE info for this level - we copy the info to
Index: linux-2.6/drivers/acpi/acpica/evxfevnt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-2.6/drivers/acpi/acpica/evxfevnt.c
@@ -235,7 +235,7 @@ acpi_status acpi_set_gpe(acpi_handle gpe
 
 	switch (action) {
 	case ACPI_GPE_ENABLE:
-		status = acpi_ev_enable_gpe(gpe_event_info, TRUE);
+		status = acpi_ev_enable_gpe(gpe_event_info);
 		break;
 
 	case ACPI_GPE_DISABLE:
@@ -276,6 +276,9 @@ acpi_status acpi_enable_gpe(acpi_handle 
 
 	ACPI_FUNCTION_TRACE(acpi_enable_gpe);
 
+	if (type & ~ACPI_GPE_TYPE_WAKE_RUN)
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/* Ensure that we have a valid GPE number */
@@ -287,11 +290,11 @@ acpi_status acpi_enable_gpe(acpi_handle 
 	}
 
 	if (type & ACPI_GPE_TYPE_RUNTIME) {
-		if (++gpe_event_info->runtime_count == 1)
-			status = acpi_ev_enable_gpe(gpe_event_info, TRUE);
-
-		if (ACPI_FAILURE(status))
-			gpe_event_info->runtime_count--;
+		if (++gpe_event_info->runtime_count == 1) {
+			status = acpi_ev_enable_gpe(gpe_event_info);
+			if (ACPI_FAILURE(status))
+				gpe_event_info->runtime_count--;
+		}
 	}
 
 	if (type & ACPI_GPE_TYPE_WAKE) {
@@ -335,6 +338,9 @@ acpi_status acpi_disable_gpe(acpi_handle
 
 	ACPI_FUNCTION_TRACE(acpi_disable_gpe);
 
+	if (type & ~ACPI_GPE_TYPE_WAKE_RUN)
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 	/* Ensure that we have a valid GPE number */
 
@@ -344,12 +350,12 @@ acpi_status acpi_disable_gpe(acpi_handle
 		goto unlock_and_exit;
 	}
 
-	if ((type & ACPI_GPE_TYPE_WAKE) && gpe_event_info->runtime_count) {
+	if ((type & ACPI_GPE_TYPE_RUNTIME) && gpe_event_info->runtime_count) {
 		if (--gpe_event_info->runtime_count == 0)
-			acpi_ev_disable_gpe(gpe_event_info);
+			status = acpi_ev_disable_gpe(gpe_event_info);
 	}
 
-	if ((type & ACPI_GPE_TYPE_RUNTIME) && gpe_event_info->wakeup_count) {
+	if ((type & ACPI_GPE_TYPE_WAKE) && gpe_event_info->wakeup_count) {
 		/*
 		 * Wake-up GPEs are not enabled after leaving system sleep
 		 * states, so we don't need to disable them here.
Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -307,6 +307,10 @@ static int acpi_ec_transaction(struct ac
 	pr_debug(PREFIX "transaction start\n");
 	/* disable GPE during transaction if storm is detected */
 	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
+		/*
+		 * It has to be disabled at the hardware level regardless of the
+		 * GPE reference counting, so that it doesn't trigger.
+		 */
 		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
 	}
 
@@ -316,7 +320,11 @@ static int acpi_ec_transaction(struct ac
 	ec_check_sci_sync(ec, acpi_ec_read_status(ec));
 	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
 		msleep(1);
-		/* it is safe to enable GPE outside of transaction */
+		/*
+		 * It is safe to enable the GPE outside of the transaction.  Use
+		 * acpi_set_gpe() for that, since we used it to disable the GPE
+		 * above.
+		 */
 		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);
 	} else if (t->irq_count > ACPI_EC_STORM_THRESHOLD) {
 		pr_info(PREFIX "GPE storm detected, "
@@ -1059,7 +1067,7 @@ error:
 static int acpi_ec_suspend(struct acpi_device *device, pm_message_t state)
 {
 	struct acpi_ec *ec = acpi_driver_data(device);
-	/* Stop using GPE */
+	/* Stop using the GPE, but keep it reference counted. */
 	acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
 	return 0;
 }
@@ -1067,7 +1075,7 @@ static int acpi_ec_suspend(struct acpi_d
 static int acpi_ec_resume(struct acpi_device *device)
 {
 	struct acpi_ec *ec = acpi_driver_data(device);
-	/* Enable use of GPE back */
+	/* Enable the GPE again, but don't reference count it once more. */
 	acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);
 	return 0;
 }

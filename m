From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] ACPI / Sleep: Do not allocate memory for
	saving NVS in advance
Date: Tue, 6 Jul 2010 20:12:34 +0200
Message-ID: <201007062012.34965.rjw__44822.8893838406$1278440170$gmane$org@sisk.pl>
References: <201007020010.13755.rjw@sisk.pl> <201007020011.22118.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007020011.22118.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, July 02, 2010, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> We only can try to allocate memory for saving the NVS region if it
> is known that the target system sleep state is valid.  Otherwise
> we will leak memory if suspend_nvs_alloc() is successful and the
> target state is invalid, because suspend_nvs_free() will not be
> called in that case.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Well, the $subject patch doesn't cover a real problem where the suspending
of devices fails (or suspend is tested in the "devices" mode) and
acpi_pm_finish() is not called at all.  So, the appended patch should be used
instead.

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: ACPI / Sleep: Free NVS copy if suspending of devices fails

If suspending of devices fails or system suspend is tested in the
"devices" mode, the memory allocated for storing a copy of the ACPI
NVS area will not be freed, because acpi_pm_finish() is not called
in that case.  Fix this by moving the suspend_nvs_free() call to
acpi_pm_end().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -145,7 +145,6 @@ static void acpi_pm_finish(void)
 {
 	u32 acpi_state = acpi_target_sleep_state;
 
-	suspend_nvs_free();
 	acpi_ec_unblock_transactions();
 
 	if (acpi_state == ACPI_STATE_S0)
@@ -167,6 +166,7 @@ static void acpi_pm_finish(void)
  */
 static void acpi_pm_end(void)
 {
+	suspend_nvs_free();
 	/*
 	 * This is necessary in case acpi_pm_finish() is not called during a
 	 * failing transition to a sleep state.

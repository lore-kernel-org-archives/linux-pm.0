From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/6] ACPI / PM: Call acpi_save_state_mem() right
	before low-level suspend
Date: Mon, 7 Feb 2011 23:20:53 +0100
Message-ID: <201102072320.53799.rjw__24723.1926805854$1297117638$gmane$org@sisk.pl>
References: <201102072316.41270.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102072316.41270.rjw@sisk.pl>
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
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Since acpi_save_state_mem() is only called by acpi_suspend_enter()
if the target sleep state is S3, it's better to call it under the
switch (acpi_state), right before do_suspend_lowlevel().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -244,17 +244,10 @@ static int acpi_suspend_enter(suspend_st
 {
 	acpi_status status = AE_OK;
 	u32 acpi_state = acpi_target_sleep_state;
+	int error;
 
 	ACPI_FLUSH_CPU_CACHE();
 
-	/* Do arch specific saving of state. */
-	if (acpi_state == ACPI_STATE_S3) {
-		int error = acpi_save_state_mem();
-
-		if (error)
-			return error;
-	}
-
 	switch (acpi_state) {
 	case ACPI_STATE_S1:
 		barrier();
@@ -262,6 +255,9 @@ static int acpi_suspend_enter(suspend_st
 		break;
 
 	case ACPI_STATE_S3:
+		error = acpi_save_state_mem();
+		if (error)
+			return error;
 		do_suspend_lowlevel();
 		pr_info(PREFIX "Low-level resume complete\n");
 		break;

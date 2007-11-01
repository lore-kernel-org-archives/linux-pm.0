From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI: Fix mismerge in acpi_hibernation_finish
Date: Thu, 1 Nov 2007 23:50:19 +0100
Message-ID: <200711012350.20574.rjw__34052.052247762$1193956458$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

[Len, please send Linuswards.]
---
From: Rafael J. Wysocki <rjw@sisk.pl>

Some code in acpi_hibernation_finish() was moved to acpi_hibernation_leave(),
but the old copy had been left (it's harmless, but also useless).  Remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |    5 -----
 1 file changed, 5 deletions(-)

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -267,11 +267,6 @@ static void acpi_hibernation_leave(void)
 
 static void acpi_hibernation_finish(void)
 {
-	/*
-	 * If ACPI is not enabled by the BIOS and the boot kernel, we need to
-	 * enable it here.
-	 */
-	acpi_enable();
 	acpi_disable_wakeup_device(ACPI_STATE_S4);
 	acpi_leave_sleep_state(ACPI_STATE_S4);
 

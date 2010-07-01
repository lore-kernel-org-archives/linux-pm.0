From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/5] ACPI / Sleep: Drop acpi_suspend_finish()
Date: Fri, 2 Jul 2010 00:14:57 +0200
Message-ID: <201007020014.57877.rjw__33200.0309638262$1278022669$gmane$org@sisk.pl>
References: <201007020010.13755.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007020010.13755.rjw@sisk.pl>
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

From: Rafael J. Wysocki <rjw@sisk.pl>

The function acpi_suspend_finish() is not necessary any more, because
acpi_pm_finish() can be used instead of it just fine.  Remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -285,11 +285,6 @@ static int acpi_suspend_enter(suspend_st
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
 
-static void acpi_suspend_finish(void)
-{
-	acpi_pm_finish();
-}
-
 static int acpi_suspend_state_valid(suspend_state_t pm_state)
 {
 	u32 acpi_state;
@@ -311,7 +306,7 @@ static struct platform_suspend_ops acpi_
 	.begin = acpi_suspend_begin,
 	.prepare_late = acpi_pm_prepare,
 	.enter = acpi_suspend_enter,
-	.wake = acpi_suspend_finish,
+	.wake = acpi_pm_finish,
 	.end = acpi_pm_end,
 };
 
@@ -339,7 +334,7 @@ static struct platform_suspend_ops acpi_
 	.begin = acpi_suspend_begin_old,
 	.prepare_late = acpi_pm_pre_suspend,
 	.enter = acpi_suspend_enter,
-	.wake = acpi_suspend_finish,
+	.wake = acpi_pm_finish,
 	.end = acpi_pm_end,
 	.recover = acpi_pm_finish,
 };

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/6] ACPI / PM: Modify the "low-level resume
	finished" message
Date: Mon, 7 Feb 2011 23:19:55 +0100
Message-ID: <201102072319.56040.rjw__3317.48918765715$1297117638$gmane$org@sisk.pl>
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

Move the low-level resume completion message to the point where
control goes back to acpi_suspend_enter() during resume and change
it so that it's more informative.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -263,6 +263,7 @@ static int acpi_suspend_enter(suspend_st
 
 	case ACPI_STATE_S3:
 		do_suspend_lowlevel();
+		pr_info(PREFIX "Low-level resume complete\n");
 		break;
 	}
 
@@ -288,8 +289,6 @@ static int acpi_suspend_enter(suspend_st
 	/* Allow EC transactions to happen. */
 	acpi_ec_unblock_transactions_early();
 
-	printk(KERN_DEBUG "Back to C!\n");
-
 	suspend_nvs_restore();
 
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;

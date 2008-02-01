From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/37] ACPI: Fix mismerge in
	acpi_hibernation_finish
Date: Thu, 31 Jan 2008 23:36:37 -0500
Message-ID: <0122b99e0414205d1f3c1f4bf80f2082f6f1c8b0.1201840183.git.len.brown__1131.90071792832$1201841874$gmane$org@intel.com>
References: <1201840628-23136-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1201840628-23136-1-git-send-email-lenb@kernel.org>
In-Reply-To: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
References: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Some code in acpi_hibernation_finish() was moved to acpi_hibernation_leave(),
but the old copy had been left (it's harmless, but also useless).  Remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/main.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 2c0b663..cbfa058 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
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
 
-- 
1.5.4.rc5.16.gc0279

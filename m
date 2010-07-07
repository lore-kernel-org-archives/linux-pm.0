From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Resend][PATCH 4/4] ACPI / ACPICA: Fail
	acpi_gpe_wakeup() if ACPI_GPE_CAN_WAKE is unset
Date: Thu, 8 Jul 2010 00:45:34 +0200
Message-ID: <201007080045.34877.rjw__13959.350778214$1278543424$gmane$org@sisk.pl>
References: <201007080041.38627.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007080041.38627.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>, "Moore,
	Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make acpi_gpe_wakeup() return error code for GPEs whose
ACPI_GPE_CAN_WAKE flag is not set.  This way acpi_gpe_wakeup() will
only wake for the GPEs reported by the host OS as "wakeup" ones with
the help of acpi_gpe_can_wake().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/evxfevnt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/acpica/evxfevnt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-2.6/drivers/acpi/acpica/evxfevnt.c
@@ -239,7 +239,7 @@ acpi_status acpi_gpe_wakeup(acpi_handle 
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
-	if (!gpe_event_info) {
+	if (!gpe_event_info || !(gpe_event_info->flags & ACPI_GPE_CAN_WAKE)) {
 		status = AE_BAD_PARAMETER;
 		goto unlock_and_exit;
 	}

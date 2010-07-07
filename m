From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Resend][PATCH 3/4] ACPI / ACPICA: Simplify
	acpi_ev_initialize_gpe_block()
Date: Thu, 8 Jul 2010 00:44:42 +0200
Message-ID: <201007080044.42928.rjw__6744.29438445276$1278543517$gmane$org@sisk.pl>
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

Simplify the main loop in acpi_ev_initialize_gpe_block() by
rearranging code and removing the "enabled" label that is not
necessary any more.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/evgpeblk.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/evgpeblk.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpeblk.c
+++ linux-2.6/drivers/acpi/acpica/evgpeblk.c
@@ -472,26 +472,21 @@ acpi_ev_initialize_gpe_block(struct acpi
 			gpe_event_info = &gpe_block->event_info[gpe_index];
 			gpe_number = gpe_index + gpe_block->block_base_number;
 
-			/*
-			 * If the GPE has already been enabled for runtime
-			 * signaling, make sure it remains enabled, but do not
-			 * increment its reference counter.
-			 */
-			if (gpe_event_info->runtime_count) {
-				status = acpi_ev_enable_gpe(gpe_event_info);
-				goto enabled;
-			}
-
 			/* Ignore GPEs that have no corresponding _Lxx/_Exx method */
 
 			if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_METHOD)) {
 				continue;
 			}
 
-			/* Enable this GPE */
+			/*
+			 * If the GPE has already been enabled for runtime
+			 * signaling, make sure it remains enabled, but do not
+			 * increment its reference counter.
+			 */
+			status = gpe_event_info->runtime_count ?
+				acpi_ev_enable_gpe(gpe_event_info) :
+				acpi_enable_gpe(gpe_device, gpe_number);
 
-			status = acpi_enable_gpe(gpe_device, gpe_number);
- enabled:
 			if (ACPI_FAILURE(status)) {
 				ACPI_EXCEPTION((AE_INFO, status,
 						"Could not enable GPE 0x%02X",

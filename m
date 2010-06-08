From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/5] ACPI / ACPICA: Avoid writing full enable
	masks to GPE registers
Date: Tue, 8 Jun 2010 10:49:45 +0200
Message-ID: <201006081049.45342.rjw__25523.2661533684$1275987924$gmane$org@sisk.pl>
References: <201006080024.46142.rjw@sisk.pl> <201006081046.48488.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006081046.48488.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

ACPICA uses acpi_hw_write_gpe_enable_reg() to re-enable a GPE after
an event signaled by it has been handled.  However, this function
writes the entire GPE enable mask to the GPE's enable register which
may not be correct.  Namely, if one of the other GPEs in the same
register was previously enabled by acpi_enable_gpe() and subsequently
disabled using acpi_set_gpe(), acpi_hw_write_gpe_enable_reg() will
re-enable it along with the target GPE.

To fix this issue rework acpi_hw_write_gpe_enable_reg() so that it
calls acpi_hw_low_set_gpe() with a special action value,
ACPI_GPE_COND_ENABLE, that will make it only enable the GPE if the
corresponding bit in its register's enable_for_run mask is set.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/hwgpe.c |   18 +++++-------------
 include/acpi/actypes.h      |    1 +
 2 files changed, 6 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/hwgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/hwgpe.c
+++ linux-2.6/drivers/acpi/acpica/hwgpe.c
@@ -118,6 +118,10 @@ acpi_hw_low_set_gpe(struct acpi_gpe_even
 	register_bit = acpi_hw_gpe_register_bit(gpe_event_info,
 						gpe_register_info);
 	switch (action) {
+	case ACPI_GPE_COND_ENABLE:
+		if (!(register_bit & gpe_register_info->enable_for_run))
+			return (AE_BAD_PARAMETER);
+
 	case ACPI_GPE_ENABLE:
 		ACPI_SET_BIT(enable_mask, register_bit);
 		break;
@@ -154,23 +158,11 @@ acpi_hw_low_set_gpe(struct acpi_gpe_even
 acpi_status
 acpi_hw_write_gpe_enable_reg(struct acpi_gpe_event_info * gpe_event_info)
 {
-	struct acpi_gpe_register_info *gpe_register_info;
 	acpi_status status;
 
 	ACPI_FUNCTION_ENTRY();
 
-	/* Get the info block for the entire GPE register */
-
-	gpe_register_info = gpe_event_info->register_info;
-	if (!gpe_register_info) {
-		return (AE_NOT_EXIST);
-	}
-
-	/* Write the entire GPE (runtime) enable register */
-
-	status = acpi_hw_write(gpe_register_info->enable_for_run,
-			       &gpe_register_info->enable_address);
-
+	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_COND_ENABLE);
 	return (status);
 }
 
Index: linux-2.6/include/acpi/actypes.h
===================================================================
--- linux-2.6.orig/include/acpi/actypes.h
+++ linux-2.6/include/acpi/actypes.h
@@ -667,6 +667,7 @@ typedef u32 acpi_event_status;
 
 #define ACPI_GPE_ENABLE                 0
 #define ACPI_GPE_DISABLE                1
+#define ACPI_GPE_COND_ENABLE            2
 
 /* gpe_types for acpi_enable_gpe and acpi_disable_gpe */
 

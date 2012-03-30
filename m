From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/76] ACPICA: Fix regression in FADT revision
	checks
Date: Fri, 30 Mar 2012 06:13:07 -0400
Message-ID: <3e80acd1af40fcd91a200b0416a7616b20c5d647.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, Julian Anastasov <ja@ssi.bg>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Julian Anastasov <ja@ssi.bg>

	commit 64b3db22c04586997ab4be46dd5a5b99f8a2d390 (2.6.39),
"Remove use of unreliable FADT revision field" causes regression
for old P4 systems because now cst_control and other fields are
not reset to 0.

	The effect is that acpi_processor_power_init will notice
cst_control != 0 and a write to CST_CNT register is performed
that should not happen. As result, the system oopses after the
"No _CST, giving up" message, sometimes in acpi_ns_internalize_name,
sometimes in acpi_ns_get_type, usually at random places. May be
during migration to CPU 1 in acpi_processor_get_throttling.

	Every one of these settings help to avoid this problem:
 - acpi=off
 - processor.nocst=1
 - maxcpus=1

	The fix is to update acpi_gbl_FADT.header.length after
the original value is used to check for old revisions.

https://bugzilla.kernel.org/show_bug.cgi?id=42700
https://bugzilla.redhat.com/show_bug.cgi?id=727865

Signed-off-by: Julian Anastasov <ja@ssi.bg>
Acked-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/tbfadt.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index c5d8704..4c9c760 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -363,10 +363,6 @@ static void acpi_tb_convert_fadt(void)
 	u32 address32;
 	u32 i;
 
-	/* Update the local FADT table header length */
-
-	acpi_gbl_FADT.header.length = sizeof(struct acpi_table_fadt);
-
 	/*
 	 * Expand the 32-bit FACS and DSDT addresses to 64-bit as necessary.
 	 * Later code will always use the X 64-bit field. Also, check for an
@@ -408,6 +404,10 @@ static void acpi_tb_convert_fadt(void)
 		acpi_gbl_FADT.boot_flags = 0;
 	}
 
+	/* Update the local FADT table header length */
+
+	acpi_gbl_FADT.header.length = sizeof(struct acpi_table_fadt);
+
 	/*
 	 * Expand the ACPI 1.0 32-bit addresses to the ACPI 2.0 64-bit "X"
 	 * generic address structures as necessary. Later code will always use
-- 
1.7.10.rc2.19.gfae9d

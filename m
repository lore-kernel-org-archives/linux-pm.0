From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/76] ACPI: ignore FADT reset-reg-sup flag
Date: Fri, 30 Mar 2012 06:13:06 -0400
Message-ID: <cf450136bfde77c7f95065c91bffded4aa7fa731.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

we check that the address is non-zero later anyway.

https://bugzilla.kernel.org/show_bug.cgi?id=11533

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwxface.c |    3 +--
 drivers/acpi/reboot.c         |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 9d38eb6..fe1fb63 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -74,8 +74,7 @@ acpi_status acpi_reset(void)
 
 	/* Check if the reset register is supported */
 
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER) ||
-	    !reset_reg->address) {
+	if (!reset_reg->address) {
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index a6c77e8b..c1d6124 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -23,8 +23,7 @@ void acpi_reboot(void)
 	/* Is the reset register supported? The spec says we should be
 	 * checking the bit width and bit offset, but Windows ignores
 	 * these fields */
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER))
-		return;
+	/* Ignore also acpi_gbl_FADT.flags.ACPI_FADT_RESET_REGISTER */
 
 	reset_value = acpi_gbl_FADT.reset_value;
 
-- 
1.7.10.rc2.19.gfae9d


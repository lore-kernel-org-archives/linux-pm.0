From: Len Brown <lenb@kernel.org>
Subject: [PATCH 35/76] ACPICA: Change exception code for invalid pathname in
 acpi_evaluate_object
Date: Fri, 30 Mar 2012 06:13:38 -0400
Message-ID: <a1acd22f7c6032e8394df7d8adee1a7cdad28b74.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Change the returned exception code from AE_BAD_PARAMETER to the
more appropriate AE_BAD_PATHNAME, when the input pathname to
evaluate object is invalid.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nsutils.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index a535b7a..7511375 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -341,7 +341,7 @@ acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info)
 
 		if (!acpi_ns_valid_path_separator(*external_name) &&
 		    (*external_name != 0)) {
-			return_ACPI_STATUS(AE_BAD_PARAMETER);
+			return_ACPI_STATUS(AE_BAD_PATHNAME);
 		}
 
 		/* Move on the next segment */
-- 
1.7.10.rc2.19.gfae9d


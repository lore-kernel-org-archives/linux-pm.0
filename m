From: Len Brown <lenb@kernel.org>
Subject: [PATCH 41/52] ACPICA: Add PCC address space to space ID decode function
Date: Tue, 24 Jul 2012 23:41:37 -0400
Message-ID: <540b85ab223f00e9715cee0f7a205f636b5eb4b8.1343187617.git.len.brown@intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343187708-19532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
References: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPI 5.0 added PCC space ID.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/utdecode.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index c8c130c..28134ae 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -129,16 +129,17 @@ char acpi_ut_hex_to_ascii_char(u64 integer, u32 position)
 /* Region type decoding */
 
 const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS] = {
-	"SystemMemory",
-	"SystemIO",
-	"PCI_Config",
-	"EmbeddedControl",
-	"SMBus",
-	"SystemCMOS",
-	"PCIBARTarget",
-	"IPMI",
-	"GeneralPurposeIo",
-	"GenericSerialBus"
+	"SystemMemory",		/* 0x00 */
+	"SystemIO",		/* 0x01 */
+	"PCI_Config",		/* 0x02 */
+	"EmbeddedControl",	/* 0x03 */
+	"SMBus",		/* 0x04 */
+	"SystemCMOS",		/* 0x05 */
+	"PCIBARTarget",		/* 0x06 */
+	"IPMI",			/* 0x07 */
+	"GeneralPurposeIo",	/* 0x08 */
+	"GenericSerialBus",	/* 0x09 */
+	"PCC"			/* 0x0A */
 };
 
 char *acpi_ut_get_region_name(u8 space_id)
-- 
1.7.12.rc0

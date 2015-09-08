From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: [PATCH 1/4] acpi: rename acpi_table_parse_entries
Date: Tue,  8 Sep 2015 13:07:57 +0200
Message-ID: <1441710480-17622-3-git-send-email-lukasz.anaczkowski@intel.com>
References: <20150827093738.GA21134@red-moon>
 <1441710480-17622-1-git-send-email-lukasz.anaczkowski@intel.com>
 <1441710480-17622-2-git-send-email-lukasz.anaczkowski@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441710480-17622-2-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tomasz.nowicki@linaro.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
List-Id: linux-pm@vger.kernel.org

ACPI subtable parsing needs to be extended to allow two or more
handlers to be run in the same ACPI table walk.
This is needed to fix CPU enumeration when APIC/X2APIC entries
are interleaved.

Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
---
 drivers/acpi/tables.c | 13 ++++++++++++-
 include/linux/acpi.h  |  4 ++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 2e19189..aa8bcc6 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -277,7 +277,7 @@ acpi_parse_entries(char *id, unsigned long table_size,
 }
 
 int __init
-acpi_table_parse_entries(char *id,
+acpi_table_parse_entries_array(char *id,
 			 unsigned long table_size,
 			 int entry_id,
 			 acpi_tbl_entry_handler handler,
@@ -311,6 +311,17 @@ acpi_table_parse_entries(char *id,
 }
 
 int __init
+acpi_table_parse_entries(char *id,
+			unsigned long table_size,
+			int entry_id,
+			acpi_tbl_entry_handler handler,
+			unsigned int max_entries)
+{
+	return acpi_table_parse_entries_array(id, table_size, entry_id,
+						handler, max_entries);
+}
+
+int __init
 acpi_table_parse_madt(enum acpi_madt_type id,
 		      acpi_tbl_entry_handler handler, unsigned int max_entries)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d2445fa..07fd1d1 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -153,6 +153,10 @@ int __init acpi_table_parse_entries(char *id, unsigned long table_size,
 				    int entry_id,
 				    acpi_tbl_entry_handler handler,
 				    unsigned int max_entries);
+int __init acpi_table_parse_entries_array(char *id, unsigned long table_size,
+				    int entry_id,
+				    acpi_tbl_entry_handler handler,
+				    unsigned int max_entries);
 int acpi_table_parse_madt(enum acpi_madt_type id,
 			  acpi_tbl_entry_handler handler,
 			  unsigned int max_entries);
-- 
1.8.3.1

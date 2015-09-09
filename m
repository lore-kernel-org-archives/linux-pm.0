From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: [PATCH 1/2] acpi: Added acpi_subtable_proc to ACPI table parsers
Date: Wed,  9 Sep 2015 11:30:17 +0200
Message-ID: <1441791018-14669-2-git-send-email-lukasz.anaczkowski@intel.com>
References: <55EF0C7A.7070105@arm.com>
 <1441791018-14669-1-git-send-email-lukasz.anaczkowski@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1441791018-14669-1-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tomasz.nowicki@linaro.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
List-Id: linux-pm@vger.kernel.org

ACPI subtable parsing needs to be extended to allow two or more
handlers to be run in the same ACPI table walk, thus adding
acpi_subtable_proc structure which stores
() ACPI table id
() handler that processes table
() counter how many items has been processed
and passing it to acpi_parse_entries_array() and
acpi_table_parse_entries_array().

This is needed to fix CPU enumeration when APIC/X2APIC entries
are interleaved.

Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
---
 drivers/acpi/tables.c | 89 +++++++++++++++++++++++++++++++++++++++++----------
 include/linux/acpi.h  | 13 ++++++++
 2 files changed, 85 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 2e19189..13e5089 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -214,20 +214,37 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 	}
 }
 
+/**
+ * acpi_parse_entries_array - for each proc_num find a subtable with proc->id
+ *    and run proc->handler on it. Assumption is that there's only
+ *    single handler for particular entry id.
+ *
+ * @id: table id (for debugging purposes)
+ * @table_size: single entry size
+ * @table_header: where does the table start?
+ * @proc: array of acpi_subtable_proc struct containing entry id
+ *        and associated handler with it
+ * @proc_num: how big proc is?
+ * @max_entries: how many entries can we process?
+ *
+ * On success returns sum of all matching entries for all proc handlers.
+ * Oterwise, -ENODEV or -EINVAL is returned.
+ */
 int __init
-acpi_parse_entries(char *id, unsigned long table_size,
-		acpi_tbl_entry_handler handler,
+acpi_parse_entries_array(char *id, unsigned long table_size,
 		struct acpi_table_header *table_header,
-		int entry_id, unsigned int max_entries)
+		struct acpi_subtable_proc *proc, int proc_num,
+		unsigned int max_entries)
 {
 	struct acpi_subtable_header *entry;
-	int count = 0;
 	unsigned long table_end;
+	int count = 0;
+	int i;
 
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (!id || !handler)
+	if (!id)
 		return -EINVAL;
 
 	if (!table_size)
@@ -247,20 +264,27 @@ acpi_parse_entries(char *id, unsigned long table_size,
 
 	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
 	       table_end) {
-		if (entry->type == entry_id
-		    && (!max_entries || count < max_entries)) {
-			if (handler(entry, table_end))
+		if (max_entries && count >= max_entries)
+			break;
+
+		for (i = 0; i < proc_num; i++) {
+			if (entry->type != proc[i].id)
+				continue;
+			if (!proc->handler || proc[i].handler(entry, table_end))
 				return -EINVAL;
 
-			count++;
+			proc->count++;
+			break;
 		}
+		if (i != proc_num)
+			count++;
 
 		/*
 		 * If entry->length is 0, break from this loop to avoid
 		 * infinite loop.
 		 */
 		if (entry->length == 0) {
-			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, entry_id);
+			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
 			return -EINVAL;
 		}
 
@@ -270,17 +294,31 @@ acpi_parse_entries(char *id, unsigned long table_size,
 
 	if (max_entries && count > max_entries) {
 		pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n",
-			id, entry_id, count - max_entries, count);
+			id, proc->id, count - max_entries, count);
 	}
 
 	return count;
 }
 
+int __init acpi_parse_entries(char *id, unsigned long table_size,
+			       acpi_tbl_entry_handler handler,
+			       struct acpi_table_header *table_header,
+			       int entry_id, unsigned int max_entries)
+{
+	struct acpi_subtable_proc proc = {
+		.id		= entry_id,
+		.handler	= handler,
+		.count		= 0,
+	};
+
+	return acpi_parse_entries_array(id, table_size, table_header,
+			&proc, 1, max_entries);
+}
+
 int __init
-acpi_table_parse_entries(char *id,
+acpi_table_parse_entries_array(char *id,
 			 unsigned long table_size,
-			 int entry_id,
-			 acpi_tbl_entry_handler handler,
+			 struct acpi_subtable_proc *proc, int proc_num,
 			 unsigned int max_entries)
 {
 	struct acpi_table_header *table_header = NULL;
@@ -291,7 +329,7 @@ acpi_table_parse_entries(char *id,
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (!id || !handler)
+	if (!id)
 		return -EINVAL;
 
 	if (!strncmp(id, ACPI_SIG_MADT, 4))
@@ -303,14 +341,31 @@ acpi_table_parse_entries(char *id,
 		return -ENODEV;
 	}
 
-	count = acpi_parse_entries(id, table_size, handler, table_header,
-			entry_id, max_entries);
+	count = acpi_parse_entries_array(id, table_size, table_header,
+			proc, proc_num, max_entries);
 
 	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
 	return count;
 }
 
 int __init
+acpi_table_parse_entries(char *id,
+			unsigned long table_size,
+			int entry_id,
+			acpi_tbl_entry_handler handler,
+			unsigned int max_entries)
+{
+	struct acpi_subtable_proc proc = {
+		.id		= entry_id,
+		.handler	= handler,
+		.count		= 0,
+	};
+
+	return acpi_table_parse_entries_array(id, table_size, &proc, 1,
+						max_entries);
+}
+
+int __init
 acpi_table_parse_madt(enum acpi_madt_type id,
 		      acpi_tbl_entry_handler handler, unsigned int max_entries)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d2445fa..7a25ef9 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -135,6 +135,12 @@ static inline void acpi_initrd_override(void *data, size_t size)
 		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
 		((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
 
+struct acpi_subtable_proc {
+	int id;
+	acpi_tbl_entry_handler handler;
+	int count;
+};
+
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
 void __acpi_unmap_table(char *map, unsigned long size);
 int early_acpi_boot_init(void);
@@ -149,10 +155,17 @@ int __init acpi_parse_entries(char *id, unsigned long table_size,
 			      acpi_tbl_entry_handler handler,
 			      struct acpi_table_header *table_header,
 			      int entry_id, unsigned int max_entries);
+int __init acpi_parse_entries_array(char *id, unsigned long table_size,
+			      struct acpi_table_header *table_header,
+			      struct acpi_subtable_proc *proc, int proc_num,
+			      unsigned int max_entries);
 int __init acpi_table_parse_entries(char *id, unsigned long table_size,
 				    int entry_id,
 				    acpi_tbl_entry_handler handler,
 				    unsigned int max_entries);
+int __init acpi_table_parse_entries_array(char *id, unsigned long table_size,
+				    struct acpi_subtable_proc *proc, int proc_num,
+				    unsigned int max_entries);
 int acpi_table_parse_madt(enum acpi_madt_type id,
 			  acpi_tbl_entry_handler handler,
 			  unsigned int max_entries);
-- 
1.8.3.1


From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: [PATCH 3/4] acpi: multi proc support
Date: Tue,  8 Sep 2015 13:07:59 +0200
Message-ID: <1441710480-17622-5-git-send-email-lukasz.anaczkowski@intel.com>
References: <20150827093738.GA21134@red-moon>
 <1441710480-17622-1-git-send-email-lukasz.anaczkowski@intel.com>
 <1441710480-17622-2-git-send-email-lukasz.anaczkowski@intel.com>
 <1441710480-17622-3-git-send-email-lukasz.anaczkowski@intel.com>
 <1441710480-17622-4-git-send-email-lukasz.anaczkowski@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1441710480-17622-4-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tomasz.nowicki@linaro.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
List-Id: linux-pm@vger.kernel.org

Now, it is possible to pass two or more handlers.

Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
---
 drivers/acpi/tables.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 33539ee..ececeac 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -214,6 +214,22 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 	}
 }
 
+/**
+ * acpi_parse_entries - for each proc_num find a subtable with proc->id
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
 acpi_parse_entries(char *id, unsigned long table_size,
 		struct acpi_table_header *table_header,
@@ -247,13 +263,20 @@ acpi_parse_entries(char *id, unsigned long table_size,
 
 	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
 	       table_end) {
-		if (entry->type == proc->id
-		    && (!max_entries || count < max_entries)) {
-			if (!proc->handler || proc->handler(entry, table_end))
+		if (max_entries && count >= max_entries)
+			break;
+
+		for (i = 0; i < proc_num; i++) {
+			if (entry->type != proc[i].id)
+				continue;
+			if (!proc->handler || proc[i].handler(entry, table_end)) {
 				return -EINVAL;
 
 			proc->count++;
+			break;
 		}
+		if (i != proc_num)
+			count++;
 
 		/*
 		 * If entry->length is 0, break from this loop to avoid
@@ -268,8 +291,6 @@ acpi_parse_entries(char *id, unsigned long table_size,
 		    ((unsigned long)entry + entry->length);
 	}
 
-	count = proc->count;
-
 	if (max_entries && count > max_entries) {
 		pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n",
 			id, proc->id, count - max_entries, count);
-- 
1.8.3.1


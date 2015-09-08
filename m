From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: [PATCH 2/4] x86, arm64, acpi: Added acpi_subtable_proc
Date: Tue,  8 Sep 2015 13:07:58 +0200
Message-ID: <1441710480-17622-4-git-send-email-lukasz.anaczkowski@intel.com>
References: <20150827093738.GA21134@red-moon>
 <1441710480-17622-1-git-send-email-lukasz.anaczkowski@intel.com>
 <1441710480-17622-2-git-send-email-lukasz.anaczkowski@intel.com>
 <1441710480-17622-3-git-send-email-lukasz.anaczkowski@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4262 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754622AbbIHLIS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Sep 2015 07:08:18 -0400
In-Reply-To: <1441710480-17622-3-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tomasz.nowicki@linaro.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>

Single item array is only supported to verify that original
logic is not changed.
Update for many item array support is to be added in next patch.

Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
---
 arch/x86/kernel/acpi/boot.c | 36 ++++++++++++++++++++++++++++--------
 drivers/acpi/numa.c         | 13 ++++++++++---
 drivers/acpi/tables.c       | 40 +++++++++++++++++++++++++---------------
 drivers/irqchip/irq-gic.c   | 15 +++++++++++----
 include/linux/acpi.h        | 13 +++++++++----
 5 files changed, 83 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e49ee24..21cb7a0 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -981,6 +981,7 @@ static int __init acpi_parse_madt_lapic_entries(void)
 {
 	int count;
 	int x2count = 0;
+	struct acpi_subtable_proc madt_proc[1];
 
 	if (!cpu_has_apic)
 		return -ENODEV;
@@ -1004,10 +1005,19 @@ static int __init acpi_parse_madt_lapic_entries(void)
 				      acpi_parse_sapic, MAX_LOCAL_APIC);
 
 	if (!count) {
-		x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
-					acpi_parse_x2apic, MAX_LOCAL_APIC);
-		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
-					acpi_parse_lapic, MAX_LOCAL_APIC);
+		memset(madt_proc, 0, sizeof(madt_proc));
+		madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_X2APIC;
+		madt_proc[0].handler = acpi_parse_x2apic;
+		x2count = acpi_table_parse_entries_array(ACPI_SIG_MADT,
+						sizeof(struct acpi_table_madt),
+						madt_proc, ARRAY_SIZE(madt_proc), MAX_LOCAL_APIC);
+
+		memset(madt_proc, 0, sizeof(madt_proc));
+		madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_APIC;
+		madt_proc[0].handler = acpi_parse_lapic;
+		count = acpi_table_parse_entries_array(ACPI_SIG_MADT,
+				sizeof(struct acpi_table_madt),
+				madt_proc, ARRAY_SIZE(madt_proc), MAX_LOCAL_APIC);
 	}
 	if (!count && !x2count) {
 		printk(KERN_ERR PREFIX "No LAPIC entries present\n");
@@ -1019,10 +1029,20 @@ static int __init acpi_parse_madt_lapic_entries(void)
 		return count;
 	}
 
-	x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC_NMI,
-					acpi_parse_x2apic_nmi, 0);
-	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_NMI,
-				      acpi_parse_lapic_nmi, 0);
+	memset(madt_proc, 0, sizeof(madt_proc));
+	madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_X2APIC_NMI;
+	madt_proc[0].handler = acpi_parse_x2apic_nmi;
+	count = acpi_table_parse_entries_array(ACPI_SIG_MADT,
+			sizeof(struct acpi_table_madt),
+			madt_proc, ARRAY_SIZE(madt_proc), 0);
+
+	memset(madt_proc, 0, sizeof(madt_proc));
+	madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_APIC_NMI;
+	madt_proc[0].handler = acpi_parse_lapic_nmi;
+	x2count = acpi_table_parse_entries_array(ACPI_SIG_MADT,
+			sizeof(struct acpi_table_madt),
+			madt_proc, ARRAY_SIZE(madt_proc), 0);
+
 	if (count < 0 || x2count < 0) {
 		printk(KERN_ERR PREFIX "Error parsing LAPIC NMI entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index acaa3b4..f3ccc68 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -314,9 +314,15 @@ static int __init
 acpi_table_parse_srat(enum acpi_srat_type id,
 		      acpi_tbl_entry_handler handler, unsigned int max_entries)
 {
-	return acpi_table_parse_entries(ACPI_SIG_SRAT,
-					    sizeof(struct acpi_table_srat), id,
-					    handler, max_entries);
+	struct acpi_subtable_proc srat_proc;
+
+	memset(&srat_proc, 0, sizeof(srat_proc));
+	srat_proc.id = id;
+	srat_proc.handler = handler;
+
+	return acpi_table_parse_entries_array(ACPI_SIG_SRAT,
+				sizeof(struct acpi_table_srat),
+				&srat_proc, 1, max_entries);
 }
 
 int __init acpi_numa_init(void)
@@ -335,6 +341,7 @@ int __init acpi_numa_init(void)
 				     acpi_parse_x2apic_affinity, 0);
 		acpi_table_parse_srat(ACPI_SRAT_TYPE_CPU_AFFINITY,
 				     acpi_parse_processor_affinity, 0);
+
 		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
 					    acpi_parse_memory_affinity,
 					    NR_NODE_MEMBLKS);
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index aa8bcc6..33539ee 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -216,9 +216,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 
 int __init
 acpi_parse_entries(char *id, unsigned long table_size,
-		acpi_tbl_entry_handler handler,
 		struct acpi_table_header *table_header,
-		int entry_id, unsigned int max_entries)
+		struct acpi_subtable_proc *proc, int proc_num,
+		unsigned int max_entries)
 {
 	struct acpi_subtable_header *entry;
 	int count = 0;
@@ -227,7 +227,7 @@ acpi_parse_entries(char *id, unsigned long table_size,
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (!id || !handler)
+	if (!id)
 		return -EINVAL;
 
 	if (!table_size)
@@ -247,12 +247,12 @@ acpi_parse_entries(char *id, unsigned long table_size,
 
 	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
 	       table_end) {
-		if (entry->type == entry_id
+		if (entry->type == proc->id
 		    && (!max_entries || count < max_entries)) {
-			if (handler(entry, table_end))
+			if (!proc->handler || proc->handler(entry, table_end))
 				return -EINVAL;
 
-			count++;
+			proc->count++;
 		}
 
 		/*
@@ -260,7 +260,7 @@ acpi_parse_entries(char *id, unsigned long table_size,
 		 * infinite loop.
 		 */
 		if (entry->length == 0) {
-			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, entry_id);
+			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
 			return -EINVAL;
 		}
 
@@ -268,9 +268,11 @@ acpi_parse_entries(char *id, unsigned long table_size,
 		    ((unsigned long)entry + entry->length);
 	}
 
+	count = proc->count;
+
 	if (max_entries && count > max_entries) {
 		pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n",
-			id, entry_id, count - max_entries, count);
+			id, proc->id, count - max_entries, count);
 	}
 
 	return count;
@@ -279,8 +281,7 @@ acpi_parse_entries(char *id, unsigned long table_size,
 int __init
 acpi_table_parse_entries_array(char *id,
 			 unsigned long table_size,
-			 int entry_id,
-			 acpi_tbl_entry_handler handler,
+			 struct acpi_subtable_proc *proc, int proc_num,
 			 unsigned int max_entries)
 {
 	struct acpi_table_header *table_header = NULL;
@@ -291,7 +292,7 @@ acpi_table_parse_entries_array(char *id,
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (!id || !handler)
+	if (!id)
 		return -EINVAL;
 
 	if (!strncmp(id, ACPI_SIG_MADT, 4))
@@ -303,8 +304,8 @@ acpi_table_parse_entries_array(char *id,
 		return -ENODEV;
 	}
 
-	count = acpi_parse_entries(id, table_size, handler, table_header,
-			entry_id, max_entries);
+	count = acpi_parse_entries(id, table_size, table_header,
+			proc, proc_num, max_entries);
 
 	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
 	return count;
@@ -317,8 +318,17 @@ acpi_table_parse_entries(char *id,
 			acpi_tbl_entry_handler handler,
 			unsigned int max_entries)
 {
-	return acpi_table_parse_entries_array(id, table_size, entry_id,
-						handler, max_entries);
+	struct acpi_subtable_proc proc[1];
+
+	if (!handler)
+		return -EINVAL;
+
+	memset(proc, 0, sizeof(proc));
+	proc[0].id = entry_id;
+	proc[0].handler = handler;
+
+	return acpi_table_parse_entries_array(id, table_size, proc, 1,
+						max_entries);
 }
 
 int __init
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4dd8826..581336c 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1091,12 +1091,16 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 {
 	void __iomem *cpu_base, *dist_base;
 	int count;
+	struct acpi_subtable_proc gic_proc[1];
+
+	memset(gic_proc, 0, sizeof(gic_proc));
+	gic_proc[0].id = ACPI_MADT_TYPE_GENERIC_INTERRUPT;
+	gic_proc[0].handler = gic_acpi_parse_madt_cpu;
 
 	/* Collect CPU base addresses */
 	count = acpi_parse_entries(ACPI_SIG_MADT,
 				   sizeof(struct acpi_table_madt),
-				   gic_acpi_parse_madt_cpu, table,
-				   ACPI_MADT_TYPE_GENERIC_INTERRUPT, 0);
+				   table, gic_proc, 1, 0);
 	if (count <= 0) {
 		pr_err("No valid GICC entries exist\n");
 		return -EINVAL;
@@ -1106,10 +1110,13 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 	 * Find distributor base address. We expect one distributor entry since
 	 * ACPI 5.1 spec neither support multi-GIC instances nor GIC cascade.
 	 */
+	memset(gic_proc, 0, sizeof(gic_proc));
+	gic_proc[0].id = ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR;
+	gic_proc[0].handler = gic_acpi_parse_madt_distributor;
+
 	count = acpi_parse_entries(ACPI_SIG_MADT,
 				   sizeof(struct acpi_table_madt),
-				   gic_acpi_parse_madt_distributor, table,
-				   ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR, 0);
+				   table, gic_proc, 1, 0);
 	if (count <= 0) {
 		pr_err("No valid GICD entries exist\n");
 		return -EINVAL;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 07fd1d1..52c8d20 100644
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
@@ -146,16 +152,15 @@ int acpi_numa_init (void);
 int acpi_table_init (void);
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
 int __init acpi_parse_entries(char *id, unsigned long table_size,
-			      acpi_tbl_entry_handler handler,
 			      struct acpi_table_header *table_header,
-			      int entry_id, unsigned int max_entries);
+			      struct acpi_subtable_proc *proc, int proc_num,
+			      unsigned int max_entries);
 int __init acpi_table_parse_entries(char *id, unsigned long table_size,
 				    int entry_id,
 				    acpi_tbl_entry_handler handler,
 				    unsigned int max_entries);
 int __init acpi_table_parse_entries_array(char *id, unsigned long table_size,
-				    int entry_id,
-				    acpi_tbl_entry_handler handler,
+				    struct acpi_subtable_proc *proc, int proc_num,
 				    unsigned int max_entries);
 int acpi_table_parse_madt(enum acpi_madt_type id,
 			  acpi_tbl_entry_handler handler,
-- 
1.8.3.1


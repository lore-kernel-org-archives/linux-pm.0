From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: [PATCH] x86, acpi: Handle xapic/x2apic entries in MADT
Date: Mon, 13 Jul 2015 15:54:47 +0200
Message-ID: <1436795687-18539-1-git-send-email-lukasz.anaczkowski@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
List-Id: linux-pm@vger.kernel.org

This patch is based on work of "Yinghai Lu <yinghai@kernel.org>"
previously published at https://lkml.org/lkml/2013/1/21/563.

In case when BIOS is populating MADT wiht both x2apic and local apic
entries (as per ACPI spec), kernel builds it's processor table
in the following order: BSP, X2APIC, local APIC, resulting in
processors on the same core are not separated by core count.

This patch fixes this behavior and resulting assignment is
correct.

Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
---
 arch/x86/kernel/acpi/boot.c | 29 +++++++++++++-----
 drivers/acpi/numa.c         | 28 ++++++++++++-----
 drivers/acpi/tables.c       | 75 ++++++++++++++++++++++++++++-----------------
 drivers/irqchip/irq-gic.c   | 15 ++++++---
 include/linux/acpi.h        | 13 ++++++--
 5 files changed, 111 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e49ee24..1bb79d5 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -981,6 +981,7 @@ static int __init acpi_parse_madt_lapic_entries(void)
 {
 	int count;
 	int x2count = 0;
+	struct acpi_subtable_proc madt_proc[2];
 
 	if (!cpu_has_apic)
 		return -ENODEV;
@@ -1004,10 +1005,16 @@ static int __init acpi_parse_madt_lapic_entries(void)
 				      acpi_parse_sapic, MAX_LOCAL_APIC);
 
 	if (!count) {
-		x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
-					acpi_parse_x2apic, MAX_LOCAL_APIC);
-		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
-					acpi_parse_lapic, MAX_LOCAL_APIC);
+		memset(madt_proc, 0, sizeof(madt_proc));
+		madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_APIC;
+		madt_proc[0].handler = acpi_parse_lapic;
+		madt_proc[1].id = ACPI_MADT_TYPE_LOCAL_X2APIC;
+		madt_proc[1].handler = acpi_parse_x2apic;
+		acpi_table_parse_entries_array(ACPI_SIG_MADT,
+			    sizeof(struct acpi_table_madt),
+			    madt_proc, ARRAY_SIZE(madt_proc), MAX_LOCAL_APIC);
+		count = madt_proc[0].count;
+		x2count = madt_proc[1].count;
 	}
 	if (!count && !x2count) {
 		printk(KERN_ERR PREFIX "No LAPIC entries present\n");
@@ -1019,10 +1026,16 @@ static int __init acpi_parse_madt_lapic_entries(void)
 		return count;
 	}
 
-	x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC_NMI,
-					acpi_parse_x2apic_nmi, 0);
-	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_NMI,
-				      acpi_parse_lapic_nmi, 0);
+	memset(madt_proc, 0, sizeof(madt_proc));
+	madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_APIC_NMI;
+	madt_proc[0].handler = acpi_parse_lapic_nmi;
+	madt_proc[1].id = ACPI_MADT_TYPE_LOCAL_X2APIC_NMI;
+	madt_proc[1].handler = acpi_parse_x2apic_nmi;
+	acpi_table_parse_entries_array(ACPI_SIG_MADT,
+			    sizeof(struct acpi_table_madt),
+			    madt_proc, ARRAY_SIZE(madt_proc), 0);
+	count = madt_proc[0].count;
+	x2count = madt_proc[1].count;
 	if (count < 0 || x2count < 0) {
 		printk(KERN_ERR PREFIX "Error parsing LAPIC NMI entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index acaa3b4..2bdff0c 100644
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
+					    sizeof(struct acpi_table_srat),
+					    &srat_proc, 1, max_entries);
 }
 
 int __init acpi_numa_init(void)
@@ -331,10 +337,18 @@ int __init acpi_numa_init(void)
 
 	/* SRAT: Static Resource Affinity Table */
 	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
-		acpi_table_parse_srat(ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY,
-				     acpi_parse_x2apic_affinity, 0);
-		acpi_table_parse_srat(ACPI_SRAT_TYPE_CPU_AFFINITY,
-				     acpi_parse_processor_affinity, 0);
+		struct acpi_subtable_proc srat_proc[2];
+
+		memset(srat_proc, 0, sizeof(srat_proc));
+		srat_proc[0].id = ACPI_SRAT_TYPE_CPU_AFFINITY;
+		srat_proc[0].handler = acpi_parse_processor_affinity;
+		srat_proc[1].id = ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY;
+		srat_proc[1].handler = acpi_parse_x2apic_affinity;
+
+		acpi_table_parse_entries_array(ACPI_SIG_SRAT,
+					    sizeof(struct acpi_table_srat),
+					    srat_proc, ARRAY_SIZE(srat_proc), 0);
+
 		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
 					    acpi_parse_memory_affinity,
 					    NR_NODE_MEMBLKS);
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 2e19189..1217e41 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -216,25 +216,27 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 
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
 	unsigned long table_end;
+	int i;
 
-	if (acpi_disabled)
+	if (acpi_disabled) {
+		proc[0].count = -ENODEV;
 		return -ENODEV;
-
-	if (!id || !handler)
-		return -EINVAL;
-
-	if (!table_size)
+	}
+	if (!table_size) {
+		proc[0].count = -EINVAL;
 		return -EINVAL;
+	}
 
 	if (!table_header) {
 		pr_warn("%4.4s not present\n", id);
+		proc[0].count = -ENODEV;
 		return -ENODEV;
 	}
 
@@ -247,12 +249,17 @@ acpi_parse_entries(char *id, unsigned long table_size,
 
 	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
 	       table_end) {
-		if (entry->type == entry_id
-		    && (!max_entries || count < max_entries)) {
-			if (handler(entry, table_end))
+		for (i = 0; i < proc_num; i++) {
+			if (entry->type != proc[i].id)
+				continue;
+			if (max_entries && count++ >= max_entries)
+				continue;
+			if (proc[i].handler(entry, table_end)) {
+				proc[i].count = -EINVAL;
 				return -EINVAL;
-
-			count++;
+			}
+			proc[i].count++;
+			break;
 		}
 
 		/*
@@ -260,7 +267,11 @@ acpi_parse_entries(char *id, unsigned long table_size,
 		 * infinite loop.
 		 */
 		if (entry->length == 0) {
-			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, entry_id);
+			pr_err("[%4.4s:0x%02x ", id, proc[0].id);
+			for (i = 1; i < proc_num; i++)
+				pr_cont(" 0x%02x", proc[i].id);
+			pr_cont("] Invalid zero length\n");
+			proc[0].count = -EINVAL;
 			return -EINVAL;
 		}
 
@@ -269,18 +280,20 @@ acpi_parse_entries(char *id, unsigned long table_size,
 	}
 
 	if (max_entries && count > max_entries) {
-		pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n",
-			id, entry_id, count - max_entries, count);
+		pr_warn("[%4.4s:0x%02x ", id, proc[0].id);
+		for (i = 1; i < proc_num; i++)
+			pr_cont(" 0x%02x", proc[i].id);
+		pr_cont("] ignored %i entries of %i found\n",
+			count-max_entries, count);
 	}
 
 	return count;
 }
 
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
@@ -288,11 +301,10 @@ acpi_table_parse_entries(char *id,
 	int count;
 	u32 instance = 0;
 
-	if (acpi_disabled)
+	if (acpi_disabled) {
+		proc[0].count = -ENODEV;
 		return -ENODEV;
-
-	if (!id || !handler)
-		return -EINVAL;
+	}
 
 	if (!strncmp(id, ACPI_SIG_MADT, 4))
 		instance = acpi_apic_instance;
@@ -300,11 +312,12 @@ acpi_table_parse_entries(char *id,
 	acpi_get_table_with_size(id, instance, &table_header, &tbl_size);
 	if (!table_header) {
 		pr_warn("%4.4s not present\n", id);
+		proc[0].count = -ENODEV;
 		return -ENODEV;
 	}
 
-	count = acpi_parse_entries(id, table_size, handler, table_header,
-			entry_id, max_entries);
+	count = acpi_parse_entries(id, table_size, table_header,
+			proc, proc_num, max_entries);
 
 	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
 	return count;
@@ -314,9 +327,15 @@ int __init
 acpi_table_parse_madt(enum acpi_madt_type id,
 		      acpi_tbl_entry_handler handler, unsigned int max_entries)
 {
-	return acpi_table_parse_entries(ACPI_SIG_MADT,
-					    sizeof(struct acpi_table_madt), id,
-					    handler, max_entries);
+	struct acpi_subtable_proc madt_proc;
+
+	memset(&madt_proc, 0, sizeof(madt_proc));
+	madt_proc.id = id;
+	madt_proc.handler = handler;
+
+	return acpi_table_parse_entries_array(ACPI_SIG_MADT,
+					    sizeof(struct acpi_table_madt),
+					    &madt_proc, 1, max_entries);
 }
 
 /**
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4dd8826..d004a32 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1091,12 +1091,16 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 {
 	void __iomem *cpu_base, *dist_base;
 	int count;
+	struct acpi_subtable_proc gic_proc;
+
+	memset(gic_proc, 0, sizeof(gic_proc));
+	gic_proc.id = ACPI_MADT_TYPE_GENERIC_INTERRUPT;
+	gic_proc.handler = gic_acpi_parse_madt_cpu;
 
 	/* Collect CPU base addresses */
 	count = acpi_parse_entries(ACPI_SIG_MADT,
 				   sizeof(struct acpi_table_madt),
-				   gic_acpi_parse_madt_cpu, table,
-				   ACPI_MADT_TYPE_GENERIC_INTERRUPT, 0);
+				   table, gic_proc, 0);
 	if (count <= 0) {
 		pr_err("No valid GICC entries exist\n");
 		return -EINVAL;
@@ -1106,10 +1110,13 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 	 * Find distributor base address. We expect one distributor entry since
 	 * ACPI 5.1 spec neither support multi-GIC instances nor GIC cascade.
 	 */
+	memset(gic_proc, 0, sizeof(gic_proc));
+	gic_proc.id = ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR;
+	gic_proc.handler = gic_acpi_parse_madt_distributor;
+
 	count = acpi_parse_entries(ACPI_SIG_MADT,
 				   sizeof(struct acpi_table_madt),
-				   gic_acpi_parse_madt_distributor, table,
-				   ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR, 0);
+				   table, gic_proc, 0);
 	if (count <= 0) {
 		pr_err("No valid GICD entries exist\n");
 		return -EINVAL;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d2445fa..59b17e8 100644
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
@@ -145,10 +151,13 @@ int acpi_numa_init (void);
 
 int acpi_table_init (void);
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
+int acpi_table_parse_entries_array(char *id, unsigned long table_size,
+			      struct acpi_subtable_proc *proc, int proc_num,
+			      unsigned int max_entries);
 int __init acpi_parse_entries(char *id, unsigned long table_size,
-			      acpi_tbl_entry_handler handler,
 			      struct acpi_table_header *table_header,
-			      int entry_id, unsigned int max_entries);
+			      struct acpi_subtable_proc *proc, int proc_num,
+			      unsigned int max_entries);
 int __init acpi_table_parse_entries(char *id, unsigned long table_size,
 				    int entry_id,
 				    acpi_tbl_entry_handler handler,
-- 
1.8.3.1

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.


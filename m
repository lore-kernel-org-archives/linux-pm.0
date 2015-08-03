From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: [PATCH] x86, acpi: Handle lapic/x2apic entries in MADT
Date: Mon,  3 Aug 2015 20:26:05 +0200
Message-ID: <1438626365-23709-2-git-send-email-lukasz.anaczkowski@intel.com>
References: <20150802134014.380415cd@arm.com>
 <1438626365-23709-1-git-send-email-lukasz.anaczkowski@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17910 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645AbbHCS0k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Aug 2015 14:26:40 -0400
In-Reply-To: <1438626365-23709-1-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>, Yinghai Lu <yinghai@kernel.org>

v2: Fixed ARM64 syntax error

>From the ACPI spec:
"Logical processors with APIC ID values less than 0xFF
(whether in XAPIC or X2APIC mode) must use the Processor LAPIC
structure [...]. Logical processors with APIC ID values 0xFF and
greater must use the Processor Local x2APIC structure."

Because of above, BIOS is first enumerating cores with HT with
LAPIC values (<0xFF) and then rest with X2APIC values (>=0xFF).

With current kernel code, where enumeration is in order:
BSP, X2APIC, LAPIC
enumeration on machine with more than 255 CPUs (each core with 4 HT)
first X2APIC IDs get low logical CPU IDs (1..x) and then LAPIC IDs
get higher logical CPU IDs (50..y), as in example below:

Core LCpu  ApicId  LCpu   ApicId   LCpu  ApicId  LCpu  ApicId
0    0     0000     97    0001     145   0002    193   0003
1   50     0004     98    0005     146   0006    194   0007
2   51     0010     99    0011     147   0012    195   0013
3   52     0014    100    0015     148   0016    196   0017
4   53     0018    101    0019     149   001a    197   001b
5   54     001c    102    001d     150   001e    198   001f
...
62  95     00f8    143    00f9     191   00fa    239   00fb
63  37     00ff     96    00fc     144   00fd    192   00fe
64   1     0100     13    0101     25    0102     38   0103
65   2     0104     14    0105     26    0106     39   0107
...

(Core - physical core, LCpu - logical CPU, ApicId - ID assigned
by BIOS).

This is wrong for the following reasons:
() it's hard to predict how cores and threads will be enumerated
() when it's hard to predict, s/w threads cannot be properly affinitized
   causing significant performance impact due to e.g. inproper cache
   sharing
() enumeration is inconsistent with how threads are enumerated on
   other Intel Xeon processors

To fix this, each LAPIC/X2APIC entry from MADT table needs to be
handled at the same time when processing it, thus adding
acpi_subtable_proc structure which stores
() ACPI table id
() handler that processes table
() counter how many items has been processed
and passing it to acpi_table_parse_entries().

Also, order in which MADT LAPIC/X2APIC handlers are passed is
reversed to achieve correct CPU enumeration.

In scenario when someone boots kernel with options 'maxcpus=72 nox2apic',
in result less cores may be booted, since some of the CPUs the kernel
will try to use will have APIC ID >= 0xFF. In such case, one
should not pass 'nox2apic'.

Disclimer: code parsing MADT LAPIC/X2APIC has not been touched since 2009,
when X2APIC support was initially added. I do not know why MADT parsing
code was added in the reversed order in the first place.
I guess it didn't matter at that time since nobody cared about cores
with APIC IDs >= 0xFF, right?

This patch is based on work of "Yinghai Lu <yinghai@kernel.org>"
previously published at https://lkml.org/lkml/2013/1/21/563,
thus putting Yinghai Lu as 'Signed-off-by', as well.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
---
 arch/x86/kernel/acpi/boot.c | 29 +++++++++++++-----
 drivers/acpi/numa.c         | 28 ++++++++++++-----
 drivers/acpi/tables.c       | 75 ++++++++++++++++++++++++++++-----------------
 drivers/irqchip/irq-gic.c   | 15 ++++++---
 include/linux/acpi.h        | 13 ++++++--
 5 files changed, 111 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e49ee24..fb4a9d6 100644
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
+	madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_X2APIC_NMI;
+	madt_proc[0].handler = acpi_parse_x2apic_nmi;
+	madt_proc[1].id = ACPI_MADT_TYPE_LOCAL_APIC_NMI;
+	madt_proc[1].handler = acpi_parse_lapic_nmi;
+	acpi_table_parse_entries_array(ACPI_SIG_MADT,
+			    sizeof(struct acpi_table_madt),
+			    madt_proc, ARRAY_SIZE(madt_proc), 0);
+	count = madt_proc[0].count;
+	x2count = madt_proc[1].count;
 	if (count < 0 || x2count < 0) {
 		printk(KERN_ERR PREFIX "Error parsing LAPIC NMI entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index acaa3b4..a000195 100644
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
+		srat_proc[0].id = ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY;
+		srat_proc[0].handler = acpi_parse_x2apic_affinity;
+		srat_proc[1].id = ACPI_SRAT_TYPE_CPU_AFFINITY;
+		srat_proc[1].handler = acpi_parse_processor_affinity;
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
index 4dd8826..d98b866 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1091,12 +1091,16 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 {
 	void __iomem *cpu_base, *dist_base;
 	int count;
+	struct acpi_subtable_proc gic_proc;
+
+	memset(&gic_proc, 0, sizeof(gic_proc));
+	gic_proc.id = ACPI_MADT_TYPE_GENERIC_INTERRUPT;
+	gic_proc.handler = gic_acpi_parse_madt_cpu;
 
 	/* Collect CPU base addresses */
 	count = acpi_parse_entries(ACPI_SIG_MADT,
 				   sizeof(struct acpi_table_madt),
-				   gic_acpi_parse_madt_cpu, table,
-				   ACPI_MADT_TYPE_GENERIC_INTERRUPT, 0);
+				   table, &gic_proc, 1, 0);
 	if (count <= 0) {
 		pr_err("No valid GICC entries exist\n");
 		return -EINVAL;
@@ -1106,10 +1110,13 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 	 * Find distributor base address. We expect one distributor entry since
 	 * ACPI 5.1 spec neither support multi-GIC instances nor GIC cascade.
 	 */
+	memset(&gic_proc, 0, sizeof(gic_proc));
+	gic_proc.id = ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR;
+	gic_proc.handler = gic_acpi_parse_madt_distributor;
+
 	count = acpi_parse_entries(ACPI_SIG_MADT,
 				   sizeof(struct acpi_table_madt),
-				   gic_acpi_parse_madt_distributor, table,
-				   ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR, 0);
+				   table, &gic_proc, 1, 0);
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


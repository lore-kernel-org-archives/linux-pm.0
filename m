From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/4] Fix how CPUs are enumerated when there's more than
 255 CPUs
Date: Tue, 08 Sep 2015 17:27:38 +0100
Message-ID: <55EF0C7A.7070105@arm.com>
References: <20150827093738.GA21134@red-moon> <1441710480-17622-1-git-send-email-lukasz.anaczkowski@intel.com> <1441710480-17622-2-git-send-email-lukasz.anaczkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441710480-17622-2-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>, lorenzo.pieralisi@arm.com, tomasz.nowicki@linaro.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/09/15 12:07, Lukasz Anaczkowski wrote:
> This series of patches attempts to fix how CPUs are enumerated by kernel when
> there's more than 255 of them on single processor.
> In such case, BIOS may interleave APIC/X2APIC MADT subtables, to obey requirements
> specified in ACPI spec. Without this patches, kernel then would first enumerate
> BSP, then X2APIC then APIC, resulting in low APIC IDs to be assigned with high
> logical IDs and high APIC IDs to be assigned low logical IDs. Biggest consequence
> of that could be performance penalties due to wrong L2 cache sharing.
> More details in patch 4/4.
> 
> Also, simpler approach has been considered, which did not required ACPI parsing
> interface changes, however it failed to meet requirements. More details can be
> found here: https://lkml.org/lkml/2015/9/7/285
> 
> I've compiled this code successfully for x86/arm64 and verified it on x86. I'd
> really appreciate if someone could give it a try on arm64.
> Although interface has changed, semantics stayed the same, thus runtime issues
> should not appear. Please verify, thanks!

I really don't see why you cannot provide simple helpers that avoids
the churn on code that doesn't require this new feature. It just makes
the code hard(er) to read, and unnecessarily convoluted. ACPI doesn't
need more of that, really.

I've come up with this (on top of your series):

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index f3ccc68..acaa3b4 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -314,15 +314,9 @@ static int __init
 acpi_table_parse_srat(enum acpi_srat_type id,
 		      acpi_tbl_entry_handler handler, unsigned int max_entries)
 {
-	struct acpi_subtable_proc srat_proc;
-
-	memset(&srat_proc, 0, sizeof(srat_proc));
-	srat_proc.id = id;
-	srat_proc.handler = handler;
-
-	return acpi_table_parse_entries_array(ACPI_SIG_SRAT,
-				sizeof(struct acpi_table_srat),
-				&srat_proc, 1, max_entries);
+	return acpi_table_parse_entries(ACPI_SIG_SRAT,
+					    sizeof(struct acpi_table_srat), id,
+					    handler, max_entries);
 }
 
 int __init acpi_numa_init(void)
@@ -341,7 +335,6 @@ int __init acpi_numa_init(void)
 				     acpi_parse_x2apic_affinity, 0);
 		acpi_table_parse_srat(ACPI_SRAT_TYPE_CPU_AFFINITY,
 				     acpi_parse_processor_affinity, 0);
-
 		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
 					    acpi_parse_memory_affinity,
 					    NR_NODE_MEMBLKS);
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index bc23220..758b334 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -215,7 +215,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 }
 
 /**
- * acpi_parse_entries - for each proc_num find a subtable with proc->id
+ * acpi_parse_entries_array - for each proc_num find a subtable with proc->id
  *    and run proc->handler on it. Assumption is that there's only
  *    single handler for particular entry id.
  *
@@ -230,8 +230,8 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
  * On success returns sum of all matching entries for all proc handlers.
  * Oterwise, -ENODEV or -EINVAL is returned.
  */
-int __init
-acpi_parse_entries(char *id, unsigned long table_size,
+static int __init
+acpi_parse_entries_array(char *id, unsigned long table_size,
 		struct acpi_table_header *table_header,
 		struct acpi_subtable_proc *proc, int proc_num,
 		unsigned int max_entries)
@@ -300,6 +300,20 @@ acpi_parse_entries(char *id, unsigned long table_size,
 	return count;
 }
 
+int __init acpi_parse_entries(char *id, unsigned long table_size,
+			      acpi_tbl_entry_handler handler,
+ 			      struct acpi_table_header *table_header,
+			      int entry_id, unsigned int max_entries)
+{
+	struct acpi_subtable_proc proc = {
+		.id		= entry_id,
+		.handler	= handler,
+	};
+
+	return acpi_parse_entries_array(id, table_size, table_header,
+					&proc, 1, max_entries);
+}
+
 int __init
 acpi_table_parse_entries_array(char *id,
 			 unsigned long table_size,
@@ -326,8 +340,8 @@ acpi_table_parse_entries_array(char *id,
 		return -ENODEV;
 	}
 
-	count = acpi_parse_entries(id, table_size, table_header,
-			proc, proc_num, max_entries);
+	count = acpi_parse_entries_array(id, table_size, table_header,
+					 proc, proc_num, max_entries);
 
 	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
 	return count;
@@ -340,17 +354,13 @@ acpi_table_parse_entries(char *id,
 			acpi_tbl_entry_handler handler,
 			unsigned int max_entries)
 {
-	struct acpi_subtable_proc proc[1];
-
-	if (!handler)
-		return -EINVAL;
-
-	memset(proc, 0, sizeof(proc));
-	proc[0].id = entry_id;
-	proc[0].handler = handler;
+	struct acpi_subtable_proc proc = {
+		.id		= entry_id,
+		.handler	= handler,
+	};
 
-	return acpi_table_parse_entries_array(id, table_size, proc, 1,
-						max_entries);
+	return acpi_table_parse_entries_array(id, table_size, &proc, 1,
+					      max_entries);
 }
 
 int __init
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 581336c..4dd8826 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1091,16 +1091,12 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 {
 	void __iomem *cpu_base, *dist_base;
 	int count;
-	struct acpi_subtable_proc gic_proc[1];
-
-	memset(gic_proc, 0, sizeof(gic_proc));
-	gic_proc[0].id = ACPI_MADT_TYPE_GENERIC_INTERRUPT;
-	gic_proc[0].handler = gic_acpi_parse_madt_cpu;
 
 	/* Collect CPU base addresses */
 	count = acpi_parse_entries(ACPI_SIG_MADT,
 				   sizeof(struct acpi_table_madt),
-				   table, gic_proc, 1, 0);
+				   gic_acpi_parse_madt_cpu, table,
+				   ACPI_MADT_TYPE_GENERIC_INTERRUPT, 0);
 	if (count <= 0) {
 		pr_err("No valid GICC entries exist\n");
 		return -EINVAL;
@@ -1110,13 +1106,10 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 	 * Find distributor base address. We expect one distributor entry since
 	 * ACPI 5.1 spec neither support multi-GIC instances nor GIC cascade.
 	 */
-	memset(gic_proc, 0, sizeof(gic_proc));
-	gic_proc[0].id = ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR;
-	gic_proc[0].handler = gic_acpi_parse_madt_distributor;
-
 	count = acpi_parse_entries(ACPI_SIG_MADT,
 				   sizeof(struct acpi_table_madt),
-				   table, gic_proc, 1, 0);
+				   gic_acpi_parse_madt_distributor, table,
+				   ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR, 0);
 	if (count <= 0) {
 		pr_err("No valid GICD entries exist\n");
 		return -EINVAL;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 52c8d20..0f6381d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -152,9 +152,9 @@ int acpi_numa_init (void);
 int acpi_table_init (void);
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
 int __init acpi_parse_entries(char *id, unsigned long table_size,
-			      struct acpi_table_header *table_header,
-			      struct acpi_subtable_proc *proc, int proc_num,
-			      unsigned int max_entries);
+			      acpi_tbl_entry_handler handler,
+ 			      struct acpi_table_header *table_header,
+			      int entry_id, unsigned int max_entries);
 int __init acpi_table_parse_entries(char *id, unsigned long table_size,
 				    int entry_id,
 				    acpi_tbl_entry_handler handler,

In my view, this makes the change a lot more palatable, and it
can fit in exactly two patches:

1) add the acpi_subtable_proc stuff with the compatibility helpers
2) change arch/x86/kernel/acpi/boot.c to do whatever you want it
   to do

It will be a lot easier to review and to verify.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] x86, acpi: Handle lapic/x2apic entries in MADT
Date: Sun, 2 Aug 2015 13:40:14 +0100
Message-ID: <20150802134014.380415cd@arm.com>
References: <alpine.DEB.2.11.1507211017590.18576 () nanos>
	<1438278219-26487-1-git-send-email-lukasz.anaczkowski@intel.com>
	<1438278219-26487-2-git-send-email-lukasz.anaczkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1438278219-26487-2-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 30 Jul 2015 19:43:39 +0200
Lukasz Anaczkowski <lukasz.anaczkowski@intel.com> wrote:

> From the ACPI spec:
> "Logical processors with APIC ID values less than 0xFF
> (whether in XAPIC or X2APIC mode) must use the Processor LAPIC
> structure [...]. Logical processors with APIC ID values 0xFF and
> greater must use the Processor Local x2APIC structure."
> 
> Because of above, BIOS is first enumerating cores with HT with
> LAPIC values (<0xFF) and then rest with X2APIC values (>=0xFF).
> 
> With current kernel code, where enumeration is in order:
> BSP, X2APIC, LAPIC
> enumeration on machine with more than 255 CPUs (each core with 4 HT)
> first X2APIC IDs get low logical CPU IDs (1..x) and then LAPIC IDs
> get higher logical CPU IDs (50..y), as in example below:
> 
> Core LCpu  ApicId  LCpu   ApicId   LCpu  ApicId  LCpu  ApicId
> 0    0     0000     97    0001     145   0002    193   0003
> 1   50     0004     98    0005     146   0006    194   0007
> 2   51     0010     99    0011     147   0012    195   0013
> 3   52     0014    100    0015     148   0016    196   0017
> 4   53     0018    101    0019     149   001a    197   001b
> 5   54     001c    102    001d     150   001e    198   001f
> ...
> 62  95     00f8    143    00f9     191   00fa    239   00fb
> 63  37     00ff     96    00fc     144   00fd    192   00fe
> 64   1     0100     13    0101     25    0102     38   0103
> 65   2     0104     14    0105     26    0106     39   0107
> ...
> 
> (Core - physical core, LCpu - logical CPU, ApicId - ID assigned
> by BIOS).
> 
> This is wrong for the following reasons:
> () it's hard to predict how cores and threads will be enumerated
> () when it's hard to predict, s/w threads cannot be properly affinitized
>    causing significant performance impact due to e.g. inproper cache
>    sharing
> () enumeration is inconsistent with how threads are enumerated on
>    other Intel Xeon processors
> 
> To fix this, each LAPIC/X2APIC entry from MADT table needs to be
> handled at the same time when processing it, thus adding
> acpi_subtable_proc structure which stores
> () ACPI table id
> () handler that processes table
> () counter how many items has been processed
> and passing it to acpi_table_parse_entries().
> 
> Also, order in which MADT LAPIC/X2APIC handlers are passed is
> reversed to achieve correct CPU enumeration.
> 
> In scenario when someone boots kernel with options 'maxcpus=72 nox2apic',
> in result less cores may be booted, since some of the CPUs the kernel
> will try to use will have APIC ID >= 0xFF. In such case, one
> should not pass 'nox2apic'.
> 
> Disclimer: code parsing MADT LAPIC/X2APIC has not been touched since 2009,
> when X2APIC support was initially added. I do not know why MADT parsing
> code was added in the reversed order in the first place.
> I guess it didn't matter at that time since nobody cared about cores
> with APIC IDs >= 0xFF, right?
> 
> This patch is based on work of "Yinghai Lu <yinghai@kernel.org>"
> previously published at https://lkml.org/lkml/2013/1/21/563,
> thus putting Yinghai Lu as 'Signed-off-by', as well.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
> ---
>  arch/x86/kernel/acpi/boot.c | 29 +++++++++++++-----
>  drivers/acpi/numa.c         | 28 ++++++++++++-----
>  drivers/acpi/tables.c       | 75 ++++++++++++++++++++++++++++-----------------
>  drivers/irqchip/irq-gic.c   | 15 ++++++---
>  include/linux/acpi.h        | 13 ++++++--
>  5 files changed, 111 insertions(+), 49 deletions(-)
> 

Hi Lukasz,

[...]

> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 4dd8826..d004a32 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1091,12 +1091,16 @@ gic_v2_acpi_init(struct acpi_table_header *table)
>  {
>  	void __iomem *cpu_base, *dist_base;
>  	int count;
> +	struct acpi_subtable_proc gic_proc;
> +
> +	memset(gic_proc, 0, sizeof(gic_proc));

You haven't ever tried compiling this, have you?

> +	gic_proc.id = ACPI_MADT_TYPE_GENERIC_INTERRUPT;
> +	gic_proc.handler = gic_acpi_parse_madt_cpu;
>  
>  	/* Collect CPU base addresses */
>  	count = acpi_parse_entries(ACPI_SIG_MADT,
>  				   sizeof(struct acpi_table_madt),
> -				   gic_acpi_parse_madt_cpu, table,
> -				   ACPI_MADT_TYPE_GENERIC_INTERRUPT, 0);
> +				   table, gic_proc, 0);

This doesn't match the prototype below.

>  	if (count <= 0) {
>  		pr_err("No valid GICC entries exist\n");
>  		return -EINVAL;
> @@ -1106,10 +1110,13 @@ gic_v2_acpi_init(struct acpi_table_header *table)
>  	 * Find distributor base address. We expect one distributor entry since
>  	 * ACPI 5.1 spec neither support multi-GIC instances nor GIC cascade.
>  	 */
> +	memset(gic_proc, 0, sizeof(gic_proc));
> +	gic_proc.id = ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR;
> +	gic_proc.handler = gic_acpi_parse_madt_distributor;
> +
>  	count = acpi_parse_entries(ACPI_SIG_MADT,
>  				   sizeof(struct acpi_table_madt),
> -				   gic_acpi_parse_madt_distributor, table,
> -				   ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR, 0);
> +				   table, gic_proc, 0);
>  	if (count <= 0) {
>  		pr_err("No valid GICD entries exist\n");
>  		return -EINVAL;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d2445fa..59b17e8 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -135,6 +135,12 @@ static inline void acpi_initrd_override(void *data, size_t size)
>  		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
>  		((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
>  
> +struct acpi_subtable_proc {
> +	int id;
> +	acpi_tbl_entry_handler handler;
> +	int count;
> +};
> +
>  char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
>  void __acpi_unmap_table(char *map, unsigned long size);
>  int early_acpi_boot_init(void);
> @@ -145,10 +151,13 @@ int acpi_numa_init (void);
>  
>  int acpi_table_init (void);
>  int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
> +int acpi_table_parse_entries_array(char *id, unsigned long table_size,
> +			      struct acpi_subtable_proc *proc, int proc_num,
> +			      unsigned int max_entries);
>  int __init acpi_parse_entries(char *id, unsigned long table_size,
> -			      acpi_tbl_entry_handler handler,
>  			      struct acpi_table_header *table_header,
> -			      int entry_id, unsigned int max_entries);
> +			      struct acpi_subtable_proc *proc, int proc_num,

Could you please check that it actually compiles when you enable ACPI
on arm64?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.

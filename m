From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] x86, arm64, acpi: Handle lapic/x2apic entries in MADT
Date: Thu, 27 Aug 2015 10:37:38 +0100
Message-ID: <20150827093738.GA21134@red-moon>
References: <55DDB45D.2030901@arm.com>
 <1440611369-26314-1-git-send-email-lukasz.anaczkowski@intel.com>
 <1440611369-26314-2-git-send-email-lukasz.anaczkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1440611369-26314-2-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, "tomasz.nowicki@linaro.org" <tomasz.nowicki@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 26, 2015 at 06:49:29PM +0100, Lukasz Anaczkowski wrote:

[...]

> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 2e19189..d5c9a1b 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -214,27 +214,45 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>         }
>  }
> 
> +/**
> + * acpi_table_parse - for each proc_num find a subtable with proc->id

Name of function does not correspond to the function you are actually
commenting.

> + *    and run proc->handler on it. Assumption is that there's only
> + *    single handler for particular id.
> + *
> + * @id: table id (for debugging purposes)
> + * @table_size: single entry size
> + * @table_header: where does the table start?
> + * @proc: array of acpi_subtable_proc struct containing subtable id
> + *        and associated handler with it
> + * @proc_num: how big proc is?
> + * @max_entries: how many entries can we process?
> + *
> + * On success returns sum of all matching entries for all proc handlers.
> + * Oterwise, -ENODEV or -EINVAL is returned.

s/Oterwise/Otherwise

> + */
>  int __init
>  acpi_parse_entries(char *id, unsigned long table_size,
> -               acpi_tbl_entry_handler handler,
>                 struct acpi_table_header *table_header,
> -               int entry_id, unsigned int max_entries)
> +               struct acpi_subtable_proc *proc, int proc_num,
> +               unsigned int max_entries)
>  {
>         struct acpi_subtable_header *entry;
>         int count = 0;
>         unsigned long table_end;
> +       int i;
> 
> -       if (acpi_disabled)
> +       if (acpi_disabled) {
> +               proc[0].count = -ENODEV;
>                 return -ENODEV;
> -
> -       if (!id || !handler)
> -               return -EINVAL;
> -
> -       if (!table_size)
> +       }

Add a space please

> +       if (!table_size) {
> +               proc[0].count = -EINVAL;

This is misleading. Why do we want to return error only in the first entry ?
If I get the function logic right, if this function returns an error
somehow the parsing failed, so the proc array content must be considered
invalid. Ergo, just returning an error code should be enough and
that's what you should check first in eg acpi_parse_madt_lapic_entries().

Comment is valid for the whole patch.

>                 return -EINVAL;
> +       }
> 
>         if (!table_header) {
>                 pr_warn("%4.4s not present\n", id);
> +               proc[0].count = -ENODEV;
>                 return -ENODEV;
>         }
> 
> @@ -247,20 +265,31 @@ acpi_parse_entries(char *id, unsigned long table_size,
> 
>         while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
>                table_end) {
> -               if (entry->type == entry_id
> -                   && (!max_entries || count < max_entries)) {
> -                       if (handler(entry, table_end))
> +               if (max_entries && count >= max_entries)
> +                       continue;
> +               for (i = 0; i < proc_num; i++) {
> +                       if (entry->type != proc[i].id)
> +                               continue;
> +                       if (proc[i].handler(entry, table_end)) {
> +                               proc[i].count = -EINVAL;
>                                 return -EINVAL;
> -
> -                       count++;
> +                       }
> +                       proc[i].count++;
> +                       break;
>                 }
> +               if (i != proc_num)
> +                       count++;
> 
>                 /*
>                  * If entry->length is 0, break from this loop to avoid
>                  * infinite loop.
>                  */
>                 if (entry->length == 0) {
> -                       pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, entry_id);
> +                       pr_err("[%4.4s:0x%02x ", id, proc[0].id);
> +                       for (i = 1; i < proc_num; i++)
> +                               pr_cont(" 0x%02x", proc[i].id);
> +                       pr_cont("] Invalid zero length\n");
> +                       proc[0].count = -EINVAL;
>                         return -EINVAL;
>                 }
> 
> @@ -269,18 +298,20 @@ acpi_parse_entries(char *id, unsigned long table_size,
>         }
> 
>         if (max_entries && count > max_entries) {
> -               pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n",
> -                       id, entry_id, count - max_entries, count);
> +               pr_warn("[%4.4s:0x%02x ", id, proc[0].id);
> +               for (i = 1; i < proc_num; i++)
> +                       pr_cont(" 0x%02x", proc[i].id);
> +               pr_cont("] ignored %i entries of %i found\n",
> +                       count-max_entries, count);
>         }
> 
>         return count;
>  }
> 
>  int __init
> -acpi_table_parse_entries(char *id,
> +acpi_table_parse_entries_array(char *id,
>                          unsigned long table_size,
> -                        int entry_id,
> -                        acpi_tbl_entry_handler handler,
> +                        struct acpi_subtable_proc *proc, int proc_num,
>                          unsigned int max_entries)
>  {
>         struct acpi_table_header *table_header = NULL;
> @@ -288,11 +319,10 @@ acpi_table_parse_entries(char *id,
>         int count;
>         u32 instance = 0;
> 
> -       if (acpi_disabled)
> +       if (acpi_disabled) {
> +               proc[0].count = -ENODEV;
>                 return -ENODEV;
> -
> -       if (!id || !handler)
> -               return -EINVAL;
> +       }
> 
>         if (!strncmp(id, ACPI_SIG_MADT, 4))
>                 instance = acpi_apic_instance;
> @@ -300,23 +330,50 @@ acpi_table_parse_entries(char *id,
>         acpi_get_table_with_size(id, instance, &table_header, &tbl_size);
>         if (!table_header) {
>                 pr_warn("%4.4s not present\n", id);
> +               proc[0].count = -ENODEV;
>                 return -ENODEV;
>         }
> 
> -       count = acpi_parse_entries(id, table_size, handler, table_header,
> -                       entry_id, max_entries);
> +       count = acpi_parse_entries(id, table_size, table_header,
> +                       proc, proc_num, max_entries);
> 
>         early_acpi_os_unmap_memory((char *)table_header, tbl_size);
>         return count;
>  }
> 
>  int __init
> +acpi_table_parse_entries(char *id,
> +                               unsigned long table_size,
> +                               int entry_id,
> +                               acpi_tbl_entry_handler handler,
> +                               unsigned int max_entries)
> +{
> +       struct acpi_subtable_proc proc[1];
> +
> +       if (!handler)
> +               return -EINVAL;
> +
> +       memset(proc, 0, sizeof(proc));
> +       proc[0].id = entry_id;
> +       proc[0].handler = handler;
> +
> +       return acpi_table_parse_entries_array(id, table_size, proc, 1,
> +                                       max_entries);
> +}
> +
> +int __init
>  acpi_table_parse_madt(enum acpi_madt_type id,
>                       acpi_tbl_entry_handler handler, unsigned int max_entries)
>  {
> -       return acpi_table_parse_entries(ACPI_SIG_MADT,
> -                                           sizeof(struct acpi_table_madt), id,
> -                                           handler, max_entries);

Why can't you leave this call as-is ?

> +       struct acpi_subtable_proc madt_proc;

Is there a reason why you use a struct here and a size 1 array in
acpi_table_parse_entries() ? Keep them consistent.

Actually, I do not think you need to parse acpi_table_parse_madt() at
all unless I am missing something.

Lorenzo

> +
> +       memset(&madt_proc, 0, sizeof(madt_proc));
> +       madt_proc.id = id;
> +       madt_proc.handler = handler;
> +
> +       return acpi_table_parse_entries_array(ACPI_SIG_MADT,
> +                                           sizeof(struct acpi_table_madt),
> +                                           &madt_proc, 1, max_entries);
>  }
> 
>  /**
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 4dd8826..d98b866 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1091,12 +1091,16 @@ gic_v2_acpi_init(struct acpi_table_header *table)
>  {
>         void __iomem *cpu_base, *dist_base;
>         int count;
> +       struct acpi_subtable_proc gic_proc;
> +
> +       memset(&gic_proc, 0, sizeof(gic_proc));
> +       gic_proc.id = ACPI_MADT_TYPE_GENERIC_INTERRUPT;
> +       gic_proc.handler = gic_acpi_parse_madt_cpu;
> 
>         /* Collect CPU base addresses */
>         count = acpi_parse_entries(ACPI_SIG_MADT,
>                                    sizeof(struct acpi_table_madt),
> -                                  gic_acpi_parse_madt_cpu, table,
> -                                  ACPI_MADT_TYPE_GENERIC_INTERRUPT, 0);
> +                                  table, &gic_proc, 1, 0);
>         if (count <= 0) {
>                 pr_err("No valid GICC entries exist\n");
>                 return -EINVAL;
> @@ -1106,10 +1110,13 @@ gic_v2_acpi_init(struct acpi_table_header *table)
>          * Find distributor base address. We expect one distributor entry since
>          * ACPI 5.1 spec neither support multi-GIC instances nor GIC cascade.
>          */
> +       memset(&gic_proc, 0, sizeof(gic_proc));
> +       gic_proc.id = ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR;
> +       gic_proc.handler = gic_acpi_parse_madt_distributor;
> +
>         count = acpi_parse_entries(ACPI_SIG_MADT,
>                                    sizeof(struct acpi_table_madt),
> -                                  gic_acpi_parse_madt_distributor, table,
> -                                  ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR, 0);
> +                                  table, &gic_proc, 1, 0);
>         if (count <= 0) {
>                 pr_err("No valid GICD entries exist\n");
>                 return -EINVAL;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d2445fa..59b17e8 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -135,6 +135,12 @@ static inline void acpi_initrd_override(void *data, size_t size)
>                 (!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
>                 ((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
> 
> +struct acpi_subtable_proc {
> +       int id;
> +       acpi_tbl_entry_handler handler;
> +       int count;
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
> +                             struct acpi_subtable_proc *proc, int proc_num,
> +                             unsigned int max_entries);
>  int __init acpi_parse_entries(char *id, unsigned long table_size,
> -                             acpi_tbl_entry_handler handler,
>                               struct acpi_table_header *table_header,
> -                             int entry_id, unsigned int max_entries);
> +                             struct acpi_subtable_proc *proc, int proc_num,
> +                             unsigned int max_entries);
>  int __init acpi_table_parse_entries(char *id, unsigned long table_size,
>                                     int entry_id,
>                                     acpi_tbl_entry_handler handler,
> --
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

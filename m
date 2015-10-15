From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH][v5] PM / hibernate: Print the possible panic reason
 when resuming with inconsistent e820 map
Date: Thu, 15 Oct 2015 01:40:59 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6402865BE87@shsmsx102.ccr.corp.intel.com>
References: <1444849196-7048-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3865 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353AbbJOBlF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 21:41:05 -0400
In-Reply-To: <1444849196-7048-1-git-send-email-yu.c.chen@intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "Brown, Len" <len.brown@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Please ignore this patch, will resend a Version 6. Thanks!

> -----Original Message-----
> From: Chen, Yu C
> Sent: Thursday, October 15, 2015 3:00 AM
> To: pavel@ucw.cz; rjw@rjwysocki.net
> Cc: tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; Brown, Len;
> Zhang, Rui; x86@kernel.org; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; Chen, Yu C
> Subject: [PATCH][v5] PM / hibernate: Print the possible panic reason when
> resuming with inconsistent e820 map
> 
> On some platforms, there is occasional panic triggered when trying to
> resume from hibernation, a typical panic looks like:
> 
> "BUG: unable to handle kernel paging request at ffff880085894000
> IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70"
> 
> This is because e820 map has been changed by BIOS before/after
> hibernation, and one of the page frames from first kernel is right located in
> second kernel's unmapped region, so panic comes out when accessing
> unmapped kernel address.
> 
> In order to tell user why this happeneded, and for scalability, we introduce a
> framework to compare the e820 maps before/after hibernation. If these two
> e820 maps are not compatible with each other, we will print the first corrupt
> e820 entry's information (there might be more than one broken e820 entries)
> once system goes into panic, for example:
> 
> BUG: unable to handle kernel paging request at ffff8800a9688000
> IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70
> PM: Hibernation Caution! Oops might be due to inconsistent e820 table.
> PM: mem [0xa963b000-0xa963d000][ACPI Table] is an invalid old e820 region.
> PM: Inconsistent with current [mem 0xa963b000-0xa963e000][ACPI Table].
> PM: Please update your BIOS, or do not use hibernation on this machine.
> 
> The following e820 entries will be regarded as invalid ones:
> 1.E820_RAM:  old region is not a subset of any current region.
> 2.E820_ACPI: old region is not strictly the same as any current
>              region(example above).
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v5:
>  - Rewrite this patch to just warn user of the broken BIOS
>    when panic.
> v4:
>  - Add __attribute__ ((unused)) for swsusp_page_is_valid,
>    to eliminate the warnning of:
>    'swsusp_page_is_valid' defined but not used
>    on non-x86 platforms.
> 
> v3:
>  - Adjust the logic to exclude the end_pfn boundary in pfn_mapped
>    when invoking mark_valid_pages, because the end_pfn is not
>    a mapped page frame, we should not regard it as a valid page.
> 
>    Move the sanity check of valid pages to a early stage in resuming
>    process(moved to mark_unsafe_pages), in this way, we can avoid
>    unnecessarily accessing these invalid pages in later stage(yes,
>    move to the original position Joey once introduced in:
>    Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820
>    reserved regions")
> 
>    With v3 patch applied, I did 30 cycles on my problematic platform,
>    no panic triggered anymore(50% reproducible before patched, by
>    plugging/unplugging memory peripheral during hibernation), and it
>    just warns of invalid pages.
> 
> v2:
>  - According to Ingo's suggestion, rewrite this patch.
> 
>    New version just checks each page frame according to pfn_mapped array.
>    So that we do not need to touch existing code related to
>    E820_RESERVED_KERN. And this method can naturely guarantee
>    that the system before/after hibernation do not need to be of
>    the same memory size on x86_64.
> ---
>  arch/x86/Kconfig               |   4 +
>  arch/x86/include/asm/suspend.h |   3 +
>  arch/x86/power/Makefile        |   2 +-
>  arch/x86/power/hibernate.c     | 229
> +++++++++++++++++++++++++++++++++++++++++
>  include/linux/suspend.h        |  16 +++
>  kernel/power/power.h           |   8 ++
>  kernel/power/snapshot.c        |   8 ++
>  7 files changed, 269 insertions(+), 1 deletion(-)  create mode 100644
> arch/x86/power/hibernate.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig index 96d058a..0b2f10c
> 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2132,6 +2132,10 @@ config ARCH_HIBERNATION_HEADER
>  	def_bool y
>  	depends on X86_64 && HIBERNATION
> 
> +config ARCH_RESUME_IMAGE_CHECKER
> +	def_bool y
> +	depends on HIBERNATION
> +
>  source "kernel/power/Kconfig"
> 
>  source "drivers/acpi/Kconfig"
> diff --git a/arch/x86/include/asm/suspend.h
> b/arch/x86/include/asm/suspend.h index 2fab6c2..63bc53e 100644
> --- a/arch/x86/include/asm/suspend.h
> +++ b/arch/x86/include/asm/suspend.h
> @@ -3,3 +3,6 @@
>  #else
>  # include <asm/suspend_64.h>
>  #endif
> +
> +extern int arch_image_info_save(char *dst, char *src, unsigned int
> +limit_len); extern bool arch_image_info_check(const char *new, const
> +char *old);
> diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile index
> a6a198c..47596e2 100644
> --- a/arch/x86/power/Makefile
> +++ b/arch/x86/power/Makefile
> @@ -4,4 +4,4 @@ nostackp := $(call cc-option, -fno-stack-protector)
>  CFLAGS_cpu.o	:= $(nostackp)
> 
>  obj-$(CONFIG_PM_SLEEP)		+= cpu.o
> -obj-$(CONFIG_HIBERNATION)	+= hibernate_$(BITS).o
> hibernate_asm_$(BITS).o
> +obj-$(CONFIG_HIBERNATION)	+= hibernate_$(BITS).o
> hibernate_asm_$(BITS).o hibernate.o
> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c new
> file mode 100644 index 0000000..d90b7ed
> --- /dev/null
> +++ b/arch/x86/power/hibernate.c
> @@ -0,0 +1,229 @@
> +/*
> + * Hibernation common support for x86
> + *
> + * Distribute under GPLv2
> + *
> + * Copyright (c) 2015 Chen Yu <yu.c.chen@intel.com>  */
> +
> +#include <linux/suspend.h>
> +#include <linux/kdebug.h>
> +
> +#include <asm/init.h>
> +#include <asm/suspend.h>
> +
> +/*
> + * The following section is to check whether the old e820 map
> + * (system before hibernation) is compatible with current
> + * e820 map(system for resuming).
> + * We check two types of regions: E820_RAM and E820_ACPI,
> + * and to make sure the two kinds of regions will satisfy:
> + * 1. E820_RAM: each old region is a subset of the current ones.
> + * 2. E820_ACPI: each old region is strictly the same as the current ones.
> + *
> + * We save the old e820 map inside the swsusp_info page,
> + * then pass it to the second system for resuming, by the
> + * following format:
> + *
> + *
> + *  +--------+---------+------+------+------+
> + *  | swsusp |e820entry|entry0|entry1|entry2|
> + *  |  info  | number  |      |      |      |
> + *  +--------+---------+------+------+------+
> + *  ^                                                        ^
> + *  |                                                        |
> + *  +--------------struct swsusp_info(PAGE_SIZE)-------------+
> + */
> +
> +/*
> + * Record the first pair of conflicted new/old
> + * e820 entries if there's any.
> + */
> +static u32 bad_old_type;
> +static u64 bad_old_start, bad_old_end;
> +
> +static u32 bad_new_type;
> +static u64 bad_new_start, bad_new_end;
> +
> +/**
> + *	arch_image_info_save - save specified e820 data to
> + *		 the hibernation image header
> + *	@dst: address to save the data to.
> + *	@src: source data need to be saved,
> + *	      if NULL then save current system's e820 map.
> + *	@limit_len: max len in bytes to write.
> + */
> +int arch_image_info_save(char *dst, char *src, unsigned int limit_len)
> +{
> +	unsigned int e820_nr_map;
> +	unsigned int size_to_copy;
> +	struct e820map *e820_map;
> +
> +	/*
> +	 * The final copied structure is illustrated below:
> +	 * [number_of_e820entry][e820entry0)[e820entry1)...
> +	 */
> +	if (src) {
> +		e820_nr_map = *(unsigned int *)src;
> +		e820_map = (struct e820map *)(src + sizeof(unsigned int));
> +	} else {
> +		e820_nr_map = e820_saved.nr_map;
> +		e820_map = &e820_saved;
> +	}
> +
> +	size_to_copy = e820_nr_map * sizeof(struct e820entry);
> +
> +	if ((size_to_copy + sizeof(unsigned int)) > limit_len) {
> +		pr_warn("PM: Hibernation can not save extra info due to too
> many e820 entries\n");
> +		return -ENOMEM;
> +	}
> +	*(unsigned int *)dst = e820_nr_map;
> +	dst += sizeof(unsigned int);
> +	memcpy(dst, (void *)&e820_map->map[0], size_to_copy);
> +	return 0;
> +}
> +
> +/**
> + *	arch_image_info_check - check the relationship between
> + *	new and old e820 map, to make sure that, the E820_RAM
> + *	in old e820, is a subset of the new e820 map, and the
> + *	E820_ACPI regions in old e820 map, are strictly the
> + *	same as new e820 map. If it is, return true, otherwise return false.
> + *
> + *	@new: New e820 map address, usually it is the
> + *	      current system's e820_saved.
> + *	@old: Old e820 map address, it is usually the
> + *	      e820 map before hibernation.
> + */
> +bool arch_image_info_check(const char *new, const char *old) {
> +	struct e820map *e820_old, *e820_new;
> +	int i, j, e820_old_num, e820_new_num;
> +
> +	e820_old = (struct e820map *)old;
> +	e820_old_num = *(unsigned int *)e820_old;
> +
> +	if (new)
> +		e820_new = (struct e820map *)new;
> +	else
> +		e820_new = &e820_saved;
> +
> +	e820_new_num = e820_new->nr_map;
> +
> +	if ((e820_old_num == 0) || (e820_new_num == 0) ||
> +		(e820_old_num > E820_X_MAX) || (e820_new_num >
> E820_X_MAX))
> +		return false;
> +
> +	for (i = 0; i < e820_old_num; i++) {
> +		u64 old_start, old_end;
> +		struct e820entry *ei_old;
> +		bool valid_old_entry = false;
> +
> +		ei_old = &e820_old->map[i];
> +
> +		/*
> +		 * Only check RAM memory and ACPI table regions,
> +		 * and we follow this policy:
> +		 * 1.The old e820 RAM region must be new RAM's subset.
> +		 * 2.The old e820 ACPI table region must be the same
> +		 *   as the new one.
> +		 */
> +		if (ei_old->type != E820_RAM && ei_old->type != E820_ACPI)
> +			continue;
> +
> +		old_start = ei_old->addr;
> +		old_end = ei_old->addr + ei_old->size;
> +
> +		for (j = 0; j < e820_new_num; j++) {
> +			u64 new_start, new_end;
> +			struct e820entry *ei_new;
> +
> +			if (valid_old_entry)
> +				break;
> +
> +			ei_new = &e820_new->map[i];
> +			new_start = ei_new->addr;
> +			new_end = ei_new->addr + ei_new->size;
> +
> +			/*
> +			 * Check the relationship between these two regions.
> +			 */
> +			if (old_start >= new_start && old_start < new_end) {
> +				   /* Must be of the same type. */
> +				if ((ei_old->type != ei_new->type) ||
> +				   /* E820_RAM must be the subset */
> +				    ((ei_old->type == E820_RAM) &&
> +				     (old_end > new_end)) ||
> +				   /* E820_ACPI must remain unchanged. */
> +				    ((ei_old->type == E820_ACPI) &&
> +				     (old_start != new_start ||
> +						old_end != new_end))) {
> +					bad_old_start = old_start;
> +					bad_old_end = old_end;
> +					bad_old_type = ei_old->type;
> +					bad_new_start = new_start;
> +					bad_new_end = new_end;
> +					bad_new_type = ei_new->type;
> +
> +					return false;
> +				}
> +				/* OK, this one is a valid e820 region. */
> +				valid_old_entry = true;
> +			}
> +		}
> +		/* If we did not find any overlapping between this old e820
> +		 * region and the new regions, return invalid.
> +		 */
> +		if (!valid_old_entry) {
> +			bad_old_start = old_start;
> +			bad_old_end = old_end;
> +			return false;
> +		}
> +	}
> +	/* All the old e820 entries are valid */
> +	return true;
> +}
> +
> +/*
> + * This hook is invoked when kernel dies, and will print the broken
> +e820 map
> + * if it is caused by BIOS memory bug.
> + */
> +static int arch_hibernation_die_check(struct notifier_block *nb,
> +				      unsigned long action,
> +				      void *data)
> +{
> +	if (!bad_old_start || !bad_old_end)
> +		return 0;
> +
> +	pr_err("PM: Hibernation Caution! Oops might be due to inconsistent
> e820 table.\n");
> +	pr_err("PM: [mem %#010llx-%#010llx][%s] is an invalid old e820
> region.\n",
> +			bad_old_start, bad_old_end,
> +			(bad_old_type == E820_RAM) ? "RAM" : "ACPI
> Table");
> +	if (bad_new_start && bad_new_end)
> +		pr_err("PM: Inconsistent with current [mem %#010llx-
> %#010llx][%s]\n",
> +			bad_new_start, bad_new_end,
> +			(bad_new_type == E820_RAM) ? "RAM" : "ACPI
> Table");
> +	pr_err("PM: Please update your BIOS, or do not use hibernation on
> this
> +machine.\n");
> +
> +	/* Avoid nested die print*/
> +	bad_old_start = bad_old_end = 0;
> +
> +	return 0;
> +}
> +
> +static struct notifier_block hibernation_notifier = {
> +	.notifier_call = arch_hibernation_die_check, };
> +
> +static int __init arch_init_hibernation(void) {
> +	int retval;
> +
> +	retval = register_die_notifier(&hibernation_notifier);
> +	if (retval)
> +		return retval;
> +
> +	return 0;
> +}
> +
> +late_initcall(arch_init_hibernation);
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h index
> 5efe743..729fa2a 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -8,6 +8,7 @@
>  #include <linux/mm.h>
>  #include <linux/freezer.h>
>  #include <asm/errno.h>
> +#include <asm/suspend.h>
> 
>  #ifdef CONFIG_VT
>  extern void pm_set_vt_switch(int);
> @@ -361,6 +362,21 @@ static inline bool system_entering_hibernation(void)
> { return false; }  static inline bool hibernation_available(void) { return false; }
> #endif /* CONFIG_HIBERNATION */
> 
> +#ifndef CONFIG_ARCH_RESUME_IMAGE_CHECKER static inline bool
> +arch_image_info_check(const char *new,
> +					 const char *old)
> +{
> +	return true;
> +}
> +
> +static inline int arch_image_info_save(char *dst,
> +					char *src,
> +					unsigned int limit_len)
> +{
> +	return 0;
> +}
> +#endif
> +
>  /* Hibernation and suspend events */
>  #define PM_HIBERNATION_PREPARE	0x0001 /* Going to hibernate */
>  #define PM_POST_HIBERNATION	0x0002 /* Hibernation finished */
> diff --git a/kernel/power/power.h b/kernel/power/power.h index
> caadb56..d279907 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -14,6 +14,14 @@ struct swsusp_info {
>  	unsigned long		size;
>  } __aligned(PAGE_SIZE);
> 
> +/*
> + *  Since struct swsusp_info will take one page size,
> + *  some platforms save the extra data right after the
> + *  last structure element.
> + */
> +#define SWSUSP_INFO_ACTUAL_SIZE \
> +	(offsetof(struct swsusp_info, size) + sizeof(unsigned long))
> +
>  #ifdef CONFIG_HIBERNATION
>  /* kernel/power/snapshot.c */
>  extern void __init hibernate_reserved_size_init(void);
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c index
> 5235dd4..394d20d 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1970,6 +1970,11 @@ int snapshot_read_next(struct snapshot_handle
> *handle)
>  		error = init_header((struct swsusp_info *)buffer);
>  		if (error)
>  			return error;
> +
> +		arch_image_info_save((char *)buffer +
> SWSUSP_INFO_ACTUAL_SIZE,
> +				     NULL,
> +				     PAGE_SIZE-SWSUSP_INFO_ACTUAL_SIZE);
> +
>  		handle->buffer = buffer;
>  		memory_bm_position_reset(&orig_bm);
>  		memory_bm_position_reset(&copy_bm);
> @@ -2491,6 +2496,9 @@ int snapshot_write_next(struct snapshot_handle
> *handle)
>  		if (error)
>  			return error;
> 
> +		arch_image_info_check(NULL,
> +				     (char *)buffer +
> SWSUSP_INFO_ACTUAL_SIZE);
> +
>  		error = memory_bm_create(&copy_bm, GFP_ATOMIC,
> PG_ANY);
>  		if (error)
>  			return error;
> --
> 1.8.4.2


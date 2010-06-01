From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] suspend: Move NVS save/restore code to
	generic suspend functionality
Date: Tue, 1 Jun 2010 23:31:59 +0200
Message-ID: <201006012331.59747.rjw__46343.4972255074$1275428007$gmane$org@sisk.pl>
References: <1275416390.3778.7.camel@maxim-laptop>
	<1275416544-4515-1-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275416544-4515-1-git-send-email-maximlevitsky@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 01 June 2010, Maxim Levitsky wrote:
> Saving platform non-volatile state may be required for suspend to RAM as
> well as hibernation. Move it to more generic code.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> Signed-off-by: Matthew Garrett <maximlevitsky@gmail.com>

You made a mistake here.

Also, why are you resending the Matthews patches?  I think Len has seen them
already.

Rafael


> ---
>  arch/x86/kernel/e820.c       |    2 +-
>  drivers/acpi/sleep.c         |   12 ++--
>  include/linux/suspend.h      |   26 ++++----
>  kernel/power/Kconfig         |    9 ++-
>  kernel/power/Makefile        |    2 +-
>  kernel/power/hibernate_nvs.c |  136 ------------------------------------------
>  kernel/power/nvs.c           |  136 ++++++++++++++++++++++++++++++++++++++++++
>  kernel/power/suspend.c       |    6 ++
>  8 files changed, 168 insertions(+), 161 deletions(-)
>  delete mode 100644 kernel/power/hibernate_nvs.c
>  create mode 100644 kernel/power/nvs.c
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 7bca3c6..0d6fc71 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -729,7 +729,7 @@ static int __init e820_mark_nvs_memory(void)
>  		struct e820entry *ei = &e820.map[i];
>  
>  		if (ei->type == E820_NVS)
> -			hibernate_nvs_register(ei->addr, ei->size);
> +			suspend_nvs_register(ei->addr, ei->size);
>  	}
>  
>  	return 0;
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 3fb4bde..bdb306f 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -404,7 +404,7 @@ static int acpi_hibernation_begin(void)
>  {
>  	int error;
>  
> -	error = s4_no_nvs ? 0 : hibernate_nvs_alloc();
> +	error = s4_no_nvs ? 0 : suspend_nvs_alloc();
>  	if (!error) {
>  		acpi_target_sleep_state = ACPI_STATE_S4;
>  		acpi_sleep_tts_switch(acpi_target_sleep_state);
> @@ -418,7 +418,7 @@ static int acpi_hibernation_pre_snapshot(void)
>  	int error = acpi_pm_prepare();
>  
>  	if (!error)
> -		hibernate_nvs_save();
> +		suspend_nvs_save();
>  
>  	return error;
>  }
> @@ -443,7 +443,7 @@ static int acpi_hibernation_enter(void)
>  
>  static void acpi_hibernation_finish(void)
>  {
> -	hibernate_nvs_free();
> +	suspend_nvs_free();
>  	acpi_ec_unblock_transactions();
>  	acpi_pm_finish();
>  }
> @@ -464,7 +464,7 @@ static void acpi_hibernation_leave(void)
>  		panic("ACPI S4 hardware signature mismatch");
>  	}
>  	/* Restore the NVS memory area */
> -	hibernate_nvs_restore();
> +	suspend_nvs_restore();
>  	/* Allow EC transactions to happen. */
>  	acpi_ec_unblock_transactions_early();
>  }
> @@ -507,7 +507,7 @@ static int acpi_hibernation_begin_old(void)
>  
>  	if (!error) {
>  		if (!s4_no_nvs)
> -			error = hibernate_nvs_alloc();
> +			error = suspend_nvs_alloc();
>  		if (!error)
>  			acpi_target_sleep_state = ACPI_STATE_S4;
>  	}
> @@ -517,7 +517,7 @@ static int acpi_hibernation_begin_old(void)
>  static int acpi_hibernation_pre_snapshot_old(void)
>  {
>  	acpi_pm_freeze();
> -	hibernate_nvs_save();
> +	suspend_nvs_save();
>  	return 0;
>  }
>  
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 5e781d8..bc7d6bb 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -256,22 +256,22 @@ static inline int hibernate(void) { return -ENOSYS; }
>  static inline bool system_entering_hibernation(void) { return false; }
>  #endif /* CONFIG_HIBERNATION */
>  
> -#ifdef CONFIG_HIBERNATION_NVS
> -extern int hibernate_nvs_register(unsigned long start, unsigned long size);
> -extern int hibernate_nvs_alloc(void);
> -extern void hibernate_nvs_free(void);
> -extern void hibernate_nvs_save(void);
> -extern void hibernate_nvs_restore(void);
> -#else /* CONFIG_HIBERNATION_NVS */
> -static inline int hibernate_nvs_register(unsigned long a, unsigned long b)
> +#ifdef CONFIG_SUSPEND_NVS
> +extern int suspend_nvs_register(unsigned long start, unsigned long size);
> +extern int suspend_nvs_alloc(void);
> +extern void suspend_nvs_free(void);
> +extern void suspend_nvs_save(void);
> +extern void suspend_nvs_restore(void);
> +#else /* CONFIG_SUSPEND_NVS */
> +static inline int suspend_nvs_register(unsigned long a, unsigned long b)
>  {
>  	return 0;
>  }
> -static inline int hibernate_nvs_alloc(void) { return 0; }
> -static inline void hibernate_nvs_free(void) {}
> -static inline void hibernate_nvs_save(void) {}
> -static inline void hibernate_nvs_restore(void) {}
> -#endif /* CONFIG_HIBERNATION_NVS */
> +static inline int suspend_nvs_alloc(void) { return 0; }
> +static inline void suspend_nvs_free(void) {}
> +static inline void suspend_nvs_save(void) {}
> +static inline void suspend_nvs_restore(void) {}
> +#endif /* CONFIG_SUSPEND_NVS */
>  
>  #ifdef CONFIG_PM_SLEEP
>  void save_processor_state(void);
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 5c36ea9..ca6066a 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -99,9 +99,13 @@ config PM_SLEEP_ADVANCED_DEBUG
>  	depends on PM_ADVANCED_DEBUG
>  	default n
>  
> +config SUSPEND_NVS
> +       bool
> +
>  config SUSPEND
>  	bool "Suspend to RAM and standby"
>  	depends on PM && ARCH_SUSPEND_POSSIBLE
> +	select SUSPEND_NVS if HAS_IOMEM
>  	default y
>  	---help---
>  	  Allow the system to enter sleep states in which main memory is
> @@ -130,13 +134,10 @@ config SUSPEND_FREEZER
>  
>  	  Turning OFF this setting is NOT recommended! If in doubt, say Y.
>  
> -config HIBERNATION_NVS
> -	bool
> -
>  config HIBERNATION
>  	bool "Hibernation (aka 'suspend to disk')"
>  	depends on PM && SWAP && ARCH_HIBERNATION_POSSIBLE
> -	select HIBERNATION_NVS if HAS_IOMEM
> +	select SUSPEND_NVS if HAS_IOMEM
>  	---help---
>  	  Enable the suspend to disk (STD) functionality, which is usually
>  	  called "hibernation" in user interfaces.  STD checkpoints the
> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
> index 524e058..f9063c6 100644
> --- a/kernel/power/Makefile
> +++ b/kernel/power/Makefile
> @@ -10,6 +10,6 @@ obj-$(CONFIG_SUSPEND)		+= suspend.o
>  obj-$(CONFIG_PM_TEST_SUSPEND)	+= suspend_test.o
>  obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o user.o \
>  				   block_io.o
> -obj-$(CONFIG_HIBERNATION_NVS)	+= hibernate_nvs.o
> +obj-$(CONFIG_SUSPEND_NVS)	+= nvs.o
>  
>  obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
> diff --git a/kernel/power/hibernate_nvs.c b/kernel/power/hibernate_nvs.c
> deleted file mode 100644
> index fdcad9e..0000000
> --- a/kernel/power/hibernate_nvs.c
> +++ /dev/null
> @@ -1,136 +0,0 @@
> -/*
> - * linux/kernel/power/hibernate_nvs.c - Routines for handling NVS memory
> - *
> - * Copyright (C) 2008,2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
> - *
> - * This file is released under the GPLv2.
> - */
> -
> -#include <linux/io.h>
> -#include <linux/kernel.h>
> -#include <linux/list.h>
> -#include <linux/mm.h>
> -#include <linux/slab.h>
> -#include <linux/suspend.h>
> -
> -/*
> - * Platforms, like ACPI, may want us to save some memory used by them during
> - * hibernation and to restore the contents of this memory during the subsequent
> - * resume.  The code below implements a mechanism allowing us to do that.
> - */
> -
> -struct nvs_page {
> -	unsigned long phys_start;
> -	unsigned int size;
> -	void *kaddr;
> -	void *data;
> -	struct list_head node;
> -};
> -
> -static LIST_HEAD(nvs_list);
> -
> -/**
> - *	hibernate_nvs_register - register platform NVS memory region to save
> - *	@start - physical address of the region
> - *	@size - size of the region
> - *
> - *	The NVS region need not be page-aligned (both ends) and we arrange
> - *	things so that the data from page-aligned addresses in this region will
> - *	be copied into separate RAM pages.
> - */
> -int hibernate_nvs_register(unsigned long start, unsigned long size)
> -{
> -	struct nvs_page *entry, *next;
> -
> -	while (size > 0) {
> -		unsigned int nr_bytes;
> -
> -		entry = kzalloc(sizeof(struct nvs_page), GFP_KERNEL);
> -		if (!entry)
> -			goto Error;
> -
> -		list_add_tail(&entry->node, &nvs_list);
> -		entry->phys_start = start;
> -		nr_bytes = PAGE_SIZE - (start & ~PAGE_MASK);
> -		entry->size = (size < nr_bytes) ? size : nr_bytes;
> -
> -		start += entry->size;
> -		size -= entry->size;
> -	}
> -	return 0;
> -
> - Error:
> -	list_for_each_entry_safe(entry, next, &nvs_list, node) {
> -		list_del(&entry->node);
> -		kfree(entry);
> -	}
> -	return -ENOMEM;
> -}
> -
> -/**
> - *	hibernate_nvs_free - free data pages allocated for saving NVS regions
> - */
> -void hibernate_nvs_free(void)
> -{
> -	struct nvs_page *entry;
> -
> -	list_for_each_entry(entry, &nvs_list, node)
> -		if (entry->data) {
> -			free_page((unsigned long)entry->data);
> -			entry->data = NULL;
> -			if (entry->kaddr) {
> -				iounmap(entry->kaddr);
> -				entry->kaddr = NULL;
> -			}
> -		}
> -}
> -
> -/**
> - *	hibernate_nvs_alloc - allocate memory necessary for saving NVS regions
> - */
> -int hibernate_nvs_alloc(void)
> -{
> -	struct nvs_page *entry;
> -
> -	list_for_each_entry(entry, &nvs_list, node) {
> -		entry->data = (void *)__get_free_page(GFP_KERNEL);
> -		if (!entry->data) {
> -			hibernate_nvs_free();
> -			return -ENOMEM;
> -		}
> -	}
> -	return 0;
> -}
> -
> -/**
> - *	hibernate_nvs_save - save NVS memory regions
> - */
> -void hibernate_nvs_save(void)
> -{
> -	struct nvs_page *entry;
> -
> -	printk(KERN_INFO "PM: Saving platform NVS memory\n");
> -
> -	list_for_each_entry(entry, &nvs_list, node)
> -		if (entry->data) {
> -			entry->kaddr = ioremap(entry->phys_start, entry->size);
> -			memcpy(entry->data, entry->kaddr, entry->size);
> -		}
> -}
> -
> -/**
> - *	hibernate_nvs_restore - restore NVS memory regions
> - *
> - *	This function is going to be called with interrupts disabled, so it
> - *	cannot iounmap the virtual addresses used to access the NVS region.
> - */
> -void hibernate_nvs_restore(void)
> -{
> -	struct nvs_page *entry;
> -
> -	printk(KERN_INFO "PM: Restoring platform NVS memory\n");
> -
> -	list_for_each_entry(entry, &nvs_list, node)
> -		if (entry->data)
> -			memcpy(entry->kaddr, entry->data, entry->size);
> -}
> diff --git a/kernel/power/nvs.c b/kernel/power/nvs.c
> new file mode 100644
> index 0000000..30c662f
> --- /dev/null
> +++ b/kernel/power/nvs.c
> @@ -0,0 +1,136 @@
> +/*
> + * linux/kernel/power/nvs.c - Routines for handling NVS memory
> + *
> + * Copyright (C) 2008,2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
> + *
> + * This file is released under the GPLv2.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/suspend.h>
> +
> +/*
> + * Platforms, like ACPI, may want us to save some memory used by them during
> + * suspend and to restore the contents of this memory during the subsequent
> + * resume.  The code below implements a mechanism allowing us to do that.
> + */
> +
> +struct nvs_page {
> +	unsigned long phys_start;
> +	unsigned int size;
> +	void *kaddr;
> +	void *data;
> +	struct list_head node;
> +};
> +
> +static LIST_HEAD(nvs_list);
> +
> +/**
> + *	suspend_nvs_register - register platform NVS memory region to save
> + *	@start - physical address of the region
> + *	@size - size of the region
> + *
> + *	The NVS region need not be page-aligned (both ends) and we arrange
> + *	things so that the data from page-aligned addresses in this region will
> + *	be copied into separate RAM pages.
> + */
> +int suspend_nvs_register(unsigned long start, unsigned long size)
> +{
> +	struct nvs_page *entry, *next;
> +
> +	while (size > 0) {
> +		unsigned int nr_bytes;
> +
> +		entry = kzalloc(sizeof(struct nvs_page), GFP_KERNEL);
> +		if (!entry)
> +			goto Error;
> +
> +		list_add_tail(&entry->node, &nvs_list);
> +		entry->phys_start = start;
> +		nr_bytes = PAGE_SIZE - (start & ~PAGE_MASK);
> +		entry->size = (size < nr_bytes) ? size : nr_bytes;
> +
> +		start += entry->size;
> +		size -= entry->size;
> +	}
> +	return 0;
> +
> + Error:
> +	list_for_each_entry_safe(entry, next, &nvs_list, node) {
> +		list_del(&entry->node);
> +		kfree(entry);
> +	}
> +	return -ENOMEM;
> +}
> +
> +/**
> + *	suspend_nvs_free - free data pages allocated for saving NVS regions
> + */
> +void suspend_nvs_free(void)
> +{
> +	struct nvs_page *entry;
> +
> +	list_for_each_entry(entry, &nvs_list, node)
> +		if (entry->data) {
> +			free_page((unsigned long)entry->data);
> +			entry->data = NULL;
> +			if (entry->kaddr) {
> +				iounmap(entry->kaddr);
> +				entry->kaddr = NULL;
> +			}
> +		}
> +}
> +
> +/**
> + *	suspend_nvs_alloc - allocate memory necessary for saving NVS regions
> + */
> +int suspend_nvs_alloc(void)
> +{
> +	struct nvs_page *entry;
> +
> +	list_for_each_entry(entry, &nvs_list, node) {
> +		entry->data = (void *)__get_free_page(GFP_KERNEL);
> +		if (!entry->data) {
> +			suspend_nvs_free();
> +			return -ENOMEM;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/**
> + *	suspend_nvs_save - save NVS memory regions
> + */
> +void suspend_nvs_save(void)
> +{
> +	struct nvs_page *entry;
> +
> +	printk(KERN_INFO "PM: Saving platform NVS memory\n");
> +
> +	list_for_each_entry(entry, &nvs_list, node)
> +		if (entry->data) {
> +			entry->kaddr = ioremap(entry->phys_start, entry->size);
> +			memcpy(entry->data, entry->kaddr, entry->size);
> +		}
> +}
> +
> +/**
> + *	suspend_nvs_restore - restore NVS memory regions
> + *
> + *	This function is going to be called with interrupts disabled, so it
> + *	cannot iounmap the virtual addresses used to access the NVS region.
> + */
> +void suspend_nvs_restore(void)
> +{
> +	struct nvs_page *entry;
> +
> +	printk(KERN_INFO "PM: Restoring platform NVS memory\n");
> +
> +	list_for_each_entry(entry, &nvs_list, node)
> +		if (entry->data)
> +			memcpy(entry->kaddr, entry->data, entry->size);
> +}
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 56e7dbb..f37cb7d 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -16,6 +16,12 @@
>  #include <linux/cpu.h>
>  #include <linux/syscalls.h>
>  #include <linux/gfp.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/suspend.h>
>  
>  #include "power.h"
>  
> 

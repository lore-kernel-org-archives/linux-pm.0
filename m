From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH][v6] x86, suspend: Save/restore extra MSR registers for
 suspend
Date: Wed, 18 Nov 2015 08:52:53 +0100
Message-ID: <20151118075252.GA21676@gmail.com>
References: <6c37c06b6496431d6d82e6d59215eb04edfd9333.1447730578.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38643 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbbKRHw6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 02:52:58 -0500
Content-Disposition: inline
In-Reply-To: <6c37c06b6496431d6d82e6d59215eb04edfd9333.1447730578.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net, pavel@ucw.cz, bp@suse.de, luto@kernel.org, linux@horizon.com, rui.zhang@intel.com, len.brown@intel.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


* Chen Yu <yu.c.chen@intel.com> wrote:

Btw., you say a bug was reported - but there's no Reported-by line. Do you know 
who reported it, can the reporter be credited?

Also, I improved the changelog to be readable, please pick this new text up for 
the next submission:

> A bug was reported that on certain Broadwell platforms, after resuming from S3, 
> the CPU is running at an anomalously low speed.
>
> It turns out that the BIOS has modified the value of the THERM_CONTROL register 
> during S3, and changed it from 0 to 0x10, thus enabled clock modulation(bit4), 
> but with undefined CPU Duty Cycle(bit1:3) - which causes the problem.
> 
> Here is a simple scenario to reproduce the issue:
>
>  1. Boot up the system
>  2. Get MSR 0x19a, it should be 0
>  3. Put the system into sleep, then wake it up
>  4. Get MSR 0x19a, it shows 0x10, while it should be 0
> 
> Although some BIOSen want to change the CPU Duty Cycle during S3, in our case we 
> don't want the BIOS to do any modification.
>
> Fix this issue by introducing a more generic x86 framework to save/restore 
> specified MSR registers(THERM_CONTROL in this case) for suspend/resume. This 
> allows us to fix similar bugs in a much simpler way in the future.
> 
> When the kernel wants to protect certain MSRs during suspending, we simply add a 
> quirk entry in msr_save_dmi_table, and customize the MSR registers inside the 
> quirk callback, for example:
> 
>   u32 msr_id_need_to_save[] = {MSR_ID0, MSR_ID1, MSR_ID2...};
> 
> and the quirk mechanism ensures that, once resumed from suspend, the MSRs 
> indicated by these IDs will be restored to their original, pre-suspend values.
> 
> Since both 64-bit and 32-bit kernels are affected, this patch covers the common 
> 64/32-bit suspend/resume code path. And because the MSRs specified by the user 
> might not be available or readable in any situation, we use rdmsrl_safe() to 
> safely save these MSRs.

The patch looks good to me, but there are a few stylistic nits I have:

> +struct msr_save_data {
> +	bool msr_saved;
> +	struct msr_info rv;

s/msr_save_data/saved_msr

> +};
> +
> +struct msr_context {
> +	unsigned short num;

Please don't use short in the kernel, the compiler will align it anyway. Use 
unsigned int instead.

> +	struct msr_save_data *msr_array;
> +};

s/msr_context/saved_msrs

> +
>  static inline unsigned long long native_read_tscp(unsigned int *aux)
>  {
>  	unsigned long low, high;
> diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
> index d1793f0..5057f65 100644
> --- a/arch/x86/include/asm/suspend_32.h
> +++ b/arch/x86/include/asm/suspend_32.h
> @@ -15,6 +15,7 @@ struct saved_context {
>  	unsigned long cr0, cr2, cr3, cr4;
>  	u64 misc_enable;
>  	bool misc_enable_saved;
> +	struct msr_context msr_to_save;

s/msr_to_save/saved_msrs

>  	struct desc_ptr gdt_desc;
>  	struct desc_ptr idt;
>  	u16 ldt;
> diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
> index 7ebf0eb..60941de 100644
> --- a/arch/x86/include/asm/suspend_64.h
> +++ b/arch/x86/include/asm/suspend_64.h
> @@ -24,6 +24,7 @@ struct saved_context {
>  	unsigned long cr0, cr2, cr3, cr4, cr8;
>  	u64 misc_enable;
>  	bool misc_enable_saved;
> +	struct msr_context msr_to_save;
>  	unsigned long efer;
>  	u16 gdt_pad; /* Unused */
>  	struct desc_ptr gdt_desc;
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index 9ab5279..0906290 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -23,6 +23,7 @@
>  #include <asm/debugreg.h>
>  #include <asm/cpu.h>
>  #include <asm/mmu_context.h>
> +#include <linux/dmi.h>
>  
>  #ifdef CONFIG_X86_32
>  __visible unsigned long saved_context_ebx;
> @@ -32,6 +33,29 @@ __visible unsigned long saved_context_eflags;
>  #endif
>  struct saved_context saved_context;
>  
> +static void msr_save_context(struct saved_context *ctxt)
> +{
> +	struct msr_save_data *msr = ctxt->msr_to_save.msr_array;
> +	struct msr_save_data *end = msr + ctxt->msr_to_save.num;
> +
> +	while (msr < end) {
> +		msr->msr_saved = !rdmsrl_safe(msr->rv.msr_no, &msr->rv.reg.q);
> +		msr++;
> +	}
> +}
> +
> +static void msr_restore_context(struct saved_context *ctxt)
> +{
> +	struct msr_save_data *msr = ctxt->msr_to_save.msr_array;
> +	struct msr_save_data *end = msr + ctxt->msr_to_save.num;
> +
> +	while (msr < end) {
> +		if (msr->msr_saved)
> +			wrmsrl(msr->rv.msr_no, msr->rv.reg.q);
> +		msr++;
> +	}
> +}
> +
>  /**
>   *	__save_processor_state - save CPU registers before creating a
>   *		hibernation image and before restoring the memory state from it
> @@ -111,6 +135,7 @@ static void __save_processor_state(struct saved_context *ctxt)
>  #endif
>  	ctxt->misc_enable_saved = !rdmsrl_safe(MSR_IA32_MISC_ENABLE,
>  					       &ctxt->misc_enable);
> +	msr_save_context(ctxt);
>  }
>  
>  /* Needed by apm.c */
> @@ -229,6 +254,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
>  	x86_platform.restore_sched_clock_state();
>  	mtrr_bp_restore();
>  	perf_restore_debug_store();
> +	msr_restore_context(ctxt);
>  }
>  
>  /* Needed by apm.c */
> @@ -320,3 +346,71 @@ static int __init bsp_pm_check_init(void)
>  }
>  
>  core_initcall(bsp_pm_check_init);
> +
> +static int msr_init_context(const u32 *msr_id, const int total_num)
> +{
> +	int i = 0;
> +	struct msr_save_data *msr_data = NULL;

No need to initialize to NULL AFAICS.

Also, please use consistent variable names for 'struct saved_msr *' variables: 
here you call it 'msr_data', elsewhere it's 'msr'. Using 'msr' consistently would 
be fine.

> +
> +	if (saved_context.msr_to_save.msr_array ||
> +			saved_context.msr_to_save.num > 0) {
> +		pr_err("PM: quirk already applied, please check your dmi match table.\n");
> +		return -EINVAL;

s/"x86/pm: Quirk already applied, ...

> +	}
> +
> +	msr_data = kmalloc_array(total_num,
> +			sizeof(struct msr_save_data), GFP_KERNEL);
> +	if (!msr_data) {
> +		pr_err("PM: can not allocate memory to save/restore MSRs during suspend.\n");

ditto. Please propagate this across the other messages as well.

> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < total_num; i++) {
> +		msr_data[i].rv.msr_no = msr_id[i];
> +		msr_data[i].msr_saved = false;
> +		msr_data[i].rv.reg.q = 0;
> +	}
> +	saved_context.msr_to_save.num = total_num;
> +	saved_context.msr_to_save.msr_array = msr_data;
> +	return 0;

Please put an empty line before the return.

> +}
> +
> +/*
> + * The following section is a quirk framework for problematic BIOS:

s/BIOSen

> + * Sometimes MSRs are modified by BIOS after suspended to

s/by the BIOS/

> + * RAM, this might cause unexpected behavior after wakeup.
> + * Thus we save/restore these specified MSRs during suspending

s/across suspend/resume

> + * in order to work around it.
> + *
> + * For any further problematic BIOS/platforms,

s/BIOSen

> + * please add your own function similar to msr_initialize_bdw.
> + */
> +static int msr_initialize_bdw(const struct dmi_system_id *d)
> +{
> +	/* Add any extra MSR ids into this array. */
> +	u32 bdw_msr_id[] = {MSR_IA32_THERM_CONTROL};

I'm quite sure checkpatch warns about the whitespaces in this initialization 
sequence.

> +
> +	pr_info("PM: %s detected, MSR saving is needed during suspending.\n",
> +		d->ident);

Please don't break the line for pr_info() arguments.

> +	return msr_init_context(bdw_msr_id, ARRAY_SIZE(bdw_msr_id));
> +}
> +
> +static struct dmi_system_id msr_save_dmi_table[] = {
> +	{
> +	 .callback = msr_initialize_bdw,
> +	 .ident = "BROADWELL BDX_EP",
> +	 .matches = {
> +		DMI_MATCH(DMI_PRODUCT_NAME, "GRANTLEY"),
> +		DMI_MATCH(DMI_PRODUCT_VERSION, "E63448-400"),

are you sure it's only this specific product version that is affected? Shouldn't 
we filter for all 'GRANTLEY' products? We can do no harm by saving/restoring on 
platforms that don't need it, right?

> +		},
> +	},
> +	{}
> +};
> +
> +static int pm_check_save_msr(void)
> +{
> +	dmi_check_system(msr_save_dmi_table);
> +	return 0;
> +}
> +
> +late_initcall(pm_check_save_msr);

Please double check that the suspend/resume test facility (CONFIG_PM_TEST_SUSPEND) 
is run _after_ this callback is called. Is there any reason why this is a late 
initcall?

Thanks,

	Ingo

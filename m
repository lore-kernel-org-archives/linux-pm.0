From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] [v2] x86, suspend: Save/restore extra MSR registers for
 suspend
Date: Mon, 24 Aug 2015 10:49:46 +0200
Message-ID: <20150824084946.GA7819@nazgul.tnic>
References: <1440158014-29610-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:37216 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbbHXIth (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 24 Aug 2015 04:49:37 -0400
Content-Disposition: inline
In-Reply-To: <1440158014-29610-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: rjw@rjwysocki.net, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rui.zhang@intel.com, lenb@kernel.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 21, 2015 at 07:53:34PM +0800, Chen Yu wrote:
> A bug is reported(https://bugzilla.redhat.com/show_bug.cgi?id=1227208)
> that, after resuming from S3, CPU is working at a low speed.
> After investigation, it is found that, BIOS has modified the value
> of THERM_CONTROL register during S3, changes it from 0 to 0x10,
> while the latter means CPU can only get 25% of the Duty Cycle,
> and this caused the problem.
> 
> Simple scenario to reproduce:
> 1.Boot up system
> 2.Get MSR with address 0x19a, it should output 0
> 3.Put system into sleep, then wake up
> 4.Get MSR with address 0x19a, it should output 0(actual it outputs 0x10)
> 
> Although this is a BIOS issue, it would be more robust for linux to deal
> with this situation. This patch fixes this issue by introducing a framework
> for saving/restoring specify MSR registers(THERM_CONTROL in this case)
> on suspend/resume.
> 
> When user finds a problematic platform that requires save/restore MSRs,
> he can simply add quirk in msr_save_dmi_table, and customizes MSR
> registers in quirk callback, for example:
> 
> unsigned int msr_id_need_to_save[] = {MSR_ID0, MSR_ID1, MSR_ID2...};
> 
> and system ensures that, once resumed from suspend, these MSR indicated
> by IDs will be restored to their original values before suspend.
> 
> Since both 64/32-bit kernels are affected, this patch covers 64/32-bit
> common code path. And because the MSR ids specified by user might not be
> available or readable in any situation, we use rdmsrl_safe to safely
> save these MSR registers.
> 
> Tested-by: Marcin Kaszewski <marcin.kaszewski@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2:
>  - Cover both 64/32-bit common code path.
>    Use rdmsrl_safe to safely read MSR.
>    Introduce a quirk framework for save/restore specified MSR on different
>    platforms.
> ---
>  arch/x86/include/asm/suspend_32.h | 12 +++++
>  arch/x86/include/asm/suspend_64.h | 12 +++++
>  arch/x86/power/cpu.c              | 93 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 117 insertions(+)
> 
> diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
> index d1793f0..07b0443 100644
> --- a/arch/x86/include/asm/suspend_32.h
> +++ b/arch/x86/include/asm/suspend_32.h
> @@ -9,12 +9,24 @@
>  #include <asm/desc.h>
>  #include <asm/fpu/api.h>
>  
> +struct msr_type {
> +	unsigned int msr_id;
> +	bool msr_saved;
> +	u64 msr_value;
> +};

These definitions look awfully close to struct msr_info in
include/asm/msr.h

Maybe reuse them instead of growing yet another type...

> +
> +struct saved_msr {
> +	unsigned short num;
> +	struct msr_type *msr_array;
> +} __attribute__((packed));



> +
>  /* image of the saved processor state */
>  struct saved_context {
>  	u16 es, fs, gs, ss;
>  	unsigned long cr0, cr2, cr3, cr4;
>  	u64 misc_enable;
>  	bool misc_enable_saved;
> +	struct saved_msr msr_for_save;
>  	struct desc_ptr gdt_desc;
>  	struct desc_ptr idt;
>  	u16 ldt;
> diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
> index 7ebf0eb..321e288 100644
> --- a/arch/x86/include/asm/suspend_64.h
> +++ b/arch/x86/include/asm/suspend_64.h
> @@ -9,6 +9,17 @@
>  #include <asm/desc.h>
>  #include <asm/fpu/api.h>
>  
> +struct msr_type {
> +	unsigned int msr_id;
> +	bool msr_saved;
> +	u64 msr_value;
> +};
> +
> +struct saved_msr {
> +	unsigned short num;
> +	struct msr_type *msr_array;
> +} __attribute__((packed));
> +
>  /*
>   * Image of the saved processor state, used by the low level ACPI suspend to
>   * RAM code and by the low level hibernation code.
> @@ -24,6 +35,7 @@ struct saved_context {
>  	unsigned long cr0, cr2, cr3, cr4, cr8;
>  	u64 misc_enable;
>  	bool misc_enable_saved;
> +	struct saved_msr msr_for_save;
>  	unsigned long efer;
>  	u16 gdt_pad; /* Unused */
>  	struct desc_ptr gdt_desc;
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index 9ab5279..ed6c562 100644
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
> @@ -32,6 +33,30 @@ __visible unsigned long saved_context_eflags;
>  #endif
>  struct saved_context saved_context;
>  
> +static void msr_save_context(struct saved_context *ctxt)
> +{
> +	int i = 0;
> +
> +	for (i = 0; i < ctxt->msr_for_save.num; i++) {
> +		struct msr_type *msr =
> +			&ctxt->msr_for_save.msr_array[i];

No need for the line breaks here, let them stick out for better readability.

> +		msr->msr_saved = !rdmsrl_safe(msr->msr_id,
> +			&msr->msr_value);
> +	}
> +}
> +
> +static void msr_restore_context(struct saved_context *ctxt)
> +{
> +	int i = 0;
> +
> +	for (i = 0; i < ctxt->msr_for_save.num; i++) {
> +		struct msr_type *msr =
> +			&ctxt->msr_for_save.msr_array[i];
> +		if (msr->msr_saved)
> +			wrmsrl(msr->msr_id, msr->msr_value);

Ditto.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

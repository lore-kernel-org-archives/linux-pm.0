From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86, suspend: Save/restore THERM_CONTROL register for
 suspend
Date: Mon, 17 Aug 2015 12:11:15 +0200
Message-ID: <20150817101115.GA27204@gmail.com>
References: <1439800192-3034-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36554 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbbHQKLU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2015 06:11:20 -0400
Content-Disposition: inline
In-Reply-To: <1439800192-3034-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: rjw@rjwysocki.net, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rui.zhang@intel.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


* Chen Yu <yu.c.chen@intel.com> wrote:

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
> with this situation. This patch fixes this issue by saving/restoring
> THERM_CONTROL(now called CLOCK_MODULATION) register on suspend/resume.
> 
> Tested-by: Marcin Kaszewski <marcin.kaszewski@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  arch/x86/include/asm/suspend_64.h | 1 +
>  arch/x86/power/cpu.c              | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
> index 7ebf0eb..b9f5591 100644
> --- a/arch/x86/include/asm/suspend_64.h
> +++ b/arch/x86/include/asm/suspend_64.h
> @@ -25,6 +25,7 @@ struct saved_context {
>  	u64 misc_enable;
>  	bool misc_enable_saved;
>  	unsigned long efer;
> +	unsigned long clock_modulation;
>  	u16 gdt_pad; /* Unused */
>  	struct desc_ptr gdt_desc;
>  	u16 idt_pad;
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index 9ab5279..f82577b 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -97,6 +97,7 @@ static void __save_processor_state(struct saved_context *ctxt)
>  	mtrr_save_fixed_ranges(NULL);
>  
>  	rdmsrl(MSR_EFER, ctxt->efer);
> +	rdmsrl(MSR_IA32_THERM_CONTROL, ctxt->clock_modulation);

So what your changelog fails to mention:

 - You only add this code to the 64-bit kernel. Are 32-bit kernels not affected?

 - the MSR read is done unconditionally. Is MSR_IA32_THERM_CONTROL available
   architecturally and readable (and has sensible values) on all 64-bit capable
   x86 CPUs that run this code path?

Thanks,

	Ingo

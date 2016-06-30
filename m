From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4] x86/power/64: Fix kernel text mapping corruption
 during image restoration
Date: Thu, 30 Jun 2016 17:05:39 +0200
Message-ID: <20160630150539.GA3962@pd.tnic>
References: <20160617105435.GB15997@pd.tnic>
 <CAGXu5j+1_06mKVsV2BeBZtitRk8GtjMPH8_zAxocfxtp7NeLXg@mail.gmail.com>
 <1735047.Yzv12qmPPB@vostro.rjw.lan>
 <1735143.jkZ4XHok9E@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:57273 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932102AbcF3PFm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 30 Jun 2016 11:05:42 -0400
Content-Disposition: inline
In-Reply-To: <1735143.jkZ4XHok9E@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Logan Gunthorpe <logang@deltatee.com>, Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>

On Thu, Jun 30, 2016 at 03:17:20PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Logan Gunthorpe reports that hibernation stopped working reliably for
> him after commit ab76f7b4ab23 (x86/mm: Set NX on gap between __ex_table
> and rodata).

...

> +static int relocate_restore_code(void)
> +{
> +	pgd_t *pgd;
> +	pud_t *pud;
> +
> +	relocated_restore_code = get_safe_page(GFP_ATOMIC);
> +	if (!relocated_restore_code)
> +		return -ENOMEM;
> +
> +	memcpy((void *)relocated_restore_code, &core_restore_code, PAGE_SIZE);
> +
> +	/* Make the page containing the relocated code executable */
> +	pgd = (pgd_t *)__va(read_cr3()) + pgd_index(relocated_restore_code);
> +	pud = pud_offset(pgd, relocated_restore_code);
> +	if (pud_large(*pud)) {
> +		set_pud(pud, __pud(pud_val(*pud) & ~_PAGE_NX));
> +	} else {
> +		pmd_t *pmd = pmd_offset(pud, relocated_restore_code);
> +
> +		if (pmd_large(*pmd)) {
> +			set_pmd(pmd, __pmd(pmd_val(*pmd) & ~_PAGE_NX));
> +		} else {
> +			pte_t *pte = pte_offset_kernel(pmd, relocated_restore_code);
> +
> +			set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_NX));
> +		}
> +	}
> +	flush_tlb_all();

I know you want to flush TLBs but this causes the splat below on the
resume kernel.

Most likely because:

resume_target_kernel() does local_irq_disable() and then

swsusp_arch_resume() -> relocate_restore_code() -> flush_tlb_all()

and smp_call_function_many() doesn't like it when IRQs are disabled.

[    7.613645] Disabling non-boot CPUs ...
[    7.902408] ------------[ cut here ]------------
[    7.907106] WARNING: CPU: 0 PID: 1 at kernel/smp.c:416 smp_call_function_many+0xb6/0x260
[    7.915319] Modules linked in:
[    7.918501] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.7.0-rc5+ #11
[    7.924931] Hardware name: To be filled by O.E.M. To be filled by O.E.M./M5A97 EVO R2.0, BIOS 1503 01/16/2013
[    7.934967]  0000000000000000 ffff88042b957cf8 ffffffff812ac1c3 0000000000000000
[    7.942664]  0000000000000000 ffff88042b957d38 ffffffff8105435d 000001a02b957d28
[    7.950369]  0000000000000000 0000000000000000 ffffffff8104d420 0000000000000000
[    7.958072] Call Trace:
[    7.960598]  [<ffffffff812ac1c3>] dump_stack+0x67/0x94
[    7.965815]  [<ffffffff8105435d>] __warn+0xdd/0x100
[    7.970771]  [<ffffffff8104d420>] ? leave_mm+0xc0/0xc0
[    7.975981]  [<ffffffff8105444d>] warn_slowpath_null+0x1d/0x20
[    7.981891]  [<ffffffff810cb526>] smp_call_function_many+0xb6/0x260
[    7.988236]  [<ffffffff8104d420>] ? leave_mm+0xc0/0xc0
[    7.993452]  [<ffffffff810cb716>] smp_call_function+0x46/0x80
[    7.999277]  [<ffffffff8104d420>] ? leave_mm+0xc0/0xc0
[    8.004494]  [<ffffffff810cb78e>] on_each_cpu+0x3e/0xa0
[    8.009790]  [<ffffffff81098e00>] ? hibernation_restore+0x130/0x130
[    8.016135]  [<ffffffff8104debc>] flush_tlb_all+0x1c/0x20
[    8.021613]  [<ffffffff815bd8d4>] swsusp_arch_resume+0x254/0x2b0
[    8.027696]  [<ffffffff815bd660>] ? restore_processor_state+0x2f0/0x2f0
[    8.034387]  [<ffffffff81098d9d>] hibernation_restore+0xcd/0x130
[    8.040464]  [<ffffffff81112fbd>] software_resume.part.6+0x1f9/0x25b
[    8.046894]  [<ffffffff81098e26>] software_resume+0x26/0x30
[    8.052545]  [<ffffffff81000449>] do_one_initcall+0x59/0x190
[    8.058282]  [<ffffffff81071b3c>] ? parse_args+0x26c/0x3f0
[    8.063867]  [<ffffffff8168b000>] ? _raw_read_unlock_irqrestore+0x30/0x60
[    8.070730]  [<ffffffff81cd5002>] kernel_init_freeable+0x118/0x19e
[    8.076986]  [<ffffffff816851ae>] kernel_init+0xe/0x100
[    8.082290]  [<ffffffff8168b75f>] ret_from_fork+0x1f/0x40
[    8.087768]  [<ffffffff816851a0>] ? rest_init+0x90/0x90
[    8.093073] ---[ end trace 6361ce069253f25c ]---

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

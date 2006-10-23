From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm] Make swsusp work on i386 with PAE
Date: Mon, 23 Oct 2006 16:50:33 +0200
Message-ID: <20061023145033.GB31273@elf.ucw.cz>
References: <200610221548.48204.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964910AbWJWOvA@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200610221548.48204.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, Dave Jones <davej@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> The purpose of the appended patch is to make swsusp work on i386 with PAE,
> but it should also allow i386 systems without PSE to use swsusp.
> 
> The patch creates temporary page tables located in resume-safe page frames
> during the resume and uses them for restoring the suspend image (the same
> approach is used on x86-64).
> 
> It has been tested on an i386 system with PAE and survived several
> suspend-resume cycles in a row, but I have no systems without PSE, so that
> requires some testing.

Thanks, looks okay to me. I guess Andi Kleen would be right person to
review it in detail?

Lack of assembly modifications is good.

I guess this should be now removed? (include/asm-i386/suspend.h)

arch_prepare_suspend(void)
{
        /* If you want to make non-PSE machine work, turn off paging
           in swsusp_arch_suspend. swsusp_pg_dir should have identity mapping, so
           it could work...  */
        if (!cpu_has_pse) {
                printk(KERN_ERR "PSE is required for swsusp.\n");
                return -EPERM;
        }

> +/*
> + * Create a middle page table on a resume-safe page and put a pointer to it in
> + * the given global directory entry.  This only returns the gd entry
> + * in non-PAE compilation mode, since the middle layer is folded.
> + */
> +static pmd_t *resume_one_md_table_init(pgd_t *pgd)
> +{
> +	pud_t *pud;
> +	pmd_t *pmd_table;
> +
> +#ifdef CONFIG_X86_PAE
> +	pmd_table = (pmd_t *)get_safe_page(GFP_ATOMIC);
> +	if (!pmd_table)
> +		return pmd_table;

I'd do plain old return NULL; here.

> +			/* Map with big pages if possible, otherwise create
> +			 * normal page tables.
> +			 * NOTE: We can mark everything as executable here
> +			 */
> +			if (cpu_has_pse) {
> +				set_pmd(pmd, pfn_pmd(pfn, PAGE_KERNEL_LARGE_EXEC));
> +				pfn += PTRS_PER_PTE;

Perhaps disabling PSE here can help getting some testing?

Okay, I guess I should really test this one... Seems good enough for
-mm to me, but it should preferably stay there for a _long_ time.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

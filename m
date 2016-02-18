From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 14/15] arm64: kernel: Add support for
 hibernate/suspend-to-disk
Date: Thu, 18 Feb 2016 17:13:36 +0000
Message-ID: <20160218171336.GB13296@red-moon>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
 <1455637767-31561-15-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41009 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946254AbcBRRLb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Feb 2016 12:11:31 -0500
Content-Disposition: inline
In-Reply-To: <1455637767-31561-15-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

On Tue, Feb 16, 2016 at 03:49:26PM +0000, James Morse wrote:
> Add support for hibernate/suspend-to-disk.
> 
> Suspend borrows code from cpu_suspend() to write cpu state onto the stack,
> before calling swsusp_save() to save the memory image.
> 
> Restore creates a set of temporary page tables, covering only the
> linear map, copies the restore code to a 'safe' page, then uses the copy to
> restore the memory image. The copied code executes in the lower half of the
> address space, and once complete, restores the original kernel's page
> tables. It then calls into cpu_resume(), and follows the normal
> cpu_suspend() path back into the suspend code.
> 
> To restore a kernel using KASLR, the address of the page tables, and
> cpu_resume() are stored in the hibernate arch-header and the el2
> vectors are pivotted via the 'safe' page in low memory. This also permits
> us to resume using a different version of the kernel to the version that
> hibernated, but because the MMU isn't turned off during resume, the
> MMU settings must be the same between both kernels. To ensure this, the
> value of the translation control register (TCR_EL1) is also included in the
> hibernate arch-header, this means your resume kernel must have the same
> page size, and virtual address space size.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com> # Tested on Juno R2
> ---

[...]

> +/*
> + * el2_setup() moves lr into elr and erets. Copy lr to another register to
> + * preserve it.
> + *
> + * int swsusp_el2_setup_helper(phys_addr_t el2_setup_pa);
> + */
> +ENTRY(swsusp_el2_setup_helper)
> +	mov	x16, x30
> +	hvc	#0
> +	mov	x30, x16
> +	ret
> +ENDPROC(swsusp_el2_setup_helper)
> +
> +/*
> + * Restore the hyp stub. Once we know where in memory el2_setup is, we
> + * can use it to re-initialise el2. This must be done before the hibernate
> + * page is unmapped.
> + *
> + * x0: The physical address of el2_setup __pa(el2_setup)
> + */
> +el1_sync:
> +	mov	x1, x0
> +	mrs	lr, elr_el2
> +	mrs	x0, sctlr_el1

You may make el2_setup return straight to swsusp_el2_setup_helper caller,
but anyway, I think you can do something even simpler.

You can stash el2_setup physical address (and a flag to check if you
have to reboot HYP or not) in the hibernate header, then, before
jumping to the _cpu_resume address you store in the header you restore
HYP by calling el2_setup_phys and you are done with that, this saves
you an extra call in C.

[...]

> +int swsusp_arch_suspend(void)
> +{
> +	int ret = 0;
> +	unsigned long flags;
> +	struct sleep_stack_data state;
> +
> +	local_dbg_save(flags);
> +
> +	if (__cpu_suspend_enter(&state)) {
> +		ret = swsusp_save();
> +	} else {
> +		void *lm_kernel_start;
> +
> +		/* Clean kernel to PoC for secondary core startup */
> +		lm_kernel_start = phys_to_virt(virt_to_phys(KERNEL_START));
> +		__flush_dcache_area(lm_kernel_start, KERNEL_END - KERNEL_START);
> +
> +		/* Reconfigure EL2 */
> +		if (is_hyp_mode_available())
> +			swsusp_el2_setup_helper(virt_to_phys(el2_setup));

I am referring to this code here, I think it is nicer to restore el2
before getting here anyway as I say above, you do know you have to call
el2_setup anyway, stash the data/address you need in the hibernate header
and just execute it in the code page set aside to resume from hibernate
(ie swsusp_arch_suspend_exit).

Thanks !
Lorenzo

> +
> +		/*
> +		 * Tell the hibernation core that we've just restored
> +		 * the memory
> +		 */
> +		in_suspend = 0;
> +
> +		__cpu_suspend_exit();
> +	}
> +
> +	local_dbg_restore(flags);
> +
> +	return ret;
> +}
> +
> +static int copy_pte(pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long start,
> +		    unsigned long end)
> +{
> +	unsigned long next;
> +	unsigned long addr = start;
> +	pte_t *src_pte = pte_offset_kernel(src_pmd, start);
> +	pte_t *dst_pte = pte_offset_kernel(dst_pmd, start);
> +
> +	do {
> +		next = addr + PAGE_SIZE;
> +		if (pte_val(*src_pte))
> +			set_pte(dst_pte,
> +				__pte(pte_val(*src_pte) & ~PTE_RDONLY));
> +	} while (dst_pte++, src_pte++, addr = next, addr != end);
> +
> +	return 0;
> +}
> +
> +static int copy_pmd(pud_t *dst_pud, pud_t *src_pud, unsigned long start,
> +		    unsigned long end)
> +{
> +	int rc = 0;
> +	pte_t *dst_pte;
> +	unsigned long next;
> +	unsigned long addr = start;
> +	pmd_t *src_pmd = pmd_offset(src_pud, start);
> +	pmd_t *dst_pmd = pmd_offset(dst_pud, start);
> +
> +	do {
> +		next = pmd_addr_end(addr, end);
> +		if (!pmd_val(*src_pmd))
> +			continue;
> +
> +		if (pmd_table(*(src_pmd))) {
> +			dst_pte = (pte_t *)get_safe_page(GFP_ATOMIC);
> +			if (!dst_pte) {
> +				rc = -ENOMEM;
> +				break;
> +			}
> +
> +			set_pmd(dst_pmd, __pmd(virt_to_phys(dst_pte)
> +					       | PMD_TYPE_TABLE));
> +
> +			rc = copy_pte(dst_pmd, src_pmd, addr, next);
> +			if (rc)
> +				break;
> +		} else {
> +			set_pmd(dst_pmd,
> +				__pmd(pmd_val(*src_pmd) & ~PMD_SECT_RDONLY));
> +		}
> +	} while (dst_pmd++, src_pmd++, addr = next, addr != end);
> +
> +	return rc;
> +}
> +
> +static int copy_pud(pgd_t *dst_pgd, pgd_t *src_pgd, unsigned long start,
> +		    unsigned long end)
> +{
> +	int rc = 0;
> +	pmd_t *dst_pmd;
> +	unsigned long next;
> +	unsigned long addr = start;
> +	pud_t *src_pud = pud_offset(src_pgd, start);
> +	pud_t *dst_pud = pud_offset(dst_pgd, start);
> +
> +	do {
> +		next = pud_addr_end(addr, end);
> +		if (!pud_val(*src_pud))
> +			continue;
> +
> +		if (pud_table(*(src_pud))) {
> +			if (PTRS_PER_PMD != 1) {
> +				dst_pmd = (pmd_t *)get_safe_page(GFP_ATOMIC);
> +				if (!dst_pmd) {
> +					rc = -ENOMEM;
> +					break;
> +				}
> +
> +				set_pud(dst_pud, __pud(virt_to_phys(dst_pmd)
> +						       | PUD_TYPE_TABLE));
> +			}
> +
> +			rc = copy_pmd(dst_pud, src_pud, addr, next);
> +			if (rc)
> +				break;
> +		} else {
> +			set_pud(dst_pud,
> +				__pud(pud_val(*src_pud) & ~PMD_SECT_RDONLY));
> +		}
> +	} while (dst_pud++, src_pud++, addr = next, addr != end);
> +
> +	return rc;
> +}
> +
> +static int copy_page_tables(pgd_t *dst_pgd, unsigned long start,
> +			    unsigned long end)
> +{
> +	int rc = 0;
> +	pud_t *dst_pud;
> +	unsigned long next;
> +	unsigned long addr = start;
> +	pgd_t *src_pgd = pgd_offset_k(start);
> +
> +	dst_pgd += pgd_index(start);
> +
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		if (!pgd_val(*src_pgd))
> +			continue;
> +
> +		if (PTRS_PER_PUD != 1) {
> +			dst_pud = (pud_t *)get_safe_page(GFP_ATOMIC);
> +			if (!dst_pud) {
> +				rc = -ENOMEM;
> +				break;
> +			}
> +
> +			set_pgd(dst_pgd, __pgd(virt_to_phys(dst_pud)
> +					       | PUD_TYPE_TABLE));
> +		}
> +
> +		rc = copy_pud(dst_pgd, src_pgd, addr, next);
> +		if (rc)
> +			break;
> +	} while (dst_pgd++, src_pgd++, addr = next, addr != end);
> +
> +	return rc;
> +}
> +
> +/*
> + * Setup then Resume from the hibernate image using swsusp_arch_suspend_exit().
> + *
> + * Memory allocated by get_safe_page() will be dealt with by the hibernate code,
> + * we don't need to free it here.
> + */
> +int swsusp_arch_resume(void)
> +{
> +	int rc = 0;
> +	size_t exit_size;
> +	pgd_t *tmp_pg_dir;
> +	void *lm_restore_pblist;
> +	phys_addr_t phys_hibernate_exit;
> +	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *, void *);
> +
> +	/*
> +	 * Copy swsusp_arch_suspend_exit() to a safe page. This will generate
> +	 * a new set of ttbr0 page tables and load them.
> +	 */
> +	exit_size = __hibernate_exit_text_end - __hibernate_exit_text_start;
> +	rc = create_safe_exec_page(__hibernate_exit_text_start, exit_size,
> +				   (void **)&hibernate_exit,
> +				   &phys_hibernate_exit,
> +				   get_safe_page, GFP_ATOMIC);
> +	if (rc) {
> +		pr_err("Failed to create safe executable page for hibernate_exit code.");
> +		goto out;
> +	}
> +
> +	/*
> +	 * The hibernate exit text contains a set of el2 vectors, that will
> +	 * be executed at el2 with the mmu off in order to reload hyp-stub.
> +	 */
> +	__flush_dcache_area(hibernate_exit, exit_size);
> +
> +	/*
> +	 * Restoring the memory image will overwrite the ttbr1 page tables.
> +	 * Create a second copy of just the linear map, and use this when
> +	 * restoring.
> +	 */
> +	tmp_pg_dir = (pgd_t *)get_safe_page(GFP_ATOMIC);
> +	if (!tmp_pg_dir) {
> +		pr_err("Failed to allocate memory for temporary page tables.");
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +	rc = copy_page_tables(tmp_pg_dir, PAGE_OFFSET, 0);
> +	if (rc)
> +		goto out;
> +
> +	/*
> +	 * Since we only copied the linear map, we need to find restore_pblist's
> +	 * linear map address.
> +	 */
> +	lm_restore_pblist = phys_to_virt(virt_to_phys(restore_pblist));
> +
> +	/*
> +	 * Both KASLR and restoring with a different kernel version will cause
> +	 * the el2 vectors to be in a different location in the resumed kernel.
> +	 * Load hibernate's temporary copy into el2.
> +	 */
> +	if (is_hyp_mode_available()) {
> +		phys_addr_t el2_vectors = phys_hibernate_exit;  /* base */
> +		el2_vectors += hibernate_el2_vectors -
> +			       __hibernate_exit_text_start;     /* offset */
> +
> +		__hyp_set_vectors(el2_vectors);
> +	}
> +
> +	hibernate_exit(virt_to_phys(tmp_pg_dir), resume_hdr.ttbr1_el1,
> +		       resume_hdr.reenter_kernel, lm_restore_pblist);
> +
> +out:
> +	return rc;
> +}
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 282e3e64a17e..02184c39f7e2 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -46,6 +46,16 @@ jiffies = jiffies_64;
>  	*(.idmap.text)					\
>  	VMLINUX_SYMBOL(__idmap_text_end) = .;
>  
> +#ifdef CONFIG_HIBERNATION
> +#define HIBERNATE_TEXT					\
> +	. = ALIGN(SZ_4K);				\
> +	VMLINUX_SYMBOL(__hibernate_exit_text_start) = .;\
> +	*(.hibernate_exit.text)				\
> +	VMLINUX_SYMBOL(__hibernate_exit_text_end) = .;
> +#else
> +#define HIBERNATE_TEXT
> +#endif
> +
>  /*
>   * The size of the PE/COFF section that covers the kernel image, which
>   * runs from stext to _edata, must be a round multiple of the PE/COFF
> @@ -107,6 +117,7 @@ SECTIONS
>  			LOCK_TEXT
>  			HYPERVISOR_TEXT
>  			IDMAP_TEXT
> +			HIBERNATE_TEXT
>  			*(.fixup)
>  			*(.gnu.warning)
>  		. = ALIGN(16);
> @@ -182,6 +193,10 @@ ASSERT(__hyp_idmap_text_end - (__hyp_idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
>  	"HYP init code too big or misaligned")
>  ASSERT(__idmap_text_end - (__idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
>  	"ID map text too big or misaligned")
> +#ifdef CONFIG_HIBERNATION
> +ASSERT(__hibernate_exit_text_end - (__hibernate_exit_text_start & ~(SZ_4K - 1))
> +	<= SZ_4K, "Hibernate exit text too big or misaligned")
> +#endif
>  
>  /*
>   * If padding is applied before .head.text, virt<->phys conversions will fail.
> -- 
> 2.6.2
> 

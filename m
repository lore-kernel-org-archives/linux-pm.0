From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3] x86/power/64: Fix kernel text mapping corruption
 during image restoration
Date: Wed, 29 Jun 2016 21:56:17 -0600
Message-ID: <8273253c-95dd-0156-7af8-d2a164d1491b@deltatee.com>
References: <20160617105435.GB15997@pd.tnic>
 <65d98ad4-124b-64e4-84e5-877af71a1d44@deltatee.com>
 <2398306.qXx6AZtdS5@vostro.rjw.lan> <1829549.Og2FdTtl4p@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:41477 "EHLO ale.deltatee.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486AbcF3D4m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 29 Jun 2016 23:56:42 -0400
In-Reply-To: <1829549.Og2FdTtl4p@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>



On 29/06/16 08:55 PM, Rafael J. Wysocki wrote:

> The only thing that comes to mind at this point is that TLBs should be flushed
> after page tables changes, so please apply the appended and let me know
> if you see this panic any more with it.


Ok, I'll build a new kernel tomorrow. But keep in mind the panic is 
pretty rare as I've only seen it once so far after a couple dozen or so 
hibernates. So it may be hard to get a concrete yes or no on whether it 
fixes the issue.

I've got a script to run a bunch of hibernates in a row. I usually only 
run it for a handful of iterations, but I'll try running it for much 
longer with this patch and let you know in a couple days.

Logan


> Thanks,
> Rafael
>
>
> ---
>  arch/x86/power/hibernate_64.c     |   92 +++++++++++++++++++++++++++++++++-----
>  arch/x86/power/hibernate_asm_64.S |   55 +++++++++-------------
>  2 files changed, 104 insertions(+), 43 deletions(-)
>
> Index: linux-pm/arch/x86/power/hibernate_64.c
> ===================================================================
> --- linux-pm.orig/arch/x86/power/hibernate_64.c
> +++ linux-pm/arch/x86/power/hibernate_64.c
> @@ -19,6 +19,7 @@
>  #include <asm/mtrr.h>
>  #include <asm/sections.h>
>  #include <asm/suspend.h>
> +#include <asm/tlbflush.h>
>
>  /* Defined in hibernate_asm_64.S */
>  extern asmlinkage __visible int restore_image(void);
> @@ -28,6 +29,7 @@ extern asmlinkage __visible int restore_
>   * kernel's text (this value is passed in the image header).
>   */
>  unsigned long restore_jump_address __visible;
> +unsigned long jump_address_phys;
>
>  /*
>   * Value of the cr3 register from before the hibernation (this value is passed
> @@ -37,7 +39,43 @@ unsigned long restore_cr3 __visible;
>
>  pgd_t *temp_level4_pgt __visible;
>
> -void *relocated_restore_code __visible;
> +unsigned long relocated_restore_code __visible;
> +
> +static int set_up_temporary_text_mapping(void)
> +{
> +	pmd_t *pmd;
> +	pud_t *pud;
> +
> +	/*
> +	 * The new mapping only has to cover the page containing the image
> +	 * kernel's entry point (jump_address_phys), because the switch over to
> +	 * it is carried out by relocated code running from a page allocated
> +	 * specifically for this purpose and covered by the identity mapping, so
> +	 * the temporary kernel text mapping is only needed for the final jump.
> +	 * Moreover, in that mapping the virtual address of the image kernel's
> +	 * entry point must be the same as its virtual address in the image
> +	 * kernel (restore_jump_address), so the image kernel's
> +	 * restore_registers() code doesn't find itself in a different area of
> +	 * the virtual address space after switching over to the original page
> +	 * tables used by the image kernel.
> +	 */
> +	pud = (pud_t *)get_safe_page(GFP_ATOMIC);
> +	if (!pud)
> +		return -ENOMEM;
> +
> +	pmd = (pmd_t *)get_safe_page(GFP_ATOMIC);
> +	if (!pmd)
> +		return -ENOMEM;
> +
> +	set_pmd(pmd + pmd_index(restore_jump_address),
> +		__pmd((jump_address_phys & PMD_MASK) | __PAGE_KERNEL_LARGE_EXEC));
> +	set_pud(pud + pud_index(restore_jump_address),
> +		__pud(__pa(pmd) | _KERNPG_TABLE));
> +	set_pgd(temp_level4_pgt + pgd_index(restore_jump_address),
> +		__pgd(__pa(pud) | _KERNPG_TABLE));
> +
> +	return 0;
> +}
>
>  static void *alloc_pgt_page(void *context)
>  {
> @@ -59,9 +97,10 @@ static int set_up_temporary_mappings(voi
>  	if (!temp_level4_pgt)
>  		return -ENOMEM;
>
> -	/* It is safe to reuse the original kernel mapping */
> -	set_pgd(temp_level4_pgt + pgd_index(__START_KERNEL_map),
> -		init_level4_pgt[pgd_index(__START_KERNEL_map)]);
> +	/* Prepare a temporary mapping for the kernel text */
> +	result = set_up_temporary_text_mapping();
> +	if (result)
> +		return result;
>
>  	/* Set up the direct mapping from scratch */
>  	for (i = 0; i < nr_pfn_mapped; i++) {
> @@ -78,19 +117,45 @@ static int set_up_temporary_mappings(voi
>  	return 0;
>  }
>
> +static int relocate_restore_code(void)
> +{
> +	pgd_t *pgd;
> +	pmd_t *pmd;
> +
> +	relocated_restore_code = get_safe_page(GFP_ATOMIC);
> +	if (!relocated_restore_code)
> +		return -ENOMEM;
> +
> +	memcpy((void *)relocated_restore_code, &core_restore_code, PAGE_SIZE);
> +
> +	/* Make the page containing the relocated code executable */
> +	pgd = (pgd_t *)__va(read_cr3()) + pgd_index(relocated_restore_code);
> +	pmd = pmd_offset(pud_offset(pgd, relocated_restore_code),
> +			 relocated_restore_code);
> +	if (pmd_large(*pmd)) {
> +		set_pmd(pmd, __pmd(pmd_val(*pmd) & ~_PAGE_NX));
> +	} else {
> +		pte_t *pte = pte_offset_kernel(pmd, relocated_restore_code);
> +
> +		set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_NX));
> +	}
> +	flush_tlb_all();
> +
> +	return 0;
> +}
> +
>  int swsusp_arch_resume(void)
>  {
>  	int error;
>
>  	/* We have got enough memory and from now on we cannot recover */
> -	if ((error = set_up_temporary_mappings()))
> +	error = set_up_temporary_mappings();
> +	if (error)
>  		return error;
>
> -	relocated_restore_code = (void *)get_safe_page(GFP_ATOMIC);
> -	if (!relocated_restore_code)
> -		return -ENOMEM;
> -	memcpy(relocated_restore_code, &core_restore_code,
> -	       &restore_registers - &core_restore_code);
> +	error = relocate_restore_code();
> +	if (error)
> +		return error;
>
>  	restore_image();
>  	return 0;
> @@ -109,11 +174,12 @@ int pfn_is_nosave(unsigned long pfn)
>
>  struct restore_data_record {
>  	unsigned long jump_address;
> +	unsigned long jump_address_phys;
>  	unsigned long cr3;
>  	unsigned long magic;
>  };
>
> -#define RESTORE_MAGIC	0x0123456789ABCDEFUL
> +#define RESTORE_MAGIC	0x123456789ABCDEF0UL
>
>  /**
>   *	arch_hibernation_header_save - populate the architecture specific part
> @@ -126,7 +192,8 @@ int arch_hibernation_header_save(void *a
>
>  	if (max_size < sizeof(struct restore_data_record))
>  		return -EOVERFLOW;
> -	rdr->jump_address = restore_jump_address;
> +	rdr->jump_address = (unsigned long)&restore_registers;
> +	rdr->jump_address_phys = __pa_symbol(&restore_registers);
>  	rdr->cr3 = restore_cr3;
>  	rdr->magic = RESTORE_MAGIC;
>  	return 0;
> @@ -142,6 +209,7 @@ int arch_hibernation_header_restore(void
>  	struct restore_data_record *rdr = addr;
>
>  	restore_jump_address = rdr->jump_address;
> +	jump_address_phys = rdr->jump_address_phys;
>  	restore_cr3 = rdr->cr3;
>  	return (rdr->magic == RESTORE_MAGIC) ? 0 : -EINVAL;
>  }
> Index: linux-pm/arch/x86/power/hibernate_asm_64.S
> ===================================================================
> --- linux-pm.orig/arch/x86/power/hibernate_asm_64.S
> +++ linux-pm/arch/x86/power/hibernate_asm_64.S
> @@ -44,9 +44,6 @@ ENTRY(swsusp_arch_suspend)
>  	pushfq
>  	popq	pt_regs_flags(%rax)
>
> -	/* save the address of restore_registers */
> -	movq	$restore_registers, %rax
> -	movq	%rax, restore_jump_address(%rip)
>  	/* save cr3 */
>  	movq	%cr3, %rax
>  	movq	%rax, restore_cr3(%rip)
> @@ -57,31 +54,34 @@ ENTRY(swsusp_arch_suspend)
>  ENDPROC(swsusp_arch_suspend)
>
>  ENTRY(restore_image)
> -	/* switch to temporary page tables */
> -	movq	$__PAGE_OFFSET, %rdx
> -	movq	temp_level4_pgt(%rip), %rax
> -	subq	%rdx, %rax
> -	movq	%rax, %cr3
> -	/* Flush TLB */
> -	movq	mmu_cr4_features(%rip), %rax
> -	movq	%rax, %rdx
> -	andq	$~(X86_CR4_PGE), %rdx
> -	movq	%rdx, %cr4;  # turn off PGE
> -	movq	%cr3, %rcx;  # flush TLB
> -	movq	%rcx, %cr3;
> -	movq	%rax, %cr4;  # turn PGE back on
> -
>  	/* prepare to jump to the image kernel */
> -	movq	restore_jump_address(%rip), %rax
> -	movq	restore_cr3(%rip), %rbx
> +	movq	restore_jump_address(%rip), %r8
> +	movq	restore_cr3(%rip), %r9
> +
> +	/* prepare to switch to temporary page tables */
> +	movq	temp_level4_pgt(%rip), %rax
> +	movq	mmu_cr4_features(%rip), %rbx
>
>  	/* prepare to copy image data to their original locations */
>  	movq	restore_pblist(%rip), %rdx
> +
> +	/* jump to relocated restore code */
>  	movq	relocated_restore_code(%rip), %rcx
>  	jmpq	*%rcx
>
>  	/* code below has been relocated to a safe page */
>  ENTRY(core_restore_code)
> +	/* switch to temporary page tables */
> +	movq	$__PAGE_OFFSET, %rcx
> +	subq	%rcx, %rax
> +	movq	%rax, %cr3
> +	/* flush TLB */
> +	movq	%rbx, %rcx
> +	andq	$~(X86_CR4_PGE), %rcx
> +	movq	%rcx, %cr4;  # turn off PGE
> +	movq	%cr3, %rcx;  # flush TLB
> +	movq	%rcx, %cr3;
> +	movq	%rbx, %cr4;  # turn PGE back on
>  .Lloop:
>  	testq	%rdx, %rdx
>  	jz	.Ldone
> @@ -96,24 +96,17 @@ ENTRY(core_restore_code)
>  	/* progress to the next pbe */
>  	movq	pbe_next(%rdx), %rdx
>  	jmp	.Lloop
> +
>  .Ldone:
>  	/* jump to the restore_registers address from the image header */
> -	jmpq	*%rax
> -	/*
> -	 * NOTE: This assumes that the boot kernel's text mapping covers the
> -	 * image kernel's page containing restore_registers and the address of
> -	 * this page is the same as in the image kernel's text mapping (it
> -	 * should always be true, because the text mapping is linear, starting
> -	 * from 0, and is supposed to cover the entire kernel text for every
> -	 * kernel).
> -	 *
> -	 * code below belongs to the image kernel
> -	 */
> +	jmpq	*%r8
>
> +	 /* code below belongs to the image kernel */
> +	.align PAGE_SIZE
>  ENTRY(restore_registers)
>  	FRAME_BEGIN
>  	/* go back to the original page tables */
> -	movq    %rbx, %cr3
> +	movq    %r9, %cr3
>
>  	/* Flush TLB, including "global" things (vmalloc) */
>  	movq	mmu_cr4_features(%rip), %rax
>

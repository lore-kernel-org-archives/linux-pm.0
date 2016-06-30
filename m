From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v5] x86/power/64: Fix kernel text mapping corruption
 during image restoration
Date: Thu, 30 Jun 2016 15:47:21 -0600
Message-ID: <45fc5264-55d5-a394-60e4-ecacbc45179b@deltatee.com>
References: <20160617105435.GB15997@pd.tnic>
 <1735047.Yzv12qmPPB@vostro.rjw.lan> <1735143.jkZ4XHok9E@vostro.rjw.lan>
 <1502959.ObXuRQlJgl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:44712 "EHLO ale.deltatee.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954AbcF3Vrw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 30 Jun 2016 17:47:52 -0400
In-Reply-To: <1502959.ObXuRQlJgl@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>
Cc: Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>

Hey,

So, I've done a couple hundred hibernate resume cycles with v5 of the 
patch and so far it looks good. I'll let you know if I hit any bugs in 
more typical usage over the coming week.

Thanks,

Logan

On 30/06/16 10:11 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Logan Gunthorpe reports that hibernation stopped working reliably for
> him after commit ab76f7b4ab23 (x86/mm: Set NX on gap between __ex_table
> and rodata).
>
> That turns out to be a consequence of a long-standing issue with the
> 64-bit image restoration code on x86, which is that the temporary
> page tables set up by it to avoid page tables corruption when the
> last bits of the image kernel's memory contents are copied into
> their original page frames re-use the boot kernel's text mapping,
> but that mapping may very well get corrupted just like any other
> part of the page tables.  Of course, if that happens, the final
> jump to the image kernel's entry point will go to nowhere.
>
> The exact reason why commit ab76f7b4ab23 matters here is that it
> sometimes causes a PMD of a large page to be split into PTEs
> that are allocated dynamically and get corrupted during image
> restoration as described above.
>
> To fix that issue note that the code copying the last bits of the
> image kernel's memory contents to the page frames occupied by them
> previoulsy doesn't use the kernel text mapping, because it runs from
> a special page covered by the identity mapping set up for that code
> from scratch.  Hence, the kernel text mapping is only needed before
> that code starts to run and then it will only be used just for the
> final jump to the image kernel's entry point.
>
> Accordingly, the temporary page tables set up in swsusp_arch_resume()
> on x86-64 need to contain the kernel text mapping too.  That mapping
> is only going to be used for the final jump to the image kernel, so
> it only needs to cover the image kernel's entry point, because the
> first thing the image kernel does after getting control back is to
> switch over to its own original page tables.  Moreover, the virtual
> address of the image kernel's entry point in that mapping has to be
> the same as the one mapped by the image kernel's page tables.
>
> With that in mind, modify the x86-64's arch_hibernation_header_save()
> and arch_hibernation_header_restore() routines to pass the physical
> address of the image kernel's entry point (in addition to its virtual
> address) to the boot kernel (a small piece of assembly code involved
> in passing the entry point's virtual address to the image kernel is
> not necessary any more after that, so drop it).  Update RESTORE_MAGIC
> too to reflect the image header format change.
>
> Next, in set_up_temporary_mappings(), use the physical and virtual
> addresses of the image kernel's entry point passed in the image
> header to set up a minimum kernel text mapping (using memory pages
> that won't be overwritten by the image kernel's memory contents) that
> will map those addresses to each other as appropriate.
>
> This makes the concern about the possible corruption of the original
> boot kernel text mapping go away and if the the minimum kernel text
> mapping used for the final jump marks the image kernel's entry point
> memory as executable, the jump to it is guaraneed to succeed.
>
> Fixes: ab76f7b4ab23 (x86/mm: Set NX on gap between __ex_table and rodata)
> Link: http://marc.info/?l=linux-pm&m=146372852823760&w=2
> Reported-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v4 -> v5: Replace flush_tlb_all() in relocate_restore_code() with
>   __flush_tlb_all() (which still should be sufficient) to avoid
>   complaints from smp_call_function_many() about disabled interrupts.
>
> v3 -> v4: The new relocate_restore_code() didn't cover the case when
>   the page containing the relocated code was mapped via a huge (1G)
>   page and it didn't clear the NX bit in that case, which led to the
>   page fault reported by Logan at
>   http://marc.info/?l=linux-kernel&m=146725158621626&w=4.
>   Fix that by making relocate_restore_code() handle the huge page
>   mapping case too.
>
> I've retained the Tested-by: from Kees as these changes have nothing to do with
> whether or not KASLR works with hibernation after this patch.
>
> Logan, please test this one thoroughly.  I'll give it at least one week in
> linux-next going forward.
>
> Boris, please test it on the machine where we saw memory corruption with
> the previous versions if poss.
>
> ---
>  arch/x86/power/hibernate_64.c     |   97 +++++++++++++++++++++++++++++++++-----
>  arch/x86/power/hibernate_asm_64.S |   55 +++++++++------------
>  2 files changed, 109 insertions(+), 43 deletions(-)
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
> @@ -78,19 +117,50 @@ static int set_up_temporary_mappings(voi
>  	return 0;
>  }
>
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
> +	__flush_tlb_all();
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
> @@ -109,11 +179,12 @@ int pfn_is_nosave(unsigned long pfn)
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
> @@ -126,7 +197,8 @@ int arch_hibernation_header_save(void *a
>
>  	if (max_size < sizeof(struct restore_data_record))
>  		return -EOVERFLOW;
> -	rdr->jump_address = restore_jump_address;
> +	rdr->jump_address = (unsigned long)&restore_registers;
> +	rdr->jump_address_phys = __pa_symbol(&restore_registers);
>  	rdr->cr3 = restore_cr3;
>  	rdr->magic = RESTORE_MAGIC;
>  	return 0;
> @@ -142,6 +214,7 @@ int arch_hibernation_header_restore(void
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

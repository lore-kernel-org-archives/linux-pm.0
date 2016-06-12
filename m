From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: PROBLEM: Resume form hibernate broken by setting NX on gap
Date: Sun, 12 Jun 2016 10:11:38 -0600
Message-ID: <575D89BA.2030702@deltatee.com>
References: <573DF82D.50006@deltatee.com> <3878383.bGDWSmEsze@vostro.rjw.lan>
 <575CE988.9030201@deltatee.com> <7588059.uGlM6LQeiI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7588059.uGlM6LQeiI@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kees Cook <keescook@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hey Rafael,

Awesome, this patch fixes the problem! Nice work.

Thanks,

Logan

On 12/06/16 08:31 AM, Rafael J. Wysocki wrote:
> On Saturday, June 11, 2016 10:48:08 PM Logan Gunthorpe wrote:
>> Hey,
>
> Hi,
>
>> On 11/06/16 07:05 PM, Rafael J. Wysocki wrote:
>>>> 1) Commit ab76f7b4ab only extends the NX bit between __ex_table and
>>>> rodata; which, by my understanding, shouldn't be used by anything. And
>>>> __ex_table and rodata are fixed by the kernel's binary so both symbols
>>>> should be the same in both the image kernel and the boot kernel given
>>>> that both are running from the same binary.
>>>
>>> Well, what if the kernel is relocated?
>>
>> Ah, I'm sure I don't fully grasp the implications of that but I would
>> assume that if the image kernel were located somewhere else it would
>> still be far away from the boot kernel's ex_table/rodata boundary.
>
> Probably.
>
>>>> 2) When ab76f7b4ab is reverted, hibernation seems to work 100%. Though,
>>>> when it's in place, it only works some of the time. Given that commit is
>>>> only extending the NX region a bit, if there is some random mismatch,
>>>> why does it never reach rodata? In other words, why is rodata a magic
>>>> line that seems to work all the time -- why doesn't this random mismatch
>>>> ever extend into the rodata region? rodata isn't _that_ far away from
>>>> the end of ex_table.
>>>
>>> That's a very good question. :-)
>>
>> Yeah, I guess if we knew the answer we'd understand what was going on
>> and have a fix.
>
> Right.
>
> Appended is one more patch to try.
>
> It actually fixes a theoretical problem, so I'll need to add comments to it
> (as it is far from obvious IMO) and a changelog etc and post it as a proper
> submission.
>
> So the concern is that the page copying done in the loop in core_restore_code()
> may corrupt the kernel text part of the temporary memory mapping used at that
> time, because that's the original kernel text mapping from the boot kernel.
>
> That doesn't matter for the loop itself (as that code runs from a "safe" page
> guaranteed not to be overwritten), but it (quite theoretically) may matter for
> the final jump to the image kernel's restore_registers().  [I realized that
> it might be a problem only after I had started to think about the problem
> you reported.]
>
> As a bonus, the patch also eliminates the possible concern about the
> executability of the memory mapped via the kernel text mapping in the boot
> kernel, so IMO it's worth to give it a shot.  I've tested it lightly on
> one machine, but I guess it would just crash right away if there were
> any problems in it.
>
> Thanks,
> Rafael
>
>
> ---
>   arch/x86/power/hibernate_64.c     |   46 ++++++++++++++++++++++++++++++++++----
>   arch/x86/power/hibernate_asm_64.S |   28 +++++++++++++----------
>   2 files changed, 58 insertions(+), 16 deletions(-)
>
> Index: linux-pm/arch/x86/power/hibernate_64.c
> ===================================================================
> --- linux-pm.orig/arch/x86/power/hibernate_64.c
> +++ linux-pm/arch/x86/power/hibernate_64.c
> @@ -27,7 +27,8 @@ extern asmlinkage __visible int restore_
>    * Address to jump to in the last phase of restore in order to get to the image
>    * kernel's text (this value is passed in the image header).
>    */
> -unsigned long restore_jump_address __visible;
> +void *restore_jump_address __visible;
> +unsigned long jump_address_phys;
>
>   /*
>    * Value of the cr3 register from before the hibernation (this value is passed
> @@ -37,6 +38,9 @@ unsigned long restore_cr3 __visible;
>
>   pgd_t *temp_level4_pgt __visible;
>
> +void *restore_pgd_addr __visible;
> +pgd_t restore_pgd __visible;
> +
>   void *relocated_restore_code __visible;
>
>   static void *alloc_pgt_page(void *context)
> @@ -44,6 +48,33 @@ static void *alloc_pgt_page(void *contex
>   	return (void *)get_safe_page(GFP_ATOMIC);
>   }
>
> +static int prepare_temporary_text_mapping(void)
> +{
> +	unsigned long vaddr = (unsigned long)restore_jump_address;
> +	unsigned long paddr = jump_address_phys & PMD_MASK;
> +	pmd_t *pmd;
> +	pud_t *pud;
> +
> +	pud = (pud_t *)get_safe_page(GFP_ATOMIC);
> +	if (!pud)
> +		return -ENOMEM;
> +
> +	restore_pgd = __pgd(__pa(pud) | _KERNPG_TABLE);
> +
> +	pud += pud_index(vaddr);
> +	pmd = (pmd_t *)get_safe_page(GFP_ATOMIC);
> +	if (!pmd)
> +		return -ENOMEM;
> +
> +	set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
> +
> +	pmd += pmd_index(vaddr);
> +	set_pmd(pmd, __pmd(paddr | __PAGE_KERNEL_LARGE_EXEC));
> +
> +	restore_pgd_addr = temp_level4_pgt + pgd_index(vaddr);
> +	return 0;
> +}
> +
>   static int set_up_temporary_mappings(void)
>   {
>   	struct x86_mapping_info info = {
> @@ -63,6 +94,10 @@ static int set_up_temporary_mappings(voi
>   	set_pgd(temp_level4_pgt + pgd_index(__START_KERNEL_map),
>   		init_level4_pgt[pgd_index(__START_KERNEL_map)]);
>
> +	result = prepare_temporary_text_mapping();
> +	if (result)
> +		return result;
> +
>   	/* Set up the direct mapping from scratch */
>   	for (i = 0; i < nr_pfn_mapped; i++) {
>   		mstart = pfn_mapped[i].start << PAGE_SHIFT;
> @@ -108,12 +143,13 @@ int pfn_is_nosave(unsigned long pfn)
>   }
>
>   struct restore_data_record {
> -	unsigned long jump_address;
> +	void *jump_address;
> +	unsigned long jump_address_phys;
>   	unsigned long cr3;
>   	unsigned long magic;
>   };
>
> -#define RESTORE_MAGIC	0x0123456789ABCDEFUL
> +#define RESTORE_MAGIC	0x123456789ABCDEF0UL
>
>   /**
>    *	arch_hibernation_header_save - populate the architecture specific part
> @@ -126,7 +162,8 @@ int arch_hibernation_header_save(void *a
>
>   	if (max_size < sizeof(struct restore_data_record))
>   		return -EOVERFLOW;
> -	rdr->jump_address = restore_jump_address;
> +	rdr->jump_address = &restore_registers;
> +	rdr->jump_address_phys = __pa_symbol(&restore_registers);
>   	rdr->cr3 = restore_cr3;
>   	rdr->magic = RESTORE_MAGIC;
>   	return 0;
> @@ -142,6 +179,7 @@ int arch_hibernation_header_restore(void
>   	struct restore_data_record *rdr = addr;
>
>   	restore_jump_address = rdr->jump_address;
> +	jump_address_phys = rdr->jump_address_phys;
>   	restore_cr3 = rdr->cr3;
>   	return (rdr->magic == RESTORE_MAGIC) ? 0 : -EINVAL;
>   }
> Index: linux-pm/arch/x86/power/hibernate_asm_64.S
> ===================================================================
> --- linux-pm.orig/arch/x86/power/hibernate_asm_64.S
> +++ linux-pm/arch/x86/power/hibernate_asm_64.S
> @@ -72,8 +72,10 @@ ENTRY(restore_image)
>   	movq	%rax, %cr4;  # turn PGE back on
>
>   	/* prepare to jump to the image kernel */
> -	movq	restore_jump_address(%rip), %rax
>   	movq	restore_cr3(%rip), %rbx
> +	movq	restore_jump_address(%rip), %r10
> +	movq	restore_pgd(%rip), %r8
> +	movq	restore_pgd_addr(%rip), %r9
>
>   	/* prepare to copy image data to their original locations */
>   	movq	restore_pblist(%rip), %rdx
> @@ -96,20 +98,22 @@ ENTRY(core_restore_code)
>   	/* progress to the next pbe */
>   	movq	pbe_next(%rdx), %rdx
>   	jmp	.Lloop
> +
>   .Ldone:
> +	/* switch over to the temporary kernel text mapping */
> +	movq	%r8, (%r9)
> +	/* flush TLB */
> +	movq	%rax, %rdx
> +	andq	$~(X86_CR4_PGE), %rdx
> +	movq	%rdx, %cr4;  # turn off PGE
> +	movq	%cr3, %rcx;  # flush TLB
> +	movq	%rcx, %cr3;
> +	movq	%rax, %cr4;  # turn PGE back on
>   	/* jump to the restore_registers address from the image header */
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
> +	jmpq	*%r10
>
> +	 /* code below belongs to the image kernel */
> +	.align PAGE_SIZE
>   ENTRY(restore_registers)
>   	FRAME_BEGIN
>   	/* go back to the original page tables */
>

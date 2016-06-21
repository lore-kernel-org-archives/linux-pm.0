From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ktime_get_ts64() splat during resume
Date: Tue, 21 Jun 2016 02:05:59 +0200
Message-ID: <3043121.Rmj8QIPsb8@vostro.rjw.lan>
References: <20160617105435.GB15997@pd.tnic> <CA+55aFwGshPVCeBeMbY_RYrA+UR7-jLjy4SCbcHTxQ=f2KwESA@mail.gmail.com> <CAJZ5v0grcXRW6tukVmyZ3Xi0PqXSyf0+swfOLjxJkNawsSP-QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63220 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751225AbcFUACB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 20:02:01 -0400
In-Reply-To: <CAJZ5v0grcXRW6tukVmyZ3Xi0PqXSyf0+swfOLjxJkNawsSP-QA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Logan Gunthorpe <logang@deltatee.com>, Kees Cook <keescook@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stable <stable@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>

On Monday, June 20, 2016 11:15:18 PM Rafael J. Wysocki wrote:
> On Mon, Jun 20, 2016 at 8:29 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Mon, Jun 20, 2016 at 7:38 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>
> >> Overall, we seem to be heading towards the "really weird" territory here.
> >
> > So the whole commit that Boris bisected down to is weird to me.
> >
> > Why isn't the temporary text mapping just set up unconditionally in
> > the temp_level4_pgt?
> >
> > Why does it have that insane "let's leave the temp_level4_pgt alone
> > until we actually switch to it, and save away restore_pgd_addr and the
> > restore_pgd, to then be set up at restore time"?
> >
> > All the other temporary mappings are set up statically in the
> > temp_level4_pgt, why not that one?
> 
> The text mapping in temp_level4_pgt has to map the image kernel's
> physical entry address to the same virtual address that the image
> kernel had for it, because the image kernel will switch over to its
> own page tables first and it will use its own kernel text mapping from
> that point on.  That may not be the same as the text mapping of the
> (currently running) restore (or "boot") kernel.
> 
> So if we set up the text mapping in temp_level4_pgt upfront, we
> basically can't reference the original kernel text (or do any
> addressing relative to it) any more after switching over to
> temp_level4_pgt.
> 
> For some reason I thought that was not doable, but now that I look at
> the code it looks like it can be done.  I'll try doing that.
> 
> > I suspect whatever corruption happens boils down to the same issue
> > that made people do that odd decision in the first place.
> 
> The breakage appears to happen regardless of these changes, though.
> 
> > And regardless, those games are too ugly to live. So I would suggest
> > that that original commit should just be considered broken, and
> > reverted (or just removed - I'm not sure if it's in a stable branch or
> > not) and the fix be rethought so that the code mapping can be done
> > once and for all and *without* the extra games.
> 
> OK

Below is a new simplified version of the offending patch (without the
restore_pgd_addr and restore_pgd things).  It works for me. :-)

Logan, Kees, can you please check if this one works for you too?

Thanks,
Rafael

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] x86/power/64: Fix kernel text mapping corruption during image restoration

Logan Gunthorpe reports that hibernation stopped working reliably for
him after commit ab76f7b4ab23 (x86/mm: Set NX on gap between __ex_table
and rodata).

That turns out to be a consequence of a long-standing issue with the
64-bit image restoration code on x86, which is that the temporary
page tables set up by it to avoid page tables corruption when the
last bits of the image kernel's memory contents are copied into
their original page frames re-use the boot kernel's text mapping,
but that mapping may very well get corrupted just like any other
part of the page tables.  Of course, if that happens, the final
jump to the image kernel's entry point will go to nowhere.

The exact reason why commit ab76f7b4ab23 matters here is that it
sometimes causes a PMD of a large page to be split into PTEs
that are allocated dynamically and get corrupted during image
restoration as described above.

To fix that issue note that the code copying the last bits of the
image kernel's memory contents to the page frames occupied by them
previoulsy doesn't use the kernel text mapping, because it runs from
a special page covered by the identity mapping set up for that code
from scratch.  Hence, the kernel text mapping is only needed before
that code starts to run and then it will only be used just for the
final jump to the image kernel's entry point.

Accordingly, the temporary page tables set up in swsusp_arch_resume()
on x86-64 need to contain the kernel text mapping too.  That mapping
is only going to be used for the final jump to the image kernel, so
it only needs to cover the image kernel's entry point, because the
first thing the image kernel does after getting control back is to
switch over to its own original page tables.  Moreover, the virtual
address of the image kernel's entry point in that mapping has to be
the same as the one mapped by the image kernel's page tables.

With that in mind, modify the x86-64's arch_hibernation_header_save()
and arch_hibernation_header_restore() routines to pass the physical
address of the image kernel's entry point (in addition to its virtual
address) to the boot kernel (a small piece of assembly code involved
in passing the entry point's virtual address to the image kernel is
not necessary any more after that, so drop it).  Update RESTORE_MAGIC
too to reflect the image header format change.

Next, in set_up_temporary_mappings(), use the physical and virtual
addresses of the image kernel's entry point passed in the image
header to set up a minimum kernel text mapping (using memory pages
that won't be overwritten by the image kernel's memory contents) that
will map those addresses to each other as appropriate.

This makes the concern about the possible corruption of the original
boot kernel text mapping go away and if the the minimum kernel text
mapping used for the final jump marks the image kernel's entry point
memory as executable, the jump to it is guaraneed to succeed.

Fixes: ab76f7b4ab23 (x86/mm: Set NX on gap between __ex_table and rodata)
Link: http://marc.info/?l=linux-pm&m=146372852823760&w=2
Reported-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/power/hibernate_64.c     |   58 ++++++++++++++++++++++++++++++++------
 arch/x86/power/hibernate_asm_64.S |   55 +++++++++++++++---------------------
 2 files changed, 72 insertions(+), 41 deletions(-)

Index: linux-pm/arch/x86/power/hibernate_64.c
===================================================================
--- linux-pm.orig/arch/x86/power/hibernate_64.c
+++ linux-pm/arch/x86/power/hibernate_64.c
@@ -27,7 +27,8 @@ extern asmlinkage __visible int restore_
  * Address to jump to in the last phase of restore in order to get to the image
  * kernel's text (this value is passed in the image header).
  */
-unsigned long restore_jump_address __visible;
+void *restore_jump_address __visible;
+unsigned long jump_address_phys;
 
 /*
  * Value of the cr3 register from before the hibernation (this value is passed
@@ -39,6 +40,42 @@ pgd_t *temp_level4_pgt __visible;
 
 void *relocated_restore_code __visible;
 
+static int set_up_temporary_text_mapping(void)
+{
+	unsigned long vaddr = (unsigned long)restore_jump_address;
+	unsigned long paddr = jump_address_phys & PMD_MASK;
+	pmd_t *pmd;
+	pud_t *pud;
+
+	/*
+	 * The new mapping only has to cover the page containing the image
+	 * kernel's entry point (jump_address_phys), because the switch over to
+	 * it is carried out by relocated code running from a page allocated
+	 * specifically for this purpose and covered by the identity mapping, so
+	 * the temporary kernel text mapping is only needed for the final jump.
+	 * Moreover, in that mapping the virtual address of the image kernel's
+	 * entry point must be the same as its virtual address in the image
+	 * kernel (restore_jump_address), so the image kernel's
+	 * restore_registers() code doesn't find itself in a different area of
+	 * the virtual address space after switching over to the original page
+	 * tables used by the image kernel.
+	 */
+	pud = (pud_t *)get_safe_page(GFP_ATOMIC);
+	if (!pud)
+		return -ENOMEM;
+
+	pmd = (pmd_t *)get_safe_page(GFP_ATOMIC);
+	if (!pmd)
+		return -ENOMEM;
+
+	set_pmd(pmd + pmd_index(vaddr), __pmd(paddr | __PAGE_KERNEL_LARGE_EXEC));
+	set_pud(pud + pud_index(vaddr), __pud(__pa(pmd) | _KERNPG_TABLE));
+	set_pgd(temp_level4_pgt + pgd_index(vaddr),
+		__pgd(__pa(pud) | _KERNPG_TABLE));
+
+	return 0;
+}
+
 static void *alloc_pgt_page(void *context)
 {
 	return (void *)get_safe_page(GFP_ATOMIC);
@@ -59,9 +96,10 @@ static int set_up_temporary_mappings(voi
 	if (!temp_level4_pgt)
 		return -ENOMEM;
 
-	/* It is safe to reuse the original kernel mapping */
-	set_pgd(temp_level4_pgt + pgd_index(__START_KERNEL_map),
-		init_level4_pgt[pgd_index(__START_KERNEL_map)]);
+	/* Prepare a temporary mapping for the kernel text */
+	result = set_up_temporary_text_mapping();
+	if (result)
+		return result;
 
 	/* Set up the direct mapping from scratch */
 	for (i = 0; i < nr_pfn_mapped; i++) {
@@ -89,8 +127,7 @@ int swsusp_arch_resume(void)
 	relocated_restore_code = (void *)get_safe_page(GFP_ATOMIC);
 	if (!relocated_restore_code)
 		return -ENOMEM;
-	memcpy(relocated_restore_code, &core_restore_code,
-	       &restore_registers - &core_restore_code);
+	memcpy(relocated_restore_code, &core_restore_code, PAGE_SIZE);
 
 	restore_image();
 	return 0;
@@ -108,12 +145,13 @@ int pfn_is_nosave(unsigned long pfn)
 }
 
 struct restore_data_record {
-	unsigned long jump_address;
+	void *jump_address;
+	unsigned long jump_address_phys;
 	unsigned long cr3;
 	unsigned long magic;
 };
 
-#define RESTORE_MAGIC	0x0123456789ABCDEFUL
+#define RESTORE_MAGIC	0x123456789ABCDEF0UL
 
 /**
  *	arch_hibernation_header_save - populate the architecture specific part
@@ -126,7 +164,8 @@ int arch_hibernation_header_save(void *a
 
 	if (max_size < sizeof(struct restore_data_record))
 		return -EOVERFLOW;
-	rdr->jump_address = restore_jump_address;
+	rdr->jump_address = &restore_registers;
+	rdr->jump_address_phys = __pa_symbol(&restore_registers);
 	rdr->cr3 = restore_cr3;
 	rdr->magic = RESTORE_MAGIC;
 	return 0;
@@ -142,6 +181,7 @@ int arch_hibernation_header_restore(void
 	struct restore_data_record *rdr = addr;
 
 	restore_jump_address = rdr->jump_address;
+	jump_address_phys = rdr->jump_address_phys;
 	restore_cr3 = rdr->cr3;
 	return (rdr->magic == RESTORE_MAGIC) ? 0 : -EINVAL;
 }
Index: linux-pm/arch/x86/power/hibernate_asm_64.S
===================================================================
--- linux-pm.orig/arch/x86/power/hibernate_asm_64.S
+++ linux-pm/arch/x86/power/hibernate_asm_64.S
@@ -44,9 +44,6 @@ ENTRY(swsusp_arch_suspend)
 	pushfq
 	popq	pt_regs_flags(%rax)
 
-	/* save the address of restore_registers */
-	movq	$restore_registers, %rax
-	movq	%rax, restore_jump_address(%rip)
 	/* save cr3 */
 	movq	%cr3, %rax
 	movq	%rax, restore_cr3(%rip)
@@ -57,28 +54,29 @@ ENTRY(swsusp_arch_suspend)
 ENDPROC(swsusp_arch_suspend)
 
 ENTRY(restore_image)
+	/* prepare to jump to the image kernel */
+	movq	restore_jump_address(%rip), %r8
+	movq	restore_cr3(%rip), %r9
+
+	/* prepare to copy image data to their original locations */
+	movq	restore_pblist(%rip), %rdx
+	movq	relocated_restore_code(%rip), %r10
+
 	/* switch to temporary page tables */
-	movq	$__PAGE_OFFSET, %rdx
 	movq	temp_level4_pgt(%rip), %rax
-	subq	%rdx, %rax
+	movq	mmu_cr4_features(%rip), %rbx
+	movq	$__PAGE_OFFSET, %rcx
+	subq	%rcx, %rax
 	movq	%rax, %cr3
-	/* Flush TLB */
-	movq	mmu_cr4_features(%rip), %rax
-	movq	%rax, %rdx
-	andq	$~(X86_CR4_PGE), %rdx
-	movq	%rdx, %cr4;  # turn off PGE
+	/* flush TLB */
+	movq	%rbx, %rcx
+	andq	$~(X86_CR4_PGE), %rcx
+	movq	%rcx, %cr4;  # turn off PGE
 	movq	%cr3, %rcx;  # flush TLB
 	movq	%rcx, %cr3;
-	movq	%rax, %cr4;  # turn PGE back on
-
-	/* prepare to jump to the image kernel */
-	movq	restore_jump_address(%rip), %rax
-	movq	restore_cr3(%rip), %rbx
-
-	/* prepare to copy image data to their original locations */
-	movq	restore_pblist(%rip), %rdx
-	movq	relocated_restore_code(%rip), %rcx
-	jmpq	*%rcx
+	movq	%rbx, %cr4;  # turn PGE back on
+	/* jump to relocated restore code */
+	jmpq	*%r10
 
 	/* code below has been relocated to a safe page */
 ENTRY(core_restore_code)
@@ -96,24 +94,17 @@ ENTRY(core_restore_code)
 	/* progress to the next pbe */
 	movq	pbe_next(%rdx), %rdx
 	jmp	.Lloop
+
 .Ldone:
 	/* jump to the restore_registers address from the image header */
-	jmpq	*%rax
-	/*
-	 * NOTE: This assumes that the boot kernel's text mapping covers the
-	 * image kernel's page containing restore_registers and the address of
-	 * this page is the same as in the image kernel's text mapping (it
-	 * should always be true, because the text mapping is linear, starting
-	 * from 0, and is supposed to cover the entire kernel text for every
-	 * kernel).
-	 *
-	 * code below belongs to the image kernel
-	 */
+	jmpq	*%r8
 
+	 /* code below belongs to the image kernel */
+	.align PAGE_SIZE
 ENTRY(restore_registers)
 	FRAME_BEGIN
 	/* go back to the original page tables */
-	movq    %rbx, %cr3
+	movq    %r9, %cr3
 
 	/* Flush TLB, including "global" things (vmalloc) */
 	movq	mmu_cr4_features(%rip), %rax


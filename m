From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ktime_get_ts64() splat during resume
Date: Mon, 20 Jun 2016 16:38:26 +0200
Message-ID: <2816580.laIl5zA8fL@vostro.rjw.lan>
References: <20160617105435.GB15997@pd.tnic> <20160617161247.GB3912@pd.tnic> <CAJZ5v0jZypC17Qbvn3TXe5Z6M5JrGaktAwXQwAW=UEhccRv=nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41643 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755219AbcFTOkv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 10:40:51 -0400
In-Reply-To: <CAJZ5v0jZypC17Qbvn3TXe5Z6M5JrGaktAwXQwAW=UEhccRv=nw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Logan Gunthorpe <logang@deltatee.com>, Kees Cook <keescook@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stable <stable@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>

On Friday, June 17, 2016 11:03:46 PM Rafael J. Wysocki wrote:
> On Fri, Jun 17, 2016 at 6:12 PM, Borislav Petkov <bp@alien8.de> wrote:
> > On Fri, Jun 17, 2016 at 05:28:10PM +0200, Rafael J. Wysocki wrote:
> >> A couple of questions:
> >> - I guess this is reproducible 100% of the time?
> >
> > Yap.
> >
> > I took latest Linus + tip/master which has your commit.
> >
> >> - If you do "echo disk > /sys/power/state" instead of using s2disk,
> >> does it still crash in the same way?
> >
> > My suspend to disk script does:
> >
> > echo 3 > /proc/sys/vm/drop_caches
> > echo "shutdown" > /sys/power/disk
> > echo "disk" > /sys/power/state
> >
> > I don't use anything else for years now.
> >
> >> - Are both the image and boot kernels the same binary?
> >
> > Yep.
> 
> OK, we need to find out what's wrong, then.

Boris is traveling this week, so the investigation will continue when he's
back, but we spent quite some time on this during the weekend, so below is
a summary of what we found plus some comments.

Overall, we seem to be heading towards the "really weird" territory here.

> First, please revert the changes in hibernate_asm_64.S alone and see
> if that makes any difference.
>
> Hibernation should still work then most of the time, but the bug fixed
> by this commit will be back.

First of all, reverting the changes in hibernate_asm_64.S doesn't make the
breakage go away, which means that the most essential changes in
"x86/power/64: Fix crash whan the hibernation code passes control to the image
kernel" don't make a difference.

Moreover, after some back-and-forth we narrowed down the memory corruption to
a single line in the (new) prepare_temporary_text_mapping() function and it
turned out that it is triggered by scribbling on a page returned by
get_safe_page(), immediately after obtaining it.  Memory is corrupted no matter
how the page is written to.  In particular, filling that page with all ones
triggers memory corruption later, for example.

So appended is the last tested patch sufficient to trigger the breakage on the
Boris' system (modulo some comments).  Quite evidently, the breakage is
triggered by the memset() line in prepare_temporary_text_mapping().

In addition to the above, there are some interesting observations from the
investigation so far.

First, what is corrupted is the image kernel memory.  This means that the line
in question scribbles on image data (which are stored in memory at that point)
somewhere.  Nevertheless, the image kernel is evidently able to continue after
it has received control and carry out the full device resume up to the point
in which user space is thawed and then it crashes as a result of page tables
corruption.  How those page tables are corrupted depends on what is written to
the page pointed to by pmd in prepare_temporary_text_mapping() (but, of course,
that write happens in the "boot" or "restore" kernel, before jumping to the
image one).

The above is what we know and now conclusions that it seems to lead to.

Generally, I see two possible scenarios here.

One is that the changes not directly related to prepare_temporary_text_mapping()
in the patch below, eg. the changes in arch_hibernation_header_save/restore()
(and related), make a difference, but that doesn't look likely to me.  In any
case, that will be the first thing to try next, as it is relatively easy.

The second scenario is fundamentally less attractive, because it means that the
address we end up with in pmd in prepare_temporary_text_mapping() is bogus.

My first reaction to that option would be "Well, what if get_safe_page() is
broken somehow?", but that's not so simple.  Namely, for the observed corruption
to happen, get_safe_page() would need to return a page that (1) had already
been allocated once before and (2) such that image data had been written to
it already.  Still, the hibernation core only writes image data to pages that
have been explicitly allocated by it and it never frees them individually
(in particular, they are never freed before jumping to the image kernel at
all).  It sets two bits in two different bitmaps for every page allocated by it
and checks those two bits every time before writing image data to any page.
One may think "Well, maybe the bitmaps don't work correctly then and the bits
are set when they shouldn't be sometimes?", but the problem with that line of
reasoning is that get_safe_page() checks one of those very bits before returning
a page and the page is only returned if that bit is clear.  Thus, even if the
bits were set when they shouldn't be sometimes, get_safe_page() would still
not return such a page to the caller.

The next question to ask might be "What if, horror shock, get_zeroed_page()
called by get_safe_page() returns a page that has been allocated already?", but
then the bitmap check mentioned above would still prevent get_safe_page() from
returning that page (the bit in question would be set for it).

Hence, the only way get_safe_page() might return a wrong page in
prepare_temporary_text_mapping() would be if both get_zeroed_page() and the
bitmap failed at the same time in coincidence to produce the bogus result.
Failures of one of the two individually are not observed, though, let alone a
combined failure leading to exactly the worst outcome.

And there are more questions, like for example, if get_safe_page() returns a
wrong page in that particular place in prepare_temporary_text_mapping(), why
doesn't it return wrong pages anywhere else?  There are at least several
invocations of it in set_up_temporary_mappings() and swsusp_arch_resume()
already and they don't lead to any kind of memory corruption, so why would
this particular one do that?

I'm honestly unsure about where that leads us, but it starts to look totally
weird to me.

Thanks,
Rafael


---
 arch/x86/power/hibernate_64.c |   45 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

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
@@ -37,8 +38,37 @@ unsigned long restore_cr3 __visible;
 
 pgd_t *temp_level4_pgt __visible;
 
+void *restore_pgd_addr __visible;
+pgd_t restore_pgd __visible;
+
 void *relocated_restore_code __visible;
 
+static int prepare_temporary_text_mapping(void)
+{
+	unsigned long vaddr = (unsigned long)restore_jump_address;
+	unsigned long paddr = jump_address_phys & PMD_MASK;
+	pmd_t *pmd;
+	pud_t *pud;
+
+	pud = (pud_t *)get_safe_page(GFP_ATOMIC);
+	if (!pud)
+		return -ENOMEM;
+
+	restore_pgd = __pgd(__pa(pud) | _KERNPG_TABLE);
+
+	pud += pud_index(vaddr);
+	pmd = (pmd_t *)get_safe_page(GFP_ATOMIC);
+	if (!pmd)
+		return -ENOMEM;
+
+	set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
+
+	memset(pmd, 0xff, PAGE_SIZE); /* CORRUPTION HERE! */
+
+	restore_pgd_addr = temp_level4_pgt + pgd_index(vaddr);
+	return 0;
+}
+
 static void *alloc_pgt_page(void *context)
 {
 	return (void *)get_safe_page(GFP_ATOMIC);
@@ -63,6 +93,10 @@ static int set_up_temporary_mappings(voi
 	set_pgd(temp_level4_pgt + pgd_index(__START_KERNEL_map),
 		init_level4_pgt[pgd_index(__START_KERNEL_map)]);
 
+	result = prepare_temporary_text_mapping();
+	if (result)
+		return result;
+
 	/* Set up the direct mapping from scratch */
 	for (i = 0; i < nr_pfn_mapped; i++) {
 		mstart = pfn_mapped[i].start << PAGE_SHIFT;
@@ -108,12 +142,13 @@ int pfn_is_nosave(unsigned long pfn)
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
@@ -126,7 +161,8 @@ int arch_hibernation_header_save(void *a
 
 	if (max_size < sizeof(struct restore_data_record))
 		return -EOVERFLOW;
-	rdr->jump_address = restore_jump_address;
+	rdr->jump_address = &restore_registers;
+	rdr->jump_address_phys = __pa_symbol(&restore_registers);
 	rdr->cr3 = restore_cr3;
 	rdr->magic = RESTORE_MAGIC;
 	return 0;
@@ -142,6 +178,7 @@ int arch_hibernation_header_restore(void
 	struct restore_data_record *rdr = addr;
 
 	restore_jump_address = rdr->jump_address;
+	jump_address_phys = rdr->jump_address_phys;
 	restore_cr3 = rdr->cr3;
 	return (rdr->magic == RESTORE_MAGIC) ? 0 : -EINVAL;
 }


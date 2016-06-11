From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: PROBLEM: Resume form hibernate broken by setting NX on gap
Date: Sat, 11 Jun 2016 03:47:59 +0200
Message-ID: <2597967.kdkjeIcHno@vostro.rjw.lan>
References: <573DF82D.50006@deltatee.com> <2733358.ov5sOzsSmy@vostro.rjw.lan> <19310985.zBnH00loSf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46792 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750753AbcFKBn4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 21:43:56 -0400
In-Reply-To: <19310985.zBnH00loSf@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Kees Cook <keescook@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>

On Saturday, June 11, 2016 02:13:45 AM Rafael J. Wysocki wrote:
> On Saturday, June 11, 2016 12:33:31 AM Rafael J. Wysocki wrote:
> > On Friday, June 10, 2016 04:28:01 PM Logan Gunthorpe wrote:
> > > 
> > > On 10/06/16 04:29 PM, Rafael J. Wysocki wrote:
> > > > OK, I have a theory, but I need a bit of help.
> > > > 
> > > > This may be a dumb question, but I don't quite remember the answer readily.
> > > > 
> > > > Given a physical address, how do I get the corresponding virtual one under
> > > > the kernel identity mapping?
> > > 
> > > Is that not just 'phys_to_virt(x)'??
> > 
> > Ah that.  Thanks!
> 
> So first, appended is a cleanup of the 64-bit hibernate/restore code that hopefully
> will make it a bit clearer what happens there.
> 
> In particular, it follows from it quite clearly that the restore will only work
> if the virtual address of the trampoline (&restore_registers) in the image
> kernel happens to match the virtual address of the same chunk of memory in the
> boot kernel (and after it has switched to the temporary page tables).
> 
> That appears to be the case most of the time, or hibernation would randomly
> break for people all over, but I'm not actually sure if that's guaranteed to
> happen.  If not, that very well may explain unexpected failures in there.
> 
> If it is not guaranteed to happen, the solution would be to pass the physical
> address of that memory from the image kernel to the boot kernel instead of its
> virtual address,

OK, the appended patch does the trick for me.

Logan, can you please try it?  It shouldn't break things, but I'm wondering if
the problem you're having after commit ab76f7b4ab is still reproducible with it.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] x86 / hibernate: Pass physical address of the trampoline

During resume from hibernation, the boot kernel has to jump to
the image kernel's trampoline code to pass control to it.  On
x86_64 the address of that code is passed from the image kernel
to the boot kernel in the image header.

Currently, the way in which that address is saved by the image kernel
is not entirely straightforward (assembly code is involved in that
unnecessarily etc).  Moreover, the current code passes the virtual
address of the trampoline with the assumption that the image and boot
kernels will always use the same virtual addresses for the chunk of
physical address space occupied by the trampoline code.

In case that assumption is not valid, pass the physical address of
the trampoline code from the image kernel to the boot kernel and
update RESTORE_MAGIC to avoid situations in which the boot kernel
may use a different trampoline address passing convention from the
one used by the image kernel.

Also drop the assembly code chunk updating restore_jump_address
in swsusp_arch_suspend() as it is not necessary any more.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/power/hibernate_64.c     |    8 ++++----
 arch/x86/power/hibernate_asm_64.S |    3 ---
 2 files changed, 4 insertions(+), 7 deletions(-)

Index: linux-pm/arch/x86/power/hibernate_64.c
===================================================================
--- linux-pm.orig/arch/x86/power/hibernate_64.c
+++ linux-pm/arch/x86/power/hibernate_64.c
@@ -27,7 +27,7 @@ extern asmlinkage __visible int restore_
  * Address to jump to in the last phase of restore in order to get to the image
  * kernel's text (this value is passed in the image header).
  */
-unsigned long restore_jump_address __visible;
+void *restore_jump_address __visible;
 
 /*
  * Value of the cr3 register from before the hibernation (this value is passed
@@ -113,7 +113,7 @@ struct restore_data_record {
 	unsigned long magic;
 };
 
-#define RESTORE_MAGIC	0x0123456789ABCDEFUL
+#define RESTORE_MAGIC	0x0123456789ABCDF0UL
 
 /**
  *	arch_hibernation_header_save - populate the architecture specific part
@@ -126,7 +126,7 @@ int arch_hibernation_header_save(void *a
 
 	if (max_size < sizeof(struct restore_data_record))
 		return -EOVERFLOW;
-	rdr->jump_address = restore_jump_address;
+	rdr->jump_address = (unsigned long)__pa_symbol(&restore_registers);
 	rdr->cr3 = restore_cr3;
 	rdr->magic = RESTORE_MAGIC;
 	return 0;
@@ -141,7 +141,7 @@ int arch_hibernation_header_restore(void
 {
 	struct restore_data_record *rdr = addr;
 
-	restore_jump_address = rdr->jump_address;
+	restore_jump_address = (void *)(rdr->jump_address + __START_KERNEL_map);
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


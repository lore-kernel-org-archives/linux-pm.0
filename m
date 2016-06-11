From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: PROBLEM: Resume form hibernate broken by setting NX on gap
Date: Sat, 11 Jun 2016 02:13:45 +0200
Message-ID: <19310985.zBnH00loSf@vostro.rjw.lan>
References: <573DF82D.50006@deltatee.com> <575B3EF1.3060507@deltatee.com> <2733358.ov5sOzsSmy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52853 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752249AbcFKAJm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 20:09:42 -0400
In-Reply-To: <2733358.ov5sOzsSmy@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>, Kees Cook <keescook@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>

On Saturday, June 11, 2016 12:33:31 AM Rafael J. Wysocki wrote:
> On Friday, June 10, 2016 04:28:01 PM Logan Gunthorpe wrote:
> > 
> > On 10/06/16 04:29 PM, Rafael J. Wysocki wrote:
> > > OK, I have a theory, but I need a bit of help.
> > > 
> > > This may be a dumb question, but I don't quite remember the answer readily.
> > > 
> > > Given a physical address, how do I get the corresponding virtual one under
> > > the kernel identity mapping?
> > 
> > Is that not just 'phys_to_virt(x)'??
> 
> Ah that.  Thanks!

So first, appended is a cleanup of the 64-bit hibernate/restore code that hopefully
will make it a bit clearer what happens there.

In particular, it follows from it quite clearly that the restore will only work
if the virtual address of the trampoline (&restore_registers) in the image
kernel happens to match the virtual address of the same chunk of memory in the
boot kernel (and after it has switched to the temporary page tables).

That appears to be the case most of the time, or hibernation would randomly
break for people all over, but I'm not actually sure if that's guaranteed to
happen.  If not, that very well may explain unexpected failures in there.

If it is not guaranteed to happen, the solution would be to pass the physical
address of that memory from the image kernel to the boot kernel instead of its
virtual address, but simply applying virt_to_phys() to &restore_registers in
arch_hibernation_header_save(), storing that in rdr->jump_address and then applying
phys_to_virt() to rdr->jump_address in arch_hibernation_header_restore() doesn't
work.

Any hints on how to do it correctly?

Thanks,
Rafael


---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] x86 / hibernate: Simplify passing of trampoline address

During resume from hibernation, the boot kernel has to jump to
the image kernel's trampoline code to pass control to it.  On
x86_64 the address of that code is passed from the image kernel
to the boot kernel in the image header.  Currently, the way in
which that address is saved by the image kernel is not entirely
straightforward (assembly code is involved in that unnecessarily
etc), so simplify it to make it easier to follow.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/power/hibernate_64.c     |    6 +++---
 arch/x86/power/hibernate_asm_64.S |    3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

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
@@ -108,7 +108,7 @@ int pfn_is_nosave(unsigned long pfn)
 }
 
 struct restore_data_record {
-	unsigned long jump_address;
+	void *jump_address;
 	unsigned long cr3;
 	unsigned long magic;
 };
@@ -126,7 +126,7 @@ int arch_hibernation_header_save(void *a
 
 	if (max_size < sizeof(struct restore_data_record))
 		return -EOVERFLOW;
-	rdr->jump_address = restore_jump_address;
+	rdr->jump_address = &restore_registers;
 	rdr->cr3 = restore_cr3;
 	rdr->magic = RESTORE_MAGIC;
 	return 0;
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


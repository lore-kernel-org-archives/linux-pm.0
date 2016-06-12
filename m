From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: PROBLEM: Resume form hibernate broken by setting NX on gap
Date: Sun, 12 Jun 2016 03:05:04 +0200
Message-ID: <3878383.bGDWSmEsze@vostro.rjw.lan>
References: <573DF82D.50006@deltatee.com> <2597967.kdkjeIcHno@vostro.rjw.lan> <575C4CE4.6060608@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52771 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751896AbcFLBBB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 11 Jun 2016 21:01:01 -0400
In-Reply-To: <575C4CE4.6060608@deltatee.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Kees Cook <keescook@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>

On Saturday, June 11, 2016 11:39:48 AM Logan Gunthorpe wrote:
> Hey Rafael,
> 
> I tried this patch as well and there was no change.
> 
> I have a couple tentative observations to make though. None of this is 
> 100% clear to me so please correct me if I'm wrong anywhere:
> 
> 1) Commit ab76f7b4ab only extends the NX bit between __ex_table and 
> rodata; which, by my understanding, shouldn't be used by anything. And 
> __ex_table and rodata are fixed by the kernel's binary so both symbols 
> should be the same in both the image kernel and the boot kernel given 
> that both are running from the same binary.

Well, what if the kernel is relocated?

> 2) When ab76f7b4ab is reverted, hibernation seems to work 100%. Though, 
> when it's in place, it only works some of the time. Given that commit is 
> only extending the NX region a bit, if there is some random mismatch, 
> why does it never reach rodata? In other words, why is rodata a magic 
> line that seems to work all the time -- why doesn't this random mismatch 
> ever extend into the rodata region? rodata isn't _that_ far away from 
> the end of ex_table.

That's a very good question. :-)

Overall, it looks like re-using the boot kernel text mapping in the temporary
page tables is a bad idea.  I guess a temporary kernel text mapping is needed
too or at least the existing one has to be modified to cover the trampoline
code properly.

> Anyway, thanks again for looking into this.

No problem.  I haven't helped much so far, though ...

Can you please check if the patch below makes any difference?

---
 arch/x86/power/hibernate_64.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

Index: linux-pm/arch/x86/power/hibernate_64.c
===================================================================
--- linux-pm.orig/arch/x86/power/hibernate_64.c
+++ linux-pm/arch/x86/power/hibernate_64.c
@@ -12,6 +12,7 @@
 #include <linux/smp.h>
 #include <linux/suspend.h>
 
+#include <asm/cacheflush.h>
 #include <asm/init.h>
 #include <asm/proto.h>
 #include <asm/page.h>
@@ -27,7 +28,7 @@ extern asmlinkage __visible int restore_
  * Address to jump to in the last phase of restore in order to get to the image
  * kernel's text (this value is passed in the image header).
  */
-unsigned long restore_jump_address __visible;
+void *restore_jump_address __visible;
 
 /*
  * Value of the cr3 register from before the hibernation (this value is passed
@@ -108,7 +109,7 @@ int pfn_is_nosave(unsigned long pfn)
 }
 
 struct restore_data_record {
-	unsigned long jump_address;
+	void *jump_address;
 	unsigned long cr3;
 	unsigned long magic;
 };
@@ -126,7 +127,7 @@ int arch_hibernation_header_save(void *a
 
 	if (max_size < sizeof(struct restore_data_record))
 		return -EOVERFLOW;
-	rdr->jump_address = restore_jump_address;
+	rdr->jump_address = &restore_registers;
 	rdr->cr3 = restore_cr3;
 	rdr->magic = RESTORE_MAGIC;
 	return 0;
@@ -140,8 +141,18 @@ int arch_hibernation_header_save(void *a
 int arch_hibernation_header_restore(void *addr)
 {
 	struct restore_data_record *rdr = addr;
+	unsigned long text_end, all_end;
+
+	if (rdr->magic != RESTORE_MAGIC)
+		return -EINVAL;
 
 	restore_jump_address = rdr->jump_address;
 	restore_cr3 = rdr->cr3;
-	return (rdr->magic == RESTORE_MAGIC) ? 0 : -EINVAL;
+
+	text_end = PFN_ALIGN(&__stop___ex_table);
+	all_end = roundup((unsigned long)restore_jump_address, PMD_SIZE);
+	if (all_end > text_end)
+		set_memory_x(text_end, (all_end - text_end) >> PAGE_SHIFT);
+
+	return 0;
 }


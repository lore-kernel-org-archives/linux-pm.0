From: Ingo Molnar <mingo@kernel.org>
Subject: Re: PROBLEM: Resume form hibernate broken by setting NX on gap
Date: Fri, 20 May 2016 09:15:17 +0200
Message-ID: <20160520071517.GB14191@gmail.com>
References: <573DF82D.50006@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34144 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331AbcETHPY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 03:15:24 -0400
Content-Disposition: inline
In-Reply-To: <573DF82D.50006@deltatee.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>


* Logan Gunthorpe <logang@deltatee.com> wrote:

> Hi,
> 
> I have been working on a bug that causes my laptop to freeze during
> resume from hibernation. I did a bisect to find the offending commit:
> 
> [ab76f7b4ab] x86/mm: Set NX on gap between __ex_table and rodata
> 
> There is more information in the bugzilla report [1] that
> I've been working on but I will summarize things below.
> 
> I've experienced intermittent but reproducible freezes when resuming
> from hibernation since about kernel version 3.19. The freeze was
> significantly more reproducible when a few applications were loaded
> before hibernation and would largely not happen if hibernated
> immediately after booting to a desktop. I did some tracing work to find
> that the kernel gets as far as the resume_image call in
> swsusp_arch_resume and I could not find any response from the image
> kernel when I hit the bug. I also did testing that seemed to rule out
> this being caused by a problematic driver.
> 
> I did a successful bisect between 3.18 and 3.19 which found a bug in
> commit f5b2831d6 that was then later fixed by commit 55696b1f66 in 4.4.
> Then, I did a second bisect with a ported version of the fix to the
> first bug and found commit ab76f7b4ab in 4.3 to also break hibernation
> with what appears to be the exact same symptoms. Reverting that commit
> in recent kernels up to and including 4.6 fixes the issue and restores
> reliable hibernation. However, it's not at all clear to me why that
> commit would cause this issue or how to fix the issue without reverting.

I've attached that commit below and also Cc:-ed a few more people who might have 
an idea about why this regressed. Worst-case we'll have to revert it.

Thanks,

	Ingo

=================>
>From ab76f7b4ab2397ffdd2f1eb07c55697d19991d10 Mon Sep 17 00:00:00 2001
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 1 Oct 2015 09:04:22 -0400
Subject: [PATCH] x86/mm: Set NX on gap between __ex_table and rodata

Unused space between the end of __ex_table and the start of
rodata can be left W+x in the kernel page tables.  Extend the
setting of the NX bit to cover this gap by starting from
text_end rather than rodata_start.

  Before:
  ---[ High Kernel Mapping ]---
  0xffffffff80000000-0xffffffff81000000          16M                               pmd
  0xffffffff81000000-0xffffffff81600000           6M     ro         PSE     GLB x  pmd
  0xffffffff81600000-0xffffffff81754000        1360K     ro                 GLB x  pte
  0xffffffff81754000-0xffffffff81800000         688K     RW                 GLB x  pte
  0xffffffff81800000-0xffffffff81a00000           2M     ro         PSE     GLB NX pmd
  0xffffffff81a00000-0xffffffff81b3b000        1260K     ro                 GLB NX pte
  0xffffffff81b3b000-0xffffffff82000000        4884K     RW                 GLB NX pte
  0xffffffff82000000-0xffffffff82200000           2M     RW         PSE     GLB NX pmd
  0xffffffff82200000-0xffffffffa0000000         478M                               pmd

  After:
  ---[ High Kernel Mapping ]---
  0xffffffff80000000-0xffffffff81000000          16M                               pmd
  0xffffffff81000000-0xffffffff81600000           6M     ro         PSE     GLB x  pmd
  0xffffffff81600000-0xffffffff81754000        1360K     ro                 GLB x  pte
  0xffffffff81754000-0xffffffff81800000         688K     RW                 GLB NX pte
  0xffffffff81800000-0xffffffff81a00000           2M     ro         PSE     GLB NX pmd
  0xffffffff81a00000-0xffffffff81b3b000        1260K     ro                 GLB NX pte
  0xffffffff81b3b000-0xffffffff82000000        4884K     RW                 GLB NX pte
  0xffffffff82000000-0xffffffff82200000           2M     RW         PSE     GLB NX pmd
  0xffffffff82200000-0xffffffffa0000000         478M                               pmd

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: <stable@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Link: http://lkml.kernel.org/r/1443704662-3138-1-git-send-email-sds@tycho.nsa.gov
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 30564e2752d3..df48430c279b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1132,7 +1132,7 @@ void mark_rodata_ro(void)
 	 * has been zapped already via cleanup_highmem().
 	 */
 	all_end = roundup((unsigned long)_brk_end, PMD_SIZE);
-	set_memory_nx(rodata_start, (all_end - rodata_start) >> PAGE_SHIFT);
+	set_memory_nx(text_end, (all_end - text_end) >> PAGE_SHIFT);
 
 	rodata_test();
 

From: chenyu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH] x86 / hibernate: Fix 64-bit code passing control to image kernel
Date: Tue, 14 Jun 2016 20:06:49 +0800
Message-ID: <CADjb_WRm1c4wrfs9xEStKOTuoS7XEV=a4Eq3QpVA4trn8GnVjA@mail.gmail.com>
References: <3006711.q9ei2E2zzf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3006711.q9ei2E2zzf@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, the arch/x86 maintainers <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 13, 2016 at 9:42 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Logan Gunthorpe reports that hibernation stopped working reliably for
> him after commit ab76f7b4ab23 (x86/mm: Set NX on gap between __ex_table
> and rodata).  Most likely, what happens is that the page containing
> the image kernel's entry point is sometimes marked as non-executable
> in the page tables used at the time of the final jump to the image
> kernel.  That at least is why commit ab76f7b4ab23 may matter.
>
> However, there is one more long-standing issue with the code in
> question, which is that the temporary page tables set up by it
> to avoid page tables corruption when the last bits of the image
> kernel's memory contents are copied into their original page frames
> re-use the boot kernel's text mapping, but that mapping may very
> well get corrupted just like any other part of the page tables.
> Of course, if that happens, the final jump to the image kernel's
> entry point will go to nowhere.
>
100 rounds test has passed with this patch on top of 4.7-rc3,
Tested-by: Chen Yu <yu.c.chen@intel.com>

BTW, I'm thinking of another possible scenario this patch fixed the NX issue,
according  to the log previously provided by Logan in bugzilla 116941

without ab76f7b4ab23:

--[ High Kernel Mapping ]---
0xffffffff80000000-0xffffffff81000000          16M
          pmd
0xffffffff81000000-0xffffffff81600000           6M     ro         PSE
   GLB x  pmd
0xffffffff81600000-0xffffffff81800000           2M     ro         PSE
   GLB NX pmd
0xffffffff81800000-0xffffffff81c00000           4M     RW
   GLB NX pte
0xffffffff81c00000-0xffffffffa0000000         484M
          pmd

with ab76f7b4ab23:

---[ High Kernel Mapping ]---
0xffffffff80000000-0xffffffff81000000          16M
          pmd
0xffffffff81000000-0xffffffff81400000           4M     ro         PSE
   GLB x  pmd
0xffffffff81400000-0xffffffff8155e000        1400K     ro
   GLB x  pte
0xffffffff8155e000-0xffffffff81600000         648K     RW
   GLB NX pte
0xffffffff81600000-0xffffffff81800000           2M     ro         PSE
   GLB NX pmd
0xffffffff81800000-0xffffffff81c00000           4M     RW
   GLB NX pte
0xffffffff81c00000-0xffffffffa0000000         484M
          pmd

ffffffff81446bb0 T restore_registers


It looks like after the NX modification, the 'huge page' text mapping
is splited into smaller pieces,
from pmd to pte mapping,  and since the original pmd is located in
.data section(which should be
the same across hibernation),  while after modification the pte table
is allocated dynamically,
we can not guarantee the dynamically allocated pte table are the same
across hibernation,
thus the kernel entry of restore_registers might become unaccessible
because of broken
page table.

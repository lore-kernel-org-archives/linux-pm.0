From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] x86/power/64: Fix kernel text mapping corruption
 during image restoration (was: Re: ktime_get_ts64() splat during resume)
Date: Mon, 27 Jun 2016 22:08:03 +0200
Message-ID: <20160627200803.GB3678@pd.tnic>
References: <20160617105435.GB15997@pd.tnic>
 <96a692a0-08eb-6d64-d396-82bee5d7a0a1@deltatee.com>
 <CAGXu5j+1_06mKVsV2BeBZtitRk8GtjMPH8_zAxocfxtp7NeLXg@mail.gmail.com>
 <1735047.Yzv12qmPPB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:52676 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbcF0UIG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Jun 2016 16:08:06 -0400
Content-Disposition: inline
In-Reply-To: <1735047.Yzv12qmPPB@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kees Cook <keescook@chromium.org>, Logan Gunthorpe <logang@deltatee.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>

On Mon, Jun 27, 2016 at 04:24:22PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v2] x86/power/64: Fix kernel text mapping corruption during image restoration
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
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/x86/power/hibernate_64.c     |   90 ++++++++++++++++++++++++++++++++------
>  arch/x86/power/hibernate_asm_64.S |   55 ++++++++++-------------
>  2 files changed, 102 insertions(+), 43 deletions(-)

Reported-and-tested-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

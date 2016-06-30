From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5] x86/power/64: Fix kernel text mapping corruption
 during image restoration
Date: Thu, 30 Jun 2016 19:02:37 +0200
Message-ID: <20160630170237.GB3932@pd.tnic>
References: <20160617105435.GB15997@pd.tnic>
 <1735047.Yzv12qmPPB@vostro.rjw.lan>
 <1735143.jkZ4XHok9E@vostro.rjw.lan>
 <1502959.ObXuRQlJgl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:47746 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179AbcF3RCl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 30 Jun 2016 13:02:41 -0400
Content-Disposition: inline
In-Reply-To: <1502959.ObXuRQlJgl@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Logan Gunthorpe <logang@deltatee.com>, Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>

On Thu, Jun 30, 2016 at 06:11:41PM +0200, Rafael J. Wysocki wrote:
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

...

> Boris, please test it on the machine where we saw memory corruption with
> the previous versions if poss.

Looks good. 5 runs passed without a hiccup.

Reported-and-tested-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

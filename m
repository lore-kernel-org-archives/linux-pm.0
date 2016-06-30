From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] x86/power/64: Fix kernel text mapping corruption
 during image restoration
Date: Thu, 30 Jun 2016 14:16:31 +0200
Message-ID: <CAJZ5v0hHzb_vQ94XL+C6kpKJW_DkdenCzbQBLN=ucZT9OE5cdQ@mail.gmail.com>
References: <20160617105435.GB15997@pd.tnic> <65d98ad4-124b-64e4-84e5-877af71a1d44@deltatee.com>
 <2398306.qXx6AZtdS5@vostro.rjw.lan> <1829549.Og2FdTtl4p@vostro.rjw.lan> <8273253c-95dd-0156-7af8-d2a164d1491b@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8273253c-95dd-0156-7af8-d2a164d1491b@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 30, 2016 at 5:56 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 29/06/16 08:55 PM, Rafael J. Wysocki wrote:
>
>> The only thing that comes to mind at this point is that TLBs should be
>> flushed
>> after page tables changes, so please apply the appended and let me know
>> if you see this panic any more with it.
>
>
>
> Ok, I'll build a new kernel tomorrow.

Well, please wait for a while.

I'm looking at the panic log right now and the picture is a bit clearer now.

> But keep in mind the panic is pretty
> rare as I've only seen it once so far after a couple dozen or so hibernates.
> So it may be hard to get a concrete yes or no on whether it fixes the issue.

Right.

> I've got a script to run a bunch of hibernates in a row. I usually only run
> it for a handful of iterations, but I'll try running it for much longer with
> this patch and let you know in a couple days.

As I said, please wait a bit, there may be updates in the meantime. :-)

>From looking at your panic log, the exception happened in
swsusp_arch_resume(), which probably covers restore_image() too,
because that is likely to go into swsusp_arch_resume() in line.

Next, the address in RIP (a) clearly is a page start and (b) is
relative to the identity mapping, so it most likely is the address
from relocated_restore_code.  Moreover, the RCX value is the same
address and the values in the other registers also match exactly the
situation before the jump to relocated_restore_code.  Thus the
exception was triggered by that jump beyond doubt.

Now, if you look above the Oops line, it becomes quite clear what
happened.  Namely, dump_pagetable() (arch/x86/mm/fault.c, line 524 in
4.6) prints the PGD, the PUD, the PMD and the PTE in that order,
unless the lower levels (PTE, PMD) are not present.  In your panic
log, only the PGD and PUD are present, meaning that this is a 1G page
and sure enough it has the NX bit set.

This case was clearly overlooked by relocate_restore_code(), so
updated patch will follow.

Thanks,
Rafael

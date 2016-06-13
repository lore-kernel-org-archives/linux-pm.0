From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86 / hibernate: Fix 64-bit code passing control to image kernel
Date: Mon, 13 Jun 2016 15:53:53 -0700
Message-ID: <CAGXu5jKb-T6PZn3CYj4+Ftt__Vh0wT1VAbndUbFyuFOgafWdhw@mail.gmail.com>
References: <3006711.q9ei2E2zzf@vostro.rjw.lan> <CAGXu5jJ+3JKTBsB9HXapmamGZ0JU23YLvUe7gGqHj8vsYGJtOQ@mail.gmail.com>
 <1518490.AMlP2tjrQi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37940 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422879AbcFMWx4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2016 18:53:56 -0400
Received: by mail-wm0-f46.google.com with SMTP id m124so98859587wme.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2016 15:53:55 -0700 (PDT)
In-Reply-To: <1518490.AMlP2tjrQi@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, the arch/x86 maintainers <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>

On Mon, Jun 13, 2016 at 3:15 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, June 13, 2016 02:58:57 PM Kees Cook wrote:
>> On Mon, Jun 13, 2016 at 6:42 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > Logan Gunthorpe reports that hibernation stopped working reliably for
>> > him after commit ab76f7b4ab23 (x86/mm: Set NX on gap between __ex_table
>> > and rodata).  Most likely, what happens is that the page containing
>> > the image kernel's entry point is sometimes marked as non-executable
>> > in the page tables used at the time of the final jump to the image
>> > kernel.  That at least is why commit ab76f7b4ab23 may matter.
>> >
>> > However, there is one more long-standing issue with the code in
>> > question, which is that the temporary page tables set up by it
>> > to avoid page tables corruption when the last bits of the image
>> > kernel's memory contents are copied into their original page frames
>> > re-use the boot kernel's text mapping, but that mapping may very
>> > well get corrupted just like any other part of the page tables.
>> > Of course, if that happens, the final jump to the image kernel's
>> > entry point will go to nowhere.
>> >
>> > As it turns out, those two issues may be addressed simultaneously.
>> >
>> > To that end, note that the code copying the last bits of the image
>> > kernel's memory contents to the page frames occupied by them
>> > previoulsy doesn't use the kernel text mapping, because it runs from
>> > a special page covered by the identity mapping set up for that code
>> > from scratch.  Hence, the kernel text mapping is only needed before
>> > that code starts to run and then it will only be used just for the
>> > final jump to the image kernel's entry point.
>> >
>> > Accordingly, the temporary page tables set up in swsusp_arch_resume()
>> > on x86-64 can re-use the boot kernel's text mapping to start with,
>> > but after all of the image kernel's memory contents are in place,
>> > that mapping has to be replaced with a new one that will allow the
>> > final jump to the image kernel's entry point to succeed.  Of course,
>> > since the first thing the image kernel does after getting control back
>> > is to switch over to its own original page tables, the new kernel text
>> > mapping only has to cover the image kernel's entry point (along with
>> > some following bytes).  Moreover, it has to do that so the virtual
>> > address of the image kernel's entry point before the jump is the same
>> > as the one mapped by the image kernel's page tables.
>> >
>> > With that in mind, modify the x86-64's arch_hibernation_header_save()
>> > and arch_hibernation_header_restore() routines to pass the physical
>> > address of the image kernel's entry point (in addition to its virtual
>> > address) to the boot kernel (a small piece of assembly code involved
>> > in passing the entry point's virtual address to the image kernel is
>> > not necessary any more after that, so drop it).  Update RESTORE_MAGIC
>> > too to reflect the image header format change.
>> >
>> > Next, in set_up_temporary_mappings(), use the physical and virtual
>> > addresses of the image kernel's entry point passed in the image
>> > header to set up a minimum kernel text mapping (using memory pages
>> > that won't be overwritten by the image kernel's memory contents) that
>> > will map those addresses to each other as appropriate.  Do not use
>> > that mapping immediately, though.  Instead, use the original boot
>> > kernel text mapping to start with and switch over to the new one
>> > after all of the image kernel's memory has been restored, right
>> > before the final jump to the image kernel's entry point.
>> >
>> > This makes the concern about the possible corruption of the original
>> > boot kernel text mapping go away and if the the minimum kernel text
>> > mapping used for the final jump marks the image kernel's entry point
>> > memory as executable, the jump to it is guaraneed to succeed.
>> >
>> > Fixes: ab76f7b4ab23 (x86/mm: Set NX on gap between __ex_table and rodata)
>> > Link: http://marc.info/?l=linux-pm&m=146372852823760&w=2
>> > Reported-by: Logan Gunthorpe <logang@deltatee.com>
>> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Acked-by: Kees Cook <keescook@chromium.org>
>>
>> And as an awesome added benefit: this fixes KASLR hibernation for me,
>> too!
>
> Interesting. :-)
>
> Is there documentation I can read about how the KASLR thing works exactly,
> wrt page tables in particular?

There's no documentation beyond the code itself. Currently, it just
bumps the physical offset (which results in bumping the virtual offset
within a 1G window), and the x86 relocation code handles everything
else (so, IIUC, the page tables are moved with the kernel). Soon it'll
randomize the physical offset within all physical memory, and the
virtual within the 1G window. The page tables for the physical offset
are just done on demand during the decompression stub, using its own
temporary tables before the main kernel takes over.

>> I will send a follow-up patch that removes all the KASLR vs
>> hibernation hacks.
>
> But that on x86-64 only?  32-bit still doesn't work I suppose?

Oh, bummer. Right. Can the same change be made on the 32-bit resume code?

>
>> Yay!
>
> I'm glad you like it. ;-)
>
> Cheers,
> Rafael
>

-Kees


-- 
Kees Cook
Chrome OS & Brillo Security

From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] x86 / hibernate: Fix 64-bit code passing control to image kernel
Date: Tue, 14 Jun 2016 03:37:55 +0200
Message-ID: <CAJZ5v0jv-KEk6cQRA2botqPXDip86W3U5RbqZuR+2PSGqNtXHQ@mail.gmail.com>
References: <3006711.q9ei2E2zzf@vostro.rjw.lan> <CAGXu5jJ+3JKTBsB9HXapmamGZ0JU23YLvUe7gGqHj8vsYGJtOQ@mail.gmail.com>
 <1518490.AMlP2tjrQi@vostro.rjw.lan> <CAGXu5jKb-T6PZn3CYj4+Ftt__Vh0wT1VAbndUbFyuFOgafWdhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36070 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbcFNBh5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2016 21:37:57 -0400
In-Reply-To: <CAGXu5jKb-T6PZn3CYj4+Ftt__Vh0wT1VAbndUbFyuFOgafWdhw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, the arch/x86 maintainers <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>

On Tue, Jun 14, 2016 at 12:53 AM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Jun 13, 2016 at 3:15 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Monday, June 13, 2016 02:58:57 PM Kees Cook wrote:
>>> On Mon, Jun 13, 2016 at 6:42 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> >

[cut]

>>>
>>> Acked-by: Kees Cook <keescook@chromium.org>
>>>
>>> And as an awesome added benefit: this fixes KASLR hibernation for me,
>>> too!
>>
>> Interesting. :-)
>>
>> Is there documentation I can read about how the KASLR thing works exactly,
>> wrt page tables in particular?
>
> There's no documentation beyond the code itself. Currently, it just
> bumps the physical offset (which results in bumping the virtual offset
> within a 1G window), and the x86 relocation code handles everything
> else (so, IIUC, the page tables are moved with the kernel). Soon it'll
> randomize the physical offset within all physical memory, and the
> virtual within the 1G window. The page tables for the physical offset
> are just done on demand during the decompression stub, using its own
> temporary tables before the main kernel takes over.

OK

So if I understand that correctly, entire mappings are shifted but the
layout of each mapping individually doesn't change.

My concern was that with KASLR the page tables set up by
kernel_ident_mapping_init() might map memory in a different way than
the original ones, but it looks like kernel_ident_mapping_init()
handles that correctly somehow. :-)

>>> I will send a follow-up patch that removes all the KASLR vs
>>> hibernation hacks.
>>
>> But that on x86-64 only?  32-bit still doesn't work I suppose?
>
> Oh, bummer. Right. Can the same change be made on the 32-bit resume code?

Not directly.

The 32-bit resume code is a bit ancient and still makes the assumption
that the layout of memory will be the same for both the boot and image
kernels.  It would first need to be changed to make that assumption go
away and that's rather tricky.

There is a patch claiming to do that
(https://patchwork.kernel.org/patch/6622991/), but I really haven't
had the time for a detailed review of it so far and there doesn't seem
to be much interest in hibernation on 32-bit x86 anyway.

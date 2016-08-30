From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH][v8] PM / hibernate: Verify the consistent of e820 memory
 map by md5 value
Date: Tue, 30 Aug 2016 23:50:08 +0200
Message-ID: <CAJZ5v0iFub00x72-eZJT1H9Sp28wZ-VG=unfp5iTtf0tnmjHaA@mail.gmail.com>
References: <1472402140-959-1-git-send-email-yu.c.chen@intel.com>
 <CAJZ5v0gBTjZjvS7iCKAQCvaYH-szObtExtV3B4ai4srow_kNMg@mail.gmail.com>
 <20160829151334.GA21313@amd> <7552351.MYV7GZcH0A@vostro.rjw.lan> <20160830195323.GA9937@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33356 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753048AbcH3VuJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2016 17:50:09 -0400
In-Reply-To: <20160830195323.GA9937@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, Chen Yu <yu.c.chen@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lee@nazgul.tnic, Chun-Yi <jlee@suse.com>

On Tue, Aug 30, 2016 at 9:53 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
>> > > I would warn and try to continue regardless (which was the original
>> > > plan here AFAICS), or we change a possible data loss into a guaranteed
>> > > one.
>> > >
>> > > IMO it is sufficient to give up when a PFN we have image data for is
>> > > not pfn_valid() during resume, which we do already.
>> >
>> > Well... can you guarantee what will be effect of resuming with
>> > different memory map?
>> >
>> > Because there's big difference between panic and trying to continue
>> > with corrupted memory.
>>
>> If all of the page frames the image kernel used before hibernation are
>> available during resume as well, memory won't really get corrupted, at least
>> not right away.
>>
>> There may be problems going forward, but whether or not they actually happen
>> depends on what the differences are.  So while an e820 mismatch indicates that
>> things may go wrong, it doesn't necessarily mean that they will.
>
> Well "memory won't get corrupted right away" seems like good reason to
> panic the machine ASAP.
>
> You can flip some bits in memory, and it may not cause problems. Still
> if you know some bits in memory were flipped, you'd better panic the
> machine. Continuing is unsafe.
>
> If you could guarantee that machine will panic down the line, and not
> something worse, you'd be right.
>
> But at least the case where there is _less_ memory available after
> resume, kernel will write into BIOS reserved memory and bad things
> will happen. Yes, it usually panics, but it is quite clear it could
> corrupt memory, too.

That depends a good deal on what those ranges were reserved for.
There very well may not be anything vital in there.

> So I believe we should take the patch, and let users update their
> BIOSes. [And I believe it is not too widespread, either.]
>
> If you want to try to cook a patch that determines if new e820 map is
> superset of the old one... well... I believe the resulting complexity
> will be obviously unreasonable but I guess you (or some interested
> person) can try.
L
>> Also, that panic() may cause hibernation to stop working in a sort of hard and
>> nasty way where it used to work flawlessly previously and that would be a
>> regression, so not really acceptable.
>
> Well, turning memory corruption bug into panic is an improvement, not
> a regression.

Since we don't do anything about these problems today and presumably
people use hibernation on the affected systems, there are reasons to
think that the problem is not quite as grave as you're painting it.

But that aside, adding a panic() like in this patch isn't particularly
useful anyway, because it panics the restore kernel.  It is sufficient
to make arch_hibernation_header_restore() return an error to actually
fail the resume and cause the restore kernel to discard the image.
And that would preserve the information about the failure in the
kernel log at least.

Thanks,
Rafael
